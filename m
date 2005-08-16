Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id E511467EEE
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 00:49:08 +1000 (EST)
Date: Tue, 16 Aug 2005 07:49:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050816144906.GI8214@smtp.west.cox.net>
References: <20050810093735.B22586@cox.net>
	<20050811194307.GW3187@smtp.west.cox.net>
	<20050815225224.F28706@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050815225224.F28706@cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Use todc on Mot PReP platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 15, 2005 at 10:52:24PM -0700, Matt Porter wrote:
> On Thu, Aug 11, 2005 at 12:43:07PM -0700, Tom Rini wrote:
> > On Wed, Aug 10, 2005 at 09:37:35AM -0700, Matt Porter wrote:
> > 
> > > This restores behavior from 2.4 where PReP platforms identified
> > > as Motorola would calibrate the decrementer using the RTC. On
> > > real Motorola PReP hardware this isn't needed. However, in order
> > > to boot a stock 2.6 PReP kernel on qemu (which emulates a Motorola
> > > PReP system) it is necessary to allow it to calibrate the decrementer
> > > using an emulated RTC.  If the decrementer rate is read from
> > > residual data then timing is screwed since a qemu PReP system typically
> > > runs much faster than the original hardware.
> > > 
> > > If anybody has objections to this as the default, let me know. It
> > > still works (as did 2.4) on a couple of my Mot PReP boxes and doesn't
> > > affect the IBM PReP paths. My goal with this is to be able to run
> > > a stock 2.6 defconfig PReP build on qemu.
> > 
> > So, I like this, and not just because I'm playing with qemu as well.
> 
> Why? It has no other redeeming quality except that it makes qemu work.

And it gets us away from residual data which can be crap or non
existant.  FWIW, I've move past using qemu, and I still like the change.

-- 
Tom Rini
http://gate.crashing.org/~trini/
