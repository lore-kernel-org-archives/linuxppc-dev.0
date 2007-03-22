Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC5BDDDF52
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 17:24:01 +1100 (EST)
Subject: [PATCH] powerpc: Always use -mno-string
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 17:23:44 +1100
Message-Id: <1174544624.10836.24.camel@localhost.localdomain>
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

The string load/store instructions are causing more damage than
help on a lot of processors where they are microcoded and are
generally not good for the kernel to use. Let's make sure we
don't emit them on any powerpc variant.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Ok, let's keep load/store multiple, they are only used on 32 bits
and are actually useful. string instructions are not though.

Index: linux-cell/arch/powerpc/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/Makefile	2007-03-22 17:02:42.000000000 +1100
+++ linux-cell/arch/powerpc/Makefile	2007-03-22 17:19:28.000000000 +1100
@@ -102,9 +102,9 @@ CFLAGS += $(call cc-option,-mno-altivec)
 # kernel considerably.
 CFLAGS += $(call cc-option,-funit-at-a-time)
 
-ifndef CONFIG_FSL_BOOKE
-CFLAGS		+= -mstring
-endif
+# Never use string load/store instructions as they are
+# often slow when they are implemented at all
+CFLAGS		+= -mno-string
 
 ifeq ($(CONFIG_6xx),y)
 CFLAGS		+= -mcpu=powerpc
