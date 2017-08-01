Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMGHQ70QMzDsPd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 22:44:50 +1000 (AEST)
Date: Tue, 1 Aug 2017 07:44:33 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/5] powerpc/lib/sstep: Add cmpb instruction emulation
Message-ID: <20170801124433.GI13471@gate.crashing.org>
References: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170731005826.32044-1-matthew.brown.dev@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Mon, Jul 31, 2017 at 10:58:22AM +1000, Matt Brown wrote:
> @@ -1049,6 +1065,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  			do_cmp_unsigned(regs, val, val2, rd >> 2);
>  			goto instr_done;
>  
> +		case 508: /* cmpb */
> +			do_cmpb(regs, regs->gpr[rd], regs->gpr[rb], ra);
> +			goto instr_done;

Should this then be under an ifdef for 64-bit?


Segher
