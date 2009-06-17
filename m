Return-Path: <nhorman@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8466AB7153
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 00:40:44 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id E8CDDDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 00:40:43 +1000 (EST)
Date: Wed, 17 Jun 2009 10:40:07 -0400
From: Neil Horman <nhorman@redhat.com>
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090617144007.GC31383@hmsreliant.think-freely.org>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090617142652.GC4059@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17, 2009 at 07:56:52PM +0530, M. Mohan Kumar wrote:
> On Wed, Jun 17, 2009 at 10:05:14AM -0400, Neil Horman wrote:
> > On Wed, Jun 17, 2009 at 07:04:35PM +0530, M. Mohan Kumar wrote:
> > > On Wed, Jun 17, 2009 at 09:04:13AM -0400, Neil Horman wrote:
> > > > On Wed, Jun 17, 2009 at 10:26:35PM +1000, Michael Ellerman wrote:
> > > > > 
> > > > > What compiler version are you using? Does the behaviour change if you
> > > > > use a newer/older compiler? It sounds to me like there's some deeper bug
> > > > > and your patch is just papering over it.
> > > > > 
> > > 
> > > I tried with gcc 4.3.2. Let me try with a recent version and update.
> > > 
> > > > Agreed, this doesn't make any sense. Try changing the compiler version to see if
> > > > the problem goes away or stops.  It might also be worthwhile to dump the
> > > > contents of the device tree at the start and end of the kexec process.  If the
> > > > changing of how a function is inlined is causing a hang, its likely changing how
> > > > the putprops function is writing information to the device tree.  Understanding
> > > > what that change is will likely provide clues to how the code has changed.
> > > 
> > > Neil, there was no code change in fs2dt.c
> > > 
> > Sure there was, by modifying the code to tell it to not inline the putprops
> > function, you changed how the complier optimizes that code block.  There may not
> > be any source level code change, but the assembly is certainly different, and it
> > must be so in a way thats causing a hang.  The putpops function changes the
> > contents of the ppc64 device-tree, so if this is a compiler bug, and its causing
> > a hang, I imagine we'll see some manifestation in a change in the device tree
> > contents.
> 
> As I mentioned in the patch description, when I retained the variable dt_len
> and dt_len = dt assignment, kexec/kdump kernel would work. But even if I
> comment the "dt_len = dt" assignment kernel would hang. If you need I can
Yes, and as Michael has noted, that is likey an indication of a compiler bug.
You shouldn't get differing behavior in a kdump kernel by removing an unused
variable in kexec.  Which is why I'm unconvinced this patch is really fixing
anything, but rather just avoiding the real problem.

> send objdump of fs2dt.o with and without this assignment.
> 
That would be a fine thing to do, and I'd be happy to compare them.  My though
regarding the comparison of the device tree on a good and bad run was meant to
expidite what change in the assembly we'd be looking for.  If its the kdump
kernel boot thats hanging, Its likely hanging on something in the device tree,
as thats whats being manipulated by this code.  So I figure that understanding
whats changed there will point us toward what change in the assembly might be
responsible for the hang.  The assmebly's going to be signficantly different
(lots of optimization might be lost from no longer inlining a function), so
anything that helps us narrow down whats changed will be good
Neil

> Regards,
> M. Mohan Kumar.
