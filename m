Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BC984DDF22
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 11:57:49 +1000 (EST)
Date: Fri, 16 May 2008 11:57:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulua@samba.org
Subject: [PATCH] [POWERPC] move of_device_get_modalias fo drivers/of
Message-Id: <20080516115745.efb998fb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Olaf Hering <olaf@aepfle.de>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 140b932f8cb6cced10b96860651a198b1b89cbb9 ("Create modalias file
in sysfs for of_platform bus") needs this to avoid breaking the sparc
builds.

Just move the code and add whitespace around some binary operators.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/of_device.c |   48 ---------------------------------------
 drivers/of/device.c             |   48 +++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/of_device.h |    2 -
 include/linux/of_device.h       |    3 ++
 4 files changed, 51 insertions(+), 50 deletions(-)

I have built this for ppc64_defconfig and sparc and sparc64 defconfigs.

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 5748ddb..e9be908 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -89,54 +89,6 @@ struct of_device *of_device_alloc(struct device_node *np,
 }
 EXPORT_SYMBOL(of_device_alloc);
 
-ssize_t of_device_get_modalias(struct of_device *ofdev,
-				char *str, ssize_t len)
-{
-	const char *compat;
-	int cplen, i;
-	ssize_t tsize, csize, repend;
-
-	/* Name & Type */
-	csize = snprintf(str, len, "of:N%sT%s",
-				ofdev->node->name, ofdev->node->type);
-
-	/* Get compatible property if any */
-	compat = of_get_property(ofdev->node, "compatible", &cplen);
-	if (!compat)
-		return csize;
-
-	/* Find true end (we tolerate multiple \0 at the end */
-	for (i=(cplen-1); i>=0 && !compat[i]; i--)
-		cplen--;
-	if (!cplen)
-		return csize;
-	cplen++;
-
-	/* Check space (need cplen+1 chars including final \0) */
-	tsize = csize + cplen;
-	repend = tsize;
-
-	if (csize>=len)		/* @ the limit, all is already filled */
-		return tsize;
-
-	if (tsize>=len) {		/* limit compat list */
-		cplen = len-csize-1;
-		repend = len;
-	}
-
-	/* Copy and do char replacement */
-	memcpy(&str[csize+1], compat, cplen);
-	for (i=csize; i<repend; i++) {
-		char c = str[i];
-		if (c=='\0')
-			str[i] = 'C';
-		else if (c==' ')
-			str[i] = '_';
-	}
-
-	return tsize;
-}
-
 int of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct of_device *ofdev;
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 8fbfeee..8a1d93a 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -104,3 +104,51 @@ void of_device_unregister(struct of_device *ofdev)
 	device_unregister(&ofdev->dev);
 }
 EXPORT_SYMBOL(of_device_unregister);
+
+ssize_t of_device_get_modalias(struct of_device *ofdev,
+				char *str, ssize_t len)
+{
+	const char *compat;
+	int cplen, i;
+	ssize_t tsize, csize, repend;
+
+	/* Name & Type */
+	csize = snprintf(str, len, "of:N%sT%s",
+				ofdev->node->name, ofdev->node->type);
+
+	/* Get compatible property if any */
+	compat = of_get_property(ofdev->node, "compatible", &cplen);
+	if (!compat)
+		return csize;
+
+	/* Find true end (we tolerate multiple \0 at the end */
+	for (i = (cplen - 1); i >= 0 && !compat[i]; i--)
+		cplen--;
+	if (!cplen)
+		return csize;
+	cplen++;
+
+	/* Check space (need cplen+1 chars including final \0) */
+	tsize = csize + cplen;
+	repend = tsize;
+
+	if (csize >= len)		/* @ the limit, all is already filled */
+		return tsize;
+
+	if (tsize >= len) {		/* limit compat list */
+		cplen = len - csize - 1;
+		repend = len;
+	}
+
+	/* Copy and do char replacement */
+	memcpy(&str[csize + 1], compat, cplen);
+	for (i = csize; i < repend; i++) {
+		char c = str[i];
+		if (c == '\0')
+			str[i] = 'C';
+		else if (c == ' ')
+			str[i] = '_';
+	}
+
+	return tsize;
+}
diff --git a/include/asm-powerpc/of_device.h b/include/asm-powerpc/of_device.h
index 6526e13..3c12399 100644
--- a/include/asm-powerpc/of_device.h
+++ b/include/asm-powerpc/of_device.h
@@ -21,8 +21,6 @@ extern struct of_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
 					 struct device *parent);
 
-extern ssize_t of_device_get_modalias(struct of_device *ofdev,
-					char *str, ssize_t len);
 extern int of_device_uevent(struct device *dev,
 			    struct kobj_uevent_env *env);
 
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index afe3382..d3a74e0 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -24,4 +24,7 @@ static inline void of_device_free(struct of_device *dev)
 	of_release_dev(&dev->dev);
 }
 
+extern ssize_t of_device_get_modalias(struct of_device *ofdev,
+					char *str, ssize_t len);
+
 #endif /* _LINUX_OF_DEVICE_H */
-- 
1.5.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
