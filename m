Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id E9CF22BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 05:06:55 +1100 (EST)
Date: Fri, 19 Nov 2004 11:06:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20041119180653.GF16043@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Borut Lukic <borutlukic@email.si>
Subject: [PATCH 2.6.10-rc2] ppc32: Have the 8260 board-hook happen a bit
	later
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Borut Lukic <borutlukic@email.si> brought to my attention that in
platform_init() on 8260 the board hook was being called too early to
allow for overrides (e.g. different memory sizings functions or rtc, or
anything else).  This moves the call to the end of platform_init() and I
suspect fixes some unnoticed yet bugs in a number of 8260 platforms.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.26/arch/ppc/syslib/m8260_setup.c	2004-08-24 08:31:20 -07:00
+++ edited/arch/ppc/syslib/m8260_setup.c	2004-11-19 11:03:35 -07:00
@@ -241,9 +241,6 @@
 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
 	}
 
-	/* Call back for board-specific settings. */
-	m82xx_board_init();
-
 	ppc_md.setup_arch		= m8260_setup_arch;
 	ppc_md.show_cpuinfo		= m8260_show_cpuinfo;
 	ppc_md.init_IRQ			= m8260_init_IRQ;
@@ -259,4 +256,7 @@
 
 	ppc_md.find_end_of_memory	= m8260_find_end_of_memory;
 	ppc_md.setup_io_mappings	= m8260_map_io;
+	
+	/* Call back for board-specific settings and overrides. */
+	m82xx_board_init();
 }

-- 
Tom Rini
http://gate.crashing.org/~trini/
