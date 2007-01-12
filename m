Return-Path: <dogoil@etinsys.com>
Received: from jupiter.etinsys.com (unknown [220.76.45.3])
	by ozlabs.org (Postfix) with ESMTP id 9F14FDDF28
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 12:45:31 +1100 (EST)
Message-Id: <200701120145.l0C1jc1x019343@jupiter.etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
Subject: RE: [PATCH] kvme080 board support patch
Date: Fri, 12 Jan 2007 10:45:15 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <6EAF2EA8-8414-4A4A-9A9A-44AA2FDC8B9D@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> >
> > +static void
> > +kvme080_restart(char *cmd)
> > +{
> > +	unsigned long srr;
> > +
> > +	local_irq_disable();
> > +	asm volatile(
> > +	" lis %0,0xfff0\n \
> > +	  ori %0,%0,0x0100\n \
> > +	  mtspr 26,%0\n \
> > +	  sync\n \
> > +	  lis %0,0x0000\n \
> > +	  ori %0,%0,0x0000\n \
> > +	  mtspr 27,%0\n \
> > +	  sync\n \
> > +	  rfi "
> > +	  : "=r" (srr));
> > +}
> 
> Does this restart actually work for you?  Do you not have any issues with
devices being in a funny state and not actually being restated?

Actually we have some issues with some pci devices not properly initialized
when restarting.
Although it causes some delay, the board eventually boot.
I am considering to put a hardware reset function here.

> Also, you can do mtspr(SPRN_SRR0, val); mtspr(SPRN_SRR1, val); and then
the asm for the "rfi".

Thank you for the good comment.
I made the incremental patch.

Signed-off-by: Sangmoon Kim <dogoil@etinsys.com>

diff --git a/arch/powerpc/platforms/embedded6xx/kvme080.c
b/arch/powerpc/platforms/embedded6xx/kvme080.c
index 6f904ca..8da3464 100644
--- a/arch/powerpc/platforms/embedded6xx/kvme080.c
+++ b/arch/powerpc/platforms/embedded6xx/kvme080.c
@@ -130,20 +130,10 @@ kvme080_init_IRQ(void)
 static void
 kvme080_restart(char *cmd)
 {
-	unsigned long srr;
-
 	local_irq_disable();
-	asm volatile(
-	" lis %0,0xfff0\n \
-	  ori %0,%0,0x0100\n \
-	  mtspr 26,%0\n \
-	  sync\n \
-	  lis %0,0x0000\n \
-	  ori %0,%0,0x0000\n \
-	  mtspr 27,%0\n \
-	  sync\n \
-	  rfi "
-	  : "=r" (srr));
+	mtspr(SPRN_SRR0, 0xfff00100);
+	mtspr(SPRN_SRR1, 0x00000000);
+	asm volatile("rfi");
 }
 
 static void

Regards,
Sangmoon Kim
