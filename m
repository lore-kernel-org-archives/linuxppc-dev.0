Return-Path: <joel@jms.id.au>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 17840140315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:25:58 +1000 (EST)
Received: by mail-pa0-f48.google.com with SMTP id hz1so1633974pad.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 00:25:56 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH 2/5] powerpc/powernv: Use ssize_t for sysparam return values
Date: Thu, 24 Apr 2014 16:55:34 +0930
Message-Id: <1398324337-896-3-git-send-email-joel@jms.id.au>
In-Reply-To: <1398324337-896-1-git-send-email-joel@jms.id.au>
References: <1398324337-896-1-git-send-email-joel@jms.id.au>
Cc: neelegup@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OPAL calls are returning int64_t values, which the sysparam code
stores in an int, and the sysfs callback returns ssize_t. Make code a
easier to read by consistently using ssize_t.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/platforms/powernv/opal-sysparam.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index cdaf145..a363c53 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -39,10 +39,11 @@ struct param_attr {
 	struct kobj_attribute kobj_attr;
 };
 
-static int opal_get_sys_param(u32 param_id, u32 length, void *buffer)
+static ssize_t opal_get_sys_param(u32 param_id, u32 length, void *buffer)
 {
 	struct opal_msg msg;
-	int ret, token;
+	ssize_t ret;
+	int token;
 
 	token = opal_async_get_token_interruptible();
 	if (token < 0) {
@@ -59,7 +60,7 @@ static int opal_get_sys_param(u32 param_id, u32 length, void *buffer)
 
 	ret = opal_async_wait_response(token, &msg);
 	if (ret) {
-		pr_err("%s: Failed to wait for the async response, %d\n",
+		pr_err("%s: Failed to wait for the async response, %zd\n",
 				__func__, ret);
 		goto out_token;
 	}
@@ -111,7 +112,7 @@ static ssize_t sys_param_show(struct kobject *kobj,
 {
 	struct param_attr *attr = container_of(kobj_attr, struct param_attr,
 			kobj_attr);
-	int ret;
+	ssize_t ret;
 
 	mutex_lock(&opal_sysparam_mutex);
 	ret = opal_get_sys_param(attr->param_id, attr->param_size,
@@ -132,7 +133,7 @@ static ssize_t sys_param_store(struct kobject *kobj,
 {
 	struct param_attr *attr = container_of(kobj_attr, struct param_attr,
 			kobj_attr);
-	int ret;
+	ssize_t ret;
 
 	mutex_lock(&opal_sysparam_mutex);
 	memcpy(param_data_buf, buf, count);
-- 
1.9.1
