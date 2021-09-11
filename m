Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63170C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 15:35:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700FB61205
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 15:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 700FB61205
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6Gz84Myrz2yWt
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Sep 2021 01:35:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6Gyc1DzNz2xv8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Sep 2021 01:35:00 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4H6GyR4H6fz9sX6;
 Sat, 11 Sep 2021 17:34:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o_KNaW9TnEo4; Sat, 11 Sep 2021 17:34:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4H6GyR2WJPz9sWt;
 Sat, 11 Sep 2021 17:34:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 351398B768;
 Sat, 11 Sep 2021 17:34:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1Bo0Q-pGQz96; Sat, 11 Sep 2021 17:34:55 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.127])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F3FE68B763;
 Sat, 11 Sep 2021 17:34:53 +0200 (CEST)
Subject: Re: [PATCH 06/10] powerpc: remove GCC version check for UPD_CONSTR
To: Nick Desaulniers <ndesaulniers@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-7-ndesaulniers@google.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <10516ec8-2650-3984-76a0-b38245527443@csgroup.eu>
Date: Sat, 11 Sep 2021 17:34:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210910234047.1019925-7-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
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
Cc: Arnd Bergmann <arnd@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 11/09/2021 à 01:40, Nick Desaulniers a écrit :
> Now that GCC 5.1 is the minimum supported version, we can drop this
> workaround for older versions of GCC. This adversely affected clang,
> too.

Why do you say that GCC 5.1 is the minimum supported ?

As far as I can see, the minimum supported is still 4.9, see 
https://github.com/torvalds/linux/blob/master/Documentation/process/changes.rst

> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>   arch/powerpc/include/asm/asm-const.h | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/asm-const.h b/arch/powerpc/include/asm/asm-const.h
> index 0ce2368bd20f..dbfa5e1e3198 100644
> --- a/arch/powerpc/include/asm/asm-const.h
> +++ b/arch/powerpc/include/asm/asm-const.h
> @@ -12,16 +12,6 @@
>   #  define ASM_CONST(x)		__ASM_CONST(x)
>   #endif
>   
> -/*
> - * Inline assembly memory constraint
> - *
> - * GCC 4.9 doesn't properly handle pre update memory constraint "m<>"
> - *
> - */
> -#if defined(GCC_VERSION) && GCC_VERSION < 50000
> -#define UPD_CONSTR ""
> -#else
>   #define UPD_CONSTR "<>"
> -#endif

There is no point in keeping UPD_CONSTR if it becomes invariant. You 
should just replace all instances of UPD_CONSTR with <> and drop 
UPD_CONSTR completely.

Christophe
