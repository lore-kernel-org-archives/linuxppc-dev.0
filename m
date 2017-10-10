Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yB7Cg35jxzDr4W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 17:55:11 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9A6sNqa005712
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 02:55:08 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dgpkffpw9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 02:55:08 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 10 Oct 2017 07:55:07 +0100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9A6t3dx8454238
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 06:55:04 GMT
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9A6srOM008714
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 17:54:54 +1100
Date: Tue, 10 Oct 2017 12:24:59 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, paulus@samba.org, anton@samba.org,
 segher@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/lib/sstep: Fix count leading zeros instructions
References: <20171010064530.19276-1-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171010064530.19276-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20171010065459.cuaexuxphzgbncgi@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/10/10 06:45AM, Sandipan Das wrote:
> According to the GCC documentation, the behaviour of __builtin_clz()
> and __builtin_clzl() is undefined if the value of the input argument
> is zero. Without handling this special case, these builtins have been
> used for emulating the following instructions:
>   * Count Leading Zeros Word (cntlzw[.])
>   * Count Leading Zeros Doubleword (cntlzd[.])
> 
> This fixes the emulated behaviour of these instructions by adding an
> additional check for this special case.
> 
> Fixes: 3cdfcbfd32b9d ("powerpc: Change analyse_instr so it doesn't modify *regs")
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>

Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

> ---
> v2: Make zero-checking condition more compact.
>     Add details of original commit that is being fixed here.
> ---
>  arch/powerpc/lib/sstep.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 5118110c3983..8c3955e183d4 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1699,11 +1699,13 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>   * Logical instructions
>   */
>  		case 26:	/* cntlzw */
> -			op->val = __builtin_clz((unsigned int) regs->gpr[rd]);
> +			val = (unsigned int) regs->gpr[rd];
> +			op->val = ( val ? __builtin_clz(val) : 32 );
>  			goto logical_done;
>  #ifdef __powerpc64__
>  		case 58:	/* cntlzd */
> -			op->val = __builtin_clzl(regs->gpr[rd]);
> +			val = regs->gpr[rd];
> +			op->val = ( val ? __builtin_clzl(val) : 64 );
>  			goto logical_done;
>  #endif
>  		case 28:	/* and */
> -- 
> 2.13.6
> 
