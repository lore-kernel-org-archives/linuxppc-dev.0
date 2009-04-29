Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA2E2DDF2E
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 22:39:17 +1000 (EST)
Message-Id: <1271A9EB-6489-4A72-B3A0-0C36AEE554CB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20090429072040.A3C761222D@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/2] powerpc: Move VSX load/stores into ppc-opcode.h
Date: Wed, 29 Apr 2009 07:38:41 -0500
References: <20090429072040.A3C761222D@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2009, at 2:20 AM, Michael Neuling wrote:

> Index: linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/ppc-opcode.h
> +++ linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
> @@ -49,6 +49,7 @@
> /* macros to insert fields into opcodes */
> #define __PPC_RA(a)	(((a) & 0x1f) << 16)
> #define __PPC_RB(b)	(((b) & 0x1f) << 11)
> +#define __PPC_XS(s)	((((s) & 0x1f) << 21) | (((s) & 0x20) >> 5))
> #define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
> #define __PPC_WC(w)	(((w) & 0x3) << 21)
>
> @@ -70,4 +71,12 @@
> #define PPC_WAIT(w)		stringify_in_c(.long PPC_INST_WAIT | \
> 					__PPC_WC(w))
>
> +/*
> + * Define what the VSX XX1 form instructions will look like, then add
> + * the 128 bit load store instructions based on that.
> + */
> +#define VSX_XX1(s, a, b)	(__PPC_XS(s) | __PPC_RA(a) | __PPC_RB(b))
> +#define STXVD2X(s, a, b)	.long (0x7c000798 | VSX_XX1((s), (a), (b)))
> +#define LXVD2X(s, a, b)		.long (0x7c000698 | VSX_XX1((s), (a), (b)))
> +

previous gripe of matching style of file for the .long 0x7c000798

- k
