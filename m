Return-Path: <ben.c@servergy.com>
Received: from exprod6og115.obsmtp.com (exprod6og115.obsmtp.com [64.18.1.35])
 by ozlabs.org (Postfix) with SMTP id D31E1B6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 13:57:48 +1000 (EST)
Received: by dakp5 with SMTP id p5so7591122dak.28
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2012 20:57:46 -0700 (PDT)
From: Ben Collins <ben.c@servergy.com>
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
Date: Tue, 5 Jun 2012 23:50:40 -0400
Message-Id: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
To: linuxppc-dev@lists.ozlabs.org
Mime-Version: 1.0 (Apple Message framework v1278)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit introducing pcibios_io_space_offset() was ignoring 32-bit to
64-bit sign extention, which is the case on ppc32 with 64-bit resource
addresses. This only seems to have shown up while running under QEMU for
e500mc target. It may or may be suboptimal that QEMU has an IO base
address > 32-bits for the e500-pci implementation, but 1) it's still a
regression and 2) it's more correct to handle things this way.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-common.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c =
b/arch/powerpc/kernel/pci-common.c
index 8e78e93..be9ced7 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1477,9 +1477,15 @@ int pcibios_enable_device(struct pci_dev *dev, =
int mask)
 	return pci_enable_resources(dev, mask);
 }
=20
+/* Before assuming too much here, take care to realize that we need =
sign
+ * extension from 32-bit pointers to 64-bit resource addresses to work.
+ */
 resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
 {
-	return (unsigned long) hose->io_base_virt - _IO_BASE;
+	long vbase =3D (long)hose->io_base_virt;
+	long io_base =3D _IO_BASE;
+
+	return (resource_size_t)(vbase - io_base);
 }
=20
 static void __devinit pcibios_setup_phb_resources(struct pci_controller =
*hose, struct list_head *resources)
--=20
1.7.9.5

--
Ben Collins
Servergy, Inc.
(757) 243-7557

CONFIDENTIALITY NOTICE: This communication contains privileged and/or =
confidential information; and should be maintained with the strictest =
confidence. It is intended solely for the use of the person or entity in =
which it is addressed. If you are not the intended recipient, you are =
STRICTLY PROHIBITED from disclosing, copying, distributing or using any =
of this information. If you received this communication in error, please =
contact the sender immediately and destroy the material in its entirety, =
whether electronic or hard copy.
