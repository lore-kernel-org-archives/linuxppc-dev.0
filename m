Return-Path: <sr@denx.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id 18A6F685F8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 01:59:10 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 28 Oct 2005 17:58:56 +0200
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509191320.09661.sr@denx.de> <200509301452.52074.sr@denx.de>
In-Reply-To: <200509301452.52074.sr@denx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ArkYDmfSRcoTTHa"
Message-Id: <200510281758.56646.sr@denx.de>
Subject: [PATCH] ppc32: Remove internal PCI arbiter check on PPC40x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_ArkYDmfSRcoTTHa
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On PPC405GP/GPR it should be possible to enable PCI support, even when
the internal PCI arbiter is disabled (e.g. when using an external PCI
arbiter). The removed code didn't allow this, and also generated a
warning on PPC405EP platforms.

Signed-off-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan

--Boundary-00=_ArkYDmfSRcoTTHa
Content-Type: text/x-diff; charset="iso-8859-6";
	name="ppc405-pci-arbiter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ppc405-pci-arbiter.patch"

[PATCH] ppc32: Remove internal PCI arbiter check on PPC40x

On PPC405GP/GPR it should be possible to enable PCI support, even when
the internal PCI arbiter is disabled (e.g. when using an external PCI
arbiter). The removed code didn't allow this, and also generated a
warning on PPC405EP platforms.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit 7f14813879d885d7f8d7ef589bbd3050c451b6a7
tree 8c14f370df43abe61e9ace8ff243fdb16e5a8c4d
parent 741b2252a5e14d6c60a913c77a6099abe73a854a
author Stefan Roese <sr@denx.de> Fri, 28 Oct 2005 15:43:00 +0200
committer Stefan Roese <sr@denx.de> Fri, 28 Oct 2005 15:43:00 +0200

 arch/ppc/syslib/ppc405_pci.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/ppc/syslib/ppc405_pci.c b/arch/ppc/syslib/ppc405_pci.c
--- a/arch/ppc/syslib/ppc405_pci.c
+++ b/arch/ppc/syslib/ppc405_pci.c
@@ -89,13 +89,6 @@ ppc4xx_find_bridges(void)
 	isa_mem_base = 0;
 	pci_dram_offset = 0;
 
-#if  (PSR_PCI_ARBIT_EN > 1)
-	/* Check if running in slave mode */
-	if ((mfdcr(DCRN_CHPSR) & PSR_PCI_ARBIT_EN) == 0) {
-		printk("Running as PCI slave, kernel PCI disabled !\n");
-		return;
-	}
-#endif
 	/* Setup PCI32 hose */
 	hose_a = pcibios_alloc_controller();
 	if (!hose_a)



!-------------------------------------------------------------flip-



--Boundary-00=_ArkYDmfSRcoTTHa--
