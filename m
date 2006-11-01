Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CB7C67B6F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 16:45:12 +1100 (EST)
Subject: [PATCH] powerpc: pmac_feature_call checks platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 15:53:00 +1100
Message-Id: <1162356781.25682.405.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes sure that a caller of pmac_call_feature() won't try to call
into ppc_md.feature_call of another platform which might happen if some
powermac drivers are loaded on powermac machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/asm-powerpc/pmac_feature.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pmac_feature.h	2006-09-08 17:17:52.000000000 +1000
+++ linux-work/include/asm-powerpc/pmac_feature.h	2006-11-01 14:34:13.000000000 +1100
@@ -146,7 +146,7 @@ struct device_node;
 static inline long pmac_call_feature(int selector, struct device_node* node,
 					long param, long value)
 {
-	if (!ppc_md.feature_call)
+	if (!ppc_md.feature_call || !machine_is(powermac))
 		return -ENODEV;
 	return ppc_md.feature_call(selector, node, param, value);
 }
