Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 8CA09DF7BF
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 02:12:41 +1000 (EST)
Date: Thu, 17 Apr 2008 20:12:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080417161239.GA24201@polina.dev.rtsoft.ru>
References: <20080311172106.GA4766@localhost.localdomain>
	<47E02A8C.2080705@freescale.com>
	<20080416183904.GA23512@polina.dev.rtsoft.ru>
	<200804171624.02769.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200804171624.02769.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 04:23:56PM +0200, Laurent Pinchart wrote:
> > +	/*
> > +	 * We have two 8 bit prescalers -- primary and secondary (psr, sps),
> > +	 * plus "slow go" mode (clk / 16). So, total prescale value is
> > +	 * 16 * (psr + 1) * (sps + 1).
> > +	 */
> > +	if (prescaler > 256 * 256 * 16)
> > +		return -EINVAL;
> > +
> > +	if (prescaler > 256 * 256) {
> > +		iclk = GTMDR_ICLK_SLGO;
> > +		prescaler /= 16;
> > +	}
> > +
> > +	if (prescaler > 256) {
> > +		psr = 256 - 1;
> > +		sps = prescaler / 256 - 1;
> > +	} else {
> > +		psr = prescaler - 1;
> > +		sps = 1 - 1;
> > +	}
> 
> Don't forget that the CPM2 doesn't support the primary prescaler.

Here is incremental diff of how this is solved. I guess this should work.

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index b0ddd54..b89c56d 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2835,7 +2835,7 @@ platforms are moved over to use the flattened-device-tree model.
 
     Required properties:
       - compatible : should be "fsl,gtm" ("fsl,qe-gtm" in addition for QE
-                     GTMs).
+                     GTMs or "fsl,cpm2-gtm" for CPM2 GTMs).
       - reg : should contain gtm registers location and length (0x40).
       - interrupts : should contain four interrupts.
       - interrupt-parent : interrupt source phandle.
diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
index 6d86983..105c633 100644
--- a/arch/powerpc/sysdev/fsl_gtm.c
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -125,27 +125,32 @@ static int gtm_reset_ref_timer16(struct gtm_timer *tmr, int frequency,
 	u8 psr;
 	u8 sps;
 	unsigned long flags;
+	int max_prescaler = 256 * 256 * 16;
+
+	/* CPM2 doesn't have primary prescaler */
+	if (!tmr->gtpsr)
+		max_prescaler /= 256;
 
 	prescaler = gtm->clock / frequency;
 	/*
 	 * We have two 8 bit prescalers -- primary and secondary (psr, sps),
 	 * plus "slow go" mode (clk / 16). So, total prescale value is
-	 * 16 * (psr + 1) * (sps + 1).
+	 * 16 * (psr + 1) * (sps + 1). Though, for CPM2 GTMs we losing psr.
 	 */
-	if (prescaler > 256 * 256 * 16)
+	if (prescaler > max_prescaler)
 		return -EINVAL;
 
-	if (prescaler > 256 * 256) {
+	if (prescaler > max_prescaler / 16) {
 		iclk = GTMDR_ICLK_SLGO;
 		prescaler /= 16;
 	}
 
-	if (prescaler > 256) {
+	if (prescaler <= 256) {
+		psr = 0;
+		sps = prescaler - 1;
+	} else {
 		psr = 256 - 1;
 		sps = prescaler / 256 - 1;
-	} else {
-		psr = prescaler - 1;
-		sps = 1 - 1;
 	}
 
 	spin_lock_irqsave(&gtm->lock, flags);
@@ -159,7 +164,8 @@ static int gtm_reset_ref_timer16(struct gtm_timer *tmr, int frequency,
 
 	setbits8(tmr->gtcfr, GTCFR_STP(num));
 
-	out_be16(tmr->gtpsr, psr);
+	if (tmr->gtpsr)
+		out_be16(tmr->gtpsr, psr);
 	clrsetbits_be16(tmr->gtmdr, 0xFFFF, iclk | GTMDR_SPS(sps) |
 			GTMDR_ORI | (free_run ? GTMDR_FFR : 0));
 	out_be16(tmr->gtcnr, 0);
@@ -222,7 +228,8 @@ void gtm_stop_timer16(struct gtm_timer *tmr)
 }
 EXPORT_SYMBOL(gtm_stop_timer16);
 
-static void __init gtm_set_shortcuts(struct gtm_timer *timers,
+static void __init gtm_set_shortcuts(struct device_node *np,
+				     struct gtm_timer *timers,
 				     struct gtm_timers_regs __iomem *regs)
 {
 	/*
@@ -233,31 +240,35 @@ static void __init gtm_set_shortcuts(struct gtm_timer *timers,
 	 */
 	timers[0].gtcfr = &regs->gtcfr1;
 	timers[0].gtmdr = &regs->gtmdr1;
-	timers[0].gtpsr = &regs->gtpsr1;
 	timers[0].gtcnr = &regs->gtcnr1;
 	timers[0].gtrfr = &regs->gtrfr1;
 	timers[0].gtevr = &regs->gtevr1;
 
 	timers[1].gtcfr = &regs->gtcfr1;
 	timers[1].gtmdr = &regs->gtmdr2;
-	timers[1].gtpsr = &regs->gtpsr2;
 	timers[1].gtcnr = &regs->gtcnr2;
 	timers[1].gtrfr = &regs->gtrfr2;
 	timers[1].gtevr = &regs->gtevr2;
 
 	timers[2].gtcfr = &regs->gtcfr2;
 	timers[2].gtmdr = &regs->gtmdr3;
-	timers[2].gtpsr = &regs->gtpsr3;
 	timers[2].gtcnr = &regs->gtcnr3;
 	timers[2].gtrfr = &regs->gtrfr3;
 	timers[2].gtevr = &regs->gtevr3;
 
 	timers[3].gtcfr = &regs->gtcfr2;
 	timers[3].gtmdr = &regs->gtmdr4;
-	timers[3].gtpsr = &regs->gtpsr4;
 	timers[3].gtcnr = &regs->gtcnr4;
 	timers[3].gtrfr = &regs->gtrfr4;
 	timers[3].gtevr = &regs->gtevr4;
+
+	/* CPM2 doesn't have primary prescaler */
+	if (!of_device_is_compatible(np, "fsl,cpm2-gtm")) {
+		timers[0].gtpsr = &regs->gtpsr1;
+		timers[1].gtpsr = &regs->gtpsr2;
+		timers[2].gtpsr = &regs->gtpsr3;
+		timers[3].gtpsr = &regs->gtpsr4;
+	}
 }
 
 static int __init gtm_init(void)
@@ -307,7 +318,7 @@ static int __init gtm_init(void)
 			goto err;
 		}
 
-		gtm_set_shortcuts(gtm->timers, gtm->regs);
+		gtm_set_shortcuts(np, gtm->timers, gtm->regs);
 
 		/* We don't want to lose the node and its ->data */
 		of_node_get(np);
