Return-Path: <tnt@246tNt.com>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE41B67BAD
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 12:20:13 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kB91K4eG017585
	for <linuxppc-dev@ozlabs.org>; Sat, 9 Dec 2006 02:20:05 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Linux PPC dev list <linuxppc-dev@ozlabs.org>
Subject: [RFC/T] powerpc: Add support for uevent to of_platform
Date: Sat,  9 Dec 2006 02:19:16 +0100
Message-Id: <1165627158401-git-send-email-tnt@246tNt.com>
In-Reply-To: <1165627156633-git-send-email-tnt@246tNt.com>
References: 11656270752370-git-send-email-tnt@246tNt.com
	<1165627156633-git-send-email-tnt@246tNt.com>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a proper uevent handler to the of_platform bus. This
allows autoloading of modules (or at least should ;).
It's _heavily_ based on the macio counterpart.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/kernel/of_platform.c |   71 +++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index b3189d0..543e294 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -73,6 +73,76 @@ static int of_platform_bus_match(struct 
 	return of_match_device(matches, of_dev) != NULL;
 }
 
+static int of_platform_uevent(struct device *dev, char **envp, int num_envp,
+                              char *buffer, int buffer_size)
+{
+	struct of_device *of;
+	const char *compat;
+	char *compat2;
+	char compat_buf[128];	/* need to be size of 'compatible' */
+
+	int i = 0;
+	int length = 0, cplen, seen = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	of = to_of_device(dev);
+	if (!of)
+		return -ENODEV;
+
+	/* stuff we want to pass to /sbin/hotplug */
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "OF_NAME=%s", of->node->name))
+		return -ENOMEM;
+
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "OF_TYPE=%s", of->node->type))
+		return -ENOMEM;
+
+        /* Since the compatible field can contain pretty much anything
+         * it's not really legal to split it out with commas. We split it
+         * up using a number of environment variables instead. */
+
+	compat = get_property(of->node, "compatible", &cplen);
+	compat2 = compat_buf;
+	if (compat)
+		strcat(compat2, compat);
+	while (compat && cplen > 0) {
+		int sl;
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
+			   of->node->name, of->node->type,
+			   compat_buf))
+		return -ENOMEM;
+
+	envp[i] = NULL;
+
+	return 0;
+}
+
 static int of_platform_device_probe(struct device *dev)
 {
 	int error = -ENODEV;
@@ -132,6 +202,7 @@ static int of_platform_device_resume(str
 struct bus_type of_platform_bus_type = {
        .name	= "of_platform",
        .match	= of_platform_bus_match,
+       .uevent	= of_platform_uevent,
        .probe	= of_platform_device_probe,
        .remove	= of_platform_device_remove,
        .suspend	= of_platform_device_suspend,
-- 
1.4.2
