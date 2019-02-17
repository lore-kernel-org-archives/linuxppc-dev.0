Return-Path: <SRS0=hR0M=QY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202F3C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 16:31:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A202190C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 16:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Y6JEch+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A202190C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442XYl1WX5zDqM3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 03:31:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Y6JEch+x"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442XWz1HPnzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 03:29:32 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 442XWn4cWcz9v1F5;
 Sun, 17 Feb 2019 17:29:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Y6JEch+x; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7pmp4OfnGaQ5; Sun, 17 Feb 2019 17:29:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 442XWn3JvSz9v0yq;
 Sun, 17 Feb 2019 17:29:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550420965; bh=xSelRrA0Ahg/5qd/UM161URZocZsaGy7b8TFgqqXFx8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Y6JEch+xV4TV9/4mv0aP+TabQ1xg7Q5W1j2iJKOyCCxWPmG/HGbcJd7f4B35nm6eE
 tArifeVyev+krQY8qa4zo3lkFTvfVxbvoeQeIpF+aSUJFwUO/HJwdFV41+DdGba3w8
 vLimYDV2PFzYfO8asM6gk29mLJziTMp7ARPJQdsY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CD6618B77F;
 Sun, 17 Feb 2019 17:29:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id yPeCkIHYn2mv; Sun, 17 Feb 2019 17:29:28 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 645208B74C;
 Sun, 17 Feb 2019 17:29:28 +0100 (CET)
Subject: Re: [RFC PATCH 4/5] powerpc: move KASAN into its own subdirectory
To: Daniel Axtens <dja@axtens.net>, aneesh.kumar@linux.ibm.com,
 bsingharora@gmail.com
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-5-dja@axtens.net>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <252ac94f-1fd6-8df1-9dd3-95ea3d68b67e@c-s.fr>
Date: Sun, 17 Feb 2019 17:29:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190215000441.14323-5-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190217-2, 17/02/2019), Outbound message
X-Antivirus-Status: Clean
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
Cc: linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 15/02/2019 à 01:04, Daniel Axtens a écrit :
> In preparation for adding ppc64 implementations, break out the
> code into its own subdirectory.

That's not a bad idea, arch/powerpc/mm is rather messy with lot of
subarch stuff.

I'll take it in my series.

Christophe

> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>   arch/powerpc/mm/Makefile                                | 4 +---
>   arch/powerpc/mm/kasan/Makefile                          | 5 +++++
>   arch/powerpc/mm/{kasan_init.c => kasan/kasan_init_32.c} | 0
>   3 files changed, 6 insertions(+), 3 deletions(-)
>   create mode 100644 arch/powerpc/mm/kasan/Makefile
>   rename arch/powerpc/mm/{kasan_init.c => kasan/kasan_init_32.c} (100%)
> 
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index d6b76f25f6de..457c0ea2b5e7 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -7,8 +7,6 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
>   
>   CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
>   
> -KASAN_SANITIZE_kasan_init.o := n
> -
>   obj-y				:= fault.o mem.o pgtable.o mmap.o \
>   				   init_$(BITS).o pgtable_$(BITS).o \
>   				   init-common.o mmu_context.o drmem.o
> @@ -57,4 +55,4 @@ obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
>   endif
>   obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
>   obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
> -obj-$(CONFIG_KASAN)		+= kasan_init.o
> +obj-$(CONFIG_KASAN)		+= kasan/
> diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
> new file mode 100644
> index 000000000000..6577897673dd
> --- /dev/null
> +++ b/arch/powerpc/mm/kasan/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +KASAN_SANITIZE := n
> +
> +obj-$(CONFIG_PPC32)           += kasan_init_32.o
> diff --git a/arch/powerpc/mm/kasan_init.c b/arch/powerpc/mm/kasan/kasan_init_32.c
> similarity index 100%
> rename from arch/powerpc/mm/kasan_init.c
> rename to arch/powerpc/mm/kasan/kasan_init_32.c
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

