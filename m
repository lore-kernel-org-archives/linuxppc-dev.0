Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C922EB7D44
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 21:19:13 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o2UAJB6U029685
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 15:49:11 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2UAJBaX3387564
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 15:49:11 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2UAJAWA031907
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 21:19:11 +1100
Date: Tue, 30 Mar 2010 15:49:08 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [RFC Patch 1/2] PPC64-HWBKPT: Disable interrupts for data
	breakpoint exceptions
Message-ID: <20100330101908.GC14734@in.ibm.com>
References: <20100323140008.954823303@pr> <20100323140702.GB21836@in.ibm.com>
	<20100330052442.GB12619@drongo> <1269927145.7101.48.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269927145.7101.48.camel@pasglop>
Cc: Michael Neuling <mikey@neuling.org>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Alan Stern <stern@rowland.harvard.edu>,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 30, 2010 at 04:32:25PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2010-03-30 at 16:24 +1100, Paul Mackerras wrote:
> > On Tue, Mar 23, 2010 at 07:37:02PM +0530, K.Prasad wrote:
> > 
> > > Index: linux-2.6.ppc64_test/arch/powerpc/kernel/exceptions-64s.S
> > > ===================================================================
> > > --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/exceptions-64s.S
> > > +++ linux-2.6.ppc64_test/arch/powerpc/kernel/exceptions-64s.S
> > > @@ -735,6 +735,9 @@ _STATIC(do_hash_page)
> > >  	std	r3,_DAR(r1)
> > >  	std	r4,_DSISR(r1)
> > >  
> > > +	andis.  r0,r4,0x0040		/* Data Address Breakpoint match? */
> > 
> > Minor comment: why not DSISR_DABRMATCH@h instead of 0x0040?
> > 
> > > +	bne-    handle_dabr_fault
> > > +
> > >  	andis.	r0,r4,0xa450		/* weird error? */
> > >  	bne-	handle_page_fault	/* if not, try to insert a HPTE */
> > >  BEGIN_FTR_SECTION
> > > @@ -823,6 +826,15 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
> > >  	bl	.raw_local_irq_restore
> > >  	b	11f
> 
> I would move your new test to the "weird error" case (ie, after the bne-
> handle_page_fault) to avoid hitting the fast path.
>

Done that...so basically the branch to handle_page_fault will happen
only if 0xa410 matches.

The changes can be seen here: linuxppc-dev: message-id:
20100330095925.GB14403@in.ibm.com.

Thanks,
K.Prasad
