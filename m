Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3td8Jr5LtHzDvhR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 17:03:24 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBD5xDmI144117
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 01:03:22 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27a8cmc918-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 01:03:21 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 13 Dec 2016 11:33:16 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4B164394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 11:33:13 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBD63C4231916106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 11:33:13 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBD63ASN029287
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 11:33:12 +0530
Date: Tue, 13 Dec 2016 11:33:02 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ananth@in.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: sstep.c: Add modsw, moduw instruction
 emulation
References: <20161207174515.7628-1-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161207174515.7628-1-prasannatsmkumar@gmail.com>
Message-Id: <20161213060302.GB4109@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/12/07 11:15PM, PrasannaKumar Muralidharan wrote:
> Add modsw and moduw instruction emulation support to analyse_instr.
> modsw is an x-form instruction that calculates signed modulo of values
> stored in registers. moduw is similar to modsw but it works with
> unsigned values.
> 
> Changes in v2:
> Don't update CR register as the instruction does not touch that
> Arrange extended opcode in numerical order

This changelog should come after '---' below so that it doesn't get 
included in the commit message.

Apart from that, for this patch:
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


Thanks!

> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
>  arch/powerpc/lib/sstep.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 9c78a9c..b0acdbc 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1128,6 +1128,11 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  		case 266:	/* add */
>  			regs->gpr[rd] = regs->gpr[ra] + regs->gpr[rb];
>  			goto arith_done;
> +
> +		case 267:	/* moduw */
> +			regs->gpr[rd] = (unsigned int) regs->gpr[ra] %
> +				(unsigned int) regs->gpr[rb];
> +			goto instr_done;
>  #ifdef __powerpc64__
>  		case 457:	/* divdu */
>  			regs->gpr[rd] = regs->gpr[ra] / regs->gpr[rb];
> @@ -1148,6 +1153,10 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  				(int) regs->gpr[rb];
>  			goto arith_done;
> 
> +		case 779:	/* modsw */
> +			regs->gpr[rd] = (int) regs->gpr[ra] %
> +				(int) regs->gpr[rb];
> +			goto instr_done;
> 
>  /*
>   * Logical instructions
> -- 
> 2.9.3
> 
