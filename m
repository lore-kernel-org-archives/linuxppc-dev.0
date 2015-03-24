Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7AD21A0549
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 13:33:18 +1100 (AEDT)
Message-ID: <1427164368.4770.310.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/5] powerpc: Remove powerpc specific byteswap from
 bt8xx DVB driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 24 Mar 2015 13:32:48 +1100
In-Reply-To: <1422941785-22557-3-git-send-email-david@gibson.dropbear.id.au>
References: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
 <1422941785-22557-3-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, aik@ozlabs.ru,
 Peter Hettkamp <peter.hettkamp@htp-tel.de>, agraf@suse.de,
 linux-kernel@vger.kernel.org, paulus@samba.org, mdroth@us.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-03 at 16:36 +1100, David Gibson wrote:
> The bt8xx PCI DVB driver includes a powerpc specific hack, using one of
> the powerpc specific byteswapping functions in an IO helper macro.
> 
> There's no reason to use the powerpc specific function instead of a
> generic byteswap, so this patch removes it.  I'm not sure if the powerpc
> specific memory barrier is required, so I'm leaving that in.
> 
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Cc: Peter Hettkamp <peter.hettkamp@htp-tel.de>

In fact there's no reason for the powerpc specific bits in this driver
(they might have been useful 15 years ago but they definitely aren't
anymore), I'll replace this with the patch with:

(Mauro, unless you holler ASAP, I'll just put this in my tree along
with David series due to various cross-dependencies, ie, he removes
those old crufty powerpc-specific leXX_to/from_cpu we had).


media/bt8xx: Remove old powerpc cruft

The powerpc arch code enables PCI_COMMAND_MEMORY (and has done so for
more than 10 years at least !) on pci_enable_device() and the hackery
on the MMIO accessor is useless as well, our writel does everything
this driver should need.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/media/pci/bt8xx/bt878.c | 12 ------------
 drivers/media/pci/bt8xx/bt878.h | 11 -----------
 2 files changed, 23 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bt878.c b/drivers/media/pci/bt8xx/bt878.c
index 0939d39..8aa7266 100644
--- a/drivers/media/pci/bt8xx/bt878.c
+++ b/drivers/media/pci/bt8xx/bt878.c
@@ -416,9 +416,6 @@ static int bt878_probe(struct pci_dev *dev, const struct pci_device_id *pci_id)
 	int result = 0;
 	unsigned char lat;
 	struct bt878 *bt;
-#if defined(__powerpc__)
-	unsigned int cmd;
-#endif
 	unsigned int cardid;
 
 	printk(KERN_INFO "bt878: Bt878 AUDIO function found (%d).\n",
@@ -461,15 +458,6 @@ static int bt878_probe(struct pci_dev *dev, const struct pci_device_id *pci_id)
 	printk("irq: %d, latency: %d, memory: 0x%lx\n",
 	       bt->irq, lat, bt->bt878_adr);
 
-
-#if defined(__powerpc__)
-	/* on OpenFirmware machines (PowerMac at least), PCI memory cycle */
-	/* response on cards with no firmware is not enabled by OF */
-	pci_read_config_dword(dev, PCI_COMMAND, &cmd);
-	cmd = (cmd | PCI_COMMAND_MEMORY);
-	pci_write_config_dword(dev, PCI_COMMAND, cmd);
-#endif
-
 #ifdef __sparc__
 	bt->bt878_mem = (unsigned char *) bt->bt878_adr;
 #else
diff --git a/drivers/media/pci/bt8xx/bt878.h b/drivers/media/pci/bt8xx/bt878.h
index d19b592..49af240 100644
--- a/drivers/media/pci/bt8xx/bt878.h
+++ b/drivers/media/pci/bt8xx/bt878.h
@@ -142,18 +142,7 @@ void bt878_start(struct bt878 *bt, u32 controlreg, u32 op_sync_orin,
 		u32 irq_err_ignore);
 void bt878_stop(struct bt878 *bt);
 
-#if defined(__powerpc__)	/* big-endian */
-static inline void io_st_le32(volatile unsigned __iomem *addr, unsigned val)
-{
-	st_le32(addr, val);
-	eieio();
-}
-
-#define bmtwrite(dat,adr)  io_st_le32((adr),(dat))
-#define bmtread(adr)       ld_le32((adr))
-#else
 #define bmtwrite(dat,adr)  writel((dat), (adr))
 #define bmtread(adr)       readl(adr)
-#endif
 
 #endif
