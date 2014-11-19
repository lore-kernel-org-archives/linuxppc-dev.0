Return-Path: <benh@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66EC21A088C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 13:15:55 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 19 Nov 2014 12:15:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 24A223578063
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 13:15:34 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAJ2FB3A15466668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 13:15:11 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAJ2FXST017441
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 13:15:33 +1100
Message-ID: <1416363332.5704.18.camel@au1.ibm.com>
Subject: Re: [PATCH V9 03/18] PCI: Add weak pcibios_iov_resource_size()
 interface
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Nov 2014 13:15:32 +1100
In-Reply-To: <20141119011243.GA23467@google.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141119011243.GA23467@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 Donald Dutile <ddutile@redhat.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-11-18 at 18:12 -0700, Bjorn Helgaas wrote:
> 
> Can you help me understand this?
> 
> We have previously called sriov_init() on the PF.  There, we sized the VF
> BARs, which are in the PF's SR-IOV Capability (SR-IOV spec sec 3.3.14).
> The size we discover is the amount of space required by a single VF, so
> sriov_init() adjusts PF->resource[PCI_IOV_RESOURCES + i] by multiplying
> that size by PCI_SRIOV_TOTAL_VF, so this PF resource is now big enough to 
> hold the VF BAR[i] areas for all the possible VFs.

So I'll let Richard (Wei) answer on the details but I'll just chime in
about the "big picture". This isn't about changing the spacing between VFs
which is handled by the system page size.

This is about the way we create MMIO windows from the CPU to the VF BARs.

Basically, we have a (limited) set of 64-bit windows we can create that
are divided in equal sized segments (256 of them), each segment assigned
in HW to one of our Partitionable Endpoints (aka domain).

So even if we only ever create 16 VFs for a device, we need to use an
entire of these windows, which will use 256*VF_size and thus allocate
that much space. Also the window has to be naturally aligned.

We can then assign the VF BAR to a spot inside that window that corresponds
to the range of PEs that we have assigned to that device (which typically
isn't going to be the beginning of the window).

Cheers,
Ben.
