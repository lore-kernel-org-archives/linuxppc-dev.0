Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93259ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 07:07:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020EF20827
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 07:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbvS1Js0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020EF20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pNyy0WR6zDrYj
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 18:07:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JbvS1Js0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=vinayakm.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JbvS1Js0"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pNwM0L8KzDrPv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 18:04:47 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id z16-v6so8209456wrv.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 23:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wTJJuCIh981c/podzqokFm77abQxsRUvn3nOyTQ9lic=;
 b=JbvS1Js0bQAVhZ3NPshUyGy5EeQsED/mgXOZeLb6/+5mlYx+IYAw/pCqZwSMSCpPR4
 h1051htvcNuQqsR7xwwQLiT+GAjzs4yMfb85ff7cW1Vubo1yShlEQ9aX9LrIXPNijK/d
 BhSSCBgGcNknMqGe4YX4eGUQ9VzWLelA0O20K7QN2GbBrsOKq8BlHiVYWiKdU8Xi8CFL
 IRQhxJ6kWfPKIDiO6KBBu24zuOaWOhmXkzUThdawUr2O56IqMoTfLGKDma0B0Ss2+Rg2
 gOekolpSph2qAWxWU8RAHjaL3SuLatOTYAlu9qXlEjFq+l1pXHNg20U/9ksvyx+LMXgD
 OFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wTJJuCIh981c/podzqokFm77abQxsRUvn3nOyTQ9lic=;
 b=G4G3wsyenOz/ausj1S2pvUD8cmfZof4olujBq4aXGKKNcbq9+u35Ne0DqdY1DVrvu8
 GF+t/u9RtEuNnRPJUuX0mnG/6VO8xWGSq5o1oQzs86NvN4Ib6+2CKgU/OPPLo15+7sXR
 KwqemCjwxbyhW1cD3dhoU3n7tU5BFSktebXKy1ZyFdAz+9zagd5vDySk0zNRwhcP/LV6
 hYZ4a6Up8cQvze8mqZpRUKuk/2fQBmZQgXwt6QeseJR2AOugQWcpqA5+xGSDp2udG/FJ
 4thLiVhPp16PECEyD/jW9d5PyZtmvDl5dd7Cx3maHUYsVXnOaNMe1eg2MzCCvPSJobiO
 sYxQ==
X-Gm-Message-State: AGRZ1gInPqYo1WjrjxkebFKlkLAOh3/Vw5IXBYePfYcjzCpw6oknY+S6
 HY2+AgbOlw3saP3bzbyKEXdEBXCFAnHD9L4Hu6A=
X-Google-Smtp-Source: AJdET5f/PXcCz0OeMLtIYK45nuyk38c2Mn/AYkyLVrI18sYP44MaBz2jwWftm1dzbLVq+JRxBtEgHVsVmTGFVe5oLV4=
X-Received: by 2002:adf:aa05:: with SMTP id
 p5-v6mr19549114wrd.56.1541401484893; 
 Sun, 04 Nov 2018 23:04:44 -0800 (PST)
MIME-Version: 1.0
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1526555193-7242-11-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1526555193-7242-11-git-send-email-ldufour@linux.vnet.ibm.com>
From: vinayak menon <vinayakm.list@gmail.com>
Date: Mon, 5 Nov 2018 12:34:33 +0530
Message-ID: <CAOaiJ-nJ_=+diXz8ji42Rro3Mj16C1=NpenRuY3-mjs_GhR4mA@mail.gmail.com>
Subject: Re: [PATCH v11 10/26] mm: protect VMA modifications using VMA
 sequence count
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: jack@suse.cz, sergey.senozhatsky.work@gmail.com,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, paulus@samba.org,
 punitagrawal@gmail.com, hpa@zytor.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, khandual@linux.vnet.ibm.com,
 Andrea Arcangeli <aarcange@redhat.com>, ak@linux.intel.com,
 Minchan Kim <minchan@kernel.org>, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, npiggin@gmail.com,
 Jerome Glisse <jglisse@redhat.com>, dave@stgolabs.net, kemi.wang@intel.com,
 kirill@shutemov.name, Thomas Gleixner <tglx@linutronix.de>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>, yang.shi@linux.alibaba.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Vinayak Menon <vinmenon@codeaurora.org>, aneesh.kumar@linux.vnet.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Laurent,

On Thu, May 17, 2018 at 4:37 PM Laurent Dufour
<ldufour@linux.vnet.ibm.com> wrote:
>
> The VMA sequence count has been introduced to allow fast detection of
> VMA modification when running a page fault handler without holding
> the mmap_sem.
>
> This patch provides protection against the VMA modification done in :
>         - madvise()
>         - mpol_rebind_policy()
>         - vma_replace_policy()
>         - change_prot_numa()
>         - mlock(), munlock()
>         - mprotect()
>         - mmap_region()
>         - collapse_huge_page()
>         - userfaultd registering services
>
> In addition, VMA fields which will be read during the speculative fault
> path needs to be written using WRITE_ONCE to prevent write to be split
> and intermediate values to be pushed to other CPUs.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  fs/proc/task_mmu.c |  5 ++++-
>  fs/userfaultfd.c   | 17 +++++++++++++----
>  mm/khugepaged.c    |  3 +++
>  mm/madvise.c       |  6 +++++-
>  mm/mempolicy.c     | 51 ++++++++++++++++++++++++++++++++++-----------------
>  mm/mlock.c         | 13 ++++++++-----
>  mm/mmap.c          | 22 +++++++++++++---------
>  mm/mprotect.c      |  4 +++-
>  mm/swap_state.c    |  8 ++++++--
>  9 files changed, 89 insertions(+), 40 deletions(-)
>
>  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>                                 struct vm_fault *vmf)
> @@ -665,9 +669,9 @@ static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
>                                      unsigned long *start,
>                                      unsigned long *end)
>  {
> -       *start = max3(lpfn, PFN_DOWN(vma->vm_start),
> +       *start = max3(lpfn, PFN_DOWN(READ_ONCE(vma->vm_start)),
>                       PFN_DOWN(faddr & PMD_MASK));
> -       *end = min3(rpfn, PFN_DOWN(vma->vm_end),
> +       *end = min3(rpfn, PFN_DOWN(READ_ONCE(vma->vm_end)),
>                     PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
>  }
>
> --
> 2.7.4
>

I have got a crash on 4.14 kernel with speculative page faults enabled
and here is my analysis of the problem.
The issue was reported only once.

[23409.303395]  el1_da+0x24/0x84
[23409.303400]  __radix_tree_lookup+0x8/0x90
[23409.303407]  find_get_entry+0x64/0x14c
[23409.303410]  pagecache_get_page+0x5c/0x27c
[23409.303416]  __read_swap_cache_async+0x80/0x260
[23409.303420]  swap_vma_readahead+0x264/0x37c
[23409.303423]  swapin_readahead+0x5c/0x6c
[23409.303428]  do_swap_page+0x128/0x6e4
[23409.303431]  handle_pte_fault+0x230/0xca4
[23409.303435]  __handle_speculative_fault+0x57c/0x7c8
[23409.303438]  do_page_fault+0x228/0x3e8
[23409.303442]  do_translation_fault+0x50/0x6c
[23409.303445]  do_mem_abort+0x5c/0xe0
[23409.303447]  el0_da+0x20/0x24

Process A accesses address ADDR (part of VMA A) and that results in a
translation fault.
Kernel enters __handle_speculative_fault to fix the fault.
Process A enters do_swap_page->swapin_readahead->swap_vma_readahead
from speculative path.
During this time, another process B which shares the same mm, does a
mprotect from another CPU which follows
mprotect_fixup->__split_vma, and it splits VMA A into VMAs A and B.
After the split, ADDR falls into VMA B, but process A is still using
VMA A.
Now ADDR is greater than VMA_A->vm_start and VMA_A->vm_end.
swap_vma_readahead->swap_ra_info uses start and end of vma to
calculate ptes and nr_pte, which goes wrong due to this and finally
resulting in wrong "entry" passed to
swap_vma_readahead->__read_swap_cache_async, and in turn causing
invalid swapper_space
being passed to __read_swap_cache_async->find_get_page, causing an abort.

The fix I have tried is to cache vm_start and vm_end also in vmf and
use it in swap_ra_clamp_pfn. Let me know your thoughts on this. I can
send
the patch I am a using if you feel that is the right thing to do.

Thanks,
Vinayak
