Return-Path: <SRS0=k936=N3=stefan-roese.de=ml@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 6D9BDDDE32
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 18:31:29 +1000 (EST)
From: Stefan Roese <ml@stefan-roese.de>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC] PCI Bug fix for MRM failure in PPC 440EPx
Date: Thu, 30 Aug 2007 10:33:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200708301033.28423.ml@stefan-roese.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Problem Description and Fix : Memory Read Multiples(MRM) do not work
correctly on PPC 440EPX based systems. A PCI driver determines whether
MRMs are supported by reading the PCI cache line size register. If this
value is zero then MRMs are not supported. However some PCI drivers
write to the PCI cache line size register on initialization. This
results in MRMs being sent to system memory on 440EPX based systems.
Since MRMs do not work correctly in 440EPX based systems this may cause
system hang. This patch solves this problem by modifying the PPC
platform specific PCI configuration register write function, by forcing
any value written to PCI_CACHE_LINE_SIZE register to be 0. This fix was
tested on different PCI cards : i.e. Silicon Image ATA card and Intel
E1000 GIGE card. On Silicon Image ATA card without this fix in place
creating a filesystem on IDE drive "mke2fs /dev/hda" was hanging the
system. MRMs issued by the PCI card were seen on the PCI analyzer since
the Silicon Image driver was setting the PCI_CACHE_LINE_SIZE register to
255. With this patch the PCI_CACHE_LINE_SIZE register was 0 and only
Memory Reads were seen on PCI analyzer.

Signed-off-by: Pravin M. Bathija <pbathija@amcc.com>
Signed-off-by: Stefan Roese <sr@denx.de>

---
I know this patch is a little "dirty", but perhaps somebody has a better
idea to fix this problem. Thanks.

commit bae603c964831f26d9816e85ffc923afc3275e44
tree 6fb93d22bcb56670a8e6f344afbe8a4a8438692c
parent b07d68b5ca4d55a16fab223d63d5fb36f89ff42f
author Stefan Roese <sr@denx.de> Thu, 30 Aug 2007 10:30:09 +0200
committer Stefan Roese <sr@denx.de> Thu, 30 Aug 2007 10:30:09 +0200

 arch/powerpc/sysdev/indirect_pci.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 5294560..d694acc 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -128,6 +128,13 @@ indirect_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	 * suitably aligned and that len is 1, 2 or 4.
 	 */
 	cfg_data = hose->cfg_data + (offset & 3);
+
+#if defined(CONFIG_440EPX) || defined(CONFIG_440GRX)
+	/* Workaround for MRM failure in 440EPx/GRx */
+	if (offset == PCI_CACHE_LINE_SIZE)
+		val = 0;
+#endif
+
 	switch (len) {
 	case 1:
 		out_8(cfg_data, val);
