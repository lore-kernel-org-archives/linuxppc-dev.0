Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9jhk3z9rzDr5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 01:45:26 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99EiNpJ084648
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 10:45:24 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dg5x0jr7h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 10:45:23 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 15:45:21 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v99EjHwg15663268
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 14:45:19 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v99EjA6M015664
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 01:45:10 +1100
Date: Mon, 9 Oct 2017 20:15:13 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, paulus@samba.org, anton@samba.org,
 segher@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/lib/sstep: Fix count leading zeros instructions
References: <20171009110726.28551-1-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171009110726.28551-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20171009144513.hwu6adxwn3ot6dze@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/10/09 11:07AM, Sandipan Das wrote:
> According to the GCC documentation, the behaviour of __builtin_clz()
> and __builtin_clzl() is undefined if the value of the input argument
> is zero. Without handling this special case, these builtins have been
> used for emulating the following instructions:
>   * Count Leading Zeros Word (cntlzw[.])
>   * Count Leading Zeros Doubleword (cntlzd[.])
> 
> This fixes the emulated behaviour of these instructions by adding an
> additional check for this special case.

So:
Fixes: 3cdfcbfd32b9d ("powerpc: Change analyse_instr so it doesn't 
modify *regs")

> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/lib/sstep.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 0f7e41bd7e88..ebbc0b92650c 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1717,11 +1717,19 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>   * Logical instructions
>   */
>  		case 26:	/* cntlzw */
> -			op->val = __builtin_clz((unsigned int) regs->gpr[rd]);
> +			val = (unsigned int) regs->gpr[rd];
> +			if (val == 0)
> +				op->val = 32;
> +			else
> +				op->val = __builtin_clz(val);

Can be made more compact:
	op->val = ( val ? __builtin_clz(val) : 32 );

- Naveen

>  			goto logical_done;
>  #ifdef __powerpc64__
>  		case 58:	/* cntlzd */
> -			op->val = __builtin_clzl(regs->gpr[rd]);
> +			val = regs->gpr[rd];
> +			if (val == 0)
> +				op->val = 64;
> +			else
> +				op->val = __builtin_clzl(val);
>  			goto logical_done;
>  #endif
>  		case 28:	/* and */
> -- 
> 2.13.6
> 
