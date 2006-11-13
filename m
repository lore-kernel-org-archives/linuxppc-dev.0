Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 880BC67F34
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 05:06:41 +1100 (EST)
To: mporter@kernel.crashing.org
Subject: [PATCH] [POWERPC] Make ppc440spe_init_pcie() static
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Nov 2006 09:57:02 -0800
Message-ID: <adahcx344cx.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc440spe_init_pcie() is only called from the file where it's defined
(except for dead code, which we remove in this patch).

Signed-off-by: Roland Dreier <rolandd@cisco.com>
---
Just a minor cleanup since I was looking at the code anyway.  Please
queue for 2.6.20 too.

 arch/ppc/platforms/4xx/yucca.c   |    5 -----
 arch/ppc/syslib/ppc440spe_pcie.c |    2 +-
 arch/ppc/syslib/ppc440spe_pcie.h |    1 -
 3 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
index 346787d..6c60d53 100644
--- a/arch/ppc/platforms/4xx/yucca.c
+++ b/arch/ppc/platforms/4xx/yucca.c
@@ -239,11 +239,6 @@ yucca_setup_hoses(void)
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
index 7ae14d2..fb0ddf1 100644
--- a/arch/ppc/syslib/ppc440spe_pcie.c
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
@@ -159,7 +159,7 @@ static void check_error(void)
 /*
  * Initialize PCI Express core as described in User Manual section 27.12.1
  */
-int ppc440spe_init_pcie(void)
+static int ppc440spe_init_pcie(void)
 {
 	int i;
 
diff --git a/arch/ppc/syslib/ppc440spe_pcie.h b/arch/ppc/syslib/ppc440spe_pcie.h
index 55b765a..23fe164 100644
--- a/arch/ppc/syslib/ppc440spe_pcie.h
+++ b/arch/ppc/syslib/ppc440spe_pcie.h
@@ -142,7 +142,6 @@ #define PECFG_PIM0LAH		0x344
 #define PECFG_POM0LAL		0x380
 #define PECFG_POM0LAH		0x384
 
-int ppc440spe_init_pcie(void);
 int ppc440spe_init_pcie_rootport(int port);
 void ppc440spe_setup_pcie(struct pci_controller *hose, int port);
 
-- 
1.4.3.2
