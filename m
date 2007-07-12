Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66A90DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 17:59:22 +1000 (EST)
Date: Thu, 12 Jul 2007 16:59:15 +0900 (JST)
Message-Id: <20070712.165915.-1300535948.kouish@swc.toshiba.co.jp>
Subject: [PATCH] fix showing xmon help
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In some configuration, xmon help string is larger than xmon output
buffer.  To show whole help string, this patch splits it into 2 parts.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/xmon/xmon.c
===================================================================
RCS file: /home/public/cvs/linux-powerpc-git/arch/powerpc/xmon/xmon.c,v
retrieving revision 1.1.1.7
diff -u -p -r1.1.1.7 xmon.c
--- linux-powerpc-git/arch/powerpc/xmon/xmon.c	11 Jul 2007 02:15:32 -0000	1.1.1.7
+++ linux-powerpc-git/arch/powerpc/xmon/xmon.c	11 Jul 2007 10:08:41 -0000
@@ -182,7 +182,7 @@ extern void xmon_save_regs(struct pt_reg
 			 || ('A' <= (c) && (c) <= 'Z'))
 #define isspace(c)	(c == ' ' || c == '\t' || c == 10 || c == 13 || c == 0)
 
-static char *help_string = "\
+static char *help_string1 = "\
 Commands:\n\
   b	show breakpoints\n\
   bd	set data breakpoint\n\
@@ -210,7 +210,9 @@ Commands:\n\
   md	compare two blocks of memory\n\
   ml	locate a block of memory\n\
   mz	zero a block of memory\n\
-  mi	show information about memory allocation\n\
+  mi	show information about memory allocation\n"
+;
+static char *help_string2 = "\
   p 	call a procedure\n\
   r	print registers\n\
   s	single step\n"
@@ -833,7 +835,8 @@ cmds(struct pt_regs *excp)
 			mdelay(2000);
 			return cmd;
 		case '?':
-			printf(help_string);
+			printf(help_string1);
+			printf(help_string2);
 			break;
 		case 'b':
 			bpt_cmds();
