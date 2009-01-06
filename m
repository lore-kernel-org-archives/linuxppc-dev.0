Return-Path: <dgibson@ozlabs.org>
Date: Tue, 6 Jan 2009 12:43:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: The usage of compatible 'simple-bus'
Message-ID: <20090106014323.GB29456@yookeroo.seuss>
References: <3A45394FD742FA419B760BB8D398F9ED0B37E7@zch01exm26.fsl.freescale.net>
	<20090105192053.GB23766@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090105192053.GB23766@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 05, 2009 at 01:20:53PM -0600, Scott Wood wrote:
> On Mon, Jan 05, 2009 at 06:27:39PM +0800, Li Yang wrote:
> > I got an assumption from the existing device trees that having
> > 'simple-bus' in the compatible property of a node means that all child
> > nodes should be added as of_platform_device in platform initialization
> > phase.  No matter it represents a bus in common sense or not.  Is this
> > truly the case? 
> 
> Yes, simple-bus indicates that the children can be driven standalone from
> any knowledge of the parent bus.

Erm, well, sort of.  Strictly it indicates that the only way to locate
the child devices of this bus is by using the address information in
the device tree - there's no way to dynamically probe the bus.

The fact that this causes of_platform_devices to be instantiated is a
Linux implementation specific detail (and one we might change in
future).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
