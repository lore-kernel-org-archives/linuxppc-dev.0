Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id C23B6DDE26
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 02:05:37 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so3796084rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Oct 2008 08:05:36 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] of-bindings: Don't support linux, <modalias> compatible values
To: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
Date: Wed, 08 Oct 2008 09:05:29 -0600
Message-ID: <20081008150529.21059.52235.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Compatible property values in the form linux,<modalias> is not documented
anywhere and using it leaks Linux implementation details into the device
tree data (which is bad).  Remove support for compatible values of this
form.

If any platforms exist which depended on this code (and I don't know of
any), then they can be fixed up by adding legacy translations to the
lookup table in this file.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/base.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)


diff --git a/drivers/of/base.c b/drivers/of/base.c
index ad8ac1a..cd1ce7a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -420,13 +420,12 @@ static struct of_modalias_table of_modalias_table[] = {
  * @len:	Length of modalias value
  *
  * Based on the value of the compatible property, this routine will determine
- * an appropriate modalias value for a particular device tree node.  Three
- * separate methods are used to derive a modalias value.
+ * an appropriate modalias value for a particular device tree node.  Two
+ * separate methods are attempted to derive a modalias value.
  *
  * First method is to lookup the compatible value in of_modalias_table.
- * Second is to look for a "linux,<modalias>" entry in the compatible list
- * and used that for modalias.  Third is to strip off the manufacturer
- * prefix from the first compatible entry and use the remainder as modalias
+ * Second is to strip off the manufacturer prefix from the first
+ * compatible entry and use the remainder as modalias
  *
  * This routine returns 0 on success
  */
@@ -449,21 +448,7 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
 	if (!compatible)
 		return -ENODEV;
 
-	/* 2. search for linux,<modalias> entry */
-	p = compatible;
-	while (cplen > 0) {
-		if (!strncmp(p, "linux,", 6)) {
-			p += 6;
-			strlcpy(modalias, p, len);
-			return 0;
-		}
-
-		i = strlen(p) + 1;
-		p += i;
-		cplen -= i;
-	}
-
-	/* 3. take first compatible entry and strip manufacturer */
+	/* 2. take first compatible entry and strip manufacturer */
 	p = strchr(compatible, ',');
 	if (!p)
 		return -ENODEV;
