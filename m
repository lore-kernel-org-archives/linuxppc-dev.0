Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E8631A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 18:18:37 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 14 Aug 2014 18:18:34 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AD62C2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 18:18:31 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7E8JBwI11403350
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 18:19:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7E8IUtw020140
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 18:18:30 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.or
Subject: [PATCH] tools/perf/powerpc: Fix build break
Date: Thu, 14 Aug 2014 13:48:19 +0530
Message-Id: <1408004299-18986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  CC       arch/powerpc/util/skip-callchain-idx.o
arch/powerpc/util/skip-callchain-idx.c: In function ‘check_return_reg’:
arch/powerpc/util/skip-callchain-idx.c:55:3: error: implicit declaration of function ‘pr_debug’ [-Werror=implicit-function-declaration]
   pr_debug("dwarf_frame_register() %s\n", dwarf_errmsg(-1));

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index a7c23a4b3778..d73ef8bb08c7 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -15,6 +15,7 @@
 
 #include "util/thread.h"
 #include "util/callchain.h"
+#include "util/debug.h"
 
 /*
  * When saving the callchain on Power, the kernel conservatively saves
-- 
1.9.1
