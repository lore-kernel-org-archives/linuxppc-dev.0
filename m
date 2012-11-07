Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBFC92C00E7
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2012 06:23:11 +1100 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 7 Nov 2012 14:23:05 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5E15838C8041
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2012 14:18:17 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA7JIGD9305760
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2012 14:18:17 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA7JH3ET028909
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2012 12:17:04 -0700
Date: Wed, 7 Nov 2012 11:18:19 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anton Blanchard <anton@au1.ibm.com>, robert.richter@amd.com
Subject: [PATCH 1/4] perf/powerpc: Use uapi/unistd.h to fix build error
Message-ID: <20121107191818.GA16211@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>From b8beef080260c1625c8f801105504a82005295e5 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2012 11:21:28 -0700
Subject: [PATCH 1/4] perf/powerpc: Use uapi/unistd.h to fix build error

Use the 'unistd.h' from arch/powerpc/include/uapi to build the perf tool.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/perf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 054182e..f4952da 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -26,7 +26,7 @@ void get_term_dimensions(struct winsize *ws);
 #endif
 
 #ifdef __powerpc__
-#include "../../arch/powerpc/include/asm/unistd.h"
+#include "../../arch/powerpc/include/uapi/asm/unistd.h"
 #define rmb()		asm volatile ("sync" ::: "memory")
 #define cpu_relax()	asm volatile ("" ::: "memory");
 #define CPUINFO_PROC	"cpu"
-- 
1.7.1
