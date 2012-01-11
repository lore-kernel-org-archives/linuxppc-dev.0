Return-Path: <B29237@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2FCB7B6EF2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 18:51:58 +1100 (EST)
From: Shi Xuelin-B29237 <B29237@freescale.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [PATCH] 	dmaengine: async_xor, fix zero address issue when xor
 highmem page
Date: Wed, 11 Jan 2012 07:51:41 +0000
Message-ID: <DBB740589CE8814680DECFE34BE197AB166593@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1324967446-28939-1-git-send-email-b29237@freescale.com>
In-Reply-To: <1324967446-28939-1-git-send-email-b29237@freescale.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Dan Williams,

Do you have any comment about this patch?

Thanks,
Forrest

-----Original Message-----
From: Shi Xuelin-B29237=20
Sent: 2011=1B$BG/=1B(B12=1B$B7n=1B(B27=1B$BF|=1B(B 14:31
To: vinod.koul@intel.com; dan.j.williams@intel.com; linuxppc-dev@lists.ozla=
bs.org; linux-kernel@vger.kernel.org; Li Yang-R58472
Cc: Shi Xuelin-B29237
Subject: [PATCH] dmaengine: async_xor, fix zero address issue when xor high=
mem page

From: Forrest shi <b29237@freescale.com>

	we may do_sync_xor high mem pages, in this case, page_address will
        return zero address which cause a failure.

	this patch uses kmap_atomic before xor the pages and kunmap_atomic
        after it.

	Signed-off-by: b29237@freescale.com <xuelin.shi@freescale.com>
---
 crypto/async_tx/async_xor.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c inde=
x bc28337..5b416d1 100644
--- a/crypto/async_tx/async_xor.c
+++ b/crypto/async_tx/async_xor.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/dma-mapping.h>
 #include <linux/raid/xor.h>
 #include <linux/async_tx.h>
@@ -126,7 +127,7 @@ do_sync_xor(struct page *dest, struct page **src_list, =
unsigned int offset,
 	    int src_cnt, size_t len, struct async_submit_ctl *submit)  {
 	int i;
-	int xor_src_cnt =3D 0;
+	int xor_src_cnt =3D 0, kmap_cnt=3D0;
 	int src_off =3D 0;
 	void *dest_buf;
 	void **srcs;
@@ -138,11 +139,13 @@ do_sync_xor(struct page *dest, struct page **src_list=
, unsigned int offset,
=20
 	/* convert to buffer pointers */
 	for (i =3D 0; i < src_cnt; i++)
-		if (src_list[i])
-			srcs[xor_src_cnt++] =3D page_address(src_list[i]) + offset;
+		if (src_list[i]) {
+			srcs[xor_src_cnt++] =3D kmap_atomic(src_list[i], KM_USER1) + offset;
+		}
+	kmap_cnt =3D xor_src_cnt;
 	src_cnt =3D xor_src_cnt;
 	/* set destination address */
-	dest_buf =3D page_address(dest) + offset;
+	dest_buf =3D kmap_atomic(dest, KM_USER0) + offset;
=20
 	if (submit->flags & ASYNC_TX_XOR_ZERO_DST)
 		memset(dest_buf, 0, len);
@@ -157,6 +160,11 @@ do_sync_xor(struct page *dest, struct page **src_list,=
 unsigned int offset,
 		src_off +=3D xor_src_cnt;
 	}
=20
+	kunmap_atomic(dest_buf, KM_USER0);
+	for (i =3D 0; i < kmap_cnt; i++)=20
+		if (src_list[i])
+			kunmap_atomic(srcs[i], KM_USER1);
+
 	async_tx_sync_epilog(submit);
 }
=20
--
1.7.0.4
