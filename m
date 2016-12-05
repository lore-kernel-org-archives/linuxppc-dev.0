Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXHq04VrgzDvtr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 19:24:12 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB58Naa3099680
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 03:24:10 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2750kgev8y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 03:24:09 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 5 Dec 2016 13:54:04 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C7EB4125805F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 13:55:08 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB58NQvi24576112
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 13:53:26 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB58Nwjg008274
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Dec 2016 13:54:01 +0530
Date: Mon, 5 Dec 2016 13:53:57 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Ananth N <ananth@in.ibm.com>
Subject: Re: [PATCH] PPC: sstep.c: Add modsw, moduw instruction emulation
References: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
Message-Id: <20161205082357.GB3450@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/12/04 10:25PM, PrasannaKumar Muralidharan wrote:
> Add modsw and moduw instruction emulation support to analyse_instr.
> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Hi Prasanna,
Thanks for the patch! A few minor comments below...

> ---
>  arch/powerpc/lib/sstep.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 9c78a9c..5acef72 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1148,6 +1148,15 @@ int __kprobes analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  				(int) regs->gpr[rb];
>  			goto arith_done;
> 
> +		case 779:	/* modsw */
> +			regs->gpr[rd] = (int) regs->gpr[ra] %
> +				(int) regs->gpr[rb];
> +			goto arith_done;

Since these instructions don't update CR, you can directly goto 
instr_done.

> +
> +		case 267:	/* moduw */

Please move this case further up so that the extended opcodes are in 
numerical order.


- Naveen
