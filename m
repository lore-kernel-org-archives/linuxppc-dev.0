Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA41967E54
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2005 19:55:21 +1000 (EST)
Date: Tue, 2 Aug 2005 11:55:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: paulus@samba.org, akpm@osdl.org
Message-ID: <20050802095509.GA32585@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix gcc4 warning in asm-ppc/time.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A function must not return a const value, instead use
__attribute_const__.


Index: linux-2.6/include/asm/time.h
===================================================================
--- linux-2.6.orig/include/asm/time.h	2005-04-30 10:17:19.000000000 +0200
+++ linux-2.6/include/asm/time.h	2005-08-01 11:57:12.000000000 +0200
@@ -10,6 +10,7 @@
 #define __ASM_TIME_H__
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/rtc.h>
 #include <linux/threads.h>
@@ -58,7 +59,7 @@
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
 #ifdef CONFIG_6xx
-extern __inline__ int const __USE_RTC(void) {
+extern __inline__ int __attribute_const__ __USE_RTC(void) {
 	return (mfspr(SPRN_PVR)>>16) == 1;
 }
 #else
