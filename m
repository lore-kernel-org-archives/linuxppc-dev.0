Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D18C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:29:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428DE20661
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8S90ZEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428DE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437r7M4lYszDqN1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 03:29:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m8S90ZEl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="m8S90ZEl"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437r4R5zvZzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 03:27:19 +1100 (AEDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D350D21582
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543854438;
 bh=qCSsx1ia05y4ES7b0cDduOEngAtMGWrVXunqUEXapJE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=m8S90ZElQ9LfdNGJaukJN5Jwd534aDEzQWDypy4rb5LsZaImTJAeI5g720pRhkL3G
 TpbrScmX2nyywTRCPm8X7PlLFFg9qW1QaWoFAHH8FLYTyAvOgu7nzhZCX5XdFqt2mc
 bgkc0VAiaktGIWz21qPe4c3BzTqxnJqqe/Bm+aFc=
Received: by mail-wr1-f53.google.com with SMTP id 96so12871186wrb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 08:27:17 -0800 (PST)
X-Gm-Message-State: AA+aEWYtQPPRzCgHQHszyfkS45fOHAv6T6xRyAJM8W9oKOPyYFqKIIVM
 IrKfAZk8DhIhPUIiUjj51G8q8nd43u/FPOeBgDYRVA==
X-Google-Smtp-Source: AFSGD/UHg+Rgy6nW0S+kGUDaigts9RFTTI9lSVLk1wtwr1sI5Gf+vkTtl0wYMNx7Mjr/fOrUtrY7vaCYLjg7KDPVzq8=
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr15531587wrf.164.1543854434387; 
 Mon, 03 Dec 2018 08:27:14 -0800 (PST)
MIME-Version: 1.0
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 3 Dec 2018 10:27:02 -0600
X-Gmail-Original-Message-ID: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
Message-ID: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm, unicore32: remove early_alloc*() wrappers
To: rppt@linux.ibm.com
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
Cc: mhocko@suse.com, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 dalias@libc.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 deanbo422@gmail.com, jonas@southpole.se, linux-c6x-dev@linux-c6x.org,
 ysato@users.sourceforge.jp, linux@armlinux.org.uk, msalter@redhat.com,
 Arnd Bergmann <arnd@arndb.de>, stefan.kristiansson@saunalahti.fi,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 shorne@gmail.com, gxt@pku.edu.cn,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 3, 2018 at 9:48 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
> oneliner wrappers for memblock_alloc.
>
> Replace their usage with direct call to memblock_alloc.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/mm/mmu.c       | 11 +++--------
>  arch/unicore32/mm/mmu.c | 12 ++++--------
>  2 files changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 0a04c9a5..57de0dd 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
>
>  #define vectors_base() (vectors_high() ? 0xffff0000 : 0)
>
> -static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
> -{
> -       return memblock_alloc(sz, align);
> -}
> -
>  static void __init *early_alloc(unsigned long sz)

Why not get rid of this wrapper like you do on unicore?

>  {
> -       return early_alloc_aligned(sz, sz);
> +       return memblock_alloc(sz, sz);
>  }
