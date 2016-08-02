Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Sy22DDlzDrLG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 17:48:58 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ez1so11418579pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:48:58 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com
Subject: [RFC] [PATCH 3/3] powernv/oppanel: Update op_panel module to utilise
 opal_oppanel interface
Date: Tue,  2 Aug 2016 17:48:37 +1000
Message-Id: <1470124117-24419-3-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1470124117-24419-1-git-send-email-sjitindarsingh@gmail.com>
References: <1470124117-24419-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powernv_op_panel kernel module is used to expose the operator panel
display present on IBM PowerNV machines with FSPs through the char device
/dev/op_panel.

The new interface opal_oppanel which has been added to allow access to the
operator panel display from within the kernel duplicates a lot of the
module code. Thus update the powernv_op_panel kernel module to access the
display through the opal_oppanel interface.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 drivers/char/powernv-op-panel.c | 153 ++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 102 deletions(-)

diff --git a/drivers/char/powernv-op-panel.c b/drivers/char/powernv-op-panel.c
index a45dabc..2d22cc4 100644
--- a/drivers/char/powernv-op-panel.c
+++ b/drivers/char/powernv-op-panel.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
-
+#include <linux/uaccess.h>
 #include <asm/opal.h>
 
 /*
@@ -28,106 +28,87 @@
  * operator panel.
  */
 
-static DEFINE_MUTEX(oppanel_mutex);
+static DEFINE_MUTEX(oppanel_driver_mutex);
 
-static u32		num_lines, oppanel_size;
-static oppanel_line_t	*oppanel_lines;
-static char		*oppanel_data;
-
-static loff_t oppanel_llseek(struct file *filp, loff_t offset, int whence)
-{
-	return fixed_size_llseek(filp, offset, whence, oppanel_size);
-}
+static u32 buf_size;
+char *oppanel_buf;
 
 static ssize_t oppanel_read(struct file *filp, char __user *userbuf, size_t len,
 			    loff_t *f_pos)
 {
-	return simple_read_from_buffer(userbuf, len, f_pos, oppanel_data,
-			oppanel_size);
-}
+	ssize_t ret;
 
-static int __op_panel_update_display(void)
-{
-	struct opal_msg msg;
-	int rc, token;
-
-	token = opal_async_get_token_interruptible();
-	if (token < 0) {
-		if (token != -ERESTARTSYS)
-			pr_debug("Couldn't get OPAL async token [token=%d]\n",
-				token);
-		return token;
-	}
+	if (*f_pos < 0)
+		return -EINVAL;
+	if (*f_pos >= (buf_size - 1) || !len)
+		return 0;
+	if (len > (buf_size - 1 - *f_pos))
+		len = buf_size - 1 - *f_pos;
 
-	rc = opal_write_oppanel_async(token, oppanel_lines, num_lines);
-	switch (rc) {
-	case OPAL_ASYNC_COMPLETION:
-		rc = opal_async_wait_response(token, &msg);
-		if (rc) {
-			pr_debug("Failed to wait for async response [rc=%d]\n",
-				rc);
-			break;
-		}
-		rc = opal_get_async_rc(msg);
-		if (rc != OPAL_SUCCESS) {
-			pr_debug("OPAL async call returned failed [rc=%d]\n",
-				rc);
-			break;
-		}
-	case OPAL_SUCCESS:
-		break;
-	default:
-		pr_debug("OPAL write op-panel call failed [rc=%d]\n", rc);
-	}
+	opal_oppanel_read(oppanel_buf);
+	ret = len - copy_to_user(userbuf, &oppanel_buf[*f_pos], len);
 
-	opal_async_release_token(token);
-	return rc;
+	/* Nothing was copied */
+	if (!ret)
+		return -EFAULT;
+
+	*f_pos += ret;
+
+	return ret;
 }
 
 static ssize_t oppanel_write(struct file *filp, const char __user *userbuf,
 			     size_t len, loff_t *f_pos)
 {
-	loff_t f_pos_prev = *f_pos;
 	ssize_t ret;
 	int rc;
 
-	if (!*f_pos)
-		memset(oppanel_data, ' ', oppanel_size);
-	else if (*f_pos >= oppanel_size)
-		return -EFBIG;
+	if (*f_pos < 0)
+		return -EINVAL;
+	if (!len)
+		return 0;
+	if (len >= buf_size)
+		len = buf_size - 1;
 
-	ret = simple_write_to_buffer(oppanel_data, oppanel_size, f_pos, userbuf,
-			len);
+	ret = len - copy_from_user(oppanel_buf, userbuf, len);
+	/* Something was copied */
 	if (ret > 0) {
-		rc = __op_panel_update_display();
+		/* Add null terminator */
+		oppanel_buf[ret] = '\0';
+		rc = opal_oppanel_write(oppanel_buf);
 		if (rc != OPAL_SUCCESS) {
 			pr_err_ratelimited("OPAL call failed to write to op panel display [rc=%d]\n",
 				rc);
-			*f_pos = f_pos_prev;
-			return -EIO;
+			return rc;
 		}
-	}
+	/* Nothing was copied */
+	} else if (!ret)
+		return -EFAULT;
+
+	*f_pos += ret;
+
 	return ret;
 }
 
 static int oppanel_open(struct inode *inode, struct file *filp)
 {
-	if (!mutex_trylock(&oppanel_mutex)) {
+	if (!mutex_trylock(&oppanel_driver_mutex)) {
 		pr_debug("Device Busy\n");
 		return -EBUSY;
 	}
+	nonseekable_open(inode, filp);
 	return 0;
 }
 
 static int oppanel_release(struct inode *inode, struct file *filp)
 {
-	mutex_unlock(&oppanel_mutex);
+	mutex_unlock(&oppanel_driver_mutex);
 	return 0;
 }
 
 static const struct file_operations oppanel_fops = {
 	.owner		= THIS_MODULE,
-	.llseek		= oppanel_llseek,
+	.llseek		= no_llseek,
 	.read		= oppanel_read,
 	.write		= oppanel_write,
 	.open		= oppanel_open,
@@ -142,62 +123,30 @@ static struct miscdevice oppanel_dev = {
 
 static int oppanel_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
-	u32 line_len;
-	int rc, i;
-
-	rc = of_property_read_u32(np, "#length", &line_len);
-	if (rc) {
-		pr_err_ratelimited("Operator panel length property not found\n");
-		return rc;
-	}
-	rc = of_property_read_u32(np, "#lines", &num_lines);
-	if (rc) {
-		pr_err_ratelimited("Operator panel lines property not found\n");
-		return rc;
-	}
-	oppanel_size = line_len * num_lines;
+	int rc;
 
-	pr_devel("Operator panel of size %u found with %u lines of length %u\n",
-			oppanel_size, num_lines, line_len);
+	opal_oppanel_get_size(&buf_size);
+	/* Add space for a null terminator */
+	buf_size += 1;
 
-	oppanel_data = kcalloc(oppanel_size, sizeof(*oppanel_data), GFP_KERNEL);
-	if (!oppanel_data)
+	oppanel_buf = kcalloc(buf_size, sizeof(*oppanel_buf), GFP_KERNEL);
+	if (!oppanel_buf)
 		return -ENOMEM;
-
-	oppanel_lines = kcalloc(num_lines, sizeof(oppanel_line_t), GFP_KERNEL);
-	if (!oppanel_lines) {
-		rc = -ENOMEM;
-		goto free_oppanel_data;
-	}
-
-	memset(oppanel_data, ' ', oppanel_size);
-	for (i = 0; i < num_lines; i++) {
-		oppanel_lines[i].line_len = cpu_to_be64(line_len);
-		oppanel_lines[i].line = cpu_to_be64(__pa(&oppanel_data[i *
-						line_len]));
-	}
+	memset(oppanel_buf, '\0', buf_size);
 
 	rc = misc_register(&oppanel_dev);
 	if (rc) {
 		pr_err_ratelimited("Failed to register as misc device\n");
-		goto free_oppanel;
+		kfree(oppanel_buf);
 	}
 
-	return 0;
-
-free_oppanel:
-	kfree(oppanel_lines);
-free_oppanel_data:
-	kfree(oppanel_data);
 	return rc;
 }
 
 static int oppanel_remove(struct platform_device *pdev)
 {
 	misc_deregister(&oppanel_dev);
-	kfree(oppanel_lines);
-	kfree(oppanel_data);
+	kfree(oppanel_buf);
 	return 0;
 }
 
-- 
2.5.5
