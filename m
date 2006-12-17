Return-Path: <tnt@246tNt.com>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.4.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CADE167BE4
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 03:52:45 +1100 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBHGqdUn019170
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Dec 2006 17:52:39 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] macintosh: tidy up uevent handler by using add_uevent_var
Date: Sun, 17 Dec 2006 17:51:16 +0100
Message-Id: <1166374279262-git-send-email-tnt@246tNt.com>
In-Reply-To: <11663742771972-git-send-email-tnt@246tNt.com>
References: <11663742771972-git-send-email-tnt@246tNt.com>
Cc: Sylvain Munaut <tnt@246tNt.com>, Linux PPC Devel <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This add_uevent_var helper is specifically there for that
task and that makes the code more readable.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 drivers/macintosh/macio_asic.c |   92 +++++++++++++++-------------------------
 1 files changed, 34 insertions(+), 58 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index d562160..3d83d6c 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -139,11 +139,12 @@ static int macio_uevent(struct device *d
 {
 	struct macio_dev * macio_dev;
 	struct of_device * of;
-	char *scratch;
-	const char *compat, *compat2;
+	const char *compat;
+	char *compat2;
+	char compat_buf[128];	/* need to be size of 'compatible' */
 
 	int i = 0;
-	int length, cplen, cplen2, seen = 0;
+	int length = 0, cplen, sl, seen = 0;
 
 	if (!dev)
 		return -ENODEV;
@@ -155,75 +156,50 @@ static int macio_uevent(struct device *d
 	of = &macio_dev->ofdev;
 
 	/* stuff we want to pass to /sbin/hotplug */
-	envp[i++] = scratch = buffer;
-	length = scnprintf (scratch, buffer_size, "OF_NAME=%s", of->node->name);
-	++length;
-	buffer_size -= length;
-	if ((buffer_size <= 0) || (i >= num_envp))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "OF_NAME=%s", of->node->name))
 		return -ENOMEM;
-	scratch += length;
 
-	envp[i++] = scratch;
-	length = scnprintf (scratch, buffer_size, "OF_TYPE=%s", of->node->type);
-	++length;
-	buffer_size -= length;
-	if ((buffer_size <= 0) || (i >= num_envp))
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "OF_TYPE=%s", of->node->type))
 		return -ENOMEM;
-	scratch += length;
 
         /* Since the compatible field can contain pretty much anything
          * it's not really legal to split it out with commas. We split it
          * up using a number of environment variables instead. */
 
 	compat = get_property(of->node, "compatible", &cplen);
-	compat2 = compat;
-	cplen2= cplen;
-	while (compat && cplen > 0) {
-                envp[i++] = scratch;
-		length = scnprintf (scratch, buffer_size,
-		                     "OF_COMPATIBLE_%d=%s", seen, compat);
-		++length;
-		buffer_size -= length;
-		if ((buffer_size <= 0) || (i >= num_envp))
+	compat2 = compat_buf;
+	if (compat)
+		memcpy(compat2, compat, cplen);
+	while (compat && *compat && cplen > 0) {
+		if (add_uevent_var(envp, num_envp, &i,
+				   buffer, buffer_size, &length,
+				   "OF_COMPATIBLE_%d=%s", seen, compat))
 			return -ENOMEM;
-		scratch += length;
-		length = strlen (compat) + 1;
-		compat += length;
-		cplen -= length;
+
+		sl = strlen (compat) + 1;
+		compat += sl;
+		compat2 += sl;
+		cplen -= sl;
 		seen++;
+		compat2[-1] = 'C'; 
 	}
+	compat2[seen?-1:0] = 0;
 
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
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "OF_COMPATIBLE_N=%d", seen))
 		return -ENOMEM;
-	scratch += length;
 
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
+	if (add_uevent_var(envp, num_envp, &i,
+			   buffer, buffer_size, &length,
+			   "MODALIAS=of:N%sT%sC%s",
+			   of->node->name, of->node->type,
+			   compat_buf))
+		return -ENOMEM;
 
 	envp[i] = NULL;
 
@@ -235,7 +211,7 @@ extern struct device_attribute macio_dev
 struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
-       .uevent = macio_uevent,
+       .uevent	= macio_uevent,
        .probe	= macio_device_probe,
        .remove	= macio_device_remove,
        .shutdown = macio_device_shutdown,
-- 
1.4.2
