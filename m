Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423CBT2WYgzF39r
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Sep 2018 22:31:10 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
 Julian Margetson <runaway@candw.ms>, Scott Wood <oss@buserror.net>
Date: Sun, 02 Sep 2018 12:30:34 +0100 (BST)
Message-ID: <4c7f98c86ad.343ea8c1@auth.smtp.1and1.co.uk>
Subject: [PATCH RFC] powerpc/kernel: Don't check for dev->dma_mask in
 fsl_set_dma_mask
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6cc13ac07145c3fc.a7"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6cc13ac07145c3fc.a7
Content-Type: text/plain

To enable use of dma to all ram on a corenet generic system, we add the
function fsl_pci_dma_set_mask, and link it into the ppc.md structure.

But this function checks for the presence of dev->dma_mask and dma_ops
at entry, and fails if one or other are missing. Powerpc's dma_set_mask 
(which it is called from) doesn't check this until after it has set the 
dma_mask for pci devs, this difference shows up on a Cyrus (AmigaOne X5000)
- a soundblaster live pci card, will works properly if memory is limited 
to <4G, but fail on probe with the following message if the memory is >=4G

[    4.646531] snd_emu10k1 1000:04:04.0: architecture does not support PCI 
busmaster DMA with mask 0x7fffffff

Remove the dev->mask tests to make the routines behave similarly. 

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

This fix looks wrong to me, although it works. The test needs to be removed,
moving it to the end of the function doesn't work either. This needs someone
with more knowledge of what's going on to take a look.

----=_BOUNDARY.6cc13ac07145c3fc.a7
Content-Type: text/plain;
	name="dma.patch"
Content-Disposition: attachment;
	filename="dma.patch";
	size=551

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 918be81..36b3c86 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -127,9 +127,6 @@ static inline void setup_swiotlb_ops(struct pci_controller *hose) {}
 
 static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
 	/*
 	 * Fix up PCI devices that are able to DMA to the large inbound
 	 * mapping that allows addressing any RAM address from across PCI.

----=_BOUNDARY.6cc13ac07145c3fc.a7--
