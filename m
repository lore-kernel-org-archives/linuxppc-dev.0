Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B678BDE11E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 04:48:46 +1100 (EST)
Date: Wed, 4 Mar 2009 20:48:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [PATCH 07/13] sdhci: Add support for hosts with strict 32 bit
	addressing
Message-ID: <20090304174845.GC7477@oksana.dev.rtsoft.ru>
References: <20090213144630.GA13436@oksana.dev.rtsoft.ru>
	<20090213144722.GG23889@oksana.dev.rtsoft.ru>
	<20090221165833.6dec220a@mjolnir.ossman.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090221165833.6dec220a@mjolnir.ossman.eu>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx,
	Pierre Ossman <drzeus-sdhci@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 21, 2009 at 04:58:33PM +0100, Pierre Ossman wrote:
> On Fri, 13 Feb 2009 17:47:22 +0300
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > SDHCI driver must take special care when working with "triggering"
> > registers on hosts with strict 32 bit addressing.
> > 
> > In FSL eSDHC hosts all registers are 32 bit width, writing to the
> > first half of any register will cause [undefined?] write the second
> > half of the register. That is, 16 bit write to the TRANSFER_MODE
> > register, makes hardware see a bogus write to the COMMAND register
> > (these two registers are adjacent).
> > 
> > This patch adds SDHCI_QUIRK_32BIT_REGISTERS quirk. When specified,
> > the sdhci driver will try to "pack" all dangerous writes into single
> > 32 bit write transaction.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> 
> What about the other places where we have 16 and 8 bit registers?

These are handled by the accessors:

+static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+       int base = reg & ~0x3;
+       int shift = (reg & 0x3) * 8;
+
+       clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);

^^ See, we're always issuing 32bit ops.

The point of this patch is to take care of "triggering" registers,
i.e. those registers that are used trigger "send some data" command.

There is just one (from the eSDHC point of view) such register:
TRANSFER_MODE+COMMAND (which is a single 32 bit register in eSDHC,
but two independant word-sized registers in standard SDHCI).

That register must be accessed with 32bit ops just _once_ per
data transfer, not two 32bit writes (half of a register one time,
and half of a register next time -- this won't work).

But I see the point of confusion... Instead of teaching
"SDHCI core" to work with 32 bits hosts, we'd better handle this
in the eSDHC part, in the accessors.

This is relatively trivial and should not cause much overhead
(at least when using DMA), just a small state machine with
the xfer mode register shadowed in software (plus, notice that
this also handles BLOCK_SIZE, as I promised in another email):

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 22bf006..5100d1d 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -30,6 +30,7 @@ struct sdhci_of_data {
 
 struct sdhci_of_host {
 	unsigned int clock;
+	u16 xfer_mode_shadow;
 };
 
 /*
@@ -69,9 +70,31 @@ static void esdhc_writel(struct sdhci_host *host, u32 val, int reg)
 
 static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
 {
+	struct sdhci_of_host *of_host = sdhci_priv(host);
 	int base = reg & ~0x3;
 	int shift = (reg & 0x2) * 8;
 
+	switch (reg) {
+	case SDHCI_TRANSFER_MODE:
+		/*
+		 * Postpone this write, we must do it together with a
+		 * command write that is down below.
+		 */
+		of_host->xfer_mode_shadow = val;
+		return;
+	case SDHCI_COMMAND:
+		esdhc_writel(host, val << 16 | of_host->xfer_mode_shadow,
+			     SDHCI_TRANSFER_MODE);
+		return;
+	case SDHCI_BLOCK_SIZE:
+		/*
+		 * Two last DMA bits are reserved, and first one is used for
+		 * non-standard blksz of 4096 bytes that we don't support
+		 * yet. So clear the DMA boundary bits.
+		 */
+		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
+		/* fall through */
+	}
 	clrsetbits_be32(host->ioaddr + base, 0xffff << shift, val << shift);
 }
 
@@ -137,13 +160,11 @@ static unsigned int esdhc_get_timeout_clock(struct sdhci_host *host)
 }
 
 static struct sdhci_of_data sdhci_esdhc = {
-	.quirks = SDHCI_QUIRK_32BIT_REGISTERS |
-		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		  SDHCI_QUIRK_NO_BUSY_IRQ |
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
 		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
-		  SDHCI_QUIRK_MAX_BLK_SZ_4096 |
 		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
 		  SDHCI_QUIRK_NO_CARD_NO_RESET,
 	.ops = {
