Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61CE8DDF2D
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:33 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMEJZ8013471
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:19 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 08/10] macintosh: Use the new of_device common uevent handler
Date: Mon, 12 Feb 2007 23:13:26 +0100
Message-Id: <11713184182928-git-send-email-tnt@246tNt.com>
In-Reply-To: <11713184171985-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<11713184112187-git-send-email-tnt@246tNt.com>
	<11713184132161-git-send-email-tnt@246tNt.com>
	<11713184141191-git-send-email-tnt@246tNt.com>
	<11713184152189-git-send-email-tnt@246tNt.com>
	<11713184171985-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The generation of the uevent is now common to all bus using
of_device.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 drivers/macintosh/macio_asic.c |   98 ----------------------------------------
 1 files changed, 1 insertions(+), 97 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index d562160..e851266 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -134,108 +134,12 @@ static int macio_device_resume(struct de
 	return 0;
 }
 
-static int macio_uevent(struct device *dev, char **envp, int num_envp,
-                          char *buffer, int buffer_size)
-{
-	struct macio_dev * macio_dev;
-	struct of_device * of;
-	char *scratch;
-	const char *compat, *compat2;
-
-	int i = 0;
-	int length, cplen, cplen2, seen = 0;
-
-	if (!dev)
-		return -ENODEV;
-
-	macio_dev = to_macio_device(dev);
-	if (!macio_dev)
-		return -ENODEV;
-
-	of = &macio_dev->ofdev;
-
-	/* stuff we want to pass to /sbin/hotplug */
-	envp[i++] = scratch = buffer;
-	length = scnprintf (scratch, buffer_size, "OF_NAME=%s", of->node->name);
-	++length;
-	buffer_size -= length;
-	if ((buffer_size <= 0) || (i >= num_envp))
-		return -ENOMEM;
-	scratch += length;
-
-	envp[i++] = scratch;
-	length = scnprintf (scratch, buffer_size, "OF_TYPE=%s", of->node->type);
-	++length;
-	buffer_size -= length;
-	if ((buffer_size <= 0) || (i >= num_envp))
-		return -ENOMEM;
-	scratch += length;
-
-        /* Since the compatible field can contain pretty much anything
-         * it's not really legal to split it out with commas. We split it
-         * up using a number of environment variables instead. */
-
-	compat = get_property(of->node, "compatible", &cplen);
-	compat2 = compat;
-	cplen2= cplen;
-	while (compat && cplen > 0) {
-                envp[i++] = scratch;
-		length = scnprintf (scratch, buffer_size,
-		                     "OF_COMPATIBLE_%d=%s", seen, compat);
-		++length;
-		buffer_size -= length;
-		if ((buffer_size <= 0) || (i >= num_envp))
-			return -ENOMEM;
-		scratch += length;
-		length = strlen (compat) + 1;
-		compat += length;
-		cplen -= length;
-		seen++;
-	}
-
-	envp[i++] = scratch;
-	length = scnprintf (scratch, buffer_size, "OF_COMPATIBLE_N=%d", seen);
-	++length;
-	buffer_size -= length;
-	if ((buffer_size <= 0) || (i >= num_envp))
-		return -ENOMEM;
-	scratch += length;
-
-	envp[i++] = scratch;
-	length = scnprintf (scratch, buffer_size, "MODALIAS=of:N%sT%s",
-			of->node->name, of->node->type);
-	/* overwrite '\0' */
-	buffer_size -= length;
-	if ((buffer_size <= 0) || (i >= num_envp))
-		return -ENOMEM;
-	scratch += length;
-
-	if (!compat2) {
-		compat2 = "";
-		cplen2 = 1;
-	}
-	while (cplen2 > 0) {
-		length = snprintf (scratch, buffer_size, "C%s", compat2);
-		buffer_size -= length;
-		if (buffer_size <= 0)
-			return -ENOMEM;
-		scratch += length;
-		length = strlen (compat2) + 1;
-		compat2 += length;
-		cplen2 -= length;
-	}
-
-	envp[i] = NULL;
-
-	return 0;
-}
-
 extern struct device_attribute macio_dev_attrs[];
 
 struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
-       .uevent = macio_uevent,
+       .uevent = of_device_uevent,
        .probe	= macio_device_probe,
        .remove	= macio_device_remove,
        .shutdown = macio_device_shutdown,
-- 
1.4.2
