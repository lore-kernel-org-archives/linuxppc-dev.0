Return-Path: <BATV+66b78c8ded87d72a509b+4943+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcVTQ3Pw3zDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 06:38:50 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/35] trace/kprobes: Add back warning about offset in return
 probes
Date: Mon,  6 Mar 2017 16:38:19 -0300
Message-Id: <20170306193825.24011-30-acme@kernel.org>
In-Reply-To: <20170306193825.24011-1-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Let's not remove the warning about offsets and return probes when the
offset is invalid.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170227115204.00f92846@gandalf.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/trace/trace_kprobe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 18775ef182f8..2b7d0dd938ba 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -695,6 +695,11 @@ static int create_trace_kprobe(int argc, char **argv)
 			pr_info("Failed to parse symbol.\n");
 			return ret;
 		}
+		if (offset && is_return &&
+		    !arch_function_offset_within_entry(offset)) {
+			pr_info("Given offset is not valid for return probe.\n");
+			return -EINVAL;
+		}
 	}
 	argc -= 2; argv += 2;
 
-- 
2.9.3
