Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A12C61A072E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 03:17:09 +1000 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <alex.williamson@redhat.com>
Subject: [PATCH 1/3] iommu/fsl: Fix PAMU window size check. 
Date: Tue, 24 Jun 2014 19:27:15 +0530
Message-ID: <1403618237-26248-2-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

is_power_of_2 requires an unsigned long parameter which would
lead to truncation of 64 bit values on 32 bit architectures.

__ffs also expects an unsigned long parameter thus won't work
for 64 bit values on 32 bit architectures.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 drivers/iommu/fsl_pamu.c        |    8 ++++----
 drivers/iommu/fsl_pamu_domain.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index b99dd88..bb446d7 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -170,10 +170,10 @@ int pamu_disable_liodn(int liodn)
 static unsigned int map_addrspace_size_to_wse(phys_addr_t addrspace_size)
 {
 	/* Bug if not a power of 2 */
-	BUG_ON(!is_power_of_2(addrspace_size));
+	BUG_ON((addrspace_size & (addrspace_size - 1)));
 
 	/* window size is 2^(WSE+1) bytes */
-	return __ffs(addrspace_size) - 1;
+	return fls64(addrspace_size) - 2;
 }
 
 /* Derive the PAACE window count encoding for the subwindow count */
@@ -351,7 +351,7 @@ int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
 	struct paace *ppaace;
 	unsigned long fspi;
 
-	if (!is_power_of_2(win_size) || win_size < PAMU_PAGE_SIZE) {
+	if ((win_size & (win_size - 1)) || win_size < PAMU_PAGE_SIZE) {
 		pr_debug("window size too small or not a power of two %llx\n", win_size);
 		return -EINVAL;
 	}
@@ -464,7 +464,7 @@ int pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin,
 		return -ENOENT;
 	}
 
-	if (!is_power_of_2(subwin_size) || subwin_size < PAMU_PAGE_SIZE) {
+	if ((subwin_size & (subwin_size - 1)) || subwin_size < PAMU_PAGE_SIZE) {
 		pr_debug("subwindow size out of range, or not a power of 2\n");
 		return -EINVAL;
 	}
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 93072ba..3dd0b8e 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -301,7 +301,7 @@ static int check_size(u64 size, dma_addr_t iova)
 	 * Size must be a power of two and at least be equal
 	 * to PAMU page size.
 	 */
-	if (!is_power_of_2(size) || size < PAMU_PAGE_SIZE) {
+	if ((size & (size - 1)) || size < PAMU_PAGE_SIZE) {
 		pr_debug("%s: size too small or not a power of two\n", __func__);
 		return -EINVAL;
 	}
-- 
1.7.9.5
