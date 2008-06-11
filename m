Return-Path: <jyoung5@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A6ACDE22C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 04:55:28 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5BItOU9005021
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 14:55:24 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5BItN6L1482822
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 14:55:23 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5BItMru008497
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 12:55:22 -0600
Subject: Re: [PATCH] powerpc/booke: Fix definitions for dbcr[1-2] and dbsr
	registers
From: Jerone Young <jyoung5@us.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0806111336320.28205@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0806111336320.28205@blarg.am.freescale.net>
Content-Type: text/plain
Date: Wed, 11 Jun 2008 13:55:17 -0500
Message-Id: <1213210517.6672.0.camel@thinkpadL>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks good to me. Yeah moving many of the aliases to 40x is much
cleaner.

On Wed, 2008-06-11 at 13:38 -0500, Kumar Gala wrote:
> From: Jerone Young <jyoung5@us.ibm.com>
> 
> This takes values from the PowerPC ISA BookIII-E specifications that are
> for DBCR0. Many of these values are different from those currently
> specified, which are for the ppc405. Also added some bookE definitions
> for DBCR1 & DBCR2.
> 
> [ galak@kernel.crashing.org: Added aliases to 40x DBCR0 to match Book-E,
>   Added enhanced debug DBCR0/DBSR _CIRPT and _CRET defines and DBSR
>   IRPT and RET. ]
> 
> Signed-off-by: Jerone Young <jyoung5@us.ibm.com>
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Jerone, take a look at this one.  Its in the powerpc-next branch of my git
> tree.  Note I've dropped some of the aliases you added and the reason is
> to match the existing DBSR bits.
> 
> - k
> 
>  include/asm-powerpc/reg_booke.h |   53 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 53 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-powerpc/reg_booke.h b/include/asm-powerpc/reg_booke.h
> index cf54a3f..8223254 100644
> --- a/include/asm-powerpc/reg_booke.h
> +++ b/include/asm-powerpc/reg_booke.h
> @@ -210,6 +210,7 @@
>  #ifdef CONFIG_BOOKE
>  #define DBSR_IC		0x08000000	/* Instruction Completion */
>  #define DBSR_BT		0x04000000	/* Branch Taken */
> +#define DBSR_IRPT	0x02000000	/* Exception Debug Event */
>  #define DBSR_TIE	0x01000000	/* Trap Instruction Event */
>  #define DBSR_IAC1	0x00800000	/* Instr Address Compare 1 Event */
>  #define DBSR_IAC2	0x00400000	/* Instr Address Compare 2 Event */
> @@ -219,10 +220,14 @@
>  #define DBSR_DAC1W	0x00040000	/* Data Addr Compare 1 Write Event */
>  #define DBSR_DAC2R	0x00020000	/* Data Addr Compare 2 Read Event */
>  #define DBSR_DAC2W	0x00010000	/* Data Addr Compare 2 Write Event */
> +#define DBSR_RET	0x00008000	/* Return Debug Event */
> +#define DBSR_CIRPT	0x00000040	/* Critical Interrupt Taken Event */
> +#define DBSR_CRET	0x00000020	/* Critical Return Debug Event */
>  #endif
>  #ifdef CONFIG_40x
>  #define DBSR_IC		0x80000000	/* Instruction Completion */
>  #define DBSR_BT		0x40000000	/* Branch taken */
> +#define DBSR_IRPT	0x20000000	/* Exception Debug Event */
>  #define DBSR_TIE	0x10000000	/* Trap Instruction debug Event */
>  #define DBSR_IAC1	0x04000000	/* Instruction Address Compare 1 Event */
>  #define DBSR_IAC2	0x02000000	/* Instruction Address Compare 2 Event */
> @@ -253,6 +258,7 @@
>  #define ESR_BO		0x00020000	/* Byte Ordering */
> 
>  /* Bit definitions related to the DBCR0. */
> +#if defined(CONFIG_40x)
>  #define DBCR0_EDM	0x80000000	/* External Debug Mode */
>  #define DBCR0_IDM	0x40000000	/* Internal Debug Mode */
>  #define DBCR0_RST	0x30000000	/* all the bits in the RST field */
> @@ -261,20 +267,67 @@
>  #define DBCR0_RST_CORE	0x10000000	/* Core Reset */
>  #define DBCR0_RST_NONE	0x00000000	/* No Reset */
>  #define DBCR0_IC	0x08000000	/* Instruction Completion */
> +#define DBCR0_ICMP	DBCR0_IC
>  #define DBCR0_BT	0x04000000	/* Branch Taken */
> +#define DBCR0_BRT	DBCR0_BT
>  #define DBCR0_EDE	0x02000000	/* Exception Debug Event */
> +#define DBCR0_IRPT	DBCR0_EDE
>  #define DBCR0_TDE	0x01000000	/* TRAP Debug Event */
>  #define DBCR0_IA1	0x00800000	/* Instr Addr compare 1 enable */
> +#define DBCR0_IAC1	DBCR0_IA1
>  #define DBCR0_IA2	0x00400000	/* Instr Addr compare 2 enable */
> +#define DBCR0_IAC2	DBCR0_IA2
>  #define DBCR0_IA12	0x00200000	/* Instr Addr 1-2 range enable */
>  #define DBCR0_IA12X	0x00100000	/* Instr Addr 1-2 range eXclusive */
>  #define DBCR0_IA3	0x00080000	/* Instr Addr compare 3 enable */
> +#define DBCR0_IAC3	DBCR0_IA3
>  #define DBCR0_IA4	0x00040000	/* Instr Addr compare 4 enable */
> +#define DBCR0_IAC4	DBCR0_IA4
>  #define DBCR0_IA34	0x00020000	/* Instr Addr 3-4 range Enable */
>  #define DBCR0_IA34X	0x00010000	/* Instr Addr 3-4 range eXclusive */
>  #define DBCR0_IA12T	0x00008000	/* Instr Addr 1-2 range Toggle */
>  #define DBCR0_IA34T	0x00004000	/* Instr Addr 3-4 range Toggle */
>  #define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
> +#elif defined(CONFIG_BOOKE)
> +#define DBCR0_EDM	0x80000000	/* External Debug Mode */
> +#define DBCR0_IDM	0x40000000	/* Internal Debug Mode */
> +#define DBCR0_RST	0x30000000	/* all the bits in the RST field */
> +/* DBCR0_RST_* is 44x specific and not followed in fsl booke */
> +#define DBCR0_RST_SYSTEM 0x30000000	/* System Reset */
> +#define DBCR0_RST_CHIP	0x20000000	/* Chip Reset */
> +#define DBCR0_RST_CORE	0x10000000	/* Core Reset */
> +#define DBCR0_RST_NONE	0x00000000	/* No Reset */
> +#define DBCR0_ICMP	0x08000000	/* Instruction Completion */
> +#define DBCR0_BRT	0x04000000	/* Branch Taken */
> +#define DBCR0_BT	DBCR0_BRT
> +#define DBCR0_IRPT	0x02000000	/* Exception Debug Event */
> +#define DBCR0_TDE	0x01000000	/* TRAP Debug Event */
> +#define DBCR0_IAC1	0x00800000	/* Instr Addr compare 1 enable */
> +#define DBCR0_IAC2	0x00400000	/* Instr Addr compare 2 enable */
> +#define DBCR0_IAC3	0x00200000	/* Instr Addr compare 3 enable */
> +#define DBCR0_IAC4	0x00100000	/* Instr Addr compare 4 enable */
> +#define DBCR0_DAC1R	0x00080000	/* DAC 1 Read enable */
> +#define DBCR0_DAC1W	0x00040000	/* DAC 1 Write enable */
> +#define DBCR0_DAC2R	0x00020000	/* DAC 2 Read enable */
> +#define DBCR0_DAC2W	0x00010000	/* DAC 2 Write enable */
> +#define DBCR0_RET	0x00008000	/* Return Debug Event */
> +#define DBCR0_CIRPT	0x00000040	/* Critical Interrupt Taken Event */
> +#define DBCR0_CRET	0x00000020	/* Critical Return Debug Event */
> +#define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
> +
> +/* Bit definitions related to the DBCR1. */
> +#define DBCR1_IAC12M	0x00800000	/* Instr Addr 1-2 range enable */
> +#define DBCR1_IAC12MX	0x00C00000	/* Instr Addr 1-2 range eXclusive */
> +#define DBCR1_IAC12AT	0x00010000	/* Instr Addr 1-2 range Toggle */
> +#define DBCR1_IAC34M	0x00000080	/* Instr Addr 3-4 range enable */
> +#define DBCR1_IAC34MX	0x000000C0	/* Instr Addr 3-4 range eXclusive */
> +#define DBCR1_IAC34AT	0x00000001	/* Instr Addr 3-4 range Toggle */
> +
> +/* Bit definitions related to the DBCR2. */
> +#define DBCR2_DAC12M	0x00800000	/* DAC 1-2 range enable */
> +#define DBCR2_DAC12MX	0x00C00000	/* DAC 1-2 range eXclusive */
> +#define DBCR2_DAC12A	0x00200000	/* DAC 1-2 Asynchronous */
> +#endif
> 
>  /* Bit definitions related to the TCR. */
>  #define TCR_WP(x)	(((x)&0x3)<<30)	/* WDT Period */
