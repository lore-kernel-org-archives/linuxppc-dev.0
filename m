Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4AE152C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 19:59:08 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 25 Dec 2013 03:59:04 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4D41FC90045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 03:59:01 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBP8x3Vn6029670
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 08:59:03 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBP8x2hL032150
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 03:59:03 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/eeh: Eliminate AER gap
Date: Wed, 25 Dec 2013 16:58:56 +0800
Message-Id: <1387961936-20451-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch intends to implement the backend of eeh_ops::restore_bars
so that we can eliminate the gap of AER and PCI error reporting
between pHyp and sapphire that is introduced by reset on one specific
PE or the whole PHB. It's notable that the PHB3 and P7IOC is sharing
the same code to eliminate the gap. The details on PHB3 is shown as
follows:

 Offset - <pHyp> <original sapphire value> <current> <after reset>

 PHB3 - Root Complex (pcie_cap: 48 aer_cap: 100)
=C2=A0004 - 00100147 00100147 00100147 00100147
=C2=A003C - 00020000 00020000 00020000 00020000
=C2=A0050 - 0000004F 0000000F 0000000F 0001000F
       (Different maximal payload size)
=C2=A0108 - 0008D000 0008D000 0008D000 0008D000
=C2=A010C - 00072030 00072030 00072030 00072030
=C2=A0114 - 00002000 00000000 00002000 00002000
=C2=A0118 - 000001E0 000001E0 000001E0 000001E0
=C2=A012C - 00000007 00000007 00000007 00000007

 Switch upstream port (pcie_cap: 68 aer_cap: fb4)
=C2=A0004 - 00100547 00100007 00100547 00100547
=C2=A003C - 00020100 00000100 00020100 00020100
=C2=A0070 - 00000857 00000810 00090817 00000817
       (Different maximal payload size)
=C2=A0fbc - 00000000 00400000 00000000 00000000
=C2=A0fc0 - 00462030 00462030 00462030 00462030
=C2=A0fc8 - 00002000 0000f1c1 00002000 00002000
=C2=A0fcc - 000000E0 000000A0 000000ff 000000ff
       (same RWS bit#6/8)

 Switch downstream port (pcie_cap: 68 aer_cap: fb4)
=C2=A0004 - 00100547 00100007 00100547 00100547
=C2=A003C - 00020100 00000100 00020100 00020100
=C2=A0070 - 00000857 00000810 00008017 00008017
       (Different maximal payload size)
=C2=A0fbc - 00000000 00400000 00000000 00000000
=C2=A0fc0 - 00402000 00462030 00402000 00402000
=C2=A0fc8 - 00002000 0000f1c1 00002000 00002000
=C2=A0fcc - 000000e0 000000A0 000000ff 000000ff
       (same RWS bit#6/8)

 Endpoint (PCI_COMMAND, pcie_cap+0x8)
 004 - 00100146 00100406 00100546 00100146
       (Same error reporting)
 068 - 0000585e 00002810 0010240e 0010240e
       (Same error reporting)

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c |  145 ++++++++++++++++++++=
+++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/=
platforms/powernv/eeh-powernv.c
index df54b76..1d4e958 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -347,6 +347,148 @@ static int powernv_eeh_next_error(struct eeh_pe **p=
e)
 	return -EEXIST;
 }
=20
+static void powernv_eeh_restore_root_port(struct device_node *dn,
+					  int ecap, int aercap)
+{
+	u32 val;
+
+	/* Enable SERR and parity checking */
+	pnv_pci_cfg_read(dn, PCI_COMMAND, 2, &val);
+	val |=3D (PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
+	pnv_pci_cfg_write(dn, PCI_COMMAND, 2, val);
+
+	/* Enable reporting various errors */
+	pnv_pci_cfg_read(dn, ecap + PCI_EXP_DEVCTL, 2, &val);
+	val |=3D (PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
+		PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
+	pnv_pci_cfg_write(dn, ecap + PCI_EXP_DEVCTL, 2, val);
+
+	/* Mask various unrecoverable errors */
+	if (!aercap) return;
+	pnv_pci_cfg_read(dn, aercap + 0x8, 4, &val);
+	val |=3D 0x0008d000;
+	pnv_pci_cfg_write(dn, aercap + 0x8, 4, val);
+
+	/* Report various unrecoverable errors as fatal errors */
+	pnv_pci_cfg_write(dn, aercap + 0xc, 4, 0x00072030);
+
+	/* Mask various recoverable errors */
+	pnv_pci_cfg_read(dn, aercap + 0x14, 4, &val);
+	val |=3D 0x00002000;
+	pnv_pci_cfg_write(dn, aercap + 0x14, 4, val);
+
+	/* Enable ECRC check */
+	pnv_pci_cfg_read(dn, aercap + 0x18, 4, &val);
+	val |=3D 0x00000140;
+	pnv_pci_cfg_write(dn, aercap + 0x18, 4, val);
+
+	/* Enable all error reporting */
+	pnv_pci_cfg_read(dn, aercap + 0x2c, 4, &val);
+	val |=3D 0x00000007;
+	pnv_pci_cfg_write(dn, aercap + 0x2c, 4, val);
+}
+
+static void powernv_eeh_restore_sw_port(struct device_node *dn,
+					int ecap, int aercap)
+{
+	struct eeh_dev *edev =3D of_node_to_eeh_dev(dn);
+	struct pnv_phb *phb =3D edev->phb->private_data;
+	u32 val;
+
+	/* Enable SERR and parity checking and disable INTx */
+	pnv_pci_cfg_read(dn, PCI_COMMAND, 2, &val);
+	val |=3D (PCI_COMMAND_INTX_DISABLE |
+		PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
+	pnv_pci_cfg_write(dn, PCI_COMMAND, 2, val);
+
+	/* Disable partity error and enable system error */
+	pnv_pci_cfg_read(dn, PCI_BRIDGE_CONTROL, 2, &val);
+	val &=3D ~PCI_BRIDGE_CTL_PARITY;
+	val |=3D PCI_BRIDGE_CTL_SERR;
+	pnv_pci_cfg_write(dn, PCI_BRIDGE_CONTROL, 2, val);
+
+	/* Enable reporting various errors */
+	pnv_pci_cfg_read(dn, ecap + PCI_EXP_DEVCTL, 2, &val);
+	val |=3D (PCI_EXP_DEVCTL_FERE |
+		PCI_EXP_DEVCTL_NFERE |
+		PCI_EXP_DEVCTL_CERE);
+	pnv_pci_cfg_write(dn, ecap + PCI_EXP_DEVCTL, 2, val);
+
+	/* Unmask all unrecoverable errors */
+	if (!aercap) return;
+	pnv_pci_cfg_write(dn, aercap + 0x8, 4, 0x0);
+
+	/* Severity of unrecoverable errors */
+	if (edev->mode & EEH_DEV_US_PORT)
+		val =3D 0x00462030;
+	else
+		val =3D 0x00402000;
+	pnv_pci_cfg_write(dn, aercap + 0xc, 4, val);
+
+	/* Mask various correctable errors */
+	if (phb->model =3D=3D PNV_PHB_MODEL_PHB3 &&
+	    phb->rev < 0xa30003)
+		val =3D 0xffffffff;
+	else
+		val =3D 0x2000;
+	pnv_pci_cfg_write(dn, aercap + 0x14, 4, val);
+
+	/* Enable ECRC generation and disable ECRC check */
+	pnv_pci_cfg_read(dn, aercap + 0x18, 4, &val);
+	val &=3D ~0x00000100;
+	val |=3D 0x00000040;
+	pnv_pci_cfg_write(dn, aercap + 0x18, 4, val);
+}
+
+static void powernv_eeh_restore_endpoint(struct device_node *dn,
+					 int ecap, int aercap)
+{
+	struct eeh_dev *edev =3D of_node_to_eeh_dev(dn);
+	struct pnv_phb *phb =3D edev->phb->private_data;
+	u32 val;
+
+	/* Enable SERR and parity checking */
+	pnv_pci_cfg_read(dn, PCI_COMMAND, 2, &val);
+	val |=3D (PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
+	pnv_pci_cfg_write(dn, PCI_COMMAND, 2, val);
+
+	/* Enable reporting various errors */
+	if (!ecap) return;
+	pnv_pci_cfg_read(dn, ecap + PCI_EXP_DEVCTL, 2, &val);
+	val &=3D ~PCI_EXP_DEVCTL_CERE;
+	val |=3D (PCI_EXP_DEVCTL_URRE |
+		PCI_EXP_DEVCTL_FERE |
+		PCI_EXP_DEVCTL_NFERE);
+	pnv_pci_cfg_write(dn, ecap + PCI_EXP_DEVCTL, 2, val);
+
+	if (!aercap) return;
+	if (phb->model =3D=3D PNV_PHB_MODEL_PHB3 &&
+	    phb->rev < 0xa30003)
+		pnv_pci_cfg_write(dn, aercap + 0x14, 4, 0xffffffff);
+
+	/* Enable ECRC generation and check */
+	pnv_pci_cfg_read(dn, aercap + 0x18, 4, &val);
+	val |=3D 0x00000140;
+	pnv_pci_cfg_write(dn, aercap + 0x18, 4, val);
+}
+
+static void powernv_eeh_restore_bars(struct device_node *dn)
+{
+	struct eeh_dev *edev =3D of_node_to_eeh_dev(dn);
+
+	if (!edev) return;
+	if (edev->mode & EEH_DEV_ROOT_PORT)
+		powernv_eeh_restore_root_port(dn,
+			edev->pcie_cap, edev->aer_cap);
+	else if ((edev->mode & EEH_DEV_US_PORT) ||
+		 (edev->mode & EEH_DEV_DS_PORT))
+		powernv_eeh_restore_sw_port(dn,
+			edev->pcie_cap, edev->aer_cap);
+	else
+		powernv_eeh_restore_endpoint(dn,
+			edev->pcie_cap, edev->aer_cap);
+}
+
 static struct eeh_ops powernv_eeh_ops =3D {
 	.name                   =3D "powernv",
 	.init                   =3D powernv_eeh_init,
@@ -362,7 +504,8 @@ static struct eeh_ops powernv_eeh_ops =3D {
 	.configure_bridge       =3D powernv_eeh_configure_bridge,
 	.read_config            =3D pnv_pci_cfg_read,
 	.write_config           =3D pnv_pci_cfg_write,
-	.next_error		=3D powernv_eeh_next_error
+	.next_error		=3D powernv_eeh_next_error,
+	.restore_bars		=3D powernv_eeh_restore_bars
 };
=20
 /**
--=20
1.7.10.4
