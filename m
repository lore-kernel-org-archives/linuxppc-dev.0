Return-Path: <linuxppc-dev+bounces-24724-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2499C531CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 11:10:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5T1V6Tw8z2yFg;
	Thu, 23 Jul 2026 21:10:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.107.17.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784805022;
	cv=none; b=L6DoqfDGHjYE/vyFl17O0nC34sSl47An+HvH7YPxbj6NYjIZT9KUvochDNdxDWX69HjlGcfakXdp267CVZwMLgATVNgfv9hQAIBHAVhJulD5OQE9MhBysEocxHC9Jz6pfQYjDchb8UwI0tCfUxNXJlWwZfydx7KBU7HEIbF56PE8/vPuFsCuI5M53OBev2Xe76LZlVitwSz9Wq55PyGvp9YCgbRN75oja8lNwNqXccB0u1aAw39mQtHonmqxwiwmuM3JqM51Ddrr19O8zU9f9RP77+J0RisvSjtPvtA+YWs4dRKTCkX8RoNaCUVvmfgDtvTmNM5EH8Otd03/uLaPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784805022; c=relaxed/relaxed;
	bh=+8yRl3+wKHI1Im4ejlroA2l39CKtznX/Pg9AZP826js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHh/gL1fcyZsmZPeUQ6HQyNl+jOBAmsje5IeajYTwC2XpjUrOnBgH4h/z9s3eYw8ghdpUQzBsenbPIBe6y8/O6SYkmibgiqyZxJ5W2nc1hroPtwiBYkn/iDMCDI92UHIN9YRsl9gf/y1dL8U7JLb9pJxwu6LLf2p1det4e//d/2KgcfSbMvbUeGze8s3SoTzIoiHYm5IrBupfyV4zSh+s/I7ymG2/QhYQBd08oJgghQH7fX2L3PLsm8fPjdvDe7UUuEFWu6QOP98HZbFdc6TP1vot5exebTxZLQIe/hweW1K9PUNxBRE9fFeF2GOds9Vak7PEilEQhWBuoYVFs216g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass (client-ip=194.107.17.57; helo=vmicros1.altlinux.org; envelope-from=ldv@altlinux.org; receiver=lists.ozlabs.org) smtp.mailfrom=altlinux.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=altlinux.org (client-ip=194.107.17.57; helo=vmicros1.altlinux.org; envelope-from=ldv@altlinux.org; receiver=lists.ozlabs.org)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5T1T2xnmz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 21:10:20 +1000 (AEST)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 1AEC872C8F5;
	Thu, 23 Jul 2026 14:10:16 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 0C0957CCB3A; Thu, 23 Jul 2026 14:10:16 +0300 (IDT)
Date: Thu, 23 Jul 2026 14:10:16 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com,
	kees@kernel.org, luto@amacapital.net, wad@chromium.org,
	mchauras@linux.ibm.com, thuth@redhat.com, ruanjinjie@huawei.com,
	sshegde@linux.ibm.com, akpm@linux-foundation.org,
	charlie@rivosinc.com, deller@gmx.de, macro@orcam.me.uk,
	segher@kernel.crashing.org, peterz@infradead.org,
	bigeasy@linutronix.de, namcao@linutronix.de, tglx@linutronix.de,
	mark.barnett@arm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 5/8] powerpc: add exit_flags field in pt_regs
Message-ID: <20260723111015.GA27638@strace.io>
References: <20260123073916.956498-1-mkchauras@linux.ibm.com>
 <20260123073916.956498-6-mkchauras@linux.ibm.com>
 <20260722070155.GA11808@strace.io>
 <amHfaIAiRu748JBa@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amHfaIAiRu748JBa@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Thu, Jul 23, 2026 at 03:02:38PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Wed, Jul 22, 2026 at 10:01:55AM +0300, Dmitry V. Levin wrote:
> > On Fri, Jan 23, 2026 at 01:09:13PM +0530, Mukesh Kumar Chaurasiya wrote:
> > > From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> > > 
> > > Add a new field `exit_flags` in the pt_regs structure. This field will hold
> > > the flags set during interrupt or syscall execution that are required during
> > > exit to user mode.
> > 
> > Apparently, this change breaks PTRACE_GETREGS as the latter has no means
> > to communicate the size of struct pt_regs being written to userspace.
> > 
> > As result, the kernel with this patch will write to userpsace 32 more
> > bytes than before, and unless the userspace is re-compiled with the latest
> > ptrace.h, 32 bytes of userspace memory after struct pt_regs will be
> > overwritten.
> > 
> > This issue was detected by strace test suite, specifically, the test that
> > checks whether the actual number of bytes written by
> > ptrace(PTRACE_GETREGS) matches sizeof(struct pt_regs), and that test failed
> > with runtime version v7.1 and headers version v7.2-rc1.
> > 
> [...]
> 
> Hey,
> 
> Can you try this fix? This should fix the ABI breakage.
[...]
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index a393b7f2760a..01e630149d48 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -55,8 +55,6 @@ struct pt_regs
>  	unsigned long dar;		/* Fault registers */
>  	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
>  	unsigned long result;		/* Result of a system call */
> -	unsigned long exit_flags;	/* System call exit flags */
> -	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
>  };
>  
>  #endif /* __ASSEMBLER__ */
> @@ -116,12 +114,10 @@ struct pt_regs
>  #define PT_DAR	41
>  #define PT_DSISR 42
>  #define PT_RESULT 43
> -#define PT_EXIT_FLAGS 44
> -#define PT_PAD 47 /* 3 times */
> -#define PT_DSCR 48
> -#define PT_REGS_COUNT 48
> +#define PT_DSCR 44
> +#define PT_REGS_COUNT 44
>  
> -#define PT_FPR0	(PT_REGS_COUNT + 4)	/* each FP reg occupies 2 slots in this space */
> +#define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
>  
>  #ifndef __powerpc64__
>  
> @@ -133,7 +129,7 @@ struct pt_regs
>  #define PT_FPSCR (PT_FPR0 + 32)	/* each FP reg occupies 1 slot in 64-bit space */
>  
>  
> -#define PT_VR0	(PT_FPSCR + 2)	/* <82> each Vector reg occupies 2 slots in 64-bit */
> +#define PT_VR0 82	/* each Vector reg occupies 2 slots in 64-bit */
>  #define PT_VSCR (PT_VR0 + 32*2 + 1)
>  #define PT_VRSAVE (PT_VR0 + 33*2)
>  
> @@ -141,7 +137,7 @@ struct pt_regs
>  /*
>   * Only store first 32 VSRs here. The second 32 VSRs in VR0-31
>   */
> -#define PT_VSR0	(PT_VRSAVE + 2)	/* each VSR reg occupies 2 slots in 64-bit */
> +#define PT_VSR0 150	/* each VSR reg occupies 2 slots in 64-bit */
>  #define PT_VSR31 (PT_VSR0 + 2*31)
>  #endif /* __powerpc64__ */
>  

As this patch essentially reverts the uapi header to its v7.1 state,
the uapi part of the patch is definitely fine.


-- 
ldv

