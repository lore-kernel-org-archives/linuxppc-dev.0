Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 5E173DDFDD
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 07:46:16 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <kexec-29-1-6.miltonm@bga.com>
In-Reply-To: <kexec-29-1.miltonm@bga.com>
Subject: [PATCH] powerpc: make dummy section a valid note header
Date: Fri, 02 Jan 2009 14:46:04 -0600
Cc: kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We are declaring the dummy section (used to work around a binutils
bug) as PT_NOTE, but we don't have enough bytes for it to be a valid
note header, and kexec userspace complains:

Warning: Elf Note name is not null terminated
Warning: append= option is not passed. Using the first kernel root partition
Warning: Elf Note name is not null terminated

Instead of using the arbitray value 0xf177 (aka "fill"), declare a
no-name no-description note of type 0.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
verified on binutils-2.6.17 that the workaround still works (that
is we get a phdr that does not have all zeros in the paddr field,
and a relocatable kernel booted).

Index: common/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- common.orig/arch/powerpc/kernel/vmlinux.lds.S	2009-01-02 01:07:12.000000000 -0600
+++ common/arch/powerpc/kernel/vmlinux.lds.S	2009-01-02 01:18:00.000000000 -0600
@@ -87,7 +87,9 @@ SECTIONS
 	/* The dummy segment contents for the bug workaround mentioned above
 	   near PHDRS.  */
 	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
-		LONG(0xf177)
+		LONG(0)
+		LONG(0)
+		LONG(0)
 	} :kernel :dummy
 
 /*
