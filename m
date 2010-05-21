Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 31ED6B7D43
	for <linuxppc-dev@ozlabs.org>; Sat, 22 May 2010 02:51:55 +1000 (EST)
From: Milton Miller <miltonm@bga.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20100520124955.GA29903@brick.ozlabs.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
Subject: [RFC PATCH] powerpc: Emulate most load and store instructions in
	emulate_step()
Date: Fri, 21 May 2010 11:35:48 -0500
Message-ID: <1274459748_7091@mail4.comsite.net>
Cc: linuxppc-dev@ozlabs.org, "K.Prasad" <prasad@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[resending to hit the list]

> +		if (regs->gpr[0] == 0x1ebe &&
> +		    cpu_has_feature(CPU_FTR_REAL_LE)) {
> +			regs->msr ^= MSR_LE;
> +			goto instr_done;
> +		}
>  		regs->gpr[9] = regs->gpr[13];
> +		regs->gpr[10] = MSR_KERNEL;
> 

this hunk didn't seem to be mentioned in the change log


>+ static inline unsigned long xform_ea(unsigned int instr, struct pt_regs *regs)
..
> +	if (ra) {
> +		ea += regs->gpr[ra];
> +		if (instr & 0x40)		/* update forms */
> +			regs->gpr[ra] = ea;
> +	}

if the instruction faults, we shouldn't update ra

> +	case 62:	/* std[u] */
> +		val = regs->gpr[rd];
> +		switch (instr & 3) {
> +		case 0:		/* ld */
> +			err = write_mem(val, dsform_ea(instr, regs), 8, regs);
> +			goto ldst_done;
> +		case 1:		/* ldu */
> +			err = write_mem(val, dsform_ea(instr, regs), 8, regs);
> +			goto ldst_done;
> +		}
> +		break;
> 

comments seem to be copied

milton
