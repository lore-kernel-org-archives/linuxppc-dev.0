Return-Path: <mohan@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1EABBDE027
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 15:54:24 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l274sFUS019693
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 23:54:15 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l274sFCu302592
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 23:54:15 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l274sEDI024128
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 23:54:14 -0500
Date: Wed, 7 Mar 2007 10:23:41 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070307045341.GG7476@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
	<20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	fastboot@lists.osdl.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 06, 2007 at 06:37:14PM +0100, Michael Ellerman wrote:
> On Tue, 2007-03-06 at 22:25 +0530, Mohan Kumar M wrote:
> > On Tue, Mar 06, 2007 at 03:16:55PM +0100, Michael Ellerman wrote:
> > > First, I don't know why we keep telling people to use maxcpus=1 for
> > > kexec/kdump - it's causing bugs, and I don't know of any that it fixes?
> > 
> > Some distros want to use maxcpus=1 for kdump.
> 
> Yeah OK.
> 
> > > Second, the way you've written this is not so good. The xics code should
> > > not be checking that "maxcpus" exists on the command line, it should be
> > > checking that the distrib server points to a cpu that is online - using
> > > cpu_online() etc.
> > >
> > 
> > In get_irq_server function in xics.c, "noirqdistrib" command line
> > parameter is indirectly checked for routing the interrupts either to a
> > specific cpu or to all cpus. So I think checking for maxcpus= command
> > line parameter in xics.c is not a problem.
> 
> No, it checks a flag, it doesn't run strstr on the saved command line.
>
What if I use a flag (or existing global variable if any) to check for
the presence of maxcpus kernel paramter?
 
> > Also during the xics_init_IRQ function other cpus (secondary cpus) will
> > not be online, they are made online at a later stage. So using
> > cpu_online() function at xics_init_IRQ will return true only for boot
> > cpu id.
> 
> OK, so you should be able to use cpus possible map or something similar.
>
Hmm, I think cpus possible map will have an entry for the offline cpu
also.
 
> cheers
> 
> -- 
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
> 
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
> 
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
