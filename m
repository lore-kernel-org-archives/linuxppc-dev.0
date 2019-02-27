Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A74C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 03:39:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EC0218E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 03:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="LULeXagi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EC0218E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448LyF0VstzDqLV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 14:39:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="LULeXagi"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448LwV4qXhzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 14:37:29 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id e17so5188482pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=RohVq4bk3hD+d+lcDfCqs9wP1nmCmAOw6y3x+VzbeoM=;
 b=LULeXagikwvRNczIlgV8is8M/5t9TjJ556NKvdVrcFxdsZFDCLQos5vAaL/vi22rOG
 ZY1dAM8gFfpBtqhusmOXkI4KqXeCoh/SsaheplzbV4/tI7WwL36/WNEOSHLo5wNe6jJv
 utrh6TjTfrGLwngpA+2QgojFdPSyQZp7Jm3SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=RohVq4bk3hD+d+lcDfCqs9wP1nmCmAOw6y3x+VzbeoM=;
 b=o8CwuL6u3Um1YfTAS/XC9s7FN9UXqt8af1ncV7rixGWULUqIx2JCswkDJt2oj7WiJS
 5gdgScQFrGCIBi9uw88rsLRUlzoTnM3Le9xj2nLTa3Zqw/MtMccCQxbf53UwmE2fua+i
 XoVCU7TrDVHKdZqMNY8VGbWB6T4zac54GCfhMAT01X6LqiDuMnNn3+/vKXUWS5nqTgAq
 j3eHC1uboWADFCtcKN6TUAwXYLEMtUYUp8uys85FDSn/CJ8RiY4ZcLZ8BIO43kPcL1D2
 AqQDX6x2PYKAFwSJkJ6G4s2Hs0/5U/n59J8O0qSViVeZiEL7p5EM3yJOrA+4nb9BhWe8
 I9Ng==
X-Gm-Message-State: AHQUAuYNpDjjB0mtr+wQY3w33rNubQerawybf0P+3cLiPe3AfeIxGDZv
 hvc2xDJu/puwJTQ4REZx4yGtig==
X-Google-Smtp-Source: AHgI3IYewvpddpw0tBhHi3csYSbtpmZK4HjwqNKYW62ahfIllUELirdtKTH32eSPlfxgcdLao5xK7Q==
X-Received: by 2002:a63:1c02:: with SMTP id c2mr878392pgc.351.1551238646314;
 Tue, 26 Feb 2019 19:37:26 -0800 (PST)
Received: from localhost (203-59-50-226.dyn.iinet.net.au. [203.59.50.226])
 by smtp.gmail.com with ESMTPSA id 10sm32339346pfq.146.2019.02.26.19.37.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 19:37:24 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Diana Craciun <diana.craciun@nxp.com>
Subject: Re: [PATCH] powerpc/fsl: Fix the flush of branch predictor.
In-Reply-To: <dccb392cd3e2b1825608576ecf2487cc5d84466d.1551205086.git.christophe.leroy@c-s.fr>
References: <dccb392cd3e2b1825608576ecf2487cc5d84466d.1551205086.git.christophe.leroy@c-s.fr>
Date: Wed, 27 Feb 2019 14:37:20 +1100
Message-ID: <878sy1aolr.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The commit identified below adds MC_BTB_FLUSH macro only when
> CONFIG_PPC_FSL_BOOK3E is defined. This results in the following error
> on some configs (seen several times with kisskb randconfig_defconfig)
>
> arch/powerpc/kernel/exceptions-64e.S:576: Error: Unrecognized opcode: `mc_btb_flush'
> make[3]: *** [scripts/Makefile.build:367: arch/powerpc/kernel/exceptions-64e.o] Error 1
> make[2]: *** [scripts/Makefile.build:492: arch/powerpc/kernel] Error 2
> make[1]: *** [Makefile:1043: arch/powerpc] Error 2
> make: *** [Makefile:152: sub-make] Error 2
>
> This patch adds a blank definition of MC_BTB_FLUSH for other cases.
>
> Fixes: 10c5e83afd4a ("powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)")
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/exceptions-64e.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 4549ce8d4637..49381f32b374 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -338,6 +338,7 @@ ret_from_mc_except:
>  #define GEN_BTB_FLUSH
>  #define CRIT_BTB_FLUSH
>  #define DBG_BTB_FLUSH
> +#define MC_BTB_FLUSH
>  #define GDBELL_BTB_FLUSH

This seems correct to me:

 - MC_BTB_FLUSH gets a definition in the CONFIG_PPC_FSL_BOOK3E case.

 - other things that are defined in the FSL_BOOK3E case get empty
   definitions in the #else branch, but MC_BTB_FLUSH doesn't.

 - this patch just adds that empty definition.

 - there are no other definitions of MC_BTB_FLUSH that should be used
   instead.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

>  #endif
>  
> -- 
> 2.13.3
