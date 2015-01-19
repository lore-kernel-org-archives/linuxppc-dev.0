Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5F211A0D65
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 04:53:09 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 10:53:07 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id CD1D419D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 10:44:16 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0JHrXqp48562338
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 10:53:33 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0JHr4Ka018624
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 10:53:05 -0700
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org
Subject: [PATCH 2/4] CXL: Add image control to sysfs
Date: Mon, 19 Jan 2015 11:52:49 -0600
Message-Id: <1421689971-34476-2-git-send-email-grimm@linux.vnet.ibm.com>
In-Reply-To: <1421689971-34476-1-git-send-email-grimm@linux.vnet.ibm.com>
References: <1421689971-34476-1-git-send-email-grimm@linux.vnet.ibm.com>
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

load_image_on_perst identifies whether a PERST will cause the image to be
flashed to the card.  And if so, which image.

Valid entries are: "none", "user" and "factory".

A value of "none" means PERST will not cause the image to be flashed.  A power
cycle to the pcie slot is required to load the image.

"user" loads the user provided image and "factory" loads the factory image upon
PERST.

sysfs updates the cxl struct in the driver then calls cxl_update_image_control
to write the vals in the VSEC.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-cxl | 14 +++++++++++
 drivers/misc/cxl/sysfs.c                  | 39 +++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 554405e..6fcc631 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -127,3 +127,17 @@ Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
                 Will return "user" or "factory" depending on the image loaded
                 onto the card.
+
+What:           /sys/class/cxl/<card>/load_image_on_perst
+Date:           December 2014
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read/write
+                Valid entries are "none", "user", and "factory".
+                "none" means PERST will not cause image to be loaded to the
+                card.  A power cycle is required to load the image.
+                "none" could be useful for debugging because the trace arrays
+                are preserved.
+                "user" and "factory" means PERST will cause either the user or
+                user or factory image to be loaded.
+                Default is to reload on PERST whichever image the card has
+                loaded.
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 461bdbd..ed4ad46 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -56,11 +56,50 @@ static ssize_t image_loaded_show(struct device *device,
 	return scnprintf(buf, PAGE_SIZE, "factory\n");
 }
 
+static ssize_t load_image_on_perst_show(struct device *device,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+
+	if (!adapter->perst_loads_image)
+		return scnprintf(buf, PAGE_SIZE, "none\n");
+
+	if (adapter->perst_select_user)
+		return scnprintf(buf, PAGE_SIZE, "user\n");
+	return scnprintf(buf, PAGE_SIZE, "factory\n");
+}
+
+static ssize_t load_image_on_perst_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+	int rc;
+
+	if (!strncmp(buf, "none", 4))
+		adapter->perst_loads_image = false;
+	else if (!strncmp(buf, "user", 4)) {
+		adapter->perst_select_user = true;
+		adapter->perst_loads_image = true;
+	} else if (!strncmp(buf, "factory", 7)) {
+		adapter->perst_select_user = false;
+		adapter->perst_loads_image = true;
+	} else
+		return -EINVAL;
+
+	if ((rc = cxl_update_image_control(adapter)))
+		return rc;
+
+	return count;
+}
+
 static struct device_attribute adapter_attrs[] = {
 	__ATTR_RO(caia_version),
 	__ATTR_RO(psl_revision),
 	__ATTR_RO(base_image),
 	__ATTR_RO(image_loaded),
+	__ATTR_RW(load_image_on_perst),
 };
 
 
-- 
1.9.1
