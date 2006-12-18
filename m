Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.5.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7ABD567B8F
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 09:48:08 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBIMm02e006326
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 23:48:02 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/4] powerpc: Add a unified uevent handler for bus based on
	of_device
Date: Mon, 18 Dec 2006 23:46:36 +0100
Message-Id: <1166482000535-git-send-email-tnt@246tNt.com>
In-Reply-To: <1166481999359-git-send-email-tnt@246tNt.com>
References: <1166481999359-git-send-email-tnt@246tNt.com>
Cc: Sylvain Munaut <tnt@246tNt.com>, Arnd Bergmann <arnd@arndb.de>,
	Linux PPC Devel <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This common uevent handler allow the several bus types based on
of_device to generate the uevent properly and avoiding
code duplication.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/kernel/of_device.c |   63 +++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/of_device.h |    3 ++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index e921514..a7e3a5f 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -120,6 +120,68 @@ void of_device_unregister(struct of_devi
 }
 
 
+int of_device_uevent(struct of_device *ofdev,
+		char **envp, int num_envp, char *buffer, int buffer_size)
+{
+	const char *compat;
+	char *compat2;
+	char compat_buf[128];   /* need to be size of 'compatible' */
+	int i = 0, length = 0, seen = 0, cplen, sl;
+
+	if (!ofdev)
+		return -ENODEV;
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "OF_NAME=%s", ofdev->node->name))
+		return -ENOMEM;
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "OF_TYPE=%s", ofdev->node->type))
+		return -ENOMEM;
+
+        /* Since the compatible field can contain pretty much anything
+         * it's not really legal to split it out with commas. We split it
+         * up using a number of environment variables instead. */
+
+	compat = get_property(ofdev->node, "compatible", &cplen);
+	compat2 = compat_buf;
+	if (compat)
+		memcpy(compat2, compat, cplen);
+	while (compat && *compat && cplen > 0) {
+		if (add_uevent_var(envp, num_envp, &i,
+				   buffer, buffer_size, &length,
+				   "OF_COMPATIBLE_%d=%s", seen, compat))
+			return -ENOMEM;
+
+		sl = strlen (compat) + 1;
+		compat += sl;
+		compat2 += sl;
+		cplen -= sl;
+		seen++;
+		compat2[-1] = 'C'; 
+	}
+	compat2[seen?-1:0] = 0;
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "OF_COMPATIBLE_N=%d", seen))
+		return -ENOMEM;
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "MODALIAS=of:N%sT%sC%s",
+			   ofdev->node->name, ofdev->node->type,
+			   compat_buf))
+		return -ENOMEM;
+
+	envp[i] = NULL;
+
+	return 0;
+}
+
+
 EXPORT_SYMBOL(of_match_node);
 EXPORT_SYMBOL(of_match_device);
 EXPORT_SYMBOL(of_device_register);
@@ -127,3 +189,4 @@ EXPORT_SYMBOL(of_device_unregister);
 EXPORT_SYMBOL(of_dev_get);
 EXPORT_SYMBOL(of_dev_put);
 EXPORT_SYMBOL(of_release_dev);
+EXPORT_SYMBOL(of_device_uevent);
diff --git a/include/asm-powerpc/of_device.h b/include/asm-powerpc/of_device.h
index a889b20..caf0619 100644
--- a/include/asm-powerpc/of_device.h
+++ b/include/asm-powerpc/of_device.h
@@ -32,5 +32,8 @@ extern int of_device_register(struct of_
 extern void of_device_unregister(struct of_device *ofdev);
 extern void of_release_dev(struct device *dev);
 
+extern int of_device_uevent(struct of_device *ofdev,
+	char **envp, int num_envp, char *buffer, int buffer_size);
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_OF_DEVICE_H */
-- 
1.4.2
