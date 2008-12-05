Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1EA80474CC
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 05:15:40 +1100 (EST)
Date: Fri, 5 Dec 2008 21:15:39 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] of: Minor simplification for the
	of_parse_phandles_with_args()
Message-ID: <20081205181539.GA23666@oksana.dev.rtsoft.ru>
References: <20081205181503.GA9855@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081205181503.GA9855@oksana.dev.rtsoft.ru>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

By using 'list++' in the beginning we can simplify the code a
little bit.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/base.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 4f884a3..cf04d4d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -547,14 +547,12 @@ int of_parse_phandles_with_args(struct device_node *np, const char *list_name,
 		const u32 *cells;
 		const phandle *phandle;
 
-		phandle = list;
-		args = list + 1;
+		phandle = list++;
+		args = list;
 
 		/* one cell hole in the list = <>; */
-		if (!*phandle) {
-			list++;
+		if (!*phandle)
 			goto next;
-		}
 
 		node = of_find_node_by_phandle(*phandle);
 		if (!node) {
@@ -570,8 +568,7 @@ int of_parse_phandles_with_args(struct device_node *np, const char *list_name,
 			goto err1;
 		}
 
-		/* Next phandle is at offset of one phandle cell + #cells */
-		list += 1 + *cells;
+		list += *cells;
 		if (list > list_end) {
 			pr_debug("%s: insufficient arguments length\n",
 				 np->full_name);
-- 
1.5.6.5
