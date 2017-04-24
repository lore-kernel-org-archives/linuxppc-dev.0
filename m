Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBLDy5y23zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:11:30 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3O99WP8090588
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 05:11:26 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a03pbfft6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 05:11:26 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 24 Apr 2017 19:11:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3O9BBR839911442
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:11:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3O9Af6e002130
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:10:41 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5] powerpc/mm: only call store_updates_sp() on stores in
 do_page_fault()
In-Reply-To: <22c2ebcfe72f4f17be6d284d922895cec34e23fc.1492606297.git.christophe.leroy@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <22c2ebcfe72f4f17be6d284d922895cec34e23fc.1492606297.git.christophe.leroy@c-s.fr>
Date: Mon, 24 Apr 2017 14:40:27 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zif6188s.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Function store_updates_sp() checks whether the faulting
> instruction is a store updating r1. Therefore we can limit its calls
> to stores exceptions.
>
> This patch is an improvement of commit a7a9dcd882a67 ("powerpc: Avoid
> taking a data miss on every userspace instruction miss")
>
> With the same microbenchmark app, run with 500 as argument, on an
> MPC885 we get:
>
> Before this patch: 152000 DTLB misses
> After this patch:  147000 DTLB misses
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 3a7d580fdc59..67fefb59d40e 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -287,7 +287,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 * can result in fault, which will cause a deadlock when called with
>  	 * mmap_sem held
>  	 */
> -	if (!is_exec && user_mode(regs))
> +	if (is_write && user_mode(regs))
>  		store_update_sp = store_updates_sp(regs);
>  
>  	if (user_mode(regs))
> -- 
> 2.12.0
