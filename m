Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910712101454l39285585j55e4d72ae4329cf9@mail.gmail.com>
Date: Mon, 10 Dec 2007 17:54:42 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Addition to the i2c series,
	copy the ppc mpc-i2c driver before changing it on powerpc
In-Reply-To: <fa686aa40712101444l448657c5jb6117e7a60715651@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910712101420o15b5e908jc7291a0086832467@mail.gmail.com>
	<fa686aa40712101444l448657c5jb6117e7a60715651@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/10/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 12/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > Copy mpc-i2c to preserve support for ARCH=ppc and allow changes on ARCH=powerpc
> >
> > Temporarily copy the mpc-i2c driver to continue support for the ppc
> > architecture until it is removed in mid-2008. This file should be
> > deleted as part of ppc's final removal.
> >
> > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
> For the record; I'm not fond of this approach.  Supporting both bus
> bindings in the single driver is simple and results in less code churn
> when arch/ppc is removed, and encourages separation between the driver
> proper and the bus bindings which is just a good idea for all drivers
> in general.

But it also triggers a testing burden on a bunch of hardware that I
don't own. By copying off the known working ppc driver the testing
burden is avoided.

A subject for later discussion is whether platform bus should even
exist when of_platform_bus is in use. I have removed platform_bus for
the mpc5200 in my local builds. Removing platform bus exposed a bunch
of junk from other platofrms that had inadvertently accumulated into
the mpc5200 build.

-- 
Jon Smirl
jonsmirl@gmail.com
