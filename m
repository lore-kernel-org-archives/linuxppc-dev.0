Return-Path: <dgibson@ozlabs.org>
Date: Wed, 22 Aug 2007 11:10:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 10/20] bootwrapper: Add CPM serial driver.
Message-ID: <20070822011006.GC12472@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173957.GI30562@ld0162-tx32.am.freescale.net>
	<20070821024200.GJ15469@localhost.localdomain>
	<46CB0FB9.5000706@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46CB0FB9.5000706@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 11:15:53AM -0500, Scott Wood wrote:
> David Gibson wrote:
> >>diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
> >>index 944f0ee..d47f8e0 100644
> >>--- a/arch/powerpc/boot/serial.c
> >>+++ b/arch/powerpc/boot/serial.c
> >>@@ -121,6 +121,11 @@ int serial_console_init(void)
> >> 		rc = ns16550_console_init(devp, &serial_cd);
> >> 	else if (dt_is_compatible(devp, "marvell,mpsc"))
> >> 		rc = mpsc_console_init(devp, &serial_cd);
> >>+	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
> >>+	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
> >>+	         dt_is_compatible(devp, "fsl,cpm2-scc-uart") ||
> >>+	         dt_is_compatible(devp, "fsl,cpm2-smc-uart"))
> >>+		rc = cpm_console_init(devp, &serial_cd);
> > 
> > 
> > If all these variants admit a compatible driver, there really should
> > be defined a compatible value that they all include in the device
> > tree.
> 
> That's what I did last time, and several people complained. :-)
> 
> The issue was that while there is a lot in common between these 
> variants, there's no one common subset that can be used to drive the 
> device without knowledge of what variant it is (or knowledge of where 
> the firmware placed the descriptors).

Ah, ok.  Fair enough then.

> > But I guess you'd still need all these tests for device trees
> > which didn't have it.
> 
> Nah, this is a new binding.
> 
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
