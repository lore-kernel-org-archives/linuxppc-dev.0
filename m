Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 71B11679A6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 04:06:02 +1100 (EST)
Date: Thu, 23 Nov 2006 18:06:00 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Kill a few compiler warnings
Message-ID: <Pine.LNX.4.62.0611231804310.9383@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-660284072-1164301560=:9383"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-660284072-1164301560=:9383
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


Kill a few compiler warnings:
  o format ‘%d’ expects type ‘int’, but argument 5 has type ‘long int’
  o implicit declaration of function ‘sys_mmap’

Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

---
 arch/powerpc/kernel/of_platform.c |    2 +-
 arch/powerpc/kernel/sys_ppc32.c   |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- ps3-linux-src.orig/arch/powerpc/kernel/of_platform.c
+++ ps3-linux-src/arch/powerpc/kernel/of_platform.c
@@ -212,7 +212,7 @@
 	 * counter (and pray...)
 	 */
 	magic = atomic_add_return(1, &bus_no_reg_magic);
-	snprintf(name, BUS_ID_SIZE, "%s.%d", node->name, magic - 1);
+	snprintf(name, BUS_ID_SIZE, "%s.%ld", node->name, magic - 1);
 }
 
 struct of_device* of_platform_device_create(struct device_node *np,
--- ps3-linux-src.orig/arch/powerpc/kernel/sys_ppc32.c
+++ ps3-linux-src/arch/powerpc/kernel/sys_ppc32.c
@@ -51,6 +51,7 @@
 #include <asm/time.h>
 #include <asm/mmu_context.h>
 #include <asm/ppc-pci.h>
+#include <asm/syscalls.h>
 
 /* readdir & getdents */
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
---584337861-660284072-1164301560=:9383--
