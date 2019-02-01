Return-Path: <SRS0=xfkn=QI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3D8C282D8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 11:12:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB4321904
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 11:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB4321904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rZFQ2bxLzDqjL
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 22:12:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rZCG5vtgzDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 22:10:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43rZCG05wgz9s4Z;
 Fri,  1 Feb 2019 22:10:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH] powerpc/6xx: Don't set back MSR_RI before reenabling
 MMU
In-Reply-To: <9f9dd859d571e324c7412ed9db9da8cfba678257.1548956511.git.christophe.leroy@c-s.fr>
References: <9f9dd859d571e324c7412ed9db9da8cfba678257.1548956511.git.christophe.leroy@c-s.fr>
Date: Fri, 01 Feb 2019 22:10:30 +1100
Message-ID: <87lg2zojbt.fsf@concordia.ellerman.id.au>
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

> By delaying the setting of MSR_RI, a 1% improvment is optained on
> null_syscall selftest on an mpc8321.
>
> Without this patch:
>
> root@vgoippro:~# ./null_syscall
>    1134.33 ns     378.11 cycles
>
> With this patch:
>
> root@vgoippro:~# ./null_syscall
>    1121.85 ns     373.95 cycles
>
> The drawback is that a machine check during that period
> would be unrecoverable, but as only main memory is accessed
> during that period, it shouldn't be a concern.

On 64-bit server CPUs accessing main memory can cause a UE
(Uncorrectable Error) which can trigger a machine check.

So it may still be a concern, it depends how paranoid you are.

> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index 146385b1c2da..ea28a6ab56ec 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -282,8 +282,6 @@ __secondary_hold_acknowledge:
>  	stw	r1,GPR1(r11);	\
>  	stw	r1,0(r11);	\
>  	tovirt(r1,r11);			/* set new kernel sp */	\
> -	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
> -	MTMSRD(r10);			/* (except for mach check in rtas) */ \
>  	stw	r0,GPR0(r11);	\
>  	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
>  	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \

Where does RI get enabled? I don't see it anywhere obvious.

cheers
