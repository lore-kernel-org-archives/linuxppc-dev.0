Return-Path: <dgibson@ozlabs.org>
Date: Wed, 9 May 2007 11:57:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Loeliger Jon-LOELIGER <jdl@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>, jdl@jdl.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Olof Johansson <olof@lixom.net>, arnd@ardnb.de,
	Tabi Timur-B04825 <timur@freescale.com>
Subject: Re: Current powerpc.git build failures
Message-ID: <20070509015753.GH4198@localhost.localdomain>
References: <20070508191758.GA26879@lixom.net>
	<20070509010941.GC4198@localhost.localdomain>
	<AF0367BA48C55940A43CCF08DF35553C012AA6B2@az33exm24.fsl.freescale.net>
	<20070509015146.GF4198@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070509015146.GF4198@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 09, 2007 at 11:51:46AM +1000, David Gibson wrote:
> On Tue, May 08, 2007 at 06:18:29PM -0700, Jon Loeliger wrote:
> > > Looks like.  AFAICT, the generic nopud.h and nopmd.h headers expect
> > > page.h to be included before pgtable.h.  I think this patch should fix
> > > the problem, but I don't have a suitable board to test with.
> > > 
> > 
> > That would be me.  I'll give it a spin.
> 
> Duh, of course, I wasn't thinking at that point and realizing I could
> at least test the build was fixed.  Which I've now done; and found
> some other warnings caused by my patch.  Improved fix below.  Unless
> you report that it breaks something, I'll ask Paul to pull it.

Gah, sorry.  Really below, this time:

Fix missing printk() parameter in physmap_of.c MTD driver

Squashes a compiler warning, and provides more useful information in
the case messed up device tree information.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/drivers/mtd/maps/physmap_of.c
===================================================================
--- working-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-05-07 12:57:07.000000000 +1000
+++ working-2.6/drivers/mtd/maps/physmap_of.c	2007-05-09 11:53:53.000000000 +1000
@@ -186,7 +186,7 @@ static int __devinit of_physmap_probe(st
 	else {
  		if (strcmp(of_probe, "ROM"))
 			dev_dbg(&dev->dev, "map_probe: don't know probe type "
-			"'%s', mapping as rom\n");
+			"'%s', mapping as rom\n", of_probe);
 		info->mtd = do_map_probe("mtd_rom", &info->map);
 	}
 	if (info->mtd == NULL) {


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
