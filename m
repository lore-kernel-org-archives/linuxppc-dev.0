Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpVnb5CKDzDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 03:27:47 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5FHOlaU010516
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 13:27:43 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b3vb1f3xm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 13:27:42 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 16 Jun 2017 03:27:39 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5FHRbnk7930286
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 03:27:37 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5FHRasB007253
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 03:27:36 +1000
Date: Thu, 15 Jun 2017 22:57:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ravi.bangoria@linux.vnet.ibm.com, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: Fix emulation of mfocrf in emulate_step()
References: <20170614234639.11997-1-anton@ozlabs.org>
 <20170614234639.11997-2-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170614234639.11997-2-anton@ozlabs.org>
Message-Id: <20170615172734.GD2800@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/15 09:46AM, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> From POWER4 onwards, mfocrf() only places the specified CR field into
> the destination GPR, and the rest of it is set to 0. The PowerPC AS
> from version 3.0 now requires this behaviour.
> 
> The emulation code currently puts the entire CR into the destination GPR.
> Fix it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

> ---
>  arch/powerpc/lib/sstep.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index fb84f51b1f0b..ee33327686ae 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -966,6 +966,19 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  #endif
> 
>  		case 19:	/* mfcr */
> +			if ((instr >> 20) & 1) {
> +				imm = 0xf0000000UL;
> +				for (sh = 0; sh < 8; ++sh) {
> +					if (instr & (0x80000 >> sh)) {
> +						regs->gpr[rd] = regs->ccr & imm;
> +						break;
> +					}
> +					imm >>= 4;
> +				}
> +
> +				goto instr_done;
> +			}
> +
>  			regs->gpr[rd] = regs->ccr;
>  			regs->gpr[rd] &= 0xffffffffUL;
>  			goto instr_done;
> -- 
> 2.11.0
> 
