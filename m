Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.5.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E025467B6C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 09:48:07 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBIMm0t9006318
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 23:48:01 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/4] macintosh: Use the new of_device common uevent handler
Date: Mon, 18 Dec 2006 23:46:37 +0100
Message-Id: <11664820003098-git-send-email-tnt@246tNt.com>
In-Reply-To: <1166482000535-git-send-email-tnt@246tNt.com>
References: <1166481999359-git-send-email-tnt@246tNt.com>
	<1166482000535-git-send-email-tnt@246tNt.com>
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

The generation of the uevent is now common to all bus using
of_device.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 drivers/macintosh/macio_asic.c |   81 ----------------------------------------
 1 files changed, 1 insertions(+), 80 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index d562160..767ad00 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -139,11 +139,6 @@ static int macio_uevent(struct device *d
 {
 	struct macio_dev * macio_dev;
 	struct of_device * of;
-	char *scratch;
-	const char *compat, *compat2;
-
-	int i = 0;
-	int length, cplen, cplen2, seen = 0;
 
 	if (!dev)
 		return -ENODEV;
@@ -153,81 +148,7 @@ static int macio_uevent(struct device *d
 		return -ENODEV;
 
 	of = &macio_dev->ofdev;
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
+	return of_device_uevent(of, envp, num_envp, buffer, buffer_size);
 }
 
 extern struct device_attribute macio_dev_attrs[];
-- 
1.4.2
