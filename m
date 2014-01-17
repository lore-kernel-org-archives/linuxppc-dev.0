Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 83F2D2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 00:31:04 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 17 Jan 2014 23:31:03 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 255F43578023
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 00:30:59 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0HDBqrV63438882
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 00:11:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0HDUvEV002974
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 00:30:58 +1100
Message-ID: <1389965453.5628.3.camel@ThinkPad-T5421>
Subject: Re: [RFC PATCH powerpc] Fix compile error of pgtable-ppc64.h
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 17 Jan 2014 21:30:53 +0800
In-Reply-To: <87vbxj6qp1.fsf@linux.vnet.ibm.com>
References: <1389939036.3000.7.camel@ThinkPad-T5421.cn.ibm.com>
 <87vbxj6qp1.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-01-17 at 12:27 +0530, Aneesh Kumar K.V wrote:
> Li Zhong <zhong@linux.vnet.ibm.com> writes:
> 
> > It seems that forward declaration couldn't work well with typedef, use
> > struct spinlock directly to avoiding following build errors:
> >
> > In file included from include/linux/spinlock.h:81,
> >                  from include/linux/seqlock.h:35,
> >                  from include/linux/time.h:5,
> >                  from include/uapi/linux/timex.h:56,
> >                  from include/linux/timex.h:56,
> >                  from include/linux/sched.h:17,
> >                  from arch/powerpc/kernel/asm-offsets.c:17:
> > include/linux/spinlock_types.h:76: error: redefinition of typedef 'spinlock_t'
> > /root/linux-next/arch/powerpc/include/asm/pgtable-ppc64.h:563: note: previous declaration of 'spinlock_t' was here
> >
> 
> what compiler version ? I have seen that error in gcc 4.3 and it was
> concluded that it is too old a compiler version to worry about. That
> specific compiler version also gave error for forward declaring struct;

gcc version 4.4.6 20110731 (Red Hat 4.4.6-3) (GCC), and it doesn't
report error after use struct directly. 

> 
> > Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/pgtable-ppc64.h |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> > index d27960c..bc141c9 100644
> > --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> > +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> > @@ -560,9 +560,9 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
> >  			    pmd_t *pmdp);
> >
> >  #define pmd_move_must_withdraw pmd_move_must_withdraw
> > -typedef struct spinlock spinlock_t;
> > -static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
> > -					 spinlock_t *old_pmd_ptl)
> > +struct spinlock;
> > +static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
> > +					 struct spinlock *old_pmd_ptl)
> >  {
> >  	/*
> >  	 * Archs like ppc64 use pgtable to store per pmd
