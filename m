Return-Path: <SRS0=7aBp=2I=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX76M1XgszDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 03:52:10 +1100 (AEDT)
Date: Mon, 27 Feb 2017 11:52:04 -0500
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3.5/5] trace/kprobes: Add back warning about offset in
 return probes
Message-ID: <20170227115204.00f92846@gandalf.local.home>
In-Reply-To: <20170227113252.05e9c0df@gandalf.local.home>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <183e7ce2921a08c9c755ee9a5da3134febc6695b.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170227113252.05e9c0df@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Let's not remove the warning about offsets and return probes when the
offset is invalid.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3f4f788..f626235 100644
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
 
