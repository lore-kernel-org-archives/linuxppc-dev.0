Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B60C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 21:30:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F8820850
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 21:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F8820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438ZlP1nXpzDqSg
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 08:30:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438ZjF07RTzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 08:28:17 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 438Zj91vr9z9v0TP;
 Tue,  4 Dec 2018 22:28:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EtCcqisf8DU8; Tue,  4 Dec 2018 22:28:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 438Zj916d5z9v0TN;
 Tue,  4 Dec 2018 22:28:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F57C8B825;
 Tue,  4 Dec 2018 22:28:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id bLVWMpAgvj2x; Tue,  4 Dec 2018 22:28:13 +0100 (CET)
Received: from [192.168.232.3] (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C144A8B800;
 Tue,  4 Dec 2018 22:28:11 +0100 (CET)
Subject: Re: [PATCH] powerpc/32: Move the old 6xx -mcpu logic before the
 TARGET_CPU logic
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20181204205345.9514-1-malat@debian.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <ba978bc1-e137-8abf-01a0-e1c68341a95f@c-s.fr>
Date: Tue, 4 Dec 2018 22:28:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204205345.9514-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/12/2018 à 21:53, Mathieu Malaterre a écrit :
> The code:
> 
>    ifdef CONFIG_6xx
>    KBUILD_CFLAGS          += -mcpu=powerpc
>    endif
> 
> was added in 2006 in commit f48b8296b315 ("[PATCH] powerpc32: Set cpu
> explicitly in kernel compiles"). This change was acceptable since the
> TARGET_CPU logic was 64-bit only.
> 
> Since commit 0e00a8c9fd92 ("powerpc: Allow CPU selection
> also on PPC32") this logic is no longer acceptable after the TARGET_CPU
> specific. It currently appends -mcpu=powerpc at the end of the command
> line, after any TARGET_CPU specific:
> 
>    gcc -Wp,-MD,init/.do_mounts.o.d ...
>      -mcpu=powerpc -mbig-endian -m32 ...
>      -mcpu=e300c2 ...
>      -mcpu=powerpc ...
>      ../init/do_mounts.c
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg142315.html
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/Makefile | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 8a2ce14d68d0..544b30667ea5 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -30,6 +30,10 @@ endif
>   endif
>   endif
>   
> +ifdef CONFIG_6xx
> +KBUILD_CFLAGS		+= -mcpu=powerpc
> +endif
> +

Could you make the patch on top of my serie (ie after the change of 
CONFIG_6xx to CONFIG_BOOK3S_32 ?

The serie is in origin/next-test

Thanks,
Christophe

>   ifeq ($(CROSS_COMPILE),)
>   KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
>   else
> @@ -241,10 +245,6 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
>   # often slow when they are implemented at all
>   KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
>   
> -ifdef CONFIG_6xx
> -KBUILD_CFLAGS		+= -mcpu=powerpc
> -endif
> -
>   cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
>   cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
>   cpu-as-$(CONFIG_E200)		+= -Wa,-me200
> 
