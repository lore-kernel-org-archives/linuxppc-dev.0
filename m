Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 580BF1A011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 02:34:19 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 08:34:13 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A0E0E3E40047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 08:34:11 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u27FYBBD19267700
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 08:34:11 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27FYAkk009240
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 08:34:11 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Christoph Lameter <cl@linux.com>, Tiejun Chen <tiejun.chen@windriver.com>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: mm: fixup preempt undefflow with huge pages
In-Reply-To: <20160307135506.GA12595@linutronix.de>
References: <20160307135506.GA12595@linutronix.de>
Date: Mon, 07 Mar 2016 21:04:05 +0530
Message-ID: <877fheti8i.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
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
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Tiejun Chen <tiejun.chen@windriver.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 744e24bcb85c..9e8919b39640 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -414,7 +414,7 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
>  {
>  	struct hugepd_freelist **batchp;
>
> -	batchp = this_cpu_ptr(&hugepd_freelist_cur);
> +	batchp = get_cpu_ptr(&hugepd_freelist_cur);
>
>  	if (atomic_read(&tlb->mm->mm_users) < 2 ||
>  	    cpumask_equal(mm_cpumask(tlb->mm),

IMHO it would better if we do

batchp = get_cpu_var(hugepd_freelist_cpu);

so that it match the existing

put_cpu_var(hugepd_freelist_cur);

While you are there, can you also fix the wrong indentation on line 423
?

-aneesh
