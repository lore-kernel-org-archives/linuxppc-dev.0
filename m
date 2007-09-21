Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65B7BDE6ED
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 09:08:30 +1000 (EST)
Date: Fri, 21 Sep 2007 18:08:16 -0500 (CDT)
Subject: [PATCH 15/15] bootwrapper: recheck for command line after fixups
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-8-15.miltonm@bga.com>
In-Reply-To: <boot-8-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After the fixups hook has run, if we still have not set a command line,
check to see if fixups pointed us to one.

Running as a part of fixup allows device tree interaction and error
messages to be displayed.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
The code in main presently checks for the platform providing commandline
information before calling the console open or platform fixups "in case
the command line data is not safe from overwrite by malloc".

If malloc can overwrite the command line then how do we know flat tree
initialization or console search has not already overwritten it?  And why
would the same argument not apply to the initrd?

If a platform can't adjust malloc to keep the loader supplied command line
safe, then it could copy the loader command line to a buffer in bss.

Regardless, this is safe as we will stop once the command line contains
any information.  My current qemu patch relies on this.

Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2007-09-19 02:21:18.000000000 -0500
+++ kernel/arch/powerpc/boot/main.c	2007-09-19 02:21:18.000000000 -0500
@@ -181,6 +181,11 @@ void start(void)
 	if (platform_ops.fixups)
 		platform_ops.fixups();
 
+	/* check again, in case fixups told us about it */
+	if ((loader_info.cmdline_len > 0) && (cmdline[0] == '\0'))
+		memmove(cmdline, loader_info.cmdline,
+			min(loader_info.cmdline_len, COMMAND_LINE_SIZE-1));
+
 	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r",
 	       _start, get_sp());
 
