Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FBB6DDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 23:38:36 +1000 (EST)
Date: Wed, 18 Jul 2007 09:36:36 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] PPC:  Prevent direct inclusion of <asm/rwsem.h>.
Message-ID: <Pine.LNX.4.64.0707180934550.20961@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  not compile-tested, so if there's a flaw here somewhere, feel free
to tweak it.

 arch/ppc/syslib/ocp.c       |    2 +-
 include/asm-powerpc/rwsem.h |    4 ++++
 include/asm-ppc/ocp.h       |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
index 491fe9a..3f5be2c 100644
--- a/arch/ppc/syslib/ocp.c
+++ b/arch/ppc/syslib/ocp.c
@@ -44,11 +44,11 @@
 #include <linux/pm.h>
 #include <linux/bootmem.h>
 #include <linux/device.h>
+#include <linux/rwsem.h>

 #include <asm/io.h>
 #include <asm/ocp.h>
 #include <asm/errno.h>
-#include <asm/rwsem.h>
 #include <asm/semaphore.h>

 //#define DBG(x)	printk x
diff --git a/include/asm-powerpc/rwsem.h b/include/asm-powerpc/rwsem.h
index e929145..cefc147 100644
--- a/include/asm-powerpc/rwsem.h
+++ b/include/asm-powerpc/rwsem.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_POWERPC_RWSEM_H
 #define _ASM_POWERPC_RWSEM_H

+#ifndef _LINUX_RWSEM_H
+#error "Please don't include <asm/rwsem.h> directly, use <linux/rwsem.h> instead."
+#endif
+
 #ifdef __KERNEL__

 /*
diff --git a/include/asm-ppc/ocp.h b/include/asm-ppc/ocp.h
index 16dbc7d..1379a4f 100644
--- a/include/asm-ppc/ocp.h
+++ b/include/asm-ppc/ocp.h
@@ -27,10 +27,10 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/device.h>
+#include <linux/rwsem.h>

 #include <asm/mmu.h>
 #include <asm/ocp_ids.h>
-#include <asm/rwsem.h>
 #include <asm/semaphore.h>

 #ifdef CONFIG_PPC_OCP
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
