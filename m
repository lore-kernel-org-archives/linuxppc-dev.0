Return-Path: <joel@jms.id.au>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 55680141450
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:26:06 +1000 (EST)
Received: by mail-pb0-f52.google.com with SMTP id rq2so1676709pbb.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 00:26:03 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH 5/5] powerpc/powernv: Check sysparam size before creation
Date: Thu, 24 Apr 2014 16:55:37 +0930
Message-Id: <1398324337-896-6-git-send-email-joel@jms.id.au>
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

The size of the sysparam sysfs files is determined from the device tree
at boot. However the buffer is hard coded to 64 bytes. If we encounter a
parameter that is larger than 64, or miss-parse the device tree, the
buffer will overflow when reading or writing to the parameter.

Check it at discovery time, and if the parameter is too large, do not
create a sysfs entry for it.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/platforms/powernv/opal-sysparam.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index 4b3367b..14231a5 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -241,6 +241,12 @@ void __init opal_sys_param_init(void)
 
 	/* For each of the parameters, populate the parameter attributes */
 	for (i = 0; i < count; i++) {
+		if (size[i] > MAX_PARAM_DATA_LEN) {
+			pr_warn("SYSPARAM: Not creating parameter %d as size "
+				"exceeds buffer length\n", i);
+			continue;
+		}
+
 		sysfs_attr_init(&attr[i].kobj_attr.attr);
 		attr[i].param_id = id[i];
 		attr[i].param_size = size[i];
-- 
1.9.1
