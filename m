Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 2C048DDFAF
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 22:46:04 +1100 (EST)
Date: Tue, 11 Mar 2008 12:46:02 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080311114601.GA19189@netgate.macqel>
References: <20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop>
	<47CECB21.3060704@freescale.com>
	<1204760811.21545.231.camel@pasglop>
	<20080307001025.GA27321@netgate.macqel>
	<1204849197.21545.272.camel@pasglop>
	<20080309223109.GA3989@netgate.macqel>
	<20080311003249.GG11559@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080311003249.GG11559@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

On Tue, Mar 11, 2008 at 11:32:49AM +1100, David Gibson wrote:
> On Sun, Mar 09, 2008 at 11:31:09PM +0100, Philippe De Muyter wrote:
> > Hi Ben,
> > 
> > I now have a working linux on my mpc8540 based board, with support for
> > the compactflash disk and the i2c rtc.
> > 
> > The network tough, does not work yet. altough the the integrated ethernet
> > controller (FEC) seems to be recognized.  Could it be a problem with the phy ?
> > I notice that I do not have an entry for gfar_interrupt in /proc/interrupts
> > on my ethernet-missing linux, while I have one ont the working arch/ppc linux ?
> > Do I need to give the phy type in the dts file, and how ?
> > 
> > I would also like to know if it is possible to still get in linux the mac
> > address known by uboot when using a dts file, and how ?
> 
> This chiefly depends on whether you're using an old u-boot that
> doesn't know about the device tree, or a new u-boot which itself
> supplies a device tree to the kernel.
> 
> If the old u-boot, you'll need to write a bootwrapper for your
> platform which reads the bd_t and pokes the right mac addresses into
> the device tree.
> 
> If the new u-boot, u-boot itself should put the address into the
> device tree.  If it's not, why it's not is a u-boot question rather
> than a device tree question.

OK :(

Now back to the first an bigger problem :
currently, I have an "old" U-boot and I have written myself a dts file.

Problem is : ethernet does not work, but that's not a mac-address problem,
but something else that I do not understand yet.  The symptom is I get

	ip route add default via 192.168.85.33 dev eth0
	RTNETLINK answers: Network is unreachable

I surmise this is because my eth0 does not become up, and I surmise
again this is because there is no driver selected to drive the phy.

In my arch/ppc setup this was automagically handled by fixed@100:1 IIRC  

Is there something I can put in my dts file to activate a driver for my phy ?

Best regards

Philippe
