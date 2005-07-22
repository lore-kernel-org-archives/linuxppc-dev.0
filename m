Return-Path: <Thomas.Downing@ipc.com>
Received: from stsnycon1.corp.root.ipc.com (ipcny.ipc.com [65.244.37.61])
	by ozlabs.org (Postfix) with ESMTP id 7214E67D1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jul 2005 23:59:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 22 Jul 2005 09:46:03 -0400
Message-ID: <1D6EDDB3E43F3B40BC089CCFEE99DB7D14D056@exnanycmbx1.corp.root.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] 2.6.12.3 Compilation error when CONFIG_PQ2FADS=y
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Compilation fails for arch/ppc/syslib/m82xx_pci.c in version
2.6.12.3 when CONFIG_PQ2FADS=3Dy.  The following patch fixes the
problems, which are just typographical.

The patch has been tested on PQ2FADS-ZU and -VR boards on 8280
and 8275 devices.

--- linux-2.6.12.3/arch/ppc/syslib/m82xx_pci.c	2005-07-15 =
17:18:57.000000000 -0400
+++ linux-musrum/arch/ppc/syslib/m82xx_pci.c	2005-07-20 =
08:42:41.000000000 -0400
@@ -238,9 +238,9 @@ pq2ads_setup_pci(struct pci_controller *
 	 * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]),
 	 * and local bus for PCI (SIUMCR [LBPC]).
 	 */
-	immap->im_siu_conf.siu_82xx.sc_siumcr =3D =
(immap->im_siu_conf.sc_siumcr &
-				~(SIUMCR_L2PC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11 | SIUMCR_APPC11) =
|
-				SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 | SIUMCR_APPC10;
+	immap->im_siu_conf.siu_82xx.sc_siumcr =3D =
(immap->im_siu_conf.siu_82xx.sc_siumcr &
+				~(SIUMCR_L2CPC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11 | SIUMCR_APPC11) =
|
+				SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 | SIUMCR_APPC10);
 #endif
 	/* Enable PCI  */
 	immap->im_pci.pci_gcr =3D cpu_to_le32(PCIGCR_PCI_BUS_EN);

Thomas Downing
IPC Information Systems, LLC
