Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1E29D68862
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 23:50:29 +1100 (EST)
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: rollandd@cisco.com
Content-Type: multipart/mixed; boundary="=-smiwh96w3kA38NfpGYzp"
Date: Tue, 06 Dec 2005 15:50:25 +0300
Message-Id: <1133873425.16347.43.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 3/5] ppc32: Fix config space address calculation for Yucca
	PCIE initialization
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-smiwh96w3kA38NfpGYzp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Fix config space address calculation for Yucca PCIE initialization. The
problem was in signed integer using.  The size of each config space
segment is 0x40000000 so the offset of config space for third hose will
be calculated as negative number if number of hose signed integer.

Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>



--=-smiwh96w3kA38NfpGYzp
Content-Disposition: attachment; filename=yucca_pciecfg_fix.patch
Content-Type: text/x-patch; name=yucca_pciecfg_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


Fix config space address calculation for Yucca PCIE initialization. The problem
was in signed integer using.  The size of each config space segment is
0x40000000 so the offset of config space for 3d hose will be calculated as
negative number if number of hose signed integer.

---
commit 4776902accd7c0721532168f73dc7618675bda1e
tree 770f0d58f4a6598028fe2dfd16b5226c7bcd0c27
parent 18b959b9ab80f8cb2fa1eff0a68cca3b5aa2f642
author Ruslan V. Sushko <rsushko@ru.mvista.com> Tue, 06 Dec 2005 13:01:57 +0300
committer Ruslan V. Sushko <rsushko@ru.mvista.com> Tue, 06 Dec 2005 13:01:57 +0300

 arch/ppc/syslib/ppc440spe_pcie.c |    4 ++--
 arch/ppc/syslib/ppc440spe_pcie.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/syslib/ppc440spe_pcie.c b/arch/ppc/syslib/ppc440spe_pcie.c
--- a/arch/ppc/syslib/ppc440spe_pcie.c
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
@@ -181,7 +181,7 @@ int ppc440spe_init_pcie(void)
 	return 0;
 }
 
-int ppc440spe_init_pcie_rootport(int port)
+int ppc440spe_init_pcie_rootport(u32 port)
 {
 	static int core_init;
 	void __iomem *utl_base;
@@ -380,7 +380,7 @@ int ppc440spe_init_pcie_rootport(int por
 	return 0;
 }
 
-void ppc440spe_setup_pcie(struct pci_controller *hose, int port)
+void ppc440spe_setup_pcie(struct pci_controller *hose, u32 port)
 {
 	void __iomem *mbase;
 
diff --git a/arch/ppc/syslib/ppc440spe_pcie.h b/arch/ppc/syslib/ppc440spe_pcie.h
--- a/arch/ppc/syslib/ppc440spe_pcie.h
+++ b/arch/ppc/syslib/ppc440spe_pcie.h
@@ -143,7 +143,7 @@
 #define PECFG_POM0LAH		0x384
 
 int ppc440spe_init_pcie(void);
-int ppc440spe_init_pcie_rootport(int port);
-void ppc440spe_setup_pcie(struct pci_controller *hose, int port);
+int ppc440spe_init_pcie_rootport(u32 port);
+void ppc440spe_setup_pcie(struct pci_controller *hose, u32 port);
 
 #endif /* __PPC_SYSLIB_PPC440SPE_PCIE_H */




--=-smiwh96w3kA38NfpGYzp--
