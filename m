Return-Path: <mhcerri@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 289CA2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 22:10:04 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mhcerri@linux.vnet.ibm.com>;
 Fri, 2 Aug 2013 09:09:58 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8EEAE1DC0066
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 08:09:55 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72C8Xkj22478908
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 09:08:33 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r72C9tSc010912
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 09:09:55 -0300
From: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 1/2] drivers/crypto/nx: fix physical addresses added to sg
 lists
Date: Fri,  2 Aug 2013 09:09:51 -0300
Message-Id: <1375445392-16237-2-git-send-email-mhcerri@linux.vnet.ibm.com>
In-Reply-To: <1375445392-16237-1-git-send-email-mhcerri@linux.vnet.ibm.com>
References: <1375445392-16237-1-git-send-email-mhcerri@linux.vnet.ibm.com>
Cc: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The co-processor receives data to be hashed through scatter/gather lists
pointing to physical addresses. When a vmalloc'ed data is given, the
driver must calculate the physical address to each page of the data.

However the current version of it just calculates the physical address
once and keeps incrementing it even when a page boundary is crossed.
This patch fixes this behaviour.

Reviewed-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
Reviewed-by: Joel Schopp <jschopp@linux.vnet.ibm.com>
Reviewed-by: Joy Latten <jmlatten@linux.vnet.ibm.com>
Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
---
 drivers/crypto/nx/nx.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/nx/nx.c b/drivers/crypto/nx/nx.c
index bbdab6e..ad07dc6 100644
--- a/drivers/crypto/nx/nx.c
+++ b/drivers/crypto/nx/nx.c
@@ -114,13 +114,29 @@ struct nx_sg *nx_build_sg_list(struct nx_sg *sg_head,
 	 * have been described (or @sgmax elements have been written), the
 	 * loop ends. min_t is used to ensure @end_addr falls on the same page
 	 * as sg_addr, if not, we need to create another nx_sg element for the
-	 * data on the next page */
+	 * data on the next page.
+	 *
+	 * Also when using vmalloc'ed data, every time that a system page
+	 * boundary is crossed the physical address needs to be re-calculated.
+	 */
 	for (sg = sg_head; sg_len < len; sg++) {
+		u64 next_page;
+
 		sg->addr = sg_addr;
-		sg_addr = min_t(u64, NX_PAGE_NUM(sg_addr + NX_PAGE_SIZE), end_addr);
-		sg->len = sg_addr - sg->addr;
+		sg_addr = min_t(u64, NX_PAGE_NUM(sg_addr + NX_PAGE_SIZE),
+				end_addr);
+
+		next_page = (sg->addr & PAGE_MASK) + PAGE_SIZE;
+		sg->len = min_t(u64, sg_addr, next_page) - sg->addr;
 		sg_len += sg->len;
 
+		if (sg_addr >= next_page &&
+				is_vmalloc_addr(start_addr + sg_len)) {
+			sg_addr = page_to_phys(vmalloc_to_page(
+						start_addr + sg_len));
+			end_addr = sg_addr + len - sg_len;
+		}
+
 		if ((sg - sg_head) == sgmax) {
 			pr_err("nx: scatter/gather list overflow, pid: %d\n",
 			       current->pid);
-- 
1.7.12
