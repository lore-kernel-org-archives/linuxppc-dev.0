Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
	by ozlabs.org (Postfix) with ESMTP id 99454DDFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 18:44:18 +1000 (EST)
From: Ian Campbell <ian.campbell@citrix.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/9] swiotlb: support HIGHMEM in swiotlb_bus_to_virt
Date: Fri, 29 May 2009 09:44:02 +0100
Message-ID: <1243586643-5554-9-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1243586643-5554-1-git-send-email-ian.campbell@citrix.com>
References: <1243586643-5554-1-git-send-email-ian.campbell@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Fitzhardinge <jeremy@goop.org>, Jeremy,
	Ian Campbell <ian.campbell@citrix.com>,
	Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, FUJITA
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rather than supplying a __weak hook which architectures which support
highmem can overide simply provide a version of swiotlb_bus_to_virt
which works with high memory. Make it conditional since it is a more
expensive variant than the non-highmem version.

Acutal function contents taken from the PowerPC swiotlb patchset by
Becky Bruce.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Becky Bruce <beckyb@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linuxppc-dev@ozlabs.org
---
 lib/swiotlb.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index e332342..c50a5ed 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -130,10 +130,22 @@ static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
 	return phys_to_dma(hwdev, virt_to_phys(address));
 }
 
-void * __weak swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
+#ifdef CONFIG_HIGHMEM
+static void * swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
+{
+	unsigned long pfn = PFN_DOWN(dma_to_phys(hwdev, addr));
+	void *pageaddr = page_address(pfn_to_page(pfn));
+
+	if (pageaddr != NULL)
+		return pageaddr + (addr % PAGE_SIZE);
+	return NULL;
+}
+#else
+static void * swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
 {
 	return phys_to_virt(dma_to_phys(hwdev, address));
 }
+#endif
 
 static void swiotlb_print_info(unsigned long bytes)
 {
-- 
1.5.6.5
