Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86023DDF53
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 17:10:50 +1100 (EST)
Subject: [RFC/PATCH] powerpc: Always use -mno-string & -mno-multiple
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 17:10:38 +1100
Message-Id: <1174543838.10836.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Akinobu Mita <mita@fixstars.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Always use -mno-string and -mno-multiple

The string and multiple load/store instructions are causing more
damage than help on a lot of processors where they are microcoded
and are generally no good for the kernel to use. Let's make sure
we don't emit them on any powerpc variant.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Is that actually true ? What about 601 ? 4xx ? Do we want to keep
generating those for space on embedded processors where they actually
work (if they do) ?

Index: linux-cell/arch/powerpc/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/Makefile	2007-03-22 17:02:42.000000000 +1100
+++ linux-cell/arch/powerpc/Makefile	2007-03-22 17:05:23.000000000 +1100
@@ -102,9 +102,9 @@ CFLAGS += $(call cc-option,-mno-altivec)
 # kernel considerably.
 CFLAGS += $(call cc-option,-funit-at-a-time)
 
-ifndef CONFIG_FSL_BOOKE
-CFLAGS		+= -mstring
-endif
+# Never use string and multiple load/store instructions as they are
+# often slow when they are implemented at all
+CFLAGS		+= -mno-string -mno-multiple
 
 ifeq ($(CONFIG_6xx),y)
 CFLAGS		+= -mcpu=powerpc
