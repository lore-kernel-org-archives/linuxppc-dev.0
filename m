Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 3A67267A7A
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Feb 2005 10:53:27 +1100 (EST)
Message-ID: <42001671.1040200@mvista.com>
Date: Tue, 01 Feb 2005 16:53:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------070208030802020905010900"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: [PATCH][PPC32] include/asm-ppc/rwsem.h RWSEM_DEBUG usage
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------070208030802020905010900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

include/asm-ppc/rwsem.h has '#ifdef RWSEM_DEBUG' but RWSEM_DEBUG is 
always defined (as 0) in include/linux/rwsem.h.  The #ifdef's should be 
#if's.  This also brings the ppc usage in line with the the other 
architectures.

Please apply.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------070208030802020905010900
Content-Type: text/plain;
 name="rwsem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwsem.patch"

diff -Nru a/include/asm-ppc/rwsem.h b/include/asm-ppc/rwsem.h
--- a/include/asm-ppc/rwsem.h	2005-02-01 16:46:53 -07:00
+++ b/include/asm-ppc/rwsem.h	2005-02-01 16:46:53 -07:00
@@ -27,7 +27,7 @@
 #define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
 	spinlock_t		wait_lock;
 	struct list_head	wait_list;
-#ifdef RWSEM_DEBUG
+#if RWSEM_DEBUG
 	int			debug;
 #endif
 };
@@ -35,7 +35,7 @@
 /*
  * initialisation
  */
-#ifdef RWSEM_DEBUG
+#if RWSEM_DEBUG
 #define __RWSEM_DEBUG_INIT      , 0
 #else
 #define __RWSEM_DEBUG_INIT	/* */
@@ -59,7 +59,7 @@
 	sem->count = RWSEM_UNLOCKED_VALUE;
 	spin_lock_init(&sem->wait_lock);
 	INIT_LIST_HEAD(&sem->wait_list);
-#ifdef RWSEM_DEBUG
+#if RWSEM_DEBUG
 	sem->debug = 0;
 #endif
 }

--------------070208030802020905010900--
