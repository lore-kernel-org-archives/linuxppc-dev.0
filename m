Return-Path: <BATV+f4a4347667329d2fa7ab+4867+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjkfF4j0qzDwTb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 04:04:21 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Chris Riyder <chris.ryder@arm.com>, Kim Phillips <kim.phillips@arm.com>,
 Markus Trippelsdorf <markus@trippelsdorf.de>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Taeung Song <treeze.taeung@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/29] perf annotate: Support jump instruction with target as
 second operand
Date: Tue, 20 Dec 2016 14:03:43 -0300
Message-Id: <20161220170358.4350-15-acme@kernel.org>
In-Reply-To: <20161220170358.4350-1-acme@kernel.org>
References: <20161220170358.4350-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Architectures like PowerPC have jump instructions that includes a target
address as a second operand. For example, 'bne cr7,0xc0000000000f6154'.
Add support for such instruction in perf annotate.

objdump o/p:
  c0000000000f6140:   ld     r9,1032(r31)
  c0000000000f6144:   cmpdi  cr7,r9,0
  c0000000000f6148:   bne    cr7,0xc0000000000f6154
  c0000000000f614c:   ld     r9,2312(r30)
  c0000000000f6150:   std    r9,1032(r31)
  c0000000000f6154:   ld     r9,88(r31)

Corresponding perf annotate o/p:

Before patch:
         ld     r9,1032(r31)
         cmpdi  cr7,r9,0
      v  bne    3ffffffffff09f2c
         ld     r9,2312(r30)
         std    r9,1032(r31)
  74:    ld     r9,88(r31)

After patch:
         ld     r9,1032(r31)
         cmpdi  cr7,r9,0
      v  bne    74
         ld     r9,2312(r30)
         std    r9,1032(r31)
  74:    ld     r9,88(r31)

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Chris Riyder <chris.ryder@arm.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1480953407-7605-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ea7e0de4b9c1..590244e5781e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -223,8 +223,12 @@ bool ins__is_call(const struct ins *ins)
 static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map *map __maybe_unused)
 {
 	const char *s = strchr(ops->raw, '+');
+	const char *c = strchr(ops->raw, ',');
 
-	ops->target.addr = strtoull(ops->raw, NULL, 16);
+	if (c++ != NULL)
+		ops->target.addr = strtoull(c, NULL, 16);
+	else
+		ops->target.addr = strtoull(ops->raw, NULL, 16);
 
 	if (s++ != NULL)
 		ops->target.offset = strtoull(s, NULL, 16);
-- 
2.9.3
