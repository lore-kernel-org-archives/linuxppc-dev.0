Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 92339DDDE6
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 11:33:33 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2438362wag
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 16:33:32 -0800 (PST)
Message-ID: <9e4733910711051633q783c2992wdaf95866f014766@mail.gmail.com>
Date: Mon, 5 Nov 2007 19:33:32 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <fa686aa40711051446q1abe886dh6225fa1ec675ef9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
	<fa686aa40711051446q1abe886dh6225fa1ec675ef9b@mail.gmail.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/5/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> > Jon Smirl wrote:
> > > On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> > >> Jon Smirl wrote:
> > >>> This is my first pass at reworking the Freescale i2c driver. It
> > >>> switches the driver from being a platform driver to an open firmware
> > >>> one. I've checked it out on my hardware and it is working.
> > >> We may want to hold off on this until arch/ppc goes away (or at least
> > >> all users of this driver in arch/ppc).
> > >
> > > How about renaming the old driver file and leaving it hooked to ppc?
> > > Then it would get deleted when ppc goes away. That would let work
> > > progress on the powerpc version.
> >
> > Or we could have one driver that has two probe methods.  I don't like
> > forking the driver.
>
> I agree.  This driver can and should have multiple bus bindings.

What non-of platform uses this driver?

I believe this is the last struct platform driver left for the
mpc5200. Fixing this one allows the platform bus to be removed. With a
device tree there isn't any reason to keep a platform bus, everything
should be on the of_platform bus.

-- 
Jon Smirl
jonsmirl@gmail.com
