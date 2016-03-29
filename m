Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
 [IPv6:2001:4d88:1ffa:82:880:aa0:9009:64ae])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZC6q6jcZzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 00:58:43 +1100 (AEDT)
Date: Tue, 29 Mar 2016 15:40:24 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Scott Wood <scottwood@freescale.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: mm: fixup preempt undefflow with huge pages
Message-ID: <20160329134024.GA25057@breakpoint.cc>
References: <20160307135506.GA12595@linutronix.de>
 <877fheti8i.fsf@linux.vnet.ibm.com>
 <1457394104.2943.69.camel@kernel.crashing.org>
 <20160308090356.GA21842@linutronix.de>
 <87bn6n1m4f.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87bn6n1m4f.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016-03-10 01:04:24 [+0530], Aneesh Kumar K.V wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

*ping*
http://patchwork.ozlabs.org/patch/593943/

> > [ text/plain ]
> > hugepd_free() used __get_cpu_var() once. Nothing ensured that the code
> > accessing the variable did not migrate from one CPU to another and soon
> > this was noticed by Tiejun Chen in 94b09d755462 ("powerpc/hugetlb:
> > Replace __get_cpu_var with get_cpu_var"). So we had it fixed.
> >
> > Christoph Lameter was doing his __get_cpu_var() replaces and forgot
> > PowerPC. Then he noticed this and sent his fixed up batch again which
> > got applied as 69111bac42f5 ("powerpc: Replace __get_cpu_var uses").
> >
> > The careful reader will noticed one little detail: get_cpu_var() got
> > replaced with this_cpu_ptr(). So now we have a put_cpu_var() which does
> > a preempt_enable() and nothing that does preempt_disable() so we
> > underflow the preempt counter.
> >
>=20
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>=20
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > v1=E2=80=A6v2: - use get_cpu_var() instead of get_cpu_ptr()
> >        - correct indentation of put_cpu_var()
> >
> >  arch/powerpc/mm/hugetlbpage.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpag=
e.c
> > index 744e24bcb85c..4a811ca7ac9d 100644
> > --- a/arch/powerpc/mm/hugetlbpage.c
> > +++ b/arch/powerpc/mm/hugetlbpage.c
> > @@ -414,13 +414,13 @@ static void hugepd_free(struct mmu_gather *tlb, v=
oid *hugepte)
> >  {
> >  	struct hugepd_freelist **batchp;
> > =20
> > -	batchp =3D this_cpu_ptr(&hugepd_freelist_cur);
> > +	batchp =3D &get_cpu_var(hugepd_freelist_cur);
> > =20
> >  	if (atomic_read(&tlb->mm->mm_users) < 2 ||
> >  	    cpumask_equal(mm_cpumask(tlb->mm),
> >  			  cpumask_of(smp_processor_id()))) {
> >  		kmem_cache_free(hugepte_cache, hugepte);
> > -        put_cpu_var(hugepd_freelist_cur);
> > +		put_cpu_var(hugepd_freelist_cur);
> >  		return;
> >  	}
> > =20

Sebastian
