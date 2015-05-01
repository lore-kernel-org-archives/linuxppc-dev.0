Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2465B1A1A6D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 17:06:02 +1000 (AEST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 1 May 2015 03:06:00 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E35FD38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 03:05:57 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4175v7451970214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 07:05:57 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4175uno027606
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 03:05:56 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [RFC][PATCH 3/4] perf/powerpc: Move mfspr and friends to header file
Date: Fri,  1 May 2015 00:05:40 -0700
Message-Id: <1430463941-26109-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1430463941-26109-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1430463941-26109-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mfspr() and related macros will be needed in two separate files.
Move these defintions to a common header file.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/header.c |    9 +--------
 tools/perf/arch/powerpc/util/header.h |    9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/header.h

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 6c1b8a7..05d3fc8 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -6,14 +6,7 @@
 
 #include "../../util/header.h"
 #include "../../util/util.h"
-
-#define mfspr(rn)       ({unsigned long rval; \
-			 asm volatile("mfspr %0," __stringify(rn) \
-				      : "=r" (rval)); rval; })
-
-#define SPRN_PVR        0x11F	/* Processor Version Register */
-#define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
-#define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
+#include "header.h"
 
 int
 get_cpuid(char *buffer, size_t sz)
diff --git a/tools/perf/arch/powerpc/util/header.h b/tools/perf/arch/powerpc/util/header.h
new file mode 100644
index 0000000..b9d3a0d
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/header.h
@@ -0,0 +1,9 @@
+#include "../../util/util.h"	// __stringify
+
+#define mfspr(rn)       ({unsigned long rval; \
+			 asm volatile("mfspr %0," __stringify(rn) \
+				      : "=r" (rval)); rval; })
+
+#define SPRN_PVR        0x11F   /* Processor Version Register */
+#define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
+#define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
-- 
1.7.9.5
