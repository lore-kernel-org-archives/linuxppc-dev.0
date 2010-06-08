Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 2/6] of/device: merge of_device_uevent
To: ben@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:26:23 -0600
Message-ID: <20100608142623.26088.4096.stgit@angua>
In-Reply-To: <20100608142152.26088.1108.stgit@angua>
References: <20100608142152.26088.1108.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge common code between powerpc and microblaze

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Wolfram Sang <w.sang@pengutronix.de>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
---
 arch/microblaze/include/asm/of_device.h |    3 --
 arch/microblaze/kernel/of_device.c      |   48 ------------------------------
 arch/powerpc/include/asm/of_device.h    |    3 --
 arch/powerpc/kernel/of_device.c         |   49 -------------------------------
 drivers/of/device.c                     |   48 ++++++++++++++++++++++++++++++
 include/linux/of_device.h               |    4 +++
 6 files changed, 52 insertions(+), 103 deletions(-)

diff --git a/arch/microblaze/include/asm/of_device.h b/arch/microblaze/include/asm/of_device.h
index 0a5f3f9..58e627d 100644
--- a/arch/microblaze/include/asm/of_device.h
+++ b/arch/microblaze/include/asm/of_device.h
@@ -22,9 +22,6 @@ extern struct of_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
 					 struct device *parent);
 
-extern int of_device_uevent(struct device *dev,
-			    struct kobj_uevent_env *env);
-
 extern void of_device_make_bus_id(struct of_device *dev);
 
 /* This is just here during the transition */
diff --git a/arch/microblaze/kernel/of_device.c b/arch/microblaze/kernel/of_device.c
index b372787..3a367d7 100644
--- a/arch/microblaze/kernel/of_device.c
+++ b/arch/microblaze/kernel/of_device.c
@@ -62,51 +62,3 @@ struct of_device *of_device_alloc(struct device_node *np,
 	return dev;
 }
 EXPORT_SYMBOL(of_device_alloc);
-
-int of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	struct of_device *ofdev;
-	const char *compat;
-	int seen = 0, cplen, sl;
-
-	if (!dev)
-		return -ENODEV;
-
-	ofdev = to_of_device(dev);
-
-	if (add_uevent_var(env, "OF_NAME=%s", ofdev->dev.of_node->name))
-		return -ENOMEM;
-
-	if (add_uevent_var(env, "OF_TYPE=%s", ofdev->dev.of_node->type))
-		return -ENOMEM;
-
-	/* Since the compatible field can contain pretty much anything
-	 * it's not really legal to split it out with commas. We split it
-	 * up using a number of environment variables instead. */
-
-	compat = of_get_property(ofdev->dev.of_node, "compatible", &cplen);
-	while (compat && *compat && cplen > 0) {
-		if (add_uevent_var(env, "OF_COMPATIBLE_%d=%s", seen, compat))
-			return -ENOMEM;
-
-		sl = strlen(compat) + 1;
-		compat += sl;
-		cplen -= sl;
-		seen++;
-	}
-
-	if (add_uevent_var(env, "OF_COMPATIBLE_N=%d", seen))
-		return -ENOMEM;
-
-	/* modalias is trickier, we add it in 2 steps */
-	if (add_uevent_var(env, "MODALIAS="))
-		return -ENOMEM;
-	sl = of_device_get_modalias(ofdev, &env->buf[env->buflen-1],
-				    sizeof(env->buf) - env->buflen);
-	if (sl >= (sizeof(env->buf) - env->buflen))
-		return -ENOMEM;
-	env->buflen += sl;
-
-	return 0;
-}
-EXPORT_SYMBOL(of_device_uevent);
diff --git a/arch/powerpc/include/asm/of_device.h b/arch/powerpc/include/asm/of_device.h
index cb36632..5d5103c 100644
--- a/arch/powerpc/include/asm/of_device.h
+++ b/arch/powerpc/include/asm/of_device.h
@@ -9,8 +9,5 @@ extern struct of_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
 					 struct device *parent);
 
-extern int of_device_uevent(struct device *dev,
-			    struct kobj_uevent_env *env);
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_OF_DEVICE_H */
diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index df78e02..db91a9d 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -82,52 +82,3 @@ struct of_device *of_device_alloc(struct device_node *np,
 	return dev;
 }
 EXPORT_SYMBOL(of_device_alloc);
-
-int of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	struct of_device *ofdev;
-	const char *compat;
-	int seen = 0, cplen, sl;
-
-	if (!dev)
-		return -ENODEV;
-
-	ofdev = to_of_device(dev);
-
-	if (add_uevent_var(env, "OF_NAME=%s", ofdev->dev.of_node->name))
-		return -ENOMEM;
-
-	if (add_uevent_var(env, "OF_TYPE=%s", ofdev->dev.of_node->type))
-		return -ENOMEM;
-
-        /* Since the compatible field can contain pretty much anything
-         * it's not really legal to split it out with commas. We split it
-         * up using a number of environment variables instead. */
-
-	compat = of_get_property(ofdev->dev.of_node, "compatible", &cplen);
-	while (compat && *compat && cplen > 0) {
-		if (add_uevent_var(env, "OF_COMPATIBLE_%d=%s", seen, compat))
-			return -ENOMEM;
-
-		sl = strlen (compat) + 1;
-		compat += sl;
-		cplen -= sl;
-		seen++;
-	}
-
-	if (add_uevent_var(env, "OF_COMPATIBLE_N=%d", seen))
-		return -ENOMEM;
-
-	/* modalias is trickier, we add it in 2 steps */
-	if (add_uevent_var(env, "MODALIAS="))
-		return -ENOMEM;
-	sl = of_device_get_modalias(ofdev, &env->buf[env->buflen-1],
-				    sizeof(env->buf) - env->buflen);
-	if (sl >= (sizeof(env->buf) - env->buflen))
-		return -ENOMEM;
-	env->buflen += sl;
-
-	return 0;
-}
-EXPORT_SYMBOL(of_device_uevent);
-EXPORT_SYMBOL(of_device_get_modalias);
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 7d18f8e..275cc9c 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -170,3 +170,51 @@ ssize_t of_device_get_modalias(struct of_device *ofdev,
 
 	return tsize;
 }
+
+/**
+ * of_device_uevent - Display OF related uevent information
+ */
+int of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	const char *compat;
+	int seen = 0, cplen, sl;
+
+	if ((!dev) || (!dev->of_node))
+		return -ENODEV;
+
+	if (add_uevent_var(env, "OF_NAME=%s", dev->of_node->name))
+		return -ENOMEM;
+
+	if (add_uevent_var(env, "OF_TYPE=%s", dev->of_node->type))
+		return -ENOMEM;
+
+	/* Since the compatible field can contain pretty much anything
+	 * it's not really legal to split it out with commas. We split it
+	 * up using a number of environment variables instead. */
+
+	compat = of_get_property(dev->of_node, "compatible", &cplen);
+	while (compat && *compat && cplen > 0) {
+		if (add_uevent_var(env, "OF_COMPATIBLE_%d=%s", seen, compat))
+			return -ENOMEM;
+
+		sl = strlen(compat) + 1;
+		compat += sl;
+		cplen -= sl;
+		seen++;
+	}
+
+	if (add_uevent_var(env, "OF_COMPATIBLE_N=%d", seen))
+		return -ENOMEM;
+
+	/* modalias is trickier, we add it in 2 steps */
+	if (add_uevent_var(env, "MODALIAS="))
+		return -ENOMEM;
+
+	sl = of_device_get_modalias(to_of_device(dev), &env->buf[env->buflen-1],
+				    sizeof(env->buf) - env->buflen);
+	if (sl >= (sizeof(env->buf) - env->buflen))
+		return -ENOMEM;
+	env->buflen += sl;
+
+	return 0;
+}
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index a3ae590..da83e73 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -44,6 +44,10 @@ static inline void of_device_free(struct of_device *dev)
 
 extern ssize_t of_device_get_modalias(struct of_device *ofdev,
 					char *str, ssize_t len);
+
+extern int of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
+
+
 #endif /* CONFIG_OF_DEVICE */
 
 #endif /* _LINUX_OF_DEVICE_H */
