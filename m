Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AFA9B7001
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 15:04:48 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: fix system.h fallout in sysdev/scom.c
 [chroma_defconfig]
Date: Mon, 16 Apr 2012 01:04:34 -0400
Message-Id: <1334552674-24107-1-git-send-email-paul.gortmaker@windriver.com>
Cc: David Howells <dhowells@redhat.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following shows up in chroma_defconfig:

 CC      arch/powerpc/sysdev/scom.o
arch/powerpc/sysdev/scom.c: In function 'scom_debug_init':
arch/powerpc/sysdev/scom.c:182:36: error: 'powerpc_debugfs_root' undeclared (first use in this function)
arch/powerpc/sysdev/scom.c:182:36: note: each undeclared identifier is reported only once for each function it appears in
make[2]: *** [arch/powerpc/sysdev/scom.o] Error 1
make[1]: *** [arch/powerpc/sysdev/scom.o] Error 2

A bisect leads to commit 9ffc93f203c18a70623f21950f1dd473c9ec48cd

    "Remove all #inclusions of asm/system.h"

Add the debug header which contains powerpc_debugfs_root.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Ben, let me know if you want to take this or have me keep it.]

diff --git a/arch/powerpc/sysdev/scom.c b/arch/powerpc/sysdev/scom.c
index 49a3ece..702256a 100644
--- a/arch/powerpc/sysdev/scom.c
+++ b/arch/powerpc/sysdev/scom.c
@@ -22,6 +22,7 @@
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <asm/debug.h>
 #include <asm/prom.h>
 #include <asm/scom.h>
 
-- 
1.7.9.1
