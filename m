Return-Path: <dgibson@ozlabs.org>
Date: Tue, 11 Mar 2008 11:45:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: OF compatible MTD platform RAM driver ?
Message-ID: <20080311004545.GI11559@localhost.localdomain>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0418505E@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0418505E@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, ben@simtec.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 10, 2008 at 12:00:22PM -0500, Rune Torgersen wrote:
> linuxppc-dev-bounces+runet=innovsys.com@ozlabs.org wrote:
> > Hi everybody,
> > 
> > as part of a ARCH=ppc to ARCH=powerpc migration process, I'm
> > looking for an
> > OpenFirmware compatible way to handle a RAM-based MTD device.
> > 
> > On the platform_device based ppc architecture, the
> > drivers/mtd/maps/plat-ram.c
> > driver handled "mtd-ram" platform devices. There is no such
> > driver for the
> > OF-based powerpc architecture.
> > 
> > As a temporary workaround I hacked the physmap_of driver to
> > handle "direct-mapped" OF devices oh type "ram" by adding a
> > corresponding entry in the of_flash_match[] array. This seems to work
> > fine. 
> > 
> > What would be the preferred way to handle OF-compatible RAM-based MTD
> > devices ? The 3 ways I can think of are
> > 
> > 1. porting the plat-ram driver to OF (the driver isn't used
> > in the kernel tree
> > but I suspect it is used by out-of-tree boards)
> > 
> > 2. creating a new plat-ram-of driver, much like the
> > physmap_of driver comes
> > from the physmap driver
> > 
> > 3. extending the physmap_of driver to handle RAM devices (in
> > which case
> > references to "flash" in the function names should probably
> > be replaced
> > by "mtd")
> > 
> > I live option 3 better so far.
> > 
> > Has anyone already worked on this ? Is there any defined
> > device tree mapping
> > for MTD RAM devices ?
> 
> We ran ito the same issue. 
> We did option 3, as it was efinetly the easiest,

I think this is the best option in principle.

> here is the sram entry in our dts:

Except that your implementation of it is not good.

You're relying on the old obsolete flash binding with the "probe-type"
field.  The solution should be adapted to the new approach which uses
values in the "compatible" field to indicate various sorts of flash
device.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
