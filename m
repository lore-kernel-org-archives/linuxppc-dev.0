Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 113951A086D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 11:14:58 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 5 Feb 2015 10:14:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5F3602BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 11:14:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t150Ejpr40960218
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 11:14:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t150EJnx019050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 11:14:20 +1100
Date: Thu, 5 Feb 2015 08:13:58 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V11 00/17] Enable SRIOV on Power8
Message-ID: <20150205001358.GA22897@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204234442.GC20072@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150204234442.GC20072@google.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 04, 2015 at 05:44:42PM -0600, Bjorn Helgaas wrote:
>On Thu, Jan 15, 2015 at 10:27:50AM +0800, Wei Yang wrote:
>> This patchset enables the SRIOV on POWER8.
>> 
>> The gerneral idea is put each VF into one individual PE and allocate required
>> resources like MMIO/DMA/MSI. The major difficulty comes from the MMIO
>> allocation and adjustment for PF's IOV BAR.
>> 
>> On P8, we use M64BT to cover a PF's IOV BAR, which could make an individual VF
>> sit in its own PE. This gives more flexiblity, while at the mean time it
>> brings on some restrictions on the PF's IOV BAR size and alignment.
>> 
>> To achieve this effect, we need to do some hack on pci devices's resources.
>> 1. Expand the IOV BAR properly.
>>    Done by pnv_pci_ioda_fixup_iov_resources().
>> 2. Shift the IOV BAR properly.
>>    Done by pnv_pci_vf_resource_shift().
>> 3. IOV BAR alignment is calculated by arch dependent function instead of an
>>    individual VF BAR size.
>>    Done by pnv_pcibios_sriov_resource_alignment().
>> 4. Take the IOV BAR alignment into consideration in the sizing and assigning.
>>    This is achieved by commit: "PCI: Take additional IOV BAR alignment in
>>    sizing and assigning"
>
>I was hoping to merge this during the v3.20 merge window, but that will
>likely open next week, and none of these patches have been in linux-next at
>all yet, so I think next week would be rushing it a bit.  
>
>Most of the changes are in arch/powerpc, which does help, but there are
>some changes in pci/setup-bus.c that I would like to have some runtime on.
>The changes aren't extensive, but I don't understand that code well enough
>to be comfortable based on just reading the patch.
>
>I pushed the current state of this patchset to my pci/virtualization
>branch.  I think the best way forward would be for you to start with that
>branch, since I've made quite a few tweaks to the patches you posted to the
>list.  Then you can post a v12 with any changes you make for the next
>round.

Thanks :-)

I will rebase code on pci/virtualization and do changes as you mentioned in
previous letters.

Really thanks for your review, which must take you a lot of time, especially
on the PE and M64 BAR stuff. Also thanks for you kindness and tolerance on my
mistakes in communications :-)

>
>Ben, I know you chimed in earlier to help explain PEs.  Are you or another
>powerpc maintainer planning to ack all this?
>
>Bjorn

-- 
Richard Yang
Help you, Help me
