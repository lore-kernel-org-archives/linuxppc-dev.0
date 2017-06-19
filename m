Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrxsV6fc9zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 02:54:38 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id e187so8236499pgc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 09:54:38 -0700 (PDT)
Date: Tue, 20 Jun 2017 02:54:25 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/9] powerpc/64s: SLB miss handler avoid r3 save/restore
Message-ID: <20170620025425.3dc050c8@roar.ozlabs.ibm.com>
In-Reply-To: <87tw3cvaze.fsf@concordia.ellerman.id.au>
References: <20170521131550.25813-1-npiggin@gmail.com>
 <20170521131550.25813-5-npiggin@gmail.com>
 <87tw3cvaze.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Jun 2017 14:48:37 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index 486e205cc762..6ba4c4c6ae69 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -625,6 +625,9 @@ EXC_COMMON_BEGIN(slb_miss_realmode)
> >  	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
> >  	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
> >  
> > +	andi.	r11,r11,MSR_RI	/* check for unrecoverable exception */
> > +	beq-	2f
> > +
> >  	crset	4*cr0+eq
> >  #ifdef CONFIG_PPC_STD_MMU_64
> >  BEGIN_MMU_FTR_SECTION
> > @@ -638,9 +641,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
> >  
> >  	beq-	8f		/* if bad address, make full stack frame */
> >  
> > -	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
> > -	beq-	2f
> > -  
> 
> Moving that check before slb_allocate_realmode() makes me a bit nervous.
> 
> It's already a bug if we're taking an SLB miss with RI off, but I'm
> worried that by not doing the SLB allocate we might turn what would be a
> regular oops into an infinite loop of SLB misses. But my brain is too
> sleep deprived today to decide either way.

After some offline back and forth over this, I think it's agreed we
should try to install the SLB entry before exiting. If nothing else
because that's what the existing code does.

So this incremental patch should restore that behaviour.

Some observations/comments:

- The additional mtcrf instruction may be getting close to the point
  where mtcr / mtcrf of multiple fields is faster. However it's not
  obviously past there yet on either POWER8 or 9, so I've kept the
  singe-field mtcrf for now.

- unrecov_slb possibly should use the emergency stack. There's a
  limit for how robust we can try to be, but with testing it wasn't
  too hard to put the code (+/- this patch) into an infinite SLB
  loop here by having something "interesting" in r1 when we take
  an RI=0 SLB fault.

Thanks,
Nick

---
 arch/powerpc/kernel/exceptions-64s.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 6ba4c4c6ae69..575eed979f41 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -625,8 +625,14 @@ EXC_COMMON_BEGIN(slb_miss_realmode)
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
 
+	/*
+	 * Test MSR_RI before calling slb_allocate_realmode, because the
+	 * MSR in r11 gets clobbered. However we still want to allocate
+	 * SLB in case MSR_RI=0, to minimise the risk of getting stuck in
+	 * recursive SLB faults. So use cr5 for this, which is preserved.
+	 */
 	andi.	r11,r11,MSR_RI	/* check for unrecoverable exception */
-	beq-	2f
+	cmpdi	cr5,r11,MSR_RI
 
 	crset	4*cr0+eq
 #ifdef CONFIG_PPC_STD_MMU_64
@@ -641,11 +647,14 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 
 	beq-	8f		/* if bad address, make full stack frame */
 
+	bne-	cr5,2f		/* if unrecoverable exception, oops */
+
 	/* All done -- return from exception. */
 
 .machine	push
 .machine	"power4"
 	mtcrf	0x80,r9
+	mtcrf	0x04,r9		/* MSR[RI] indication is in cr5 */
 	mtcrf	0x02,r9		/* I/D indication is in cr6 */
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
-- 
2.11.0
