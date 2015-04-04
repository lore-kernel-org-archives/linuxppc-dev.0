Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 363A91A0AC4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 20:14:33 +1100 (AEDT)
Message-ID: <1428138872.19454.0.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/4] powerpc/tm: Abort syscalls in active transactions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Sat, 04 Apr 2015 20:14:32 +1100
In-Reply-To: <cb32074cdf25c5b5707904ea618f3c375daa6126.1427685637.git.sam.bobroff@au1.ibm.com>
References: <cover.1427685637.git.sam.bobroff@au1.ibm.com>
 <cb32074cdf25c5b5707904ea618f3c375daa6126.1427685637.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-30 at 14:20 +1100, Sam Bobroff wrote:
> @@ -145,6 +146,24 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
>  	bne	syscall_dotrace
>  .Lsyscall_dotrace_cont:
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +BEGIN_FTR_SECTION
> +	b	1f
> +END_FTR_SECTION_IFCLR(CPU_FTR_TM)
> +	extrdi.	r11, r12, 1, (63-MSR_TS_T_LG) /* transaction active? */
> +	beq+	1f
> +
> +	/* Doom the transaction and don't perform the syscall: */
> +	mfmsr	r11
> +	li	r12, 1
> +	rldimi	r11, r12, MSR_TM_LG, 63-MSR_TM_LG
> +	mtmsrd	r11, 0
> +	li	r11, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
> +	tabort. r11

TABORT please, otherwise old toolchains can't build it.

cheers
