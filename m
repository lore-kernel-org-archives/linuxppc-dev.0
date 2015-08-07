Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50AED1A1DB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 13:20:56 +1000 (AEST)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC3821402AD
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 13:20:55 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so45095282pab.0
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Aug 2015 20:20:54 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/4] cxl: sparse: Make declarations static
Date: Fri,  7 Aug 2015 13:18:18 +1000
Message-Id: <1438917500-12100-2-git-send-email-dja@axtens.net>
In-Reply-To: <1438917500-12100-1-git-send-email-dja@axtens.net>
References: <1438917500-12100-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A few declarations were identified by sparse as needing to be static:

/scratch/dja/linux-capi/drivers/misc/cxl/irq.c:408:6: warning: symbol 'afu_irq_name_free' was not declared. Should it be static?
/scratch/dja/linux-capi/drivers/misc/cxl/irq.c:467:6: warning: symbol 'afu_register_hwirqs' was not declared. Should it be static?
/scratch/dja/linux-capi/drivers/misc/cxl/file.c:254:6: warning: symbol 'afu_compat_ioctl' was not declared. Should it be static?
/scratch/dja/linux-capi/drivers/misc/cxl/file.c:399:30: warning: symbol 'afu_master_fops' was not declared. Should it be static?

Make them static.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/file.c | 4 ++--
 drivers/misc/cxl/irq.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index e3f4b69527a9..c8c8bfa2679b 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -251,7 +251,7 @@ long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return -EINVAL;
 }
 
-long afu_compat_ioctl(struct file *file, unsigned int cmd,
+static long afu_compat_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
 	return afu_ioctl(file, cmd, arg);
@@ -396,7 +396,7 @@ const struct file_operations afu_fops = {
 	.mmap           = afu_mmap,
 };
 
-const struct file_operations afu_master_fops = {
+static const struct file_operations afu_master_fops = {
 	.owner		= THIS_MODULE,
 	.open           = afu_master_open,
 	.poll		= afu_poll,
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 680cd263436d..77e5d0e7ebe1 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -405,7 +405,7 @@ void cxl_release_psl_irq(struct cxl_afu *afu)
 	kfree(afu->psl_irq_name);
 }
 
-void afu_irq_name_free(struct cxl_context *ctx)
+static void afu_irq_name_free(struct cxl_context *ctx)
 {
 	struct cxl_irq_name *irq_name, *tmp;
 
@@ -464,7 +464,7 @@ out:
 	return -ENOMEM;
 }
 
-void afu_register_hwirqs(struct cxl_context *ctx)
+static void afu_register_hwirqs(struct cxl_context *ctx)
 {
 	irq_hw_number_t hwirq;
 	struct cxl_irq_name *irq_name;
-- 
2.1.4
