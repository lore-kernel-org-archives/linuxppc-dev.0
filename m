Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmb9X6LNHzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 00:38:24 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CEYkcw051287
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 10:38:22 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b1tar7t6h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 10:38:21 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 10:38:21 -0400
Date: Mon, 12 Jun 2017 20:08:15 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/14] powerpc/64s: msgclr when handling doorbell
 exceptions
Reply-To: ego@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170611235835.7400-6-npiggin@gmail.com>
Message-Id: <20170612143815.GD10921@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 12, 2017 at 09:58:26AM +1000, Nicholas Piggin wrote:
> msgsnd doorbell exceptions are cleared when the doorbell interrupt is
> taken. However if a doorbell exception causes a system reset interrupt
> wake from power saving state, the message is not cleared. Processing
> the doorbell from the system reset interrupt requires msgclr to avoid
> taking the exception again.
>

So you are clearing the doorbell message in this patch.

> Testing this plus the previous wakup direct patch gives:
> 
>                                 original         wakeup direct     msgclr
> Different threads, same core:   315k/s           264k/s            345k/s
> Different cores:                235k/s           242k/s            242k/s
> 
> Net speedup is +10% for same core, and +3% for different core.

This is good speedup.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/dbell.h      | 13 +++++++++++++
>  arch/powerpc/include/asm/ppc-opcode.h |  3 +++
>  arch/powerpc/kernel/asm-offsets.c     |  1 +
>  arch/powerpc/kernel/exceptions-64s.S  | 23 +++++++++++++++++++++--
>  4 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
> index f70cbfe0ec04..9f2ae0d25e15 100644
> --- a/arch/powerpc/include/asm/dbell.h
> +++ b/arch/powerpc/include/asm/dbell.h
> @@ -56,6 +56,19 @@ static inline void ppc_msgsync(void)
>  				: : "i" (CPU_FTR_HVMODE|CPU_FTR_ARCH_300));
>  }
> 
> +static inline void _ppc_msgclr(u32 msg)
> +{
> +	__asm__ __volatile__ (ASM_FTR_IFSET(PPC_MSGCLR(%1), PPC_MSGCLRP(%1), %0)
> +				: : "i" (CPU_FTR_HVMODE), "r" (msg));
> +}
> +
> +static inline void ppc_msgclr(enum ppc_dbell type)
> +{
> +	u32 msg = PPC_DBELL_TYPE(type);
> +
> +	_ppc_msgclr(msg);
> +}
> +
>  #else /* CONFIG_PPC_BOOK3S */
> 
>  #define PPC_DBELL_MSGTYPE		PPC_DBELL
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 3a8d278e7421..3b29c54e51fa 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -221,6 +221,7 @@
>  #define PPC_INST_MSGCLR			0x7c0001dc
>  #define PPC_INST_MSGSYNC		0x7c0006ec
>  #define PPC_INST_MSGSNDP		0x7c00011c
> +#define PPC_INST_MSGCLRP		0x7c00015c
>  #define PPC_INST_MTTMR			0x7c0003dc
>  #define PPC_INST_NOP			0x60000000
>  #define PPC_INST_PASTE			0x7c00070c
> @@ -409,6 +410,8 @@
>  					___PPC_RB(b))
>  #define PPC_MSGSNDP(b)		stringify_in_c(.long PPC_INST_MSGSNDP | \
>  					___PPC_RB(b))
> +#define PPC_MSGCLRP(b)		stringify_in_c(.long PPC_INST_MSGCLRP | \
> +					___PPC_RB(b))
>  #define PPC_POPCNTB(a, s)	stringify_in_c(.long PPC_INST_POPCNTB | \
>  					__PPC_RA(a) | __PPC_RS(s))
>  #define PPC_POPCNTD(a, s)	stringify_in_c(.long PPC_INST_POPCNTD | \
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index e15c178ba079..9624851ca276 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -746,6 +746,7 @@ int main(void)
>  #endif
> 
>  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> +	DEFINE(PPC_DBELL_MSGTYPE, PPC_DBELL_MSGTYPE);
> 
>  #ifdef CONFIG_PPC_8xx
>  	DEFINE(VIRT_IMMR_BASE, (u64)__fix_to_virt(FIX_IMMR_BASE));
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index ae418b85c17c..a04ee0d7f88e 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1552,6 +1552,25 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
>  	b	1b
> 
>  /*
> + * When doorbell is triggered from system reset wakeup, the message is
> + * not cleared, so it would fire again when EE is enabled.
> + *
> + * When coming from local_irq_enable, there may be the same problem if
> + * we were hard disabled.
> + *
> + * Execute msgclr to clear pending exceptions before handling it.
> + */
> +h_doorbell_common_msgclr:
> +	LOAD_REG_IMMEDIATE(r3, PPC_DBELL_MSGTYPE << (63-36))
> +	PPC_MSGCLR(3)
> +	b 	h_doorbell_common
> +
> +doorbell_super_common_msgclr:
> +	LOAD_REG_IMMEDIATE(r3, PPC_DBELL_MSGTYPE << (63-36))
> +	PPC_MSGCLRP(3)
> +	b 	doorbell_super_common
> +
> +/*
>   * Called from arch_local_irq_enable when an interrupt needs
>   * to be resent. r3 contains 0x500, 0x900, 0xa00 or 0xe80 to indicate
>   * which kind of interrupt. MSR:EE is already off. We generate a
> @@ -1576,13 +1595,13 @@ _GLOBAL(__replay_interrupt)
>  	beq	hardware_interrupt_common
>  BEGIN_FTR_SECTION
>  	cmpwi	r3,0xe80
> -	beq	h_doorbell_common
> +	beq	h_doorbell_common_msgclr
>  	cmpwi	r3,0xea0
>  	beq	h_virt_irq_common
>  	cmpwi	r3,0xe60
>  	beq	hmi_exception_common
>  FTR_SECTION_ELSE
>  	cmpwi	r3,0xa00
> -	beq	doorbell_super_common
> +	beq	doorbell_super_common_msgclr
>  ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
>  	blr
> -- 
> 2.11.0
> 
