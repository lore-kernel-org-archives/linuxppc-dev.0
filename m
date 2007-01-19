Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3D58FDDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 03:11:18 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0JGBFoR017588
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 09:11:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0JGBFrL023355
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 10:11:15 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Discussion on SOC device tree bindings
Date: Fri, 19 Jan 2007 09:11:14 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3023612F8@az33exm25.fsl.freescale.net>
In-Reply-To: <CB20EEEE-9C3D-4FFC-869E-D331F8CA264A@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Back in Grant's original summary of the problem he wrote:
> 4. I think that the general consensus is that the device tree should
> have a node for shared SoC registers and a node for each on chip
> device.  One will point to the other (phandle?) to indicate which node
> device drivers should look to for twiddling the shared bits.
>
> 5. The contentious issue is which direction those links should be
> constructed.  Does the device node describe where to find it's SoC
> parent node and what the device index is?  Or does the SoC node
> describe which device nodes it provides shared register service for?

How about linking in _both_ directions?

-The SOC node describes the shared register with links to the
 the device nodes it is associated with

-The device nodes link to the SOC parent shared register node
(_but_ don't necessarily specify the device index, since that
 could be determined by looking at the SOC node)

Doing both provides flexibility in the way the device tree
is used.   The SOC node in a single place describes the
shared register which conceptually makes sense.  The device
node has a pointer to an affiliated register which exists
outside the device itself.

Stuart Yoder
PowerPC Software Architecture, Freescale
