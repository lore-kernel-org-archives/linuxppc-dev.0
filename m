Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E6131A0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 16:36:29 +1100 (AEDT)
Message-ID: <1415856988.28703.7.camel@concordia>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Nov 2014 16:36:28 +1100
In-Reply-To: <1415772441.5124.39.camel@kernel.crashing.org>
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
 <1415772441.5124.39.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 wsa@the-dreams.de, linux-i2c@vger.kernel.org,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-11-12 at 17:07 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2014-11-10 at 11:35 +0530, Neelesh Gupta wrote:
> > The patch exposes the available i2c busses on the PowerNV platform
> > to the kernel and implements the bus driver to support i2c and
> > smbus commands.
> > The driver uses the platform device infrastructure to probe the busses
> > on the platform and registers them with the i2c driver framework.
> > 
> > Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> This version slightly modified removes the unrelated gunk in opal.c
> (but needs to apply on top of some other patches in the powerpc tree)
> 
> The driver is the same, it's only the
> arch/powerpc/platform/powernv/opal.c init bits that get cleaned up and
> simplified.
> 
> From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Date: Fri, 7 Nov 2014 16:20:07 +1100
> Subject: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
> 
> The patch exposes the available i2c busses on the PowerNV platform
> to the kernel and implements the bus driver to support i2c and
> smbus commands.
> 
> If the devices are found on the device tree for a given bus/adapter,
> the platform init code registers them to the core and binds them
> a static bus/adapter number, otherwise the driver registers the
> adapter to get the adapter number dynamically.

So the driver part depends on the arch/powerpc changes.

I added Wolfram the i2c maintainer to CC. Wolfram are you happy if we take this
through the powerpc tree with your ack, or I can do a topic branch?

cheers
