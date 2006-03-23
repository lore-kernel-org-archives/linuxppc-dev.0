Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C998567B2D
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 08:04:03 +1100 (EST)
Date: Thu, 23 Mar 2006 22:03:57 +0100
From: Olaf Hering <olh@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] return to OF via trap, not exit
Message-ID: <20060323210357.GC24667@suse.de>
References: <20060304191026.GA9815@suse.de>
	<200603061212.12815.michael@ellerman.id.au>
	<20060306073834.GA24869@suse.de>
	<590CA2B3-AACE-4B69-930D-9A66A42FFC83@kernel.crashing.org>
	<20060306074339.GC24869@suse.de>
	<1912CD56-027C-491D-B2A2-EA44AB4DDD14@kernel.crashing.org>
	<20060306074953.GE24869@suse.de>
	<EA07A673-A993-490A-ADEC-29CFDF1DDAC1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <EA07A673-A993-490A-ADEC-29CFDF1DDAC1@kernel.crashing.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Mar 06, Segher Boessenkool wrote:

> That's better than always calling trap, sure.  Is there any reason
> you can't just do it on Macs though?  Because the problem you're trying
> to work around only happens there.

Maybe something like this? Only compile tested


Do not call prom exit prom_panic. It clears the screen and the exit message is lost.
On some (or all?) pmacs it causes another crash when OF tries to print the
date and time in its banner.

Set of_platform earlier to catch more prom_panic() calls.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/prom_init.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

Index: linux-2.6.16-olh/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.16-olh.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6.16-olh/arch/powerpc/kernel/prom_init.c
@@ -397,6 +397,11 @@ static void __init __attribute__((noretu
 	reason = PTRRELOC(reason);
 #endif
 	prom_print(reason);
+	/* Do not call exit because it clears the screen on pmac
+	 * it also causes some sort of double-fault on early pmacs */
+	if (RELOC(of_platform) == PLATFORM_POWERMAC)
+		asm("trap\n");
+
 	/* ToDo: should put up an SRC here on p/iSeries */
 	call_prom("exit", 0, 0);
 
@@ -2060,15 +2065,6 @@ unsigned long __init prom_init(unsigned 
 	 */
 	prom_init_stdout();
 
-	/* Bail if this is a kdump kernel. */
-	if (PHYSICAL_START > 0)
-		prom_panic("Error: You can't boot a kdump kernel from OF!\n");
-
-	/*
-	 * Check for an initrd
-	 */
-	prom_check_initrd(r3, r4);
-
 	/*
 	 * Get default machine type. At this point, we do not differentiate
 	 * between pSeries SMP and pSeries LPAR
@@ -2078,6 +2074,15 @@ unsigned long __init prom_init(unsigned 
 	prom_setprop(_prom->chosen, "/chosen", "linux,platform",
 		     &getprop_rval, sizeof(getprop_rval));
 
+	/* Bail if this is a kdump kernel. */
+	if (PHYSICAL_START > 0)
+		prom_panic("Error: You can't boot a kdump kernel from OF!\n");
+
+	/*
+	 * Check for an initrd
+	 */
+	prom_check_initrd(r3, r4);
+
 #ifdef CONFIG_PPC_PSERIES
 	/*
 	 * On pSeries, inform the firmware about our capabilities
