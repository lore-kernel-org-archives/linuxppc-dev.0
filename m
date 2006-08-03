Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id AF81A67B56
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 19:45:36 +1000 (EST)
Date: Thu, 3 Aug 2006 04:32:33 -0500
From: Milton Miller <miltonm@bga.com>
To: trini@kernel.crashing.org, jdl@freescale.com
Subject: Re: RFC: Location for Device Tree Sources?
Message-Id: <3115459755319495cff4.1649760492.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, g.liakhovetski@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Aug  2 2006 01:57:28 PM CDT, Tom Rini wrote:
> On Wed, Aug 02, 2006 at 01:23:08PM -0500, Jon Loeliger wrote:
> > On Wed, 2006-08-02 at 13:21, Tom Rini wrote:
> > 
> > > Yes, as I said, I'm not totally sure we're at the stable point right
> > > now, but I think that we are.  I'll add that maybe we need to think
> > > about API changes and DTS format versions.  To quote from my post..
> > > 
> > > > > X bugs) or a change that requires a dts version bump.
> > 
> > Now it sounds like the IRQ thing was an "Oops, we should have changed
> > the dts version" and bailed, noting what is wrong with the dts.
> > 
> > This confuses me.  
...
> > Same (DTS) format
> > both before and after the IRQ changes.
> > 
> > What have I missed here?
> 
> Matthew said:
> > The sandpoint (as far as I know) does not have a stable DTS. So in this
> > case including the DTS in the kernel would reduce confusion. The same
> > could be said for other boards where the DTS needed to be changed for
> > the IRQ rework. The old DTS will no longer boot the new kernels. I'm not
> > sure how much longer we will run into this problem though.
> 
> Now, if we've had to change the contents of the DTS because of a kernel
> change, I'd say the DTS format changed as when I say format I mean not
> only layout and naming, but what the contents are supposed to contain.
> 
> And, so it's clear, I don't know if we're at the very stable format
> (names/layout/content means...), but when we are at that point, what
> Matthew noted should, IMHO, be a graceful (ie explained in the panic()
> or something) death.
> 
> And, so it's clear, I think (and hope!) we all agree on that last part,
> once we hit stability.

I don't think we need to bump the dt version every time we make a tree
content requirements change.  We need to bump when we add or
change fields in the struct header, change internal layout, or change how
we pass  information through the tree.  Certianly not because someone 
left things out of their tree.

If we bump every time we check some new property, then the tools will 
always be producing the wrong version and/or we will end up with trees 
that claim they are good for some broad range that is really  incompatable.

That being said, I haven't looked at what is now required.  If we were to
eexpect some shim or preeparsing code to fixup existing trees then that
might warrant a version number beng assigned, if such information is not
readily determined by scanning the tree.

milton
