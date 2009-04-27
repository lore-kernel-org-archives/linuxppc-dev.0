Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B70FADDFB9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 04:47:44 +1000 (EST)
Date: Mon, 27 Apr 2009 22:47:42 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] alim15x3: Remove historical hacks, re-enable init_hwif for
	PowerPC
Message-ID: <20090427184742.GA6435@oksana.dev.rtsoft.ru>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
	<20090417124014.GA8944@oksana.dev.rtsoft.ru>
	<1239986984.7210.9.camel@pasglop>
	<200904172017.18486.bzolnier@gmail.com>
	<20090417182332.GA18756@oksana.dev.rtsoft.ru>
	<c8485d470904270146g7b7204eckc58cd57449a41f45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <c8485d470904270146g7b7204eckc58cd57449a41f45@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Roderick Colenbrander <thunderbird2k@gmail.com>,
	linux-ide@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some time ago we had to disable init_hwif callback for PowerPC builds.
That was because of a historical IRQ overwrite in the driver, which
was causing IDE malfunction on the MPC8610HPCD PowerPC boards.

It's unclear whether this overwrite is still useful, but it is proven
to cause a bit of harm, and today some PowerPC targets (Xilinx ML510,
as reported by Roderick Colenbrander) need the init_hwif, so we have
to re-enable it and remove the overwrite.

Reported-by: Roderick Colenbrander <thunderbird2k@gmail.com>
Suggested-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Mon, Apr 27, 2009 at 10:46:25AM +0200, Roderick Colenbrander wrote:
> >> Seems like this should allow MPC8610HPCD to work with Roderick's patch
> >> if the IDE controller is set to native mode and ALI south-bridge SIRQ
> >> tables are correctly set (or if this is not ALI's south-bridge).  Anton?
> >
> > OK, I'll test this approach.
> >
> 
> Did this approach work for you?

I'm sorry for the delay. Yes, it seem to work.

 drivers/ide/alim15x3.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
index 537da1c..e59b6de 100644
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -402,27 +402,23 @@ static u8 ali_cable_detect(ide_hwif_t *hwif)
 	return cbl;
 }
 
-#if !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC)
+#ifndef CONFIG_SPARC64
 /**
  *	init_hwif_ali15x3	-	Initialize the ALI IDE x86 stuff
  *	@hwif: interface to configure
  *
  *	Obtain the IRQ tables for an ALi based IDE solution on the PC
  *	class platforms. This part of the code isn't applicable to the
- *	Sparc and PowerPC systems.
+ *	Sparc systems.
  */
 
 static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
 {
-	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	u8 ideic, inmir;
 	s8 irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
 				      1, 11, 0, 12, 0, 14, 0, 15 };
 	int irq = -1;
 
-	if (dev->device == PCI_DEVICE_ID_AL_M5229)
-		hwif->irq = hwif->channel ? 15 : 14;
-
 	if (isa_dev) {
 		/*
 		 * read IDE interface control
@@ -455,7 +451,7 @@ static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
 }
 #else
 #define init_hwif_ali15x3 NULL
-#endif /* !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC) */
+#endif /* CONFIG_SPARC64 */
 
 /**
  *	init_dma_ali15x3	-	set up DMA on ALi15x3
-- 
1.6.2.2
