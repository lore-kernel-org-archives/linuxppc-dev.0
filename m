Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD7C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:31:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BB8214C4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BB8214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TxRR17lYzDqlD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:31:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TxMM4lVFzDrQ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 23:27:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42TxML5vRHz8t7b
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 23:27:42 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42TxML3rhVz9s8F; Tue,  9 Oct 2018 23:27:42 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42TxMK5Hrzz9s7h
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2018 23:27:41 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w99CRVWN010430;
 Tue, 9 Oct 2018 07:27:32 -0500
Message-ID: <7214513011238e4e7efd3a9451409a7999f4644a.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix HMIs on big-endian with CONFIG_RELOCATABLE=y
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 09 Oct 2018 23:27:31 +1100
In-Reply-To: <87tvlv1k3u.fsf@concordia.ellerman.id.au>
References: <e4bfa53ea8c777105359e1770df906909dde2c57.camel@kernel.crashing.org>
 <20181008170435.0ef2d573@roar.ozlabs.ibm.com>
 <898c4d47e80562b843fcf4c7ba03eb6f4c9c5d5b.camel@kernel.crashing.org>
 <87tvlv1k3u.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-09 at 21:37 +1100, Michael Ellerman wrote:
> Technically yes. But I thought because we build with mcmodel=medium
> we'll never actually get multiple TOCs in the kernel itself, so it
> doesn't actually matter.
> 
> So this seems to work for now:

Ok, fine. I forgot about DOTSYM. Will do for now.

Cheers,
Ben.

> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 301a6a86a20f..e5566e248a02 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1149,7 +1149,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
>  	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
>  	EXCEPTION_PROLOG_COMMON_3(0xe60)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	BRANCH_LINK_TO_FAR(hmi_exception_realmode) /* Function call ABI */
> +	BRANCH_LINK_TO_FAR(DOTSYM(hmi_exception_realmode)) /* Function call ABI */
>  	cmpdi	cr0,r3,0
>  
>  	/* Windup the stack. */
> 
> 
> cheers

