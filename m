Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBLFn3xTWzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:12:13 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3O98dN3003854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 05:12:02 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a0mqg4jm8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 05:12:00 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 24 Apr 2017 19:11:58 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3O9BjAK34013184
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:11:53 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3O9BKfo021051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:11:21 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/mm: split store_updates_sp() in two parts in
 do_page_fault()
In-Reply-To: <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
Date: Mon, 24 Apr 2017 14:41:01 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87wpaa187u.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Only the get_user() in store_updates_sp() has to be done outside
> the mm semaphore. All the comparison can be done within the semaphore,
> so only when really needed.
>
> As we got a DSI exception, the address pointed by regs->nip is
> obviously valid, otherwise we would have had a instruction exception.
> So __get_user() can be used instead of get_user()
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/fault.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 67fefb59d40e..9d21e5fd383d 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -73,12 +73,8 @@ static inline int notify_page_fault(struct pt_regs *regs)
>   * Check whether the instruction at regs->nip is a store using
>   * an update addressing form which will update r1.
>   */
> -static int store_updates_sp(struct pt_regs *regs)
> +static int store_updates_sp(unsigned int inst)
>  {
> -	unsigned int inst;
> -
> -	if (get_user(inst, (unsigned int __user *)regs->nip))
> -		return 0;
>  	/* check for 1 in the rA field */
>  	if (((inst >> 16) & 0x1f) != 1)
>  		return 0;
> @@ -207,7 +203,8 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	int trap = TRAP(regs);
>   	int is_exec = trap == 0x400;
>  	int fault;
> -	int rc = 0, store_update_sp = 0;
> +	int rc = 0;
> +	unsigned int inst = 0;
>  
>  #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
>  	/*
> @@ -288,7 +285,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 * mmap_sem held
>  	 */
>  	if (is_write && user_mode(regs))
> -		store_update_sp = store_updates_sp(regs);
> +		__get_user(inst, (unsigned int __user *)regs->nip);
>  
>  	if (user_mode(regs))
>  		flags |= FAULT_FLAG_USER;
> @@ -358,7 +355,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  		 * between the last mapped region and the stack will
>  		 * expand the stack rather than segfaulting.
>  		 */
> -		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
> +		if (address + 2048 < uregs->gpr[1] && !store_updates_sp(inst))
>  			goto bad_area;
>  	}
>  	if (expand_stack(vma, address))
> -- 
> 2.12.0
