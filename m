Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id 19767DDEF2
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 07:21:36 +1100 (EST)
Date: Wed, 30 Jan 2008 22:03:13 +0200
From: Adrian Bunk <bunk@kernel.org>
To: paulus@samba.org
Subject: [2.6 patch] powerpc: free_property() mustn't be __init
Message-ID: <20080130200313.GG29368@does.not.exist>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the following section mismatch:

<--  snip  -->

...
WARNING: vmlinux.o(.text+0x55648): Section mismatch in reference from the function .free_node() to the function .init.text:.free_property()
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
99e9b48d8f5aba059916540fc69815db2b60b08d 
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
index be06cfd..657b72f 100644
--- a/arch/powerpc/platforms/iseries/vio.c
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -75,7 +75,7 @@ static struct property *new_property(const char *name, int length,
 	return np;
 }
 
-static void __init free_property(struct property *np)
+static void free_property(struct property *np)
 {
 	kfree(np);
 }
