Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpVn26YV9zDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 03:27:18 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5FHNp5g107975
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 13:27:15 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b3s5j0c0s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 13:27:15 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 16 Jun 2017 03:27:12 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5FHR9Qd7143864
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 03:27:09 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5FHR8We013726
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 03:27:09 +1000
Date: Thu, 15 Jun 2017 22:57:01 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ravi.bangoria@linux.vnet.ibm.com, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Fix emulation of mcrf in emulate_step()
References: <20170614234639.11997-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170614234639.11997-1-anton@ozlabs.org>
Message-Id: <20170615172701.GC2800@naverao1-tp.localdomain>
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
> The mcrf emulation code was looking at the CR fields in the reverse
> order. It also relied on reserved fields being zero which is somewhat
> fragile, so fix that too.

Yikes! Amazing catch!
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks,
Naveen

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/lib/sstep.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 33117f8a0882..fb84f51b1f0b 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -683,8 +683,10 @@ int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  	case 19:
>  		switch ((instr >> 1) & 0x3ff) {
>  		case 0:		/* mcrf */
> -			rd = (instr >> 21) & 0x1c;
> -			ra = (instr >> 16) & 0x1c;
> +			rd = 7 - ((instr >> 23) & 0x7);
> +			ra = 7 - ((instr >> 18) & 0x7);
> +			rd *= 4;
> +			ra *= 4;
>  			val = (regs->ccr >> ra) & 0xf;
>  			regs->ccr = (regs->ccr & ~(0xfUL << rd)) | (val << rd);
>  			goto instr_done;
> -- 
> 2.11.0
> 
