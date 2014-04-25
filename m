Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5BD0F141363
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 19:26:11 +1000 (EST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 04/13] x86/PCI: Use new pci_is_bridge() to simplify code
Date: Fri, 25 Apr 2014 17:18:26 +0800
Message-ID: <1398417515-8740-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
References: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now we can use new pci_is_bridge() helper function
to simplify code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/x86/pci/fixup.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 94ae9ae..e5f000c 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -337,9 +337,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
 		 * type BRIDGE, or CARDBUS. Host to PCI controllers use
 		 * PCI header type NORMAL.
 		 */
-		if (bridge
-		    && ((bridge->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-		       || (bridge->hdr_type == PCI_HEADER_TYPE_CARDBUS))) {
+		if (bridge && (pci_is_bridge(bridge))) {
 			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
 						&config);
 			if (!(config & PCI_BRIDGE_CTL_VGA))
-- 
1.7.1
