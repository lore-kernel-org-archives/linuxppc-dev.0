Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A17A8DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 23:08:38 +1100 (EST)
Date: Fri, 27 Mar 2009 23:08:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: linux-next: tracing/powerpc tree build failure
Message-Id: <20090327230834.93d0221d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Steven Rostedt <srostedt@redhat.com>, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next build (powerpc allyesconfig) failed like this:

arch/powerpc/kernel/ftrace.c: In function 'prepare_ftrace_return':
arch/powerpc/kernel/ftrace.c:612: warning: passing argument 3 of 'ftrace_push_return_trace' makes pointer from integer without a cast
arch/powerpc/kernel/ftrace.c:612: error: too many arguments to function 'ftrace_push_return_trace'

Caused by commit 5d1a03dc541dc6672e60e57249ed22f40654ca47
("function-graph: moved the timestamp from arch to generic code") from
the tracing tree which (removed an argument from
ftrace_push_return_trace()) interacting with commit
6794c78243bfda020ab184d6d578944f8e90d26c ("powerpc64: port of the
function graph tracer") from the powerpc tree.

I added the following patch and can carry it as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 27 Mar 2009 22:47:58 +1100
Subject: [PATCH] tracing: fixup for ftrace_push_return_trace API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/ftrace.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 5b5d16b..5455943 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -557,7 +557,6 @@ extern void mod_return_to_handler(void);
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 {
 	unsigned long old;
-	unsigned long long calltime;
 	int faulted;
 	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
@@ -606,10 +605,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 		return;
 	}
 
-	calltime = cpu_clock(raw_smp_processor_id());
-
-	if (ftrace_push_return_trace(old, calltime,
-				self_addr, &trace.depth) == -EBUSY) {
+	if (ftrace_push_return_trace(old, self_addr, &trace.depth) == -EBUSY) {
 		*parent = old;
 		return;
 	}
-- 
1.6.2.1
