Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXmbg0YXKzDqcF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 19:01:34 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4O9174N103806
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 05:01:26 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2amy2w1rqp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 05:01:15 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 24 May 2017 18:59:42 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4O8xWLJ6554022
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 18:59:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4O8x638004970
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 18:59:06 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Cc: Sombat Tragolgosol <sombat3960@gmail.com>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] powerpc/spufs: Fix hash faults for kernel regions
In-Reply-To: <1495608599-16819-1-git-send-email-jk@ozlabs.org>
References: <1495608599-16819-1-git-send-email-jk@ozlabs.org>
Date: Wed, 24 May 2017 14:28:49 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760gqr5py.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jeremy Kerr <jk@ozlabs.org> writes:

> Change ac29c64089b7 swapped _PAGE_USER for _PAGE_PRIVILEGED, and
> introduced check_pte_access() which denied kernel access to
> non-_PAGE_PRIVILEGED pages.
>
> However, it didn't add _PAGE_PRIVILEGED to the hash fault handler for
> spufs' kernel accesses, so the DMAs required to establish SPE memory
> no longer work.
>
> This change adds _PAGE_PRIVILEGED to the hash fault handler for
> kernel accesses.
>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Reported-by: Sombat Tragolgosol <sombat3960@gmail.com>
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/cell/spu_base.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
> index 96c2b8a..0c45cdb 100644
> --- a/arch/powerpc/platforms/cell/spu_base.c
> +++ b/arch/powerpc/platforms/cell/spu_base.c
> @@ -197,7 +197,9 @@ static int __spu_trap_data_map(struct spu *spu, unsigned long ea, u64 dsisr)
>  	    (REGION_ID(ea) != USER_REGION_ID)) {
>
>  		spin_unlock(&spu->register_lock);
> -		ret = hash_page(ea, _PAGE_PRESENT | _PAGE_READ, 0x300, dsisr);
> +		ret = hash_page(ea,
> +				_PAGE_PRESENT | _PAGE_READ | _PAGE_PRIVILEGED,
> +				0x300, dsisr);
>  		spin_lock(&spu->register_lock);
>
>  		if (!ret) {
> -- 
> 2.7.4
