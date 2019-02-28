Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330FDC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:43:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F7E21850
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0NSmVl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F7E21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44970W5VW7zDqPM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:43:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="U0NSmVl8"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4496x80jf2zDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:40:43 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id w18so13716550itj.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 01:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S26r9EQQiDPxNxYvJmNZCbJAOL1UM5RvwiPMkziSBzg=;
 b=U0NSmVl8J7o8diMWrXaBfCRVVO9hkRPtkZrl6aaI7DAn6GobljIhfpFjav5mIPIS8h
 Jk0/ckQ2BcKcJGSZvPPqxMlWGkVVCunbaOGBPIGjep6k6E67Fut0r+hD1iE5++BFqjW7
 GFWekBaixpATDluYe1h0LFj3/KwhqNt38di+s6OczOUlUI7ibcqMgSsAB/V8h2f/WN7e
 pezFFRymqiaSWEq7rnyCdFnjeYNigblLeWPm32VhX4TIdyBhcjaOdu+k3ZqXMLYzRVWp
 HOphgOgOJxLBW3x+LFR9N7yNccsd8OSEGxbuDGnfHw/ykkEdlnnOnCo+Kh+MTFIcWPku
 xp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S26r9EQQiDPxNxYvJmNZCbJAOL1UM5RvwiPMkziSBzg=;
 b=DJsrNDzz34Jz8UGM6WfD1hClPT8fqUXeWBMf7bWfdktTK2qy4Chp9Rvm8p+7k3zLEu
 78Z4EGKXj2n9ium75fECNRcTH0uxvFWkErA4gUZabe9EuuDoXl1SmC8eqFowBfEsxVM6
 fv4dTjngybFI8SJGENw2BP9f0v1nJwbK9wXC2fyOMpdzA1cWrl/bflmsjSclEOFUA6ZD
 Fvz5auuVyKGNSy7C7drxDz7kOrq/v3/Rbi0lHZkHEqR+b5wkHdVvwBv1fI3A4Bltdxeu
 RI1EWV8ql45+Woz0dezVngM2ltqoHv4nSjlIalMRJoueiuYBguoGKO2gimN7IuKeHT73
 PXww==
X-Gm-Message-State: AHQUAubwMO6rkDPUgVyklcNkgOtez2SZYoyj/9sPt7Osh9YbwQ7dEgwA
 F53x9vuIczdxMpOdXNQzUadDmQRnEr600PY8Uxk=
X-Google-Smtp-Source: APXvYqyLNampIdRkpMVsvaM4M4JZbyfAswlr4iCIih/PAb6NXl9jqGpo35tzyFoMCexDlnISxW3EVxD6yAbte4aapG0=
X-Received: by 2002:a24:5ec1:: with SMTP id h184mr2240354itb.4.1551346840414; 
 Thu, 28 Feb 2019 01:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Thu, 28 Feb 2019 20:40:29 +1100
Message-ID: <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>
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
Cc: Jan Kara <jack@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Ross Zwisler <zwisler@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Add a flag to indicate the ability to do huge page dax mapping. On architecture
> like ppc64, the hypervisor can disable huge page support in the guest. In
> such a case, we should not enable huge page dax mapping. This patch adds
> a flag which the architecture code will update to indicate huge page
> dax mapping support.

*groan*

> Architectures mostly do transparent_hugepage_flag = 0; if they can't
> do hugepages. That also takes care of disabling dax hugepage mapping
> with this change.
>
> Without this patch we get the below error with kvm on ppc64.
>
> [  118.849975] lpar: Failed hash pte insert with error -4
>
> NOTE: The patch also use
>
> echo never > /sys/kernel/mm/transparent_hugepage/enabled
> to disable dax huge page mapping.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> TODO:
> * Add Fixes: tag
>
>  include/linux/huge_mm.h | 4 +++-
>  mm/huge_memory.c        | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 381e872bfde0..01ad5258545e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -53,6 +53,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>                         pud_t *pud, pfn_t pfn, bool write);
>  enum transparent_hugepage_flag {
>         TRANSPARENT_HUGEPAGE_FLAG,
> +       TRANSPARENT_HUGEPAGE_DAX_FLAG,
>         TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
> @@ -111,7 +112,8 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>                 return true;
>
> -       if (vma_is_dax(vma))
> +       if (vma_is_dax(vma) &&
> +           (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_DAX_FLAG)))
>                 return true;

Forcing PTE sized faults should be fine for fsdax, but it'll break
devdax. The devdax driver requires the fault size be >= the namespace
alignment since devdax tries to guarantee hugepage mappings will be
used and PMD alignment is the default. We can probably have devdax
fall back to the largest size the hypervisor has made available, but
it does run contrary to the design. Ah well, I suppose it's better off
being degraded rather than unusable.

>         if (transparent_hugepage_flags &
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index faf357eaf0ce..43d742fe0341 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -53,6 +53,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
>         (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
>  #endif
> +       (1 << TRANSPARENT_HUGEPAGE_DAX_FLAG) |
>         (1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
>         (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
>         (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
> @@ -475,6 +476,8 @@ static int __init setup_transparent_hugepage(char *str)
>                           &transparent_hugepage_flags);
>                 clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>                           &transparent_hugepage_flags);
> +               clear_bit(TRANSPARENT_HUGEPAGE_DAX_FLAG,
> +                         &transparent_hugepage_flags);
>                 ret = 1;
>         }
>  out:

> @@ -753,6 +756,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>         spinlock_t *ptl;
>
>         ptl = pmd_lock(mm, pmd);
> +       /* should we check for none here again? */

VM_WARN_ON() maybe? If THP is disabled and we're here then something
has gone wrong.

>         entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
>         if (pfn_t_devmap(pfn))
>                 entry = pmd_mkdevmap(entry);
> --
> 2.20.1
>
