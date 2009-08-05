Return-Path: <mohan@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 42764B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 02:49:58 +1000 (EST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [59.145.155.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A4B5DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 02:49:55 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id n75Gnkql009158
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 22:19:46 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75GnkmE1417298
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 22:19:46 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n75GnjgP025490
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 22:19:46 +0530
Date: Wed, 5 Aug 2009 22:19:38 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090805164938.GA2970@in.ibm.com>
References: <1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
	<1245803263.9237.3.camel@concordia>
	<20090803054919.GA19594@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090803054919.GA19594@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Neil Horman <nhorman@redhat.com>,
	Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
	miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

When I align the dtstruct variable to 8 bytes, I am able to invoke kdump.

When the line
	static unsigned dtstruct[TREEWORDS], *dt;
changed to 
	static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;

kexec-tool works.

Regards,
M. Mohan Kumar

On Mon, Aug 03, 2009 at 11:19:19AM +0530, M. Mohan Kumar wrote:
> On Wed, Jun 24, 2009 at 10:27:43AM +1000, Michael Ellerman wrote:
> > On Tue, 2009-06-23 at 09:56 -0400, Neil Horman wrote:
> > > On Tue, Jun 23, 2009 at 06:25:34PM +0530, M. Mohan Kumar wrote:
> > > > 
> > > Well it definately looks like removing that variable had some code changes.
> > > It'll take some time to match it up to source, but Most interesting I think is
> > > the variance in putprops around address f34.  Looks like its doing some string
> > > maniuplation in a reversed order, using a huge offset.  Might be worthwhile to
> > > check to see if theres any string overruns in this code.
> > 
> > Yeah I still suspect it's just a bug in the code that's being exposed
> > now.
> > 
> Hi,
> 
> The same code works with gcc-3.4.
> 
> > Mohan, can you try running it under valgrind?
> 
> Still I am not able to use valgrind to debug kexec-tools
> 
> Regards,
> M. Mohan Kumar.
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
