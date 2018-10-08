Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70C5C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:12:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0032084D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1oipPWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0032084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TBQX3wH6zDrJq
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:12:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H1oipPWZ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TBF810gjzF3JT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 18:04:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H1oipPWZ"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42TBF8082Vz8t2S
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 18:04:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42TBF772cWz9sD2; Mon,  8 Oct 2018 18:04:43 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H1oipPWZ"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42TBF65n8Rz9sBh
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2018 18:04:42 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id t70-v6so7372657pgd.12
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2018 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+v9bT0mnPHL8DZDSfnwol5q+b37JczrvqpLCMZXxiX4=;
 b=H1oipPWZc+MKRqs7t5x1uc4BUspsCfMr1D/j4Tk0/AzMOCRrjYL2Ob6wgGPu+eXDUK
 fuerBmgxo6v7owjbHfCzucBvmby5wOmyghN9T2MSnOSv2TYsnhKs5rMKY024OdGayOuJ
 rTElk5aBH/npmDLp+eBkGIGeVCdCtnUiFv7PckGi+8QUfQgQQQcuZtV5T4NHZ84v+Z4P
 qsiy4d4wc/oaSNFNegghWBwweVXSP7To5ff3Ku7tIxdObJzUR8ubkvQCHFQMWjbEEM1A
 IRs9EN1aeLWv9ggVazeZImm6d8eHoleEZbjgGHt9s2vO45NS4UNwDIoZptH+8H/BkJCj
 RaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+v9bT0mnPHL8DZDSfnwol5q+b37JczrvqpLCMZXxiX4=;
 b=pHJD0sknFmKqy4pEc78B5SugqjmeF4r+cR2UMAhB3jjgEPes0ZNARcyYCYSGe6kpcH
 VcDT1b/vbgnI0X3FibY5TrhRb1LGYq/s2C76vRh+9Dvum0+HT8ygR0iaB9qM3vHVGdug
 GlAxCuufgsGLwPmXziIqRPHPr++i81C2wG1Iw4o4sPpcE00GaSUbjbbD0bNBbp/SitlL
 aG/0Us9EIyl1FA8NKkXY984WnYtNfm6YAPWEnV/ohhXCanY7HuGZlbqEUHi88udKIA2H
 PAGk2hWuilpWbEtYgEUKWJ9gtcO9BdW2rPoUSFZylivG494MMrBp53r5TfGf4VhRLick
 IyPA==
X-Gm-Message-State: ABuFfohKCqU4/Z+Xxtzr94vqn4QuA0t+dxRh9zyqrOaxgHQwZUK3xuUL
 pH3a52zJC+Mjupz0gc6tvfE=
X-Google-Smtp-Source: ACcGV60SBHjEqumsgVkBiCoSmHxXpTGMyUd9tGiRPxfnoQue3NUBGgYkI85bUgBKX7pCOfYE/sya7w==
X-Received: by 2002:a62:f553:: with SMTP id
 n80-v6mr23563853pfh.59.1538982280493; 
 Mon, 08 Oct 2018 00:04:40 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([210.185.78.74])
 by smtp.gmail.com with ESMTPSA id 76-v6sm29562665pfk.134.2018.10.08.00.04.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Oct 2018 00:04:39 -0700 (PDT)
Date: Mon, 8 Oct 2018 17:04:35 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix HMIs on big-endian with CONFIG_RELOCATABLE=y
Message-ID: <20181008170435.0ef2d573@roar.ozlabs.ibm.com>
In-Reply-To: <e4bfa53ea8c777105359e1770df906909dde2c57.camel@kernel.crashing.org>
References: <e4bfa53ea8c777105359e1770df906909dde2c57.camel@kernel.crashing.org>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 08 Oct 2018 15:08:31 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> HMIs will crash the kernel due to
> 
> 	BRANCH_LINK_TO_FAR(hmi_exception_realmode)
> 
> Calling into the OPD instead of the actual code.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This hack fixes it for me, but it's not great. Nick, any better idea ?

Is it a hack because the ifdef gunk, or because there's something
deeper wrong with using the .sym?

I guess all those handlers that load label address by hand could have
the bug silently creep in. Can we have them use the DOTSYM() macro?

Thanks,
Nick

> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index ea04dfb..752709cc8 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1119,7 +1119,11 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
>  	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
>  	EXCEPTION_PROLOG_COMMON_3(0xe60)
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
> +#ifdef PPC64_ELF_ABI_v1
> +	BRANCH_LINK_TO_FAR(.hmi_exception_realmode) /* Function call ABI */
> +#else
>  	BRANCH_LINK_TO_FAR(hmi_exception_realmode) /* Function call ABI */
> +#endif
>  	cmpdi	cr0,r3,0
>  
>  	/* Windup the stack. */
> 
> 

