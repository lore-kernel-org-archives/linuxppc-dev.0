Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B875DDF86
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:31 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMEL7o013498
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:21 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 07/10] powerpc: Add a unified uevent handler for bus based on
	of_device
Date: Mon, 12 Feb 2007 23:13:25 +0100
Message-Id: <11713184171985-git-send-email-tnt@246tNt.com>
In-Reply-To: <11713184152189-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<11713184112187-git-send-email-tnt@246tNt.com>
	<11713184132161-git-send-email-tnt@246tNt.com>
	<11713184141191-git-send-email-tnt@246tNt.com>
	<11713184152189-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
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

This handlers take a struct device as argument and can therefore
be used as the uevent call directly if no special treatment is
needed for the bus.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/kernel/of_device.c |  112 +++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/of_device.h |    3 +
 2 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index e921514..e8aa1f3 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -120,6 +120,117 @@ void of_device_unregister(struct of_devi
 }
 
 
+static ssize_t of_device_get_modalias(struct of_device *ofdev,
+					char *str, ssize_t len)
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
+	compat = get_property(ofdev->node, "compatible", &cplen);
+	if (!compat)
+		return csize;
+
+	/* Find true end (we tolerate multiple \0 at the end */
+	for (i=(cplen-1); i>=0 && !compat[i]; i--)
+		cplen--;
+	if (!cplen)
+		return csize;
+	cplen++;
+
+	/* Check space (need cplen+1 chars including final \0) */
+	tsize = csize + cplen;
+	repend = tsize;
+
+	if (csize>=len)		/* @ the limit, all is already filled */
+		return tsize;
+
+	if (tsize>=len) {		/* limit compat list */
+		cplen = len-csize-1;
+		repend = len;
+	}
+
+	/* Copy and do char replacement */
+	memcpy(&str[csize+1], compat, cplen);
+	for (i=csize; i<repend; i++) {
+		char c = str[i];
+		if (c=='\0')
+			str[i] = 'C';
+		else if (c==' ')
+			str[i] = '_';
+	}
+
+	return tsize;
+}
+
+int of_device_uevent(struct device *dev,
+		char **envp, int num_envp, char *buffer, int buffer_size)
+{
+	struct of_device *ofdev;
+	const char *compat;
+	int i = 0, length = 0, seen = 0, cplen, sl;
+
+	if (!dev)
+		return -ENODEV;
+
+	ofdev = to_of_device(dev);
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
+	while (compat && *compat && cplen > 0) {
+		if (add_uevent_var(envp, num_envp, &i,
+				   buffer, buffer_size, &length,
+				   "OF_COMPATIBLE_%d=%s", seen, compat))
+			return -ENOMEM;
+
+		sl = strlen (compat) + 1;
+		compat += sl;
+		cplen -= sl;
+		seen++;
+	}
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "OF_COMPATIBLE_N=%d", seen))
+		return -ENOMEM;
+
+	/* modalias is trickier, we add it in 2 steps */
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "MODALIAS="))
+		return -ENOMEM;
+
+	sl = of_device_get_modalias(ofdev, &buffer[length-1],
+					buffer_size-length);
+	if (sl >= (buffer_size-length))
+		return -ENOMEM;
+
+	length += sl;
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
@@ -127,3 +238,4 @@ EXPORT_SYMBOL(of_device_unregister);
 EXPORT_SYMBOL(of_dev_get);
 EXPORT_SYMBOL(of_dev_put);
 EXPORT_SYMBOL(of_release_dev);
+EXPORT_SYMBOL(of_device_uevent);
diff --git a/include/asm-powerpc/of_device.h b/include/asm-powerpc/of_device.h
index a889b20..4f1aabe 100644
--- a/include/asm-powerpc/of_device.h
+++ b/include/asm-powerpc/of_device.h
@@ -32,5 +32,8 @@ extern int of_device_register(struct of_
 extern void of_device_unregister(struct of_device *ofdev);
 extern void of_release_dev(struct device *dev);
 
+extern int of_device_uevent(struct device *dev,
+	char **envp, int num_envp, char *buffer, int buffer_size);
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_OF_DEVICE_H */
-- 
1.4.2
