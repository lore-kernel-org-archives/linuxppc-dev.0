Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BF0A7DE0D5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:09:09 +1000 (EST)
Message-ID: <4673025B.8020503@am.sony.com>
Date: Fri, 15 Jun 2007 14:19:23 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 09/33] PS3: Simplify definition of DBG
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Simplify the PS3 definition of DBG.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/htab.c      |    4 ++--
 arch/powerpc/platforms/ps3/interrupt.c |    4 ++--
 arch/powerpc/platforms/ps3/mm.c        |    4 ++--
 arch/powerpc/platforms/ps3/setup.c     |    4 ++--
 arch/powerpc/platforms/ps3/smp.c       |    4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -29,9 +29,9 @@
 #include "platform.h"
 
 #if defined(DEBUG)
-#define DBG(fmt...) udbg_printf(fmt)
+#define DBG udbg_printf
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+#define DBG pr_debug
 #endif
 
 static hpte_t *htab;
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -30,9 +30,9 @@
 #include "platform.h"
 
 #if defined(DEBUG)
-#define DBG(fmt...) udbg_printf(fmt)
+#define DBG udbg_printf
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+#define DBG pr_debug
 #endif
 
 /**
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -30,9 +30,9 @@
 #include "platform.h"
 
 #if defined(DEBUG)
-#define DBG(fmt...) udbg_printf(fmt)
+#define DBG udbg_printf
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+#define DBG pr_debug
 #endif
 
 enum {
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -37,9 +37,9 @@
 #include "platform.h"
 
 #if defined(DEBUG)
-#define DBG(fmt...) udbg_printf(fmt)
+#define DBG udbg_printf
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+#define DBG pr_debug
 #endif
 
 #if !defined(CONFIG_SMP)
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -27,9 +27,9 @@
 #include "platform.h"
 
 #if defined(DEBUG)
-#define DBG(fmt...) udbg_printf(fmt)
+#define DBG udbg_printf
 #else
-#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
+#define DBG pr_debug
 #endif
 
 static irqreturn_t ipi_function_handler(int irq, void *msg)

-- 
