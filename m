Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B0219DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:35 +1000 (EST)
Message-ID: <466EE983.6020801@am.sony.com>
Date: Tue, 12 Jun 2007 11:44:19 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 09/30] PS3: Use inline DBG
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
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

Change the PS3 early debug routine DBG from a pritk call to a
local inline call.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/htab.c      |    3 ++-
 arch/powerpc/platforms/ps3/interrupt.c |    3 ++-
 arch/powerpc/platforms/ps3/mm.c        |    3 ++-
 arch/powerpc/platforms/ps3/setup.c     |    3 ++-
 arch/powerpc/platforms/ps3/smp.c       |    3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -31,7 +31,8 @@
 #if defined(DEBUG)
 #define DBG(fmt...) udbg_printf(fmt)
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+static inline int __attribute__ ((format (printf, 1, 2))) DBG(
+	const char *fmt, ...) {return 0;}
 #endif
 
 static hpte_t *htab;
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -32,7 +32,8 @@
 #if defined(DEBUG)
 #define DBG(fmt...) udbg_printf(fmt)
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+static inline int __attribute__ ((format (printf, 1, 2))) DBG(
+	const char *fmt, ...) {return 0;}
 #endif
 
 /**
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -32,7 +32,8 @@
 #if defined(DEBUG)
 #define DBG(fmt...) udbg_printf(fmt)
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+static inline int __attribute__ ((format (printf, 1, 2))) DBG(
+	const char *fmt, ...) {return 0;}
 #endif
 
 enum {
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -39,7 +39,8 @@
 #if defined(DEBUG)
 #define DBG(fmt...) udbg_printf(fmt)
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+static inline int __attribute__ ((format (printf, 1, 2))) DBG(
+	const char *fmt, ...) {return 0;}
 #endif
 
 #if !defined(CONFIG_SMP)
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -29,7 +29,8 @@
 #if defined(DEBUG)
 #define DBG(fmt...) udbg_printf(fmt)
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+static inline int __attribute__ ((format (printf, 1, 2))) DBG(
+	const char *fmt, ...) {return 0;}
 #endif
 
 static irqreturn_t ipi_function_handler(int irq, void *msg)

-- 
