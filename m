Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FDD41A0007
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 06:34:38 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 12:34:34 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id AAD603E40067
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 12:34:32 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29JYW8h16711692
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 12:34:32 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29JYVS3013726
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 12:34:32 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christoph Lameter <cl@linux.com>, Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc: mm: fixup preempt undefflow with huge pages
In-Reply-To: <20160308090356.GA21842@linutronix.de>
References: <20160307135506.GA12595@linutronix.de>
 <877fheti8i.fsf@linux.vnet.ibm.com>
 <1457394104.2943.69.camel@kernel.crashing.org>
 <20160308090356.GA21842@linutronix.de>
Date: Thu, 10 Mar 2016 01:04:24 +0530
Message-ID: <87bn6n1m4f.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> [ text/plain ]
> hugepd_free() used __get_cpu_var() once. Nothing ensured that the code
> accessing the variable did not migrate from one CPU to another and soon
> this was noticed by Tiejun Chen in 94b09d755462 ("powerpc/hugetlb:
> Replace __get_cpu_var with get_cpu_var"). So we had it fixed.
>
> Christoph Lameter was doing his __get_cpu_var() replaces and forgot
> PowerPC. Then he noticed this and sent his fixed up batch again which
> got applied as 69111bac42f5 ("powerpc: Replace __get_cpu_var uses").
>
> The careful reader will noticed one little detail: get_cpu_var() got
> replaced with this_cpu_ptr(). So now we have a put_cpu_var() which does
> a preempt_enable() and nothing that does preempt_disable() so we
> underflow the preempt counter.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1=E2=80=A6v2: - use get_cpu_var() instead of get_cpu_ptr()
>        - correct indentation of put_cpu_var()
>
>  arch/powerpc/mm/hugetlbpage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 744e24bcb85c..4a811ca7ac9d 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -414,13 +414,13 @@ static void hugepd_free(struct mmu_gather *tlb, voi=
d *hugepte)
>  {
>  	struct hugepd_freelist **batchp;
>=20=20
> -	batchp =3D this_cpu_ptr(&hugepd_freelist_cur);
> +	batchp =3D &get_cpu_var(hugepd_freelist_cur);
>=20=20
>  	if (atomic_read(&tlb->mm->mm_users) < 2 ||
>  	    cpumask_equal(mm_cpumask(tlb->mm),
>  			  cpumask_of(smp_processor_id()))) {
>  		kmem_cache_free(hugepte_cache, hugepte);
> -        put_cpu_var(hugepd_freelist_cur);
> +		put_cpu_var(hugepd_freelist_cur);
>  		return;
>  	}
>=20=20
> --=20
> 2.7.0
