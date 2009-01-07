Return-Path: <scottwood@freescale.com>
Date: Wed, 7 Jan 2009 09:25:51 -0600
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: The usage of compatible 'simple-bus'
Message-ID: <20090107152551.GA15585@ld0162-tx32.am.freescale.net>
References: <20090106014323.GB29456@yookeroo.seuss>
	<3A45394FD742FA419B760BB8D398F9ED0B38C9@zch01exm26.fsl.freescale.net>
	<20090107020006.GD13731@yookeroo.seuss>
	<2a27d3730901061951g333d10b6mf4dc0219570e521b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2a27d3730901061951g333d10b6mf4dc0219570e521b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2009 at 11:51:12AM +0800, Li Yang wrote:
> > I see two sensible options for this situation:
> >        - Move the MDIO node to outside the gianfar MAC node.  I think
> > this is already done on some boards with gianfar?
> 
> Yes, we can use good old way.  But as Scott has moved the MDIO into
> the gianfar node on MPC8313, maybe it's a better way to describe the
> relationship of the two parts.

Ah, right, that was to reflect the clock domain situation so that someday
when I get time to do device power management the kernel can know that by
shutting down ethernet@25000 it's also shutting down mdio@24520, which is
also used by ethernet@26000.

Adding simple-bus was a bit of a hack, but it preserves the existing
binding whereby mdio sits under a simple-bus.  Ideally, the mdio node
would simply be a container for PHY nodes, and would simply be a part of
gianfar rather than a separate entity.

-Scott
