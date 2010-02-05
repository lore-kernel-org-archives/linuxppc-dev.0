Return-Path: <jwboyer@gmail.com>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172]) by ozlabs.org (Postfix) with ESMTP id 449E9B7E39
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Feb 2010 00:54:04 +1100 (EST)
Received: by iwn2 with SMTP id 2so352940iwn.10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Feb 2010 05:54:02 -0800 (PST)
Date: Fri, 5 Feb 2010 08:53:54 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/4] Fedora kernel patch review
Message-ID: <20100205135354.GI12001@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide a modalias entry for VIO devices in sysfs.  I believe
this was another initrd generation bugfix for anaconda.

---
 
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index f988672..12a0851 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -294,9 +294,27 @@ static ssize_t devspec_show(struct device *dev,
 	return sprintf(buf, "%s\n", of_node ? of_node->full_name : "none");
 }
 
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	const struct vio_dev *vio_dev = to_vio_dev(dev);
+	struct device_node *dn;
+	const char *cp;
+
+	dn = dev->archdata.of_node;
+	if (!dn)
+		return -ENODEV;
+	cp = of_get_property(dn, "compatible", NULL);
+	if (!cp)
+		return -ENODEV;
+
+	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
+}
+
 static struct device_attribute vio_dev_attrs[] = {
 	__ATTR_RO(name),
 	__ATTR_RO(devspec),
+	__ATTR_RO(modalias),
 	__ATTR_NULL
 };
