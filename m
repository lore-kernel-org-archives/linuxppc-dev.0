Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXSgd44wKzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 05:02:37 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 26 Mar 2016 14:02:34 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C27BF38C8046
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 14:02:32 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2QI2W8f23265466
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 18:02:32 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2QI2V3q025370
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 14:02:32 -0400
Date: Sat, 26 Mar 2016 11:01:47 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] perf tools: Fix build break on powerpc
Message-ID: <20160326180146.GA32441@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=46rom 502e8236082412db1d33abfad95aaf14b539502e Mon Sep 17 00:00:00 2001
=46rom: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Sat, 26 Mar 2016 17:31:39 -0400
Subject: [PATCH 1/1] perf tools: Fix build break on powerpc
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

'Commit 531d2410635c ("perf tools: Do not include stringify.h from the
kernel sources")' seems to have accidentially removed the inclusion of
"util/header.h" from "arch/powerpc/util/header.c".

"util/header.h" provides the prototype for get_cpuid() and is needed to
build perf on Powerpc.

	arch/powerpc/util/header.c:17:1: error: no previous prototype for
	=E2=80=98get_cpuid=E2=80=99 [-Werror=3Dmissing-prototypes]

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/header.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerp=
c/util/header.c
index 6138bde..5111e34 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/stringify.h>
+#include "../../util/header.h"
=20
 #define mfspr(rn)       ({unsigned long rval; \
 			 asm volatile("mfspr %0," __stringify(rn) \
--=20
1.8.3.1
