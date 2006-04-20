Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56CE6679E9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 03:24:14 +1000 (EST)
Message-ID: <4447C3BA.6050709@am.sony.com>
Date: Thu, 20 Apr 2006 10:24:10 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] powerpc: move PAGE_SIZE outside #ifdef __KERNEL__
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The procps package needs PAGE_SIZE, defined in asm-powerpc/page.h,
but it is defined inside "#ifdef __KERNEL__".

This moves the PAGE_SIZE definition outside of "#ifdef __KERNEL__".

From: Hiroaki Fuse
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

Index: powerpc.git/include/asm-powerpc/page.h
===================================================================
--- powerpc.git.orig/include/asm-powerpc/page.h	2006-03-19 21:53:29.000000000 -0800
+++ powerpc.git/include/asm-powerpc/page.h	2006-04-19 12:30:04.000000000 -0700
@@ -10,7 +10,6 @@
  * 2 of the License, or (at your option) any later version.
  */

-#ifdef __KERNEL__
 #include <linux/config.h>
 #include <asm/asm-compat.h>

@@ -37,6 +36,7 @@
  */
 #define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))

+#ifdef __KERNEL__
 /*
  * KERNELBASE is the virtual address of the start of the kernel, it's often
  * the same as PAGE_OFFSET, but _might not be_.
