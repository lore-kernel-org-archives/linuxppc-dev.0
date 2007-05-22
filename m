Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F4B1DDE26
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 14:33:10 +1000 (EST)
Subject: [PATCH] powerpc: Fix powerpc vmlinux.lds.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 22 May 2007 14:33:05 +1000
Message-Id: <1179808385.32247.791.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sam's recent changes broke things for us, some stuff sneaked in before
the entry point. In fact, we don't need that *(.text.*) thing anymore
and it incorrectly matched .text.init.refok, thus putting it
before .text. .. ouch !

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vmlinux.lds.S	2007-05-22 14:16:39.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vmlinux.lds.S	2007-05-22 14:19:00.000000000 +1000
@@ -34,7 +34,6 @@ SECTIONS
 	/* Text and gots */
 	.text : {
 		_text = .;
-		*(.text.*)
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
