Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55407B7BA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 16:22:02 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id nA55LxkT012855
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2009 16:21:59 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA55Iwtu888966
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2009 16:18:58 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA55LxW8013670
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2009 16:21:59 +1100
Subject: Re: [PATCH] powerpc/mm: Remove debug context clamping from nohash code
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6BAA37ED-F9DB-43A6-867B-B63D65926185@kernel.crashing.org>
References: <1257377992.13611.77.camel@pasglop>
	<6BAA37ED-F9DB-43A6-867B-B63D65926185@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 16:21:53 +1100
Message-ID: <1257398513.13611.92.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-04 at 23:16 -0600, Kumar Gala wrote:
> On Nov 4, 2009, at 5:39 PM, Benjamin Herrenschmidt wrote:
> 
> > I inadvertently left that debug code enabled, causing the number of
> > contexts to be clamped to 31 which is going to slow things down on
> > 4xx and just plain breaks 8xx
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > arch/powerpc/mm/mmu_context_nohash.c |    4 ++--
> > 1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/ 
> > mmu_context_nohash.c
> > index c2f93dc..be4f34c 100644
> > --- a/arch/powerpc/mm/mmu_context_nohash.c
> > +++ b/arch/powerpc/mm/mmu_context_nohash.c
> > @@ -25,8 +25,8 @@
> >  *     also clear mm->cpu_vm_mask bits when processes are migrated
> >  */
> >
> > -#define DEBUG_MAP_CONSISTENCY
> > -#define DEBUG_CLAMP_LAST_CONTEXT   31
> > +//#define DEBUG_MAP_CONSISTENCY
> > +//#define DEBUG_CLAMP_LAST_CONTEXT   31
> > //#define DEBUG_HARDER
> >
> > /* We don't use DEBUG because it tends to be compiled in always  
> > nowadays
> 
> Can you send this to stable.

No need. .31 doesn't have the clamp, it went in afterward afaik
(my bad) though stable does have DEBUG_MAP_CONSISTENCY which you
may want to remove for perfs.

Cheers,
Ben.
