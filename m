Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlcyj4CjlzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 22:54:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/5] powerpc/xmon: Move static regno into its only user
Date: Thu,  7 Jul 2016 22:54:27 +1000
Message-Id: <1467896070-15167-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1467896070-15167-1-git-send-email-mpe@ellerman.id.au>
References: <1467896070-15167-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index f351ba6a58ab..369501283994 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1682,7 +1682,6 @@ write_spr(int n, unsigned long val)
 	catch_spr_faults = 0;
 }
 
-static unsigned long regno;
 
 static void dump_one_spr(int spr, bool show_unimplemented)
 {
@@ -1714,6 +1713,7 @@ static void dump_one_spr(int spr, bool show_unimplemented)
 
 static void super_regs(void)
 {
+	static unsigned long regno;
 	int cmd;
 	int spr;
 
-- 
2.7.4
