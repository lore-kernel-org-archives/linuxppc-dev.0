Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7860CDDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:05 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1X0G4027011
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:00 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1WxJC001138
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:32:59 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18I7D007817
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:18 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 8FDB6AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:32:58 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1WwCc015251
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:32:58 -0500
Date: Tue, 17 Jul 2007 20:32:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/61] Only include linux/ide.h if CONFIG_BLOCK is defined.
Message-ID: <20070718013258.GB15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The IDE header file uses type definitions that are undefined if the
CONFIG_BLOCK is deselected.  This causes a compilation failure in
setup_32.c.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/ppc_ksyms.c |    2 ++
 arch/powerpc/kernel/setup_32.c  |    4 +++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index a20f195..bc54493 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -12,7 +12,9 @@
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#ifdef CONFIG_BLOCK
 #include <linux/ide.h>
+#endif
 #include <linux/bitops.h>
 
 #include <asm/page.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 7ec6ba5..ae5d60e 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -10,7 +10,6 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
-#include <linux/ide.h>
 #include <linux/tty.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
@@ -51,7 +50,10 @@
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
+#ifdef COFNIG_BLOCK
+#include <linux/ide.h>
 struct ide_machdep_calls ppc_ide_md;
+#endif
 
 int boot_cpuid;
 EXPORT_SYMBOL_GPL(boot_cpuid);
-- 
1.5.0.3
