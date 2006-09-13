Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4C6C067B78
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 04:33:49 +1000 (EST)
Date: Wed, 13 Sep 2006 13:32:39 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: fix non-smp build
Message-ID: <20060913133239.74a2389a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This only surfaces on CONFIG_SMP=n builds, it seems to get pulled in
through another header file for SMP builds.

(Introduced by the hvcall stats patch)


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: linux-2.6/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux-2.6/arch/powerpc/kernel/asm-offsets.c
@@ -43,6 +43,7 @@
 #include <asm/cache.h>
 #include <asm/compat.h>
 #include <asm/mmu.h>
+#include <asm/hvcall.h>
 #endif
 
 #define DEFINE(sym, val) \
