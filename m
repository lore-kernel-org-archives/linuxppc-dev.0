Return-Path: <xenidis@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E935FB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 07:26:08 +1000 (EST)
Received: by yxk8 with SMTP id 8so1200546yxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Sep 2011 14:26:05 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: xmon: Fix the 'u' command
Date: Thu, 29 Sep 2011 16:25:10 -0500
Message-Id: <1317331510-22505-1-git-send-email-jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 'u' command will print the TLB on book3e parts and the SLB on
Book3s parts, but the help system doesn't say that correctly.

Signed-off-by: Jimi Xenidis <jimix@pobox.com>
---
 arch/powerpc/xmon/xmon.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 13f82f8..ad6ada8 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -228,13 +228,11 @@ Commands:\n\
   t	print backtrace\n\
   x	exit monitor and recover\n\
   X	exit monitor and dont recover\n"
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_BOOK3E)
 "  u	dump segment table or SLB\n"
-#endif
-#ifdef CONFIG_PPC_STD_MMU_32
+#elif defined(CONFIG_PPC_STD_MMU_32)
 "  u	dump segment registers\n"
-#endif
-#ifdef CONFIG_44x
+#elif defined(CONFIG_44x) || defined(CONFIG_PPC_BOOK3E)
 "  u	dump TLB\n"
 #endif
 "  ?	help\n"
@@ -885,13 +883,11 @@ cmds(struct pt_regs *excp)
 		case 'u':
 			dump_segments();
 			break;
-#endif
-#ifdef CONFIG_4xx
+#elif defined(CONFIG_4xx)
 		case 'u':
 			dump_tlb_44x();
 			break;
-#endif
-#ifdef CONFIG_PPC_BOOK3E
+#elif defined(CONFIG_PPC_BOOK3E)
 		case 'u':
 			dump_tlb_book3e();
 			break;
-- 
1.7.0.4
