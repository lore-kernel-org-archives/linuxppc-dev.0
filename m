Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC374C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 15:55:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CFC206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 15:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CFC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ddNb15W3zDqWH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.167.67; helo=mail-lf1-f67.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ddLN1R0zzDqW7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 02:53:47 +1100 (AEDT)
Received: by mail-lf1-f67.google.com with SMTP id z13so15936831lfe.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 07:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wZITMFUMV0zEIamJ3VVbE4heK6bK4WYzVzsFXzCFVH0=;
 b=mrE2Ieb902oQLoD6xqT30zPFSVMeVPzpaH+MrQOrxk+LyKSUtzxsKMY2UhMyb7i8Eh
 XUvN+7N4EgezfQOS7yBV83Or87NG8tVrmNxO2j0kBkC75yvjmUxGJG+S+fK/kS6PgwVR
 qmhaWd3+0VoKXqDVEIZ2A8PuPwCOd6hlp99lBANVPs5bTu0ihDbIAYczsn/osEuKzD+b
 Q6X34t5zMjbRiZxppZdz8HHS8oF5DDdtXNLNEVNz4pY+WRdgiRYAwOqqGofXt/XM4LJI
 e+0q7dLEOlyTk1J0C338/VMvDNo+qT/Ufh0o/XZP2mC2tkeU1mxbeSrCFYtOY2v2P/zh
 yyKw==
X-Gm-Message-State: AJcUukft+GkDDbh9z6xXnF2YKMNNZXga5+757fsIjBtx2NSN+/nYfEJA
 M85PoOHCpTspvMzGUpwCVsLUaV3HV70HnjNlucG/jw==
X-Google-Smtp-Source: ALg8bN74ZQTuDIjsqUhLgFMGYUxSw81lMr9Ia6Rp9LV1zOdpgU9nkrJsrZPjHC4E0QC4PQUfRTidFXCqru+uICR4BPA=
X-Received: by 2002:ac2:51af:: with SMTP id f15mr13329880lfk.44.1547481224807; 
 Mon, 14 Jan 2019 07:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20190114125903.24845-1-david@redhat.com>
 <20190114125903.24845-8-david@redhat.com>
In-Reply-To: <20190114125903.24845-8-david@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 14 Jan 2019 21:22:49 +0530
Message-ID: <CACi5LpPphoJzfKXPN5kSV42aF27=2ZjqXSVLQjEtMdSN8+6bsA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] arm64: kdump: No need to mark crashkernel pages
 manually PG_reserved
To: David Hildenbrand <david@redhat.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>,
 CHANDAN VN <chandan.vn@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Stefan Agner <stefan@agner.ch>,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Laura Abbott <labbott@redhat.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-m68k@lists.linux-m68k.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 linux-mediatek@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dave Kleikamp <dave.kleikamp@oracle.com>, James Morse <james.morse@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Greg Hackmann <ghackmann@android.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi David,

On Mon, Jan 14, 2019 at 6:30 PM David Hildenbrand <david@redhat.com> wrote:
>
> The crashkernel is reserved via memblock_reserve(). memblock_free_all()
> will call free_low_memory_core_early(), which will go over all reserved
> memblocks, marking the pages as PG_reserved.
>
> So manually marking pages as PG_reserved is not necessary, they are
> already in the desired state (otherwise they would have been handed over
> to the buddy as free pages and bad things would happen).
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Greg Hackmann <ghackmann@android.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: CHANDAN VN <chandan.vn@samsung.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arm64/kernel/machine_kexec.c |  2 +-
>  arch/arm64/mm/init.c              | 27 ---------------------------
>  2 files changed, 1 insertion(+), 28 deletions(-)
>
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 6f0587b5e941..66b5d697d943 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -321,7 +321,7 @@ void crash_post_resume(void)
>   * but does not hold any data of loaded kernel image.
>   *
>   * Note that all the pages in crash dump kernel memory have been initially
> - * marked as Reserved in kexec_reserve_crashkres_pages().
> + * marked as Reserved as memory was allocated via memblock_reserve().
>   *
>   * In hibernation, the pages which are Reserved and yet "nosave" are excluded
>   * from the hibernation iamge. crash_is_nosave() does thich check for crash
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7205a9085b4d..c38976b70069 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -118,35 +118,10 @@ static void __init reserve_crashkernel(void)
>         crashk_res.start = crash_base;
>         crashk_res.end = crash_base + crash_size - 1;
>  }
> -
> -static void __init kexec_reserve_crashkres_pages(void)
> -{
> -#ifdef CONFIG_HIBERNATION
> -       phys_addr_t addr;
> -       struct page *page;
> -
> -       if (!crashk_res.end)
> -               return;
> -
> -       /*
> -        * To reduce the size of hibernation image, all the pages are
> -        * marked as Reserved initially.
> -        */
> -       for (addr = crashk_res.start; addr < (crashk_res.end + 1);
> -                       addr += PAGE_SIZE) {
> -               page = phys_to_page(addr);
> -               SetPageReserved(page);
> -       }
> -#endif
> -}
>  #else
>  static void __init reserve_crashkernel(void)
>  {
>  }
> -
> -static void __init kexec_reserve_crashkres_pages(void)
> -{
> -}
>  #endif /* CONFIG_KEXEC_CORE */
>
>  #ifdef CONFIG_CRASH_DUMP
> @@ -586,8 +561,6 @@ void __init mem_init(void)
>         /* this will put all unused low memory onto the freelists */
>         memblock_free_all();
>
> -       kexec_reserve_crashkres_pages();
> -
>         mem_init_print_info(NULL);
>
>         /*
> --
> 2.17.2

LGTM, so:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
