Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E2C32679FD
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 11:32:00 +1000 (EST)
Date: Mon, 16 May 2005 20:31:54 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0505162031190.24582@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: enable use of early_param
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to call parse_early_param() early on to allow usage of
early_param() for command line parsing.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit d9aa16f3736be7e3ff97ead1a710b8061e9990f8
tree ad05fc7300bdd058ecfb5cbbf022c4c19f4e13c5
parent 704da4a5c793087584fa5d0ed73440dd4ac44294
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 16 May 2005 20:29:56 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 16 May 2005 20:29:56 -0500

 ppc/kernel/setup.c |    2 ++
 1 files changed, 2 insertions(+)

Index: arch/ppc/kernel/setup.c
===================================================================
--- 1702b9dd418707a930969079b460df0ace2f1c1a/arch/ppc/kernel/setup.c  (mode:100644)
+++ ad05fc7300bdd058ecfb5cbbf022c4c19f4e13c5/arch/ppc/kernel/setup.c  (mode:100644)
@@ -753,6 +753,8 @@
 	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
+	parse_early_param();
+
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
