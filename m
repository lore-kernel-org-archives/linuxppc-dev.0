Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F11651A0CE1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:09:10 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Fri, 15 Jan 2016 17:09:10 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 74D8B2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:09:08 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0F790jt9502960
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:09:08 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0F78ZIS024778
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:08:36 +1100
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 alex.williamson@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 4/5] powerpc/powernv/pci-ioda: Enable msi_filtered bit
 for any IODA host bridge
Date: Fri, 15 Jan 2016 15:06:13 +0800
Message-Id: <1452841574-2781-5-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables msi_filtered bit for any IODA host bridge.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 414fd1a..689f0dc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2934,6 +2934,11 @@ static void pnv_pci_ioda_fixup(void)
 #endif
 }
 
+static void pnv_pci_ioda_fixup_phb(struct pci_controller *hose)
+{
+	to_pci_host_bridge(hose->bus->bridge)->msi_filtered = 1;
+}
+
 /*
  * Returns the alignment for I/O or memory windows for P2P
  * bridges. That actually depends on how PEs are segmented.
@@ -3201,6 +3206,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * the child P2P bridges) can form individual PE.
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
+	ppc_md.pcibios_fixup_phb = pnv_pci_ioda_fixup_phb;
 	hose->controller_ops = pnv_pci_ioda_controller_ops;
 
 #ifdef CONFIG_PCI_IOV
-- 
1.7.9.5
