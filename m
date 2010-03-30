Return-Path: <benh@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B94A7B7CBB
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 16:32:36 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2U5WGiK002301
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 16:32:16 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2U5QKHL1708218
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 16:26:20 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2U5WRHl024160
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 16:32:27 +1100
Subject: Re: [RFC Patch 1/2] PPC64-HWBKPT: Disable interrupts for data
	breakpoint exceptions
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20100330052442.GB12619@drongo>
References: <20100323140008.954823303@pr>
	<20100323140702.GB21836@in.ibm.com>  <20100330052442.GB12619@drongo>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Mar 2010 16:32:25 +1100
Message-ID: <1269927145.7101.48.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-03-30 at 16:24 +1100, Paul Mackerras wrote:
> On Tue, Mar 23, 2010 at 07:37:02PM +0530, K.Prasad wrote:
> 
> > Index: linux-2.6.ppc64_test/arch/powerpc/kernel/exceptions-64s.S
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/exceptions-64s.S
> > +++ linux-2.6.ppc64_test/arch/powerpc/kernel/exceptions-64s.S
> > @@ -735,6 +735,9 @@ _STATIC(do_hash_page)
> >  	std	r3,_DAR(r1)
> >  	std	r4,_DSISR(r1)
> >  
> > +	andis.  r0,r4,0x0040		/* Data Address Breakpoint match? */
> 
> Minor comment: why not DSISR_DABRMATCH@h instead of 0x0040?
> 
> > +	bne-    handle_dabr_fault
> > +
> >  	andis.	r0,r4,0xa450		/* weird error? */
> >  	bne-	handle_page_fault	/* if not, try to insert a HPTE */
> >  BEGIN_FTR_SECTION
> > @@ -823,6 +826,15 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
> >  	bl	.raw_local_irq_restore
> >  	b	11f

I would move your new test to the "weird error" case (ie, after the bne-
handle_page_fault) to avoid hitting the fast path.

Cheers,
Ben.
