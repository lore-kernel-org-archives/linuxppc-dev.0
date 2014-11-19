Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60F1A1A0885
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 14:21:08 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 19 Nov 2014 13:21:06 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 75B693578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 14:21:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAJ3Mt4Q36896896
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 14:22:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAJ3L1vP007436
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 14:21:02 +1100
Date: Wed, 19 Nov 2014 11:21:00 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH V9 03/18] PCI: Add weak pcibios_iov_resource_size()
 interface
Message-ID: <20141119032100.GA7105@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141119011243.GA23467@google.com>
 <1416363332.5704.18.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416363332.5704.18.camel@au1.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Myron Stowe <myron.stowe@redhat.com>,
 linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 Donald Dutile <ddutile@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 19, 2014 at 01:15:32PM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2014-11-18 at 18:12 -0700, Bjorn Helgaas wrote:
>> 
>> Can you help me understand this?
>> 
>> We have previously called sriov_init() on the PF.  There, we sized the VF
>> BARs, which are in the PF's SR-IOV Capability (SR-IOV spec sec 3.3.14).
>> The size we discover is the amount of space required by a single VF, so
>> sriov_init() adjusts PF->resource[PCI_IOV_RESOURCES + i] by multiplying
>> that size by PCI_SRIOV_TOTAL_VF, so this PF resource is now big enough to 
>> hold the VF BAR[i] areas for all the possible VFs.
>
>So I'll let Richard (Wei) answer on the details but I'll just chime in
>about the "big picture". This isn't about changing the spacing between VFs
>which is handled by the system page size.
>
>This is about the way we create MMIO windows from the CPU to the VF BARs.
>
>Basically, we have a (limited) set of 64-bit windows we can create that
>are divided in equal sized segments (256 of them), each segment assigned
>in HW to one of our Partitionable Endpoints (aka domain).
>
>So even if we only ever create 16 VFs for a device, we need to use an
>entire of these windows, which will use 256*VF_size and thus allocate
>that much space. Also the window has to be naturally aligned.
>
>We can then assign the VF BAR to a spot inside that window that corresponds
>to the range of PEs that we have assigned to that device (which typically
>isn't going to be the beginning of the window).
>

Bjorn & Ben,

Let me try to explain it. Thanks for Ben's explanation, it would be helpful. We
are not trying to change the space between VFs.

As mentioned by Ben, we use some HW to map the MMIO space to PE. But the HW
must map 256 segments with the same size. This will lead a situation like
this.

   +------+------+        +------+------+------+------+
   |VF#0  |VF#1  |   ...  |      |VF#N-1|PF#A  |PF#B  |
   +------+------+        +------+------+------+------+

Suppose N = 254 and the HW map these 256 segments to their corresponding PE#.
Then it introduces one problem, the PF#A and PF#B have been already assigned
to some PE#. We can't map one MMIO range to two different PE#.

What we have done is to "Expand the IOV BAR" to fit the whole HW 256 segments.
By doing so, the MMIO range will look like this.

   +------+------+        +------+------+------+------+------+------+
   |VF#0  |VF#1  |   ...  |      |VF#N-1|blank |blank |PF#A  |PF#B  |
   +------+------+        +------+------+------+------+------+------+

We do some tricky to "Expand" the IOV BAR, so that make sure there would not
be some overlap between VF's PE and PF's PE.

Then this will leads to the IOV BAR size change from:
   
   IOV BAR size = (VF BAR aperture size) * VF_number

 to:
   
   IOV BAR size = (VF BAR aperture size) * 256

This is the reason we need a platform dependent method to get the VF BAR size.
Otherwise the VF BAR size would be not correct.

Now let's take a look at your example again.

  PF SR-IOV Capability
    TotalVFs = 4
    NumVFs = 4
    System Page Size = 4KB
    VF BAR0 = [mem 0x00000000-0x00000fff] (4KB at address 0)

  PF  pci_dev->resource[7] = [mem 0x00000000-0x00003fff] (16KB)
  VF1 pci_dev->resource[0] = [mem 0x00000000-0x00000fff]
  VF2 pci_dev->resource[0] = [mem 0x00001000-0x00001fff]
  VF3 pci_dev->resource[0] = [mem 0x00002000-0x00002fff]
  VF4 pci_dev->resource[0] = [mem 0x00003000-0x00003fff]

The difference after our expanding is the IOV BAR size is 256*4KB instead of
16KB. So it will look like this:

  PF  pci_dev->resource[7] = [mem 0x00000000-0x000fffff] (1024KB)
  VF1 pci_dev->resource[0] = [mem 0x00000000-0x00000fff]
  VF2 pci_dev->resource[0] = [mem 0x00001000-0x00001fff]
  VF3 pci_dev->resource[0] = [mem 0x00002000-0x00002fff]
  VF4 pci_dev->resource[0] = [mem 0x00003000-0x00003fff]
  ...
  and 252 4KB space leave not used.

So the start address and the size of VF will not change, but the PF's IOV BAR
will be expanded.

>Cheers,
>Ben.
>

-- 
Richard Yang
Help you, Help me
