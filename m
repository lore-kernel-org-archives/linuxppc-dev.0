Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCB4C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 15:39:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B99C218C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Pe+ODxdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B99C218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pSLf3q5PzDq67
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 01:39:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Pe+ODxdg"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pSJ46hMPzDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 01:37:39 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44pSHx3n3Nz9v03N;
 Tue, 23 Apr 2019 17:37:33 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Pe+ODxdg; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id TlVHJQFCEeQw; Tue, 23 Apr 2019 17:37:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44pSHx2lN7z9v03M;
 Tue, 23 Apr 2019 17:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556033853; bh=vFwcJSh1/GqbCWfnNUfdIYbVJNXskPvViKXBLoaJwuo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Pe+ODxdgXXBtKsq0/3OPcKwb2kMTzUP8AKbFPh9+bQaM6R9GeMbYUFca7mUHqF4AU
 z/xbGHumf0lZ+3zfXi58hxB6DISyiUM3NNA4kPRF8IqYU7gZbr0kH944qLe/8qBDOF
 rq5+vrqDN1X8t5RjXKRLp4fpKPml8v6RMNjNvrQ4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F0D8E8B8E7;
 Tue, 23 Apr 2019 17:37:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id DwMiDEufZd-h; Tue, 23 Apr 2019 17:37:34 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1050E8B8C4;
 Tue, 23 Apr 2019 17:37:33 +0200 (CEST)
Subject: Re: [PATCH 10/10] powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for
 PPC64
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <20190409212517.7321-11-linux@rasmusvillemoes.dk>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b5304c4c-736a-fd8b-e025-4ea040f5c346@c-s.fr>
Date: Tue, 23 Apr 2019 17:37:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409212517.7321-11-linux@rasmusvillemoes.dk>
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
Cc: Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 09/04/2019 à 23:25, Rasmus Villemoes a écrit :
> Similar to GENERIC_BUG_RELATIVE_POINTERS, one can now relativize the
> four const char* members of struct _ddebug, thus saving 16 bytes per
> instance (one for each pr_debug(), dev_debug() etc. in a
> CONFIG_DYNAMIC_DEBUG kernel). The asm-generic implementation seems to
> work out-of-the-box, though this is only compile-tested.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   arch/powerpc/Kconfig            | 1 +
>   arch/powerpc/include/asm/Kbuild | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2d0be82c3061..6821c8ae1d62 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -155,6 +155,7 @@ config PPC
>   	select BUILDTIME_EXTABLE_SORT
>   	select CLONE_BACKWARDS
>   	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
> +	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64

Why only PPC64 ? Won't it work with PPC32 ? Or would it be 
counter-performant on 32 bits ?

Christophe

>   	select DYNAMIC_FTRACE			if FUNCTION_TRACER
>   	select EDAC_ATOMIC_SCRUB
>   	select EDAC_SUPPORT
> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index a0c132bedfae..f332e202192a 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -3,6 +3,7 @@ generated-y += syscall_table_64.h
>   generated-y += syscall_table_c32.h
>   generated-y += syscall_table_spu.h
>   generic-y += div64.h
> +generic-y += dynamic_debug.h
>   generic-y += export.h
>   generic-y += irq_regs.h
>   generic-y += local64.h
> 
