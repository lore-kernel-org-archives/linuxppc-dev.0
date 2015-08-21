Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEA841A022F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 14:25:35 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A057C140AF3
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:25:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 21 Aug 2015 14:25:32 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8F2F62BB0052
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:25:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7L4PEJa49479878
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:25:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7L4OuH9006661
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2015 14:24:56 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, khandual@linux.vnet.ibm.com
Subject: [PATCH v2 2/2] powerpc/xmon: Paginate kernel log buffer display
Date: Fri, 21 Aug 2015 14:24:28 +1000
Message-Id: <b2566bb9759662fbbc8dd8718c59fcefdb4df3b0.1440131027.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1440131027.git.sam.bobroff@au1.ibm.com>
References: <cover.1440131027.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1440131027.git.sam.bobroff@au1.ibm.com>
References: <cover.1440131027.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel log buffer is often much longer than the size of a terminal
so paginate it's output.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9ce9e7d..fdd765e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -248,9 +248,7 @@ Commands:\n\
 "  u	dump TLB\n"
 #endif
 "  ?	help\n"
-#ifdef CONFIG_PPC64
-"  .#	limit output to # lines per page (dump paca only)\n"
-#endif
+"  .#	limit output to # lines per page (for dp#, dpa, dl)\n"
 "  zr	reboot\n\
   zh	halt\n"
 ;
@@ -850,6 +848,7 @@ static void paged_set_size(void)
 		paged_size = 0;
 	}
 }
+
 static void paged_reset(void)
 {
 	paged_cur_page = 0;
@@ -2372,10 +2371,12 @@ dump_log_buf(void)
 	sync();
 
 	kmsg_dump_rewind_nolock(&dumper);
+	paged_start();
 	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
 		buf[len] = '\0';
-		printf("%s", buf);
+		XMON_PRINTF("%s", buf);
 	}
+	paged_end("dl\n");
 
 	sync();
 	/* wait a little while to see if we get a machine check */
-- 
2.1.4
