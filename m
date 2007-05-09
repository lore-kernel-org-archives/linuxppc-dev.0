Return-Path: <dgibson@ozlabs.org>
Date: Wed, 9 May 2007 11:09:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Current powerpc.git build failures
Message-ID: <20070509010941.GC4198@localhost.localdomain>
References: <20070508191758.GA26879@lixom.net> <4640DDD8.4040001@freescale.com>
	<5E47D5F4-DD15-46D1-A947-3031D069486F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5E47D5F4-DD15-46D1-A947-3031D069486F@kernel.crashing.org>
Cc: jdl@jdl.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Olof Johansson <olof@lixom.net>, arnd@ardnb.de,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 03:38:35PM -0500, Kumar Gala wrote:
> 
> On May 8, 2007, at 3:30 PM, Timur Tabi wrote:
> 
> > Olof Johansson wrote:
> >
> >> powerpc.mpc8641_hpcn_defconfig:
> >> In file included from include/asm-generic/pgtable-nopmd.h:6,
> >>                  from include/asm/pgtable-ppc32.h:4,
> >>                  from include/asm/pgtable.h:8,
> >>                  from arch/powerpc/platforms/86xx/mpc86xx_smp.c:18:
> >> include/asm-generic/pgtable-nopud.h:13: error: expected specifier- 
> >> qualifier-list before 'pgd_t'
> >
> > This must have occurred in the past 24 hours because I built the  
> > latest 8641 yesterday
> > morning and it worked fine.  mpc86xx_smp.c has not changed since  
> > February, so I'm guessing
> > that some header file that mpc86xx_smp.c includes no longer  
> > includes some other header.
> 
> I'm guessing this is from david gibson's  4level-fixup.h for ppc32  
> patch.

Looks like.  AFAICT, the generic nopud.h and nopmd.h headers expect
page.h to be included before pgtable.h.  I think this patch should fix
the problem, but I don't have a suitable board to test with.

Index: working-2.6/arch/powerpc/platforms/86xx/mpc86xx_smp.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/86xx/mpc86xx_smp.c	2007-05-09 11:08:15.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/86xx/mpc86xx_smp.c	2007-05-09 11:08:33.000000000 +1000
@@ -15,8 +15,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-#include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/pgtable.h>
 #include <asm/pci-bridge.h>
 #include <asm-powerpc/mpic.h>
 #include <asm/mpc86xx.h>


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
