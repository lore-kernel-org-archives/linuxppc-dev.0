Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 30979140180
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 12:08:50 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 12:08:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5BEE12BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 12:08:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s451lUie7340294
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:47:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4528jft024956
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 12:08:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/eeh: Fix build error for celleb
Date: Mon,  5 May 2014 12:09:05 +1000
Message-Id: <1399255745-2745-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 7f52a526f ("powerpc/eeh: Allow to disable EEH") caused
following build error with "celleb_defconfig" as being catched
by Mikey on linux-next.

arch/powerpc/kernel/eeh.c: In function 'eeh_init_proc':
arch/powerpc/kernel/eeh.c:1173:37: error: 'powerpc_debugfs_root' \
undeclared (first use in this function)
arch/powerpc/kernel/eeh.c:1173:37: note: each undeclared identifier \
is reported only once for each function it appears in

Reported-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 33d683a..9c6b899 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 
 #include <linux/atomic.h>
+#include <asm/debug.h>
 #include <asm/eeh.h>
 #include <asm/eeh_event.h>
 #include <asm/io.h>
-- 
1.8.3.2
