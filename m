Return-Path: <jdubois@mc.com>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id 36AD9DDE3C
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 20:18:21 +1000 (EST)
From: Jean-Christophe Dubois <jdubois@mc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix dcr_unmap()
Date: Wed, 28 Mar 2007 11:07:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703281207.41425.jdubois@mc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a bug in dcr_unmap(). 

At unmap time the DCR offset need to be added instead of substracted.

Signed-off-by: Jean-Christophe Dubois <jdubois@mc.com>

Index: linux-2.6.20/arch/powerpc/sysdev/dcr.c
===================================================================
--- linux-2.6.20.orig/arch/powerpc/sysdev/dcr.c
+++ linux-2.6.20/arch/powerpc/sysdev/dcr.c
@@ -129,7 +129,7 @@ void dcr_unmap(dcr_host_t host, unsigned
 
 	if (h.token == NULL)
 		return;
-	h.token -= dcr_n * h.stride;
+	h.token += dcr_n * h.stride;
 	iounmap(h.token);
 	h.token = NULL;
 }
