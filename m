Return-Path: <BATV+d275b2856bf31ae0a7e0+3447+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 659B52C0040
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2013 01:47:25 +1100 (EST)
From: Arnaldo Carvalho de Melo <acme@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 16/21] perf tools,
 powerpc: Fix compile warnings in tests/attr.c
Date: Wed, 30 Jan 2013 11:46:57 -0300
Message-Id: <1359557222-17547-17-git-send-email-acme@infradead.org>
In-Reply-To: <1359557222-17547-1-git-send-email-acme@infradead.org>
References: <1359557222-17547-1-git-send-email-acme@infradead.org>
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linuxppc-dev@ozlabs.org,
 Michael Ellerman <ellerman@au1.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

We print several '__u64' quantities using '%llu'. On powerpc, we by
default include '<asm-generic/int-l64.h> which results in __u64 being an
unsigned long. This causes compile warnings which are treated as errors
due to '-Werror'.

By defining __SANE_USERSPACE_TYPES__ we include <asm-generic/int-ll64.h>
and define __u64 as unsigned long long.

Changelog[v2]:
	[Michael Ellerman] Use __SANE_USERSPACE_TYPES__ and avoid PRIu64
	format specifier - which as Jiri Olsa pointed out, breaks on x86-64.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <ellerman@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Link: http://lkml.kernel.org/r/20130124054439.GA31588@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.c | 5 +++++
 1 file changed, 5 insertions(+)

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
1.8.1.1.361.gec3ae6e
