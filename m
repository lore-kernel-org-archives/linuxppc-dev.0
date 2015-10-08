Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 007651A0133
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 11:51:26 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BDC81140D89
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 11:51:26 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 8 Oct 2015 10:51:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A93D3357804F
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 11:51:23 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t980pA7S21233896
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 11:51:19 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t980ooQi030836
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 11:50:51 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: khandual@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH v3 2/2] powerpc/xmon: Paginate kernel log buffer display
Date: Thu,  8 Oct 2015 11:50:24 +1100
Message-Id: <aa70d3c5f38c2e4fa7be78bb926f0aa5e1b8bbcb.1444265419.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
References: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
References: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
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
 arch/powerpc/xmon/xmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index cc070c3..8ba8ea7 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -242,9 +242,7 @@ Commands:\n\
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
@@ -2333,10 +2331,12 @@ dump_log_buf(void)
 	sync();
 
 	kmsg_dump_rewind_nolock(&dumper);
+	xmon_start_pagination();
 	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
 		buf[len] = '\0';
 		printf("%s", buf);
 	}
+	xmon_end_pagination();
 
 	sync();
 	/* wait a little while to see if we get a machine check */
-- 
2.1.4
