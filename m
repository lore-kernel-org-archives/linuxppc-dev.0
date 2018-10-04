Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15247C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:57:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4D52098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="piO/SYBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4D52098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QkGR40syzDqKg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 16:57:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="piO/SYBV";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QjMV1xSXzF3Bd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 16:16:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="piO/SYBV"; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42QjMT4s26z9s7T;
 Thu,  4 Oct 2018 16:16:37 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538633797; bh=K0YCHGuKRPgP095BvoT/r+134UHTCEA8KCMWpWPu81o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=piO/SYBVNOlKqnB6zVeSJoae19HAlyiYBkW0iDIPUJESRyHE9hrX+/tc3a359vDM3
 z6wJ9IxLUafFrNEeiGWXG9WTs4jKGvtLknQc5EpgsqZCfXda2cCOhRKDHjb8azxuCE
 px9EJKqXypIym3OUdJPce+sRuJkfAVAyEXL1cP0bZvwHFGkowd5dUaSBurEcpJsvXe
 zSt1mU1DoQLhpxWXH3AHfeUvIY5iqk0dZVcSbKgz9WcANChhgyyrfNGIJHMQtXtYu6
 l64t7Z2OfQK119vbKhvEUD7lyRZi4gy7Wo9Xw/WxqfYVvzyO1hkdPVgHOPYUw91xg0
 eaOvtdYi1fyIA==
Date: Thu, 4 Oct 2018 16:16:36 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH] powerpc: Add doorbell tracepoints
Message-ID: <20181004161636.3940033e@kryten>
In-Reply-To: <32bd00f1b50f77f7c58972d72e8459a72317204b.camel@russell.cc>
References: <20181003002957.7711-1-anton@ozlabs.org>
 <32bd00f1b50f77f7c58972d72e8459a72317204b.camel@russell.cc>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Russell,

> snowpatch builds failed for this patch on all 64-bit configurations
> (ppc64e, ppc64 and ppc64le) with the following:

Thanks! Stupid bug on my part, need more quilt ref. Update to follow.

Anton

> arch/powerpc/kernel/dbell.c:85:9: error: undefined identifier
> 'trace_doorbell_entry'
> arch/powerpc/kernel/dbell.c:96:9: error: undefined identifier
> 'trace_doorbell_exit'
> ./arch/powerpc/include/asm/spinlock.h:171:9: warning: context
> imbalance in 'key_user_put' - unexpected unlock
> arch/powerpc/kernel/dbell.c: In function 'doorbell_exception':
> arch/powerpc/kernel/dbell.c:85:2: error: implicit declaration of
> function 'trace_doorbell_entry'; did you mean 'trace_irq_entry'?
> [-Werror=implicit- function-declaration]
>   trace_doorbell_entry(regs);
>   ^~~~~~~~~~~~~~~~~~~~
>   trace_irq_entry
> arch/powerpc/kernel/dbell.c:96:2: error: implicit declaration of
> function 'trace_doorbell_exit'; did you mean 'trace_irq_exit'?
> [-Werror=implicit-function- declaration]
>   trace_doorbell_exit(regs);
>   ^~~~~~~~~~~~~~~~~~~
>   trace_irq_exit
> cc1: all warnings being treated as errors
> scripts/Makefile.build:305: recipe for target
> 'arch/powerpc/kernel/dbell.o' failed make[1]: ***
> [arch/powerpc/kernel/dbell.o] Error 1 Makefile:1060: recipe for
> target 'arch/powerpc/kernel' failed
> 
> So does something else need to check for CONFIG_PPC_DOORBELL maybe?
> 
> You can see the failures here:
> http://patchwork.ozlabs.org/patch/978088/ - output in build_new.log
> (I know it's not pretty in there yet, you can search for "Error 1" to
> find the build failure)
> 
> - Russell
> 
> 

