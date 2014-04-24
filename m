Return-Path: <joel@jms.id.au>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2F1DB140280
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:26:00 +1000 (EST)
Received: by mail-pd0-f182.google.com with SMTP id y10so1649811pdj.27
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 00:25:58 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH 3/5] powerpc/powernv: Check sysfs size before copying
Date: Thu, 24 Apr 2014 16:55:35 +0930
Message-Id: <1398324337-896-4-git-send-email-joel@jms.id.au>
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

The sysparam code currently uses the userspace supplied number of
bytes when memcpy()ing in to a local 64-byte buffer.

Limit the maximum number of bytes by the size of the buffer.
---
 arch/powerpc/platforms/powernv/opal-sysparam.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index a363c53..21fdc0a 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -135,6 +135,10 @@ static ssize_t sys_param_store(struct kobject *kobj,
 			kobj_attr);
 	ssize_t ret;
 
+        /* MAX_PARAM_DATA_LEN is sizeof(param_data_buf) */
+        if (count > MAX_PARAM_DATA_LEN)
+                count = MAX_PARAM_DATA_LEN;
+
 	mutex_lock(&opal_sysparam_mutex);
 	memcpy(param_data_buf, buf, count);
 	ret = opal_set_sys_param(attr->param_id, attr->param_size,
-- 
1.9.1
