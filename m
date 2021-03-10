Return-Path: <SRS0=GP0G=II=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7274EC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 01:23:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DD0650F2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 01:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DD0650F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DwDq74fkQz3cZx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 12:23:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=bzYrsE8a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f;
 helo=mail-pl1-x62f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=bzYrsE8a; dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DwDpg1v2Cz30L4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Mar 2021 12:22:48 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id w7so4157439pll.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Mar 2021 17:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=/0T9Q/3VYJdpmRDY2Zb62s1teTncsS5cl8cP6z35CcM=;
 b=bzYrsE8ab+hzvJInwNOsFN4tTFMxA3qcocbvzHxjAO+IZcW33em6ESOnW76SumDCG2
 4F4fPJgaw/SirzDK/hcDZd3An6x3E4pjnWpvEv3XQ5OU62l3Q5p0L77dekVecVmuT86C
 7Iiig07OyeyjTTiQ5d8+bZGuqLuQ03Aa8jg0SAQxiWEGhIBwsT6iM4vte8IznTM7Tz68
 05WuF8Oxpiv33TLgJ/8QaDhquImZIqHbXSsNxVpRGMzKHXKFX1XQVQcek5sp12oZRDfp
 EJHup+icXOeseFDB5S0sriXGqfrWYGDvMMoBE9AN/2RwlMnlgVbC8mx3Tlkq28YJZG4v
 gabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=/0T9Q/3VYJdpmRDY2Zb62s1teTncsS5cl8cP6z35CcM=;
 b=kyO43kwSHmBamQT9E+1voDoq4qvC0C/G6c5DCFzw8H3jpSwUh3alhi54oXimiA4+qt
 +e1kPJNXnnKkdmv1JCBP+qDZIuwZmb7przsejtHbLD0g9mCtfDsmjicecFUSoxIhi49+
 j94k/YiGMI3XnWL/CfzYkjhZUeir7hEwIn5Wl7jNScgWF/ZXvdv7yfKqGwkvj62Daj4G
 u7fLnTKTY/tRK9svlrr09FxSjTHU6Iok99oREOMgXtDSWVzcaKg6uVOFPCnOMeROcgVZ
 ib9PL1+X678NRtWWhKrerFN7/gzqKL6k8FUlnR27h8aPZ1xEvcUvbjGXxrcqsu0P7G+8
 fuGA==
X-Gm-Message-State: AOAM531tX2ohjxMLxeNXLba/AlDI38qemvgIudvgFPSd3Uk/eYCcXiho
 Tzc6W9AE6qcEEk+COCbhwN0=
X-Google-Smtp-Source: ABdhPJxTOZjEHZ9m10YEdhbBRQMe0zJEDNi/G7r+9KpnfEzOCSm9nbO3D39CGUHblwkoYfJoKT+e+A==
X-Received: by 2002:a17:90a:bf04:: with SMTP id
 c4mr766670pjs.170.1615339365730; 
 Tue, 09 Mar 2021 17:22:45 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id s194sm14297397pfs.57.2021.03.09.17.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 17:22:45 -0800 (PST)
Date: Wed, 10 Mar 2021 11:22:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 02/43] powerpc/traps: Declare unrecoverable_exception()
 as __noreturn
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
 <f097a1071254e8f6875588f8fb9771467824a569.1615291471.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f097a1071254e8f6875588f8fb9771467824a569.1615291471.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1615339022.cb2m6h66vl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Excerpts from Christophe Leroy's message of March 9, 2021 10:09 pm:
> unrecoverable_exception() is never expected to return, most callers
> have an infiniteloop in case it returns.
>=20
> Ensure it really never returns by terminating it with a BUG(), and
> declare it __no_return.
>=20
> It always GCC to really simplify functions calling it. In the exemple
> below, it avoids the stack frame in the likely fast path and avoids
> code duplication for the exit.
>=20
> With this patch:

[snip]

Nice.

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index a44a30b0688c..d5c9d9ddd186 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -2170,11 +2170,15 @@ DEFINE_INTERRUPT_HANDLER(SPEFloatingPointRoundExc=
eption)
>   * in the MSR is 0.  This indicates that SRR0/1 are live, and that
>   * we therefore lost state by taking this exception.
>   */
> -void unrecoverable_exception(struct pt_regs *regs)
> +void __noreturn unrecoverable_exception(struct pt_regs *regs)
>  {
>  	pr_emerg("Unrecoverable exception %lx at %lx (msr=3D%lx)\n",
>  		 regs->trap, regs->nip, regs->msr);
>  	die("Unrecoverable exception", regs, SIGABRT);
> +	/* die() should not return */
> +	WARN(true, "die() unexpectedly returned");
> +	for (;;)
> +		;
>  }

I don't think the WARN should be added because that will cause another
interrupt after something is already badly wrong, so this might just
make it harder to debug.

For example if die() is falling through for some reason, we warn and
cause a program check here, and that might also be unrecoverable so it
might come through here and fall through again and warn again, etc.

Putting the infinite loop is good enough I think (and better than there=20
was previously).

Otherwise

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
