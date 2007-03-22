Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 21837DDFC6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 09:11:10 +1100 (EST)
Date: Thu, 22 Mar 2007 23:11:17 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] fix xmon print_bug_trap compile error
Message-ID: <20070322221117.GA13481@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


These 2 members of struct bug_entry are inside CONFIG_DEBUG_BUGVERBOSE

arch/powerpc/xmon/xmon.c:1364: error: 'const struct bug_entry' has no member named 'file'
arch/powerpc/xmon/xmon.c:1364: error: 'const struct bug_entry' has no member named 'line'

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/xmon/xmon.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/arch/powerpc/xmon/xmon.c
===================================================================
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1360,8 +1360,10 @@ static void print_bug_trap(struct pt_reg
 	if (is_warning_bug(bug))
 		return;
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
 	printf("kernel BUG at %s:%u!\n",
 	       bug->file, bug->line);
+#endif
 }
 
 void excprint(struct pt_regs *fp)
