Return-Path: <SRS0=Lnkm=BC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF3BC433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 06:50:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CFE20709
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 06:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HohM+0bP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CFE20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BC2zB2W8yzDrCt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 16:50:46 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BC2vt2VkqzDrCJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2020 16:47:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=HohM+0bP; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BC2vr4Zfxz9sQt;
 Thu, 23 Jul 2020 16:47:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595486873;
 bh=OeNPhpHvBcuXZex2aPYrGLTVDAkNiyf0rppWSgiCxS8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HohM+0bPBvgVW9/HLN4IMf5yi02AnIfVZnPyIdTtAqHC444cFOH1CKBqWpDM7Lwon
 NsM2R52CvAiwEd0oX+42uRFpfb/YABuNwOZBc3DeK4/+VbhCdDG6tHlBPeBneiYZuW
 x/sjp2Pc9GDKywfRjjOwgwst4SPVzzgNXME3MASoNfD6aqfhLT8wAtukHrEuE6y5h5
 0AOqS5iR7BzgP5uZOc2BfOKaLT4d9hdVadOEuqIlPGilDO/5G5Z+CFWTi+jic2wAc3
 oZ6pwqxKCRUOOvrVii1xzFbG1V85GZ0g85dphJPcJZYxt2e93/P/e/b5BBlJGk5abE
 SUl2R+mpqXtVQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/64s: system call support for scv/rfscv
 instructions
In-Reply-To: <20200611081203.995112-3-npiggin@gmail.com>
References: <20200611081203.995112-1-npiggin@gmail.com>
 <20200611081203.995112-3-npiggin@gmail.com>
Date: Thu, 23 Jul 2020 16:47:51 +1000
Message-ID: <871rl2ralk.fsf@mpe.ellerman.id.au>
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
Cc: libc-dev@lists.llvm.org, musl@lists.openwall.com,
 Nicholas Piggin <npiggin@gmail.com>, linux-api@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 2a39c716c343..b2bdc4de1292 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -257,6 +257,7 @@
>  #define PPC_INST_MFVSRD			0x7c000066
>  #define PPC_INST_MTVSRD			0x7c000166
>  #define PPC_INST_SC			0x44000002
> +#define PPC_INST_SCV			0x44000001
...
> @@ -411,6 +412,7 @@
...
> +#define __PPC_LEV(l)	(((l) & 0x7f) << 5)

These conflicted and didn't seem to be used so I dropped them.

> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 5abe98216dc2..161bfccbc309 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -3378,6 +3382,16 @@ int emulate_step(struct pt_regs *regs, struct ppc_inst instr)
>  		regs->msr = MSR_KERNEL;
>  		return 1;
>  
> +	case SYSCALL_VECTORED_0:	/* scv 0 */
> +		regs->gpr[9] = regs->gpr[13];
> +		regs->gpr[10] = MSR_KERNEL;
> +		regs->gpr[11] = regs->nip + 4;
> +		regs->gpr[12] = regs->msr & MSR_MASK;
> +		regs->gpr[13] = (unsigned long) get_paca();
> +		regs->nip = (unsigned long) &system_call_vectored_emulate;
> +		regs->msr = MSR_KERNEL;
> +		return 1;
> +

This broke the ppc64e build:

  ld: arch/powerpc/lib/sstep.o:(.toc+0x0): undefined reference to `system_call_vectored_emulate'
  make[1]: *** [/home/michael/linux/Makefile:1139: vmlinux] Error 1

I wrapped it in #ifdef CONFIG_PPC64_BOOK3S.

cheers
