Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 109BC67F36
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2005 17:33:05 +1000 (EST)
Date: Tue, 16 Aug 2005 00:33:04 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Message-ID: <20050816003303.H28706@cox.net>
References: <20050810093735.B22586@cox.net>
	<20050811194307.GW3187@smtp.west.cox.net>
	<20050815225224.F28706@cox.net>
	<20050816071912.GA18653@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050816071912.GA18653@localhost.localdomain>;
	from sven.luther@wanadoo.fr on Tue, Aug 16, 2005 at 09:19:12AM
	+0200
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Use todc on Mot PReP platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 16, 2005 at 09:19:12AM +0200, Sven Luther wrote:
> On Mon, Aug 15, 2005 at 10:52:24PM -0700, Matt Porter wrote:
> > On Thu, Aug 11, 2005 at 12:43:07PM -0700, Tom Rini wrote:
> > > On Wed, Aug 10, 2005 at 09:37:35AM -0700, Matt Porter wrote:
> > > 
> > > > This restores behavior from 2.4 where PReP platforms identified
> > > > as Motorola would calibrate the decrementer using the RTC. On
> > > > real Motorola PReP hardware this isn't needed. However, in order
> > > > to boot a stock 2.6 PReP kernel on qemu (which emulates a Motorola
> > > > PReP system) it is necessary to allow it to calibrate the decrementer
> > > > using an emulated RTC.  If the decrementer rate is read from
> > > > residual data then timing is screwed since a qemu PReP system typically
> > > > runs much faster than the original hardware.
> > > > 
> > > > If anybody has objections to this as the default, let me know. It
> > > > still works (as did 2.4) on a couple of my Mot PReP boxes and doesn't
> > > > affect the IBM PReP paths. My goal with this is to be able to run
> > > > a stock 2.6 defconfig PReP build on qemu.
> > > 
> > > So, I like this, and not just because I'm playing with qemu as well.
> > 
> > Why? It has no other redeeming quality except that it makes qemu work.
> > It's better to use residual data versus todc calibration in real machine
> > cases since residual data is accurate for this particular value on these
> > machines. I'm just curious why you would like this patch outside of
> > its qemu value.
> > 
> > BTW, it's _possible_ that we might eventually modify the open
> > hackware OF to do a timing loop and dynamically fill in the
> > residual data time base freq but that's unfamiliar territory and
> > this is an easy workaround.
> 
> What about modifying qemu's OF to emulate a chrp machine instead ?

That's good, but not the point of this exercise...at least for me. :)
Eventually, we should be able to boot a stock prep, chrp, or pmac
image built from the mainline kernel defconfig. Personally, I
want to boot some stock embedded kernels as well, but that's a
lot more work emulating on-chip I/O.

FWIW, jmayer did PReP first because all the PeeCee hardware was
already emulated. I believe CHRP/Pmac work to some degree but
I haven't personally tried them yet.

-Matt
