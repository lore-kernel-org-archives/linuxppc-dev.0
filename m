Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 60B972C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 17:43:06 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Gavin Shan
 <shangw@linux.vnet.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, "James
 E.J. Bottomley" <JBottomley@parallels.com>, "David S. Miller"
 <davem@davemloft.net>
Subject: [PATCH 3/7] powerpc/pci: use pci_is_pcie() to simplify code
Date: Tue, 3 Sep 2013 15:35:11 +0800
Message-ID: <1378193715-25328-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1378193715-25328-1-git-send-email-wangyijing@huawei.com>
References: <1378193715-25328-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Hanjun Guo <guohanjun@huawei.com>,
 Yijing Wang <wangyijing@huawei.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use pci_is_pcie() to simplify code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/kernel/eeh.c     |    3 +--
 arch/powerpc/sysdev/fsl_pci.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 39954fe..b0bd41a 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -189,8 +189,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 	}
 
 	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
-	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
-	if (cap) {
+	if (pci_is_pcie(dev)) {
 		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
 		printk(KERN_WARNING
 		       "EEH: PCI-E capabilities and status follow:\n");
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 46ac1dd..5402a1d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -41,7 +41,7 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
 	u8 hdr_type;
 
 	/* if we aren't a PCIe don't bother */
-	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
+	if (!pci_is_pcie(dev))
 		return;
 
 	/* if we aren't in host mode don't bother */
-- 
1.7.1
