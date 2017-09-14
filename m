Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt7Zq2mF3zDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 16:16:19 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8E6EwnA064302
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 02:16:16 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cye4hy30s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 02:16:16 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Thu, 14 Sep 2017 16:16:13 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8E6GALe40108268
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 16:16:10 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8E6G9M1008610
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 16:16:10 +1000
Subject: Re: [PATCH 1/5] powerpc/kprobes: Some cosmetic updates to
 try_to_emulate()
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Thu, 14 Sep 2017 11:46:06 +0530
MIME-Version: 1.0
In-Reply-To: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <bbad9ff2-6849-6ae6-691a-50d75ef3dd35@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 14 September 2017 02:50 AM, Naveen N. Rao wrote:
> 1. This is only used in kprobes.c, so make it static.
> 2. Remove the un-necessary (ret == 0) comparison in the else clause.
>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/kprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 367494dc67d9..c2a6ab38a67f 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -239,7 +239,7 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(arch_prepare_kretprobe);
>
> -int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
> +static int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
>  {
>  	int ret;
>  	unsigned int insn = *p->ainsn.insn;
> @@ -261,7 +261,7 @@ int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
>  		 */
>  		printk("Can't step on instruction %x\n", insn);
>  		BUG();
> -	} else if (ret == 0)
> +	} else
>  		/* This instruction can't be boosted */
>  		p->ainsn.boostable = -1;
>
