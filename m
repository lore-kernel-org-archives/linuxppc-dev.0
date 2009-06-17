Return-Path: <mohan@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 68CF5B71D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 00:26:58 +1000 (EST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A4ADDDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 00:26:56 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp08.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5HDaVpE016696
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 19:06:31 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5HEQjQa1650922
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 19:56:45 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5HEQj2X004813
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 00:26:45 +1000
Date: Wed, 17 Jun 2009 19:56:52 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090617142652.GC4059@in.ibm.com>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090617140514.GB31383@hmsreliant.think-freely.org>
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17, 2009 at 10:05:14AM -0400, Neil Horman wrote:
> On Wed, Jun 17, 2009 at 07:04:35PM +0530, M. Mohan Kumar wrote:
> > On Wed, Jun 17, 2009 at 09:04:13AM -0400, Neil Horman wrote:
> > > On Wed, Jun 17, 2009 at 10:26:35PM +1000, Michael Ellerman wrote:
> > > > 
> > > > What compiler version are you using? Does the behaviour change if you
> > > > use a newer/older compiler? It sounds to me like there's some deeper bug
> > > > and your patch is just papering over it.
> > > > 
> > 
> > I tried with gcc 4.3.2. Let me try with a recent version and update.
> > 
> > > Agreed, this doesn't make any sense. Try changing the compiler version to see if
> > > the problem goes away or stops.  It might also be worthwhile to dump the
> > > contents of the device tree at the start and end of the kexec process.  If the
> > > changing of how a function is inlined is causing a hang, its likely changing how
> > > the putprops function is writing information to the device tree.  Understanding
> > > what that change is will likely provide clues to how the code has changed.
> > 
> > Neil, there was no code change in fs2dt.c
> > 
> Sure there was, by modifying the code to tell it to not inline the putprops
> function, you changed how the complier optimizes that code block.  There may not
> be any source level code change, but the assembly is certainly different, and it
> must be so in a way thats causing a hang.  The putpops function changes the
> contents of the ppc64 device-tree, so if this is a compiler bug, and its causing
> a hang, I imagine we'll see some manifestation in a change in the device tree
> contents.

As I mentioned in the patch description, when I retained the variable dt_len
and dt_len = dt assignment, kexec/kdump kernel would work. But even if I
comment the "dt_len = dt" assignment kernel would hang. If you need I can
send objdump of fs2dt.o with and without this assignment.

Regards,
M. Mohan Kumar.
