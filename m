Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37CCC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 03:56:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244A02175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 03:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va7Lbx3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244A02175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w4HJ4xDGzDqL2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 14:56:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w4FW5XC8zDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 14:54:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Va7Lbx3/"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43w4FW45tPz8tPg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 14:54:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43w4FW3G6Tz9sMM; Thu,  7 Feb 2019 14:54:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Va7Lbx3/"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43w4FV3sQ8z9s9G
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 14:54:38 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id s1so4158842plp.9
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2019 19:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=vc8cMYF1L6gKIfL6zWo/1A6Usypbec7RL0TLyAaFAsY=;
 b=Va7Lbx3//9kReCwawXgxZg7fBu1QeF05AwsXKTY9ithupdLxRYB/wo7V6MaUOuq+Tr
 n6x4wAErss/TRF7ERFNLn1qaZGXazzM1MPew2gqVTEHbg176vrdpdH5np4KU+U0Gatov
 b/iFWu5dmM6jMb3kJHrllnco4jidwRPyze4602jg7Qm/cqxd6b/Tbxr16OIVeHve7zym
 48MMGlk0UTbDzbXdpbuTIGWqlE2xw0cytJTuSPz0LVBHjMvaEmEcav513xVwQj3PICRS
 NxBG6V9GkEnHFecjmaaMOoLyVaqytuEpb3/Bt6qLceEmJRXIjKSJpvedK7Dom6XQ9jee
 zebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=vc8cMYF1L6gKIfL6zWo/1A6Usypbec7RL0TLyAaFAsY=;
 b=WrGlwjgqIYq4dQwdiZ5e2dFndLQeEW5w6/6Lg3iI1MWorG7A+ZgkAPFHpWwJMpy8Yw
 MSM3tVxF08Woz1MhPNdNkadEKigToTf76Y9y78R6bNdOs0EluBef08OMJz/cKVWrd96/
 joXkvU8fj6/ax5lG2mm6Y9rB78GTosEeHve9pWDaVMPq3b5Y3o1yp9EfvoMiLsm4NO8+
 FVFTvPumOayw3oOmjYKuvLEGYcEy0TJuGC9Ou0ViNP5rJ4RjdcstTA9fZpNt3JGLvn97
 0n0ydQ4JXHzKn8MR+3aSPN29SySW5e1EQIp9usmlfWtEQZ3yIaTRy1xSp3CBYnLJ1eoH
 lMfw==
X-Gm-Message-State: AHQUAuYuMad1mdt2xuprR4fBYjCDI7YZrd9i6uTDlq7nVW2MygQ4GmAp
 srNYhIH1oowvSTTATMKrrFZQ9o9PxU8=
X-Google-Smtp-Source: AHgI3IauhEu7sXBrkEv90GkPIeHE6jN7rORwOXBYiuKjIqRx0jr5gqF2ut6iGXOiJs7DWgXPDke2vw==
X-Received: by 2002:a17:902:5066:: with SMTP id
 f35mr14479997plh.78.1549511676596; 
 Wed, 06 Feb 2019 19:54:36 -0800 (PST)
Received: from localhost (193-116-103-101.tpgi.com.au. [193.116.103.101])
 by smtp.gmail.com with ESMTPSA id d11sm9266581pgi.25.2019.02.06.19.54.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 19:54:35 -0800 (PST)
Date: Thu, 07 Feb 2019 13:54:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v16 01/21] powerpc/irq: use memblock functions returning
 virtual address
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-2-mpe@ellerman.id.au>
In-Reply-To: <20190205113219.17903-2-mpe@ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1549511172.79hcj41212.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman's on February 5, 2019 9:31 pm:
> From: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> Since only the virtual address of allocated blocks is used,
> lets use functions returning directly virtual address.
>=20
> Those functions have the advantage of also zeroing the block.
>=20
> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/irq.c      |  5 -----
>  arch/powerpc/kernel/setup_32.c | 26 ++++++++++++++++----------
>  arch/powerpc/kernel/setup_64.c | 19 +++++++------------
>  3 files changed, 23 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index bb299613a462..4a5dd8800946 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -725,18 +725,15 @@ void exc_lvl_ctx_init(void)
>  #endif
>  #endif
> =20
> -		memset((void *)critirq_ctx[cpu_nr], 0, THREAD_SIZE);
>  		tp =3D critirq_ctx[cpu_nr];
>  		tp->cpu =3D cpu_nr;
>  		tp->preempt_count =3D 0;
> =20
>  #ifdef CONFIG_BOOKE
> -		memset((void *)dbgirq_ctx[cpu_nr], 0, THREAD_SIZE);
>  		tp =3D dbgirq_ctx[cpu_nr];
>  		tp->cpu =3D cpu_nr;
>  		tp->preempt_count =3D 0;
> =20
> -		memset((void *)mcheckirq_ctx[cpu_nr], 0, THREAD_SIZE);
>  		tp =3D mcheckirq_ctx[cpu_nr];
>  		tp->cpu =3D cpu_nr;
>  		tp->preempt_count =3D HARDIRQ_OFFSET;
> @@ -754,12 +751,10 @@ void irq_ctx_init(void)
>  	int i;
> =20
>  	for_each_possible_cpu(i) {
> -		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
>  		tp =3D softirq_ctx[i];
>  		tp->cpu =3D i;
>  		klp_init_thread_info(tp);
> =20
> -		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
>  		tp =3D hardirq_ctx[i];
>  		tp->cpu =3D i;
>  		klp_init_thread_info(tp);
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_3=
2.c
> index 947f904688b0..1f0b7629c1a6 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -196,6 +196,17 @@ static int __init ppc_init(void)
>  }
>  arch_initcall(ppc_init);
> =20
> +static void *__init alloc_stack(void)
> +{
> +	void *ptr =3D memblock_alloc(THREAD_SIZE, THREAD_SIZE);
> +
> +	if (!ptr)
> +		panic("cannot allocate %d bytes for stack at %pS\n",
> +		      THREAD_SIZE, (void *)_RET_IP_);
> +
> +	return ptr;
> +}
> +
>  void __init irqstack_early_init(void)
>  {
>  	unsigned int i;
> @@ -203,10 +214,8 @@ void __init irqstack_early_init(void)
>  	/* interrupt stacks must be in lowmem, we get that for free on ppc32
>  	 * as the memblock is limited to lowmem by default */
>  	for_each_possible_cpu(i) {
> -		softirq_ctx[i] =3D (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> -		hardirq_ctx[i] =3D (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> +		softirq_ctx[i] =3D alloc_stack();
> +		hardirq_ctx[i] =3D alloc_stack();
>  	}
>  }
> =20
> @@ -224,13 +233,10 @@ void __init exc_lvl_early_init(void)
>  		hw_cpu =3D 0;
>  #endif
> =20
> -		critirq_ctx[hw_cpu] =3D (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> +		critirq_ctx[hw_cpu] =3D alloc_stack();
>  #ifdef CONFIG_BOOKE
> -		dbgirq_ctx[hw_cpu] =3D (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> -		mcheckirq_ctx[hw_cpu] =3D (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> +		dbgirq_ctx[hw_cpu] =3D alloc_stack();
> +		mcheckirq_ctx[hw_cpu] =3D alloc_stack();
>  #endif
>  	}
>  }
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c
> index 236c1151a3a7..080dd515d587 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -634,19 +634,17 @@ __init u64 ppc64_bolted_size(void)
> =20
>  static void *__init alloc_stack(unsigned long limit, int cpu)
>  {
> -	unsigned long pa;
> +	void *ptr;
> =20
>  	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
> =20
> -	pa =3D memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
> -					early_cpu_to_node(cpu), MEMBLOCK_NONE);
> -	if (!pa) {
> -		pa =3D memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> -		if (!pa)
> -			panic("cannot allocate stacks");
> -	}
> +	ptr =3D memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE,
> +				     MEMBLOCK_LOW_LIMIT, limit,
> +				     early_cpu_to_node(cpu));

This is much nicer. Looks like removing MEMBLOCK_LOW_LIMIT would be a=20
cleanup for generic kernel code. Actually some of these calls are used
only by powerpc (memblock_alloc_base_nid) which probably could get
tidied up. Something for a rainy day or a beginner.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
=
