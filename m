Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A666D2C0080
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2013 16:44:44 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 23 Jan 2013 22:44:42 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id CCA633E40039
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 22:44:32 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0O5id72284612
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 22:44:39 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0O5icr6015192
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 22:44:38 -0700
Date: Wed, 23 Jan 2013 21:44:39 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH][v2] perf tools, powerpc: Fix compile warnings in tests/attr.c
Message-ID: <20130124054439.GA31588@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com,
 Anton Blanchard <anton@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[PATCH][v2] perf tools, powerpc: Fix compile warnings in tests/attr.c

We print several '__u64' quantities using '%llu'. On powerpc, we by
default include '<asm-generic/int-l64.h> which results in __u64 being
an unsigned long. This causes compile warnings which are treated as
errors due to '-Werror'.

By defining __SANE_USERSPACE_TYPES__ we include <asm-generic/int-ll64.h>
and define __u64 as unsigned long long.

Changelog[v2]:
	[Michael Ellerman] Use __SANE_USERSPACE_TYPES__ and avoid PRIu64
	format specifier - which as Jiri Olsa pointed out, breaks on x86-64.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/tests/attr.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index f61dd3f..bdcceb8 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -19,6 +19,11 @@
  * permissions. All the event text files are stored there.
  */
 
+/*
+ * Powerpc needs __SANE_USERSPACE_TYPES__ before <linux/types.h> to select
+ * 'int-ll64.h' and avoid compile warnings when printing __u64 with %llu.
+ */
+#define __SANE_USERSPACE_TYPES__
 #include <stdlib.h>
 #include <stdio.h>
 #include <inttypes.h>
-- 
1.7.1
