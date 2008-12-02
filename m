Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 690AADDDE6
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 22:45:47 +1100 (EST)
Subject: Re: Erratic MPC8248 CPM2 I2C behaviour
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200812021150.26233.laurentp@cse-semaphore.com>
References: <mailman.569.1227903153.29923.linuxppc-dev@ozlabs.org>
	<49347317.5080600@consentry.com>
	<1228207199.9867.69.camel@gentoo-jocke.transmode.se>
	<200812021150.26233.laurentp@cse-semaphore.com>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 12:45:44 +0100
Message-Id: <1228218344.9867.87.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Mike Ditto <mditto@consentry.com>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-02 at 11:50 +0100, Laurent Pinchart wrote:
> Hi Joakim,
> 
> On Tuesday 02 December 2008 09:39:59 Joakim Tjernlund wrote:
> > On Mon, 2008-12-01 at 15:28 -0800, Mike Ditto wrote:
> > > Laurent Pinchart <laurentp@cse-semaphore.com> wrote:
> > > > Transmission timeout after one second. The first TX buffer descriptor
> > > > status hasn't been modified by the CPM. The CPM state dump shows that
> > > > processing of
> > >
> > > ...
> > >
> > > This sounds very similar to a problem I have seen on MPC8247 and
> > > MPC8248.
> > >
> > > It could be a variation of the CPM bug documented by Freescale as
> > > erratum CPM98.  But the key difference is that we see a persistent
> > > failure, while the erratum only mentions a problem with "the next
> > > transaction".  What we see is that once the I2C engine gets confused
> > > by some anomaly on the SCL signal, it stops processing buffer
> > > descriptors entirely until it is turned off and back on.  You can
> > > observe this bug by momentarily grounding the SCL line (it's an
> > > open-collector bus) with a jumper while you attempt an I/O.
> > >
> > > Our production equipment is using Linux 2.6 with the out-of-tree
> > > i2c-algo-8260.c by Dan Malek and Brad Parker.  I modified this
> > > driver to shut off the I2C controller and turn it back on when it
> > > hits this problem, and now it can recover from this condition.
> > >
> > > However, this does not explain how the controller gets into the
> > > frozen state in the first place.  We see it very rarely in production
> > > units and have not been able to identify the cause.  If it is
> > > similar to erratum CPM98 then it could be noise on the SCL signal or
> > > perhaps an I2C device that doesn't conform to the protocol perfectly.
> > > Also beware, if you are using some kind of multiplexer, that you don't
> > > direct the multiplexer to switch to a different bus (segment) while a
> > > transaction is in progress.
> > >
> > > In testing with the current (2.6.27) i2c-cpm.c driver, I found that
> > > it is sufficient to #define I2C_CHIP_ERRATA to allow it to recover
> > > from the CPM I2C freeze.  However, I don't know if I like this
> > > approach because it turns off the I2C engine after every transfer,
> > > even successful ones, and I don't know if this will affect reliability
> > > or performance.  And I don't know if this will actually prevent the
> > > freeze from happening, although I presume that it would protect the
> > > I2C engine from getting confused by a glitch that happens while no
> > > transfer is in progress.
> > >
> > > I am not aware of any documentation for what exactly the I2C_CHIP_ERRATA
> > > conditional code in i2c-cpm.c is meant to work around.
> >
> > The I2C_CHIP_ERRATA is mine and refers to mpc8xx, mpc860 in my case. The
> > driver was adapted by me some years ago in 2.4 and now someone has
> > ported it to 2.6 it seems. From memory, you should check that mrblr is
> > one byte bigger than your max transfer size.
> 
> I've checked that, there's no problem there. The transfer that fails doesn't 
> involve any rx buffer anyway, so mrblr is irrelevant here.

hmm, as I recall that doesn't matter. Mrblr should always be > transfer
size. This was for 8xx though so maybe it doesn't matter for you.
Try setting mrblr = transfer size, see if that trigger any problems.

 Jocke
