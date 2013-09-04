Return-Path: <qiuxishi@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BE3D2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2013 20:50:27 +1000 (EST)
Message-ID: <52270E64.20401@huawei.com>
Date: Wed, 4 Sep 2013 18:41:40 +0800
From: Xishi Qiu <qiuxishi@huawei.com>
MIME-Version: 1.0
To: <plagnioj@jcrosoft.com>, <tomi.valkeinen@ti.com>, <james.hogan@imgtec.com>,
 <monstr@monstr.eu>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] mm/driver: use __free_reserved_page() to simplify the code
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-fbdev@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Xishi Qiu <qiuxishi@huawei.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use __free_reserved_page() to simplify the code in the others.

Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
---
 drivers/video/acornfb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index 6488a73..4ef302a 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -1205,9 +1205,7 @@ free_unused_pages(unsigned int virtual_start, unsigned int virtual_end)
 		 * the page.
 		 */
 		page = virt_to_page(virtual_start);
-		ClearPageReserved(page);
-		init_page_count(page);
-		free_page(virtual_start);
+		__free_reserved_page(page);
 
 		virtual_start += PAGE_SIZE;
 		mb_freed += PAGE_SIZE / 1024;
-- 
1.7.1
