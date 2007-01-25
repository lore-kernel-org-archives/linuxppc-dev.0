Return-Path: <benh@kernel.crashing.org>
Subject: EMAC "powerpc" port update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 18:00:02 +1100
Message-Id: <1169708402.24996.82.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Josh Boyer <jdub@us.ibm.com>, Murali N Iyer <mniyer@us.ibm.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's a new drop at:

http://gate.crashing.org/~benh/powerpc-emac-new-20070125.diff

No much differences from the previous one, most of my previous comments
about things to do still apply. The updates are mostly to make it work
for a customer :-)

 - Fix build without debug
 - Fix build when sungem or spidernet are built-in (name conflict of
exported functions in the PHY stuff)
 - Fix STACR bits since it seems the HW folks had the great idea of
changing their meaning, so the PHY is now properly setup and flow
control works (yeah !)

I've decided to delay the port to the common phy layer due to the
locking issues I mentioned to after I merge it. Already too many things
going on at the same time in there :-)

I also haven't brought back the mecanism for dealing with Rx clock loss
as I need to verify wether we can do that differently using loopback, or
else, use some different way of implementing it for locking reasons
(probably pushing the clock control to the platform/cpu code and have
emac call it so the locking for access to those clock registers can be
centralized).

In fact, most of my other comments in my initial submission still
appply :-) It's however good enough to use with the Axon chip on cell
and thus could probably be merged as it co-exists fine with the old
driver in arch/ppc. Now that David Gibson is porting 4xx over to
arch/powerpc, I'll soon be able to start beating it up on 4xx too and
fix the remaining issues on these.

Murali: Note that I still don't unmap DMA pages, so it works fine as
long as the IOMMU is disabled, which should be the default on all HW we
are interested in at the moment, except some stuff you might know about
that has more than 2GB of RAM... I'll fix that in a later drop.

Ben.
