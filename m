Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9C20C6884B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 23:48:48 +1100 (EST)
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: rolandd@cisco.com
Content-Type: multipart/mixed; boundary="=-iplLpjgzYAjfEvuZRUBY"
Date: Tue, 06 Dec 2005 15:48:42 +0300
Message-Id: <1133873322.16347.39.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/5] ppc32: Removes dead code from original Yucca PCIE
	initialization sequence
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-iplLpjgzYAjfEvuZRUBY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch removes dead code from PCIE initialization sequence

Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>


--=-iplLpjgzYAjfEvuZRUBY
Content-Disposition: attachment; filename=yucca_pcie_rdead_code.patch
Content-Type: text/x-patch; name=yucca_pcie_rdead_code.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch removes dead code from Yucca PCIE initialization sequence

---
commit 27304e1086e96f8110626096a75cf4783a5512bb
tree 5d002bc97c0edcc2646ebd941a9f2b321a4777fc
parent e4f5c82a92c2a546a16af1614114eec19120e40a
author Ruslan V. Sushko <rsushko@ru.mvista.com> Tue, 06 Dec 2005 12:33:57 +0300
committer Ruslan V. Sushko <rsushko@ru.mvista.com> Tue, 06 Dec 2005 12:33:57 +0300

 arch/ppc/platforms/4xx/yucca.c   |    5 -----
 arch/ppc/syslib/ppc440spe_pcie.c |   16 ----------------
 2 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
--- a/arch/ppc/platforms/4xx/yucca.c
+++ b/arch/ppc/platforms/4xx/yucca.c
@@ -242,11 +242,6 @@ yucca_setup_hoses(void)
 	char name[20];
 	int i;
 
-	if (0 && ppc440spe_init_pcie()) {
-		printk(KERN_WARNING "PPC440SPe PCI Express initialization failed\n");
-		return;
-	}
-
 	for (i = 0; i <= 2; ++i) {
 		if (!yucca_pcie_card_present(i))
 			continue;
diff --git a/arch/ppc/syslib/ppc440spe_pcie.c b/arch/ppc/syslib/ppc440spe_pcie.c
--- a/arch/ppc/syslib/ppc440spe_pcie.c
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
@@ -47,8 +47,6 @@ pcie_read_config(struct pci_bus *bus, un
 		break;
 	}
 
-	if (0) printk("%s: read %x(%d) @ %x\n", __func__, *val, len, offset);
-
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -353,20 +351,6 @@ int ppc440spe_init_pcie_rootport(int por
 		break;
 	}
 
-#if 0
-	/* Dump all config regs */
-	for (i = 0x300; i <= 0x320; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x340; i <= 0x353; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x370; i <= 0x383; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x3a0; i <= 0x3a2; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x3c0; i <= 0x3c3; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-#endif
-
 	mdelay(100);
 
 	return 0;




--=-iplLpjgzYAjfEvuZRUBY--
