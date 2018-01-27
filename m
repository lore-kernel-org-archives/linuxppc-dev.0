Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zTBJ94rtdzDqH0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 21:06:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Add POWER9 copy_page() loop
In-Reply-To: <20170320234046.32718-1-anton@ozlabs.org>
References: <20170320234046.32718-1-anton@ozlabs.org>
Date: Sat, 27 Jan 2018 21:06:32 +1100
Message-ID: <87bmhf39av.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@ozlabs.org> writes:

> From: Anton Blanchard <anton@samba.org>
>
> Add a POWER9 optimised copy_page() loop. This loop uses the new D form
> vector loads and stores, and uses dcbz to pre zero the destination.
>
...
> +
> +#ifdef CONFIG_ALTIVEC
> +	mflr	r0
> +	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
> +	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
> +	std	r0,16(r1)
> +	stdu	r1,-STACKFRAMESIZE(r1)
> +	bl	enter_vmx_copy
> +	cmpwi	r3,0
> +	ld	r0,STACKFRAMESIZE+16(r1)
> +	ld	r3,STK_REG(R31)(r1)
> +	ld	r4,STK_REG(R30)(r1)
> +	addi	r1,r1,STACKFRAMESIZE
> +	mtlr	r0
> +
> +	li	r0,((PAGE_SIZE/128)-2)
> +	mtctr	r0
> +
> +	li	r8,256
> +
> +	beq	.Lnonvmx_copy
> +
> +	.balign 16
> +1:	dcbz	r8,r3
> +	lxv	vs32,0(r4)
> +	lxv	vs33,16(r4)

Unfortunately this doesn't build:

  arch/powerpc/lib/copypage_power9.S: Assembler messages:
  arch/powerpc/lib/copypage_power9.S:66: Error: unrecognized opcode: `lxv'
  arch/powerpc/lib/copypage_power9.S:67: Error: unrecognized opcode: `lxv'
  arch/powerpc/lib/copypage_power9.S:68: Error: unrecognized opcode: `stxv'
  arch/powerpc/lib/copypage_power9.S:69: Error: unrecognized opcode: `stxv'


Presumably we need to a .long macro version for older toolchains?

cheers
