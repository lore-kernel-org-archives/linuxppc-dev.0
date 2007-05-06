Return-Path: <tnt@246tNt.com>
Received: from outmx033.isp.belgacom.be (outmx033.isp.belgacom.be
	[195.238.6.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C32F0DDE41
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 01:39:11 +1000 (EST)
Received: from outmx033.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx033.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l46Fd6vo027574
	for <linuxppc-dev@ozlabs.org>; Sun, 6 May 2007 17:39:06 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/8] macintosh: Use common modalias generation for macio_sysfs
Date: Sun,  6 May 2007 17:38:47 +0200
Message-Id: <11784659368-git-send-email-tnt@246tNt.com>
In-Reply-To: <1178465935138-git-send-email-tnt@246tNt.com>
References: <11784659324066-git-send-email-tnt@246tNt.com>
	<11784659351487-git-send-email-tnt@246tNt.com>
	<1178465935138-git-send-email-tnt@246tNt.com>
Cc: PPC dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is now a common function to generate the modalias string,
so use it. We just need to add the \n at the end.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 drivers/macintosh/macio_sysfs.c |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index cc82679..d8fadc4 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -40,29 +40,16 @@ compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
 
 static ssize_t modalias_show (struct device *dev, struct device_attribute *attr,
 			      char *buf)
-{
-	struct of_device *of;
-	const char *compat;
-	int cplen;
-	int length;
+{			
+	struct of_device *ofdev = to_of_device(dev);
+	int len;
 
-	of = &to_macio_device (dev)->ofdev;
-	compat = of_get_property(of->node, "compatible", &cplen);
-	if (!compat) compat = "", cplen = 1;
-	length = sprintf (buf, "of:N%sT%s", of->node->name, of->node->type);
-	buf += length;
-	while (cplen > 0) {
-		int l;
-		l = sprintf (buf, "C%s", compat);
-		length += l;
-		buf += l;
-		l = strlen (compat) + 1;
-		compat += l;
-		cplen -= l;
-	}
-	length += sprintf(buf, "\n");
+	len = of_device_get_modalias(ofdev, buf, PAGE_SIZE);
 
-	return length;
+	buf[len] = '\n';
+	buf[len+1] = 0;
+
+	return len+1;
 }
 
 macio_config_of_attr (name, "%s\n");
-- 
1.5.1.2
