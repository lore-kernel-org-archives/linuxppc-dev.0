Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40711190742l7940e75m4262b6e96acb05e1@mail.gmail.com>
Date: Mon, 19 Nov 2007 08:42:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <9e4733910711190737o59b7b692se7cc5ff569c6a479@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<4741A56D.9050808@freescale.com>
	<9e4733910711190737o59b7b692se7cc5ff569c6a479@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/19/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 11/19/07, Timur Tabi <timur@freescale.com> wrote:
> > Jon Smirl wrote:
> >
> > > In the ALSA SOC model the i2s, codec and ac97 drivers are all generic.
> > > A fabric driver tells specifically how a generic codec is wired into
> > > the board. What I haven't been able figure out is how to load the
> > > right fabric driver.
> >
> > Do not use the device tree to load the fabric driver!
>
> If I have a multiplatform kernel with 10 fabric drivers built in, how
> do you decide which one to activate without looking at the device
> tree? Multiplatform kernels are what is causing this problem. If the
> kernel is just for a single platform I can hardwire the fabric driver
> in without looking at the tree.

Simple; instantiate the needed platform_device or of_platform_device
in the board platform code (arch/powerpc/platforms/*).  Then the
driver has something to bind against.

That way the driver's probe() method gets called without having to
traverse the entire tree.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
