Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rD8y445ynzDqN0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 06:18:52 +1000 (AEST)
Date: Mon, 23 May 2016 15:17:47 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc32: use stmw/lmw for non volatile registers
 save/restore
Message-ID: <20160523201747.GA11583@gate.crashing.org>
References: <20160523084637.063611A239A@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160523084637.063611A239A@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2016 at 10:46:36AM +0200, Christophe Leroy wrote:
> lmw/stmw have a 1 cycle (2 cycles for lmw on some ppc) in addition
> and implies serialising, however it reduces the amount of instructions
> hence the amount of instruction fetch compared to the equivalent
> operation with several lzw/stw. It means less pressure on cache and
> less fetching delays on slow memory.

lmw/stmw do not work at all in LE mode, on most processors.  This is a
supported configuration.  NAK.

> When we transfer 20 registers, it is worth it.
> gcc uses stmw/lmw at function entry/exit to save/restore non
> volatile register, so lets also do it that way.

No, C code is compiled with -mno-multiple for LE configs.  Saving a few
bytes of code is not "worth it", anyway.

> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -1086,3 +1086,25 @@ relocate_new_kernel_end:
>  relocate_new_kernel_size:
>  	.long relocate_new_kernel_end - relocate_new_kernel
>  #endif
> +
> +_GLOBAL(setjmp)
> +	mflr	r0
> +	li	r3, 0
> +	stw	r0, 0(r3)
> +	stw	r1, 4(r3)
> +	stw	r2, 8(r3)
> +	mfcr	r12
> +	stmw	r12, 12(r3)
> +	blr

This code has been tested?  I very much doubt it.


Segher
