Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 613A21A15BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:18:30 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 19:18:29 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7A69A357804C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:18:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B9II7N26804276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:18:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B9Hq4j015808
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:17:52 +1100
Date: Wed, 11 Mar 2015 17:17:35 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 10/21] PCI: Consider additional PF's IOV BAR
 alignment in sizing and assigning
Message-ID: <20150311091735.GE5826@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083406.32124.65957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224084152.GG6220@google.com> <20150302073247.GE21571@richard>
 <20150311023658.GA10994@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150311023658.GA10994@google.com>
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

On Tue, Mar 10, 2015 at 09:36:58PM -0500, Bjorn Helgaas wrote:
>On Mon, Mar 02, 2015 at 03:32:47PM +0800, Wei Yang wrote:
>> On Tue, Feb 24, 2015 at 02:41:52AM -0600, Bjorn Helgaas wrote:
>> >On Tue, Feb 24, 2015 at 02:34:06AM -0600, Bjorn Helgaas wrote:
>> >> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>> >> 
>> >> When sizing and assigning resources, we divide the resources into two
>> >> lists: the requested list and the additional list.  We don't consider the
>> >> alignment of additional VF(n) BAR space.
>> >> 
>> >> This is reasonable because the alignment required for the VF(n) BAR space
>> >> is the size of an individual VF BAR, not the size of the space for *all*
>> >> VFs.  But some platforms, e.g., PowerNV, require additional alignment.
>> >> 
>> >> Consider the additional IOV BAR alignment when sizing and assigning
>> >> resources.  When there is not enough system MMIO space, the PF's IOV BAR
>> >> alignment will not contribute to the bridge.  When there is enough system
>> >> MMIO space, the additional alignment will contribute to the bridge.
>> >
>> >I don't understand the ""when there is not enough system MMIO space" part.
>> >How do we tell if there's enough MMIO space?
>> >
>> 
>> In __assign_resources_sorted(), it has two resources list, one for requested
>> (head) and one for additional (realloc_head). This function will first try to
>> combine them and assign. If failed, this means we don't have enough MMIO
>> space.
>
>How about this text:
>
>  This is because the alignment required for the VF(n) BAR space is the size
>  of an individual VF BAR, not the size of the space for *all* VFs.  But we
>  want additional alignment to support partitioning on PowerNV.
>
>  Consider the additional IOV BAR alignment when sizing and assigning
>  resources.  When there is not enough system MMIO space to accomodate both
>  the requested list and the additional list, the PF's IOV BAR alignment will
>  not contribute to the bridge.  When there is enough system MMIO space for
>  both lists, the additional alignment will contribute to the bridge.
>
>We're doing something specifically for PowerNV.  I would really like to be
>able to read this patch and say "Oh, here's the hook where we get the
>PowerNV behavior, and it's obvious that other platforms are unaffected."
>But I don't see a pcibios or similar hook, so I don't know where that
>PowerNV behavior is.
>
>Is it something to do with get_res_add_align()?  That uses min_align, but I
>don't know how that's connected ...  ah, I see, "add_align" is computed
>from pci_resource_alignment(), which has this path:
>
>  pci_resource_alignment
>    pci_sriov_resource_alignment
>      pcibios_iov_resource_alignment
>
>and powerpc has a special pcibios_iov_resource_alignment() for PowerNV.
>

Thanks for the text. I have added these in the change log and some description
about how it give arch a chance to be involved.

>> >> Also, take advantage of pci_dev_resource::min_align to store this
>> >> additional alignment.
>> >
>> >This comment doesn't seem to make sense; this patch doesn't save anything
>> >in min_align.
>> 
>> At the end of this patch:
>> 
>>    add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
>> 
>> The add_align is stored in pci_dev_resource::min_align in add_to_list(). And
>> retrieved by get_res_add_align() in below code. This field is not used
>> previously, so I took advantage of this field to store the alignment of the
>> additional resources.
>
>Hmm.  pci_dev_resource::min_align *is* already used in
>reassign_resources_sorted().  Maybe there's no overlap; I gave up the
>analysis before I could convince myself.
>

Bjorn,

I know you may have some concern on this, let me try to explain how I
understand the code. If my understanding is not correct, please let me know.

In __assign_resources_sorted(), we pass two resources list, one is required
and the other is the additional. First, we try our best to assigned both of
them by merge them together. If this fails, we will assign the required list
first and then take care of the additional list.

There is one interesting thing in the first step. We merge these two list to
the required list and in this patch I fix the alignment in required list.
(Which is the "head" list in code.) And before doing so, we save the original
information in "save_head". When we fail to assign the merged list, we will
restore the required list, this mean we clean the alignment done in this patch
and make sure we assign the required resource just with basic alignment.

The usage of the min_align in reassign_resources_sorted() happens in the
second part to assign the additional list individually. In the realloc_head
list, those resources still have the add_align which is calculated in
pbus_size_mem(). And we try to allocate it with this alignment, which is
exactly what we want.

BTW, by reading the code again, it looks I missed to change one place in
reassign_resources_sorted(). In condition when (!resource_size(res)) is true,
we rely on the res->start to be the alignment. Since the alignment is no
longer the start address, we need to fix this part too.

I may miss some background of the code, if my understanding is not correct,
glad to hear from you.

>The changelog needs to mention the add_to_list() connection.
>

Added in the change log.

>> >> +		/*
>> >> +		 * There are two kinds of additional resources in the list:
>> >> +		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
>> >> +		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
>> >> +		 * Here just fix the additional alignment for bridge
>> >> +		 */
>> >> +		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
>> >> +			continue;
>> >> +
>> >> +		add_align = get_res_add_align(realloc_head, dev_res->res);
>> >> +
>> >> +		/* Reorder the list by their alignment */
>> >
>> >Why do we need to reorder the list by alignment?
>> 
>> Resource list "head" is sorted by the alignment, while the alignment would be
>> changed after we considering the additional resource.
>> 
>> Take powernv platform as an example. The IOV BAR is expanded and need to be
>> aligned with its total size instead of the individual VF BAR size. If we don't
>> reorder it, the IOV BAR would be assigned after some other resources, which
>> may cause the real assignment fail even the total size is enough.
>
>This is worthy of a comment in the code.
>
>Bjorn
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me
