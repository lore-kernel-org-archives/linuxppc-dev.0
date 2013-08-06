Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 12/63] powerpc: Make RTAS device tree accesses endian safe
Date: Wed,  7 Aug 2013 02:01:29 +1000
Message-Id: <1375804940-22050-13-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/rtas.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 80b5ef4..98b26af 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -204,7 +204,7 @@ void rtas_progress(char *s, unsigned short hex)
 {
 	struct device_node *root;
 	int width;
-	const int *p;
+	const __be32 *p;
 	char *os;
 	static int display_character, set_indicator;
 	static int display_width, display_lines, form_feed;
@@ -221,13 +221,13 @@ void rtas_progress(char *s, unsigned short hex)
 		if ((root = of_find_node_by_path("/rtas"))) {
 			if ((p = of_get_property(root,
 					"ibm,display-line-length", NULL)))
-				display_width = *p;
+				display_width = be32_to_cpu(*p);
 			if ((p = of_get_property(root,
 					"ibm,form-feed", NULL)))
-				form_feed = *p;
+				form_feed = be32_to_cpu(*p);
 			if ((p = of_get_property(root,
 					"ibm,display-number-of-lines", NULL)))
-				display_lines = *p;
+				display_lines = be32_to_cpu(*p);
 			row_width = of_get_property(root,
 					"ibm,display-truncation-length", NULL);
 			of_node_put(root);
@@ -322,11 +322,11 @@ EXPORT_SYMBOL(rtas_progress);		/* needed by rtas_flash module */
 
 int rtas_token(const char *service)
 {
-	const int *tokp;
+	const __be32 *tokp;
 	if (rtas.dev == NULL)
 		return RTAS_UNKNOWN_SERVICE;
 	tokp = of_get_property(rtas.dev, service, NULL);
-	return tokp ? *tokp : RTAS_UNKNOWN_SERVICE;
+	return tokp ? be32_to_cpu(*tokp) : RTAS_UNKNOWN_SERVICE;
 }
 EXPORT_SYMBOL(rtas_token);
 
@@ -588,8 +588,8 @@ bool rtas_indicator_present(int token, int *maxindex)
 {
 	int proplen, count, i;
 	const struct indicator_elem {
-		u32 token;
-		u32 maxindex;
+		__be32 token;
+		__be32 maxindex;
 	} *indicators;
 
 	indicators = of_get_property(rtas.dev, "rtas-indicators", &proplen);
@@ -599,10 +599,10 @@ bool rtas_indicator_present(int token, int *maxindex)
 	count = proplen / sizeof(struct indicator_elem);
 
 	for (i = 0; i < count; i++) {
-		if (indicators[i].token != token)
+		if (__be32_to_cpu(indicators[i].token) != token)
 			continue;
 		if (maxindex)
-			*maxindex = indicators[i].maxindex;
+			*maxindex = __be32_to_cpu(indicators[i].maxindex);
 		return true;
 	}
 
@@ -1097,19 +1097,19 @@ void __init rtas_initialize(void)
 	 */
 	rtas.dev = of_find_node_by_name(NULL, "rtas");
 	if (rtas.dev) {
-		const u32 *basep, *entryp, *sizep;
+		const __be32 *basep, *entryp, *sizep;
 
 		basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
 		sizep = of_get_property(rtas.dev, "rtas-size", NULL);
 		if (basep != NULL && sizep != NULL) {
-			rtas.base = *basep;
-			rtas.size = *sizep;
+			rtas.base = __be32_to_cpu(*basep);
+			rtas.size = __be32_to_cpu(*sizep);
 			entryp = of_get_property(rtas.dev,
 					"linux,rtas-entry", NULL);
 			if (entryp == NULL) /* Ugh */
 				rtas.entry = rtas.base;
 			else
-				rtas.entry = *entryp;
+				rtas.entry = __be32_to_cpu(*entryp);
 		} else
 			rtas.dev = NULL;
 	}
-- 
1.8.1.2
