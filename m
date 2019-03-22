Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EB0C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 22:14:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96A121900
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 22:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Zb9Bl7Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96A121900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qycq5VZXzDqTZ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 09:14:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::144; helo=mail-it1-x144.google.com;
 envelope-from=dan.j.williams@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="Zb9Bl7Bn"; 
 dkim-atps=neutral
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QybB1LjLzDqRm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 09:13:09 +1100 (AEDT)
Received: by mail-it1-x144.google.com with SMTP id w18so5874216itj.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 15:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VnWfr5Cz9g8Ts5McgdJK3bb2nMan4nq5nXqWONnMsfs=;
 b=Zb9Bl7Bn4sqZs4rM2mwfzJd7rKnn+/+6ONyGGwJqa1scMrXWXjmi9yoQBAbfMlLpgS
 RGV1LtFJyFJAtRyqt7x4phr5CYLMLHxyjOqtaGBIgKlABbih3LbLp5n0OYCbWIHRLaHd
 TTQ98w8krLJnK39QE8Dp0ik11E8+01Sgyn1wW72V9bUGSzJ08oA4QbCqRZA5AnJQLOtm
 o3basMsLTQYqNorbmDjd4KoyjPrND/z4P2rEoZfVYQnDMfAEdcsp9b63663QinvyZoJp
 HOu5mHwb07RCBU+1v7ChvrPznU5/HmjF8OEnSTsQgs+cld8MrdbVwNZKadLpnlT93nHs
 Yb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VnWfr5Cz9g8Ts5McgdJK3bb2nMan4nq5nXqWONnMsfs=;
 b=haF7f/5l8KH4UQfTMTYH7ehoazoal1zRgYeXb9OvHn3AwkDyPRaL/nTiiPSAQ5f/nc
 hkeaOAtIsHG+4iBKPfO3BCkKjhO0hCKinddk3TbMsVGkU9GejS4cVW4MHxaGFIDCoOi1
 e6yzb7GeWO5VFNU0GZkeRD9DjWLeKfZBLk0si6tSzA7pJrmAJS3oez7uuACdroIdjm/8
 z6oQo7F7TG5RtfmkIgZIodyvoThskHQVzf4YuxeEjnCbsXDqGDhqIksaUKEa4Ge3pCcg
 r/5pP7jdQhT04xdE2qVMk+VQqgbrW54HayUDtbTJr0DYDRZ7Hx5VvYY5CcrRRBlckfAc
 3NXw==
X-Gm-Message-State: APjAAAVt490dQkcxQWZ7SEcZ8M84OQVpvrdWg3geoipOCPsLMjuCZuZa
 ofVtNLFsaTzZvYCXZCyvfz/wQgdjPVAqKmnXnfE=
X-Google-Smtp-Source: APXvYqwPCPjaWzKVXpURWg65K5fkBoLbrluPEoFqqgn2rT6o/InM1ko8UbBUfBaLU8H/oERd+79+VhkVDmrMWUaE2i4=
X-Received: by 2002:a02:c007:: with SMTP id y7mr8517902jai.1.1553292786464;
 Fri, 22 Mar 2019 15:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-5-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-5-ira.weiny@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Mar 2019 15:12:55 -0700
Message-ID: <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
To: ira.weiny@intel.com
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
Cc: Michal Hocko <mhocko@suse.com>, Linux-sh <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> DAX pages were previously unprotected from longterm pins when users
> called get_user_pages_fast().
>
> Use the new FOLL_LONGTERM flag to check for DEVMAP pages and fall
> back to regular GUP processing if a DEVMAP page is encountered.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  mm/gup.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 0684a9536207..173db0c44678 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1600,6 +1600,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>                         goto pte_unmap;
>
>                 if (pte_devmap(pte)) {
> +                       if (unlikely(flags & FOLL_LONGTERM))
> +                               goto pte_unmap;
> +
>                         pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
>                         if (unlikely(!pgmap)) {
>                                 undo_dev_pagemap(nr, nr_start, pages);
> @@ -1739,8 +1742,11 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>         if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
>                 return 0;
>
> -       if (pmd_devmap(orig))
> +       if (pmd_devmap(orig)) {
> +               if (unlikely(flags & FOLL_LONGTERM))
> +                       return 0;
>                 return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
> +       }
>
>         refs = 0;
>         page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> @@ -1777,8 +1783,11 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>         if (!pud_access_permitted(orig, flags & FOLL_WRITE))
>                 return 0;
>
> -       if (pud_devmap(orig))
> +       if (pud_devmap(orig)) {
> +               if (unlikely(flags & FOLL_LONGTERM))
> +                       return 0;
>                 return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
> +       }
>
>         refs = 0;
>         page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> @@ -2066,8 +2075,20 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>                 start += nr << PAGE_SHIFT;
>                 pages += nr;
>
> -               ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
> -                                             gup_flags);
> +               if (gup_flags & FOLL_LONGTERM) {
> +                       down_read(&current->mm->mmap_sem);
> +                       ret = __gup_longterm_locked(current, current->mm,
> +                                                   start, nr_pages - nr,
> +                                                   pages, NULL, gup_flags);
> +                       up_read(&current->mm->mmap_sem);
> +               } else {
> +                       /*
> +                        * retain FAULT_FOLL_ALLOW_RETRY optimization if
> +                        * possible
> +                        */
> +                       ret = get_user_pages_unlocked(start, nr_pages - nr,
> +                                                     pages, gup_flags);

I couldn't immediately grok why this path needs to branch on
FOLL_LONGTERM? Won't get_user_pages_unlocked(..., FOLL_LONGTERM) do
the right thing?
