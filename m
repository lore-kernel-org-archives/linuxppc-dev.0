Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 6F74EDE0E1
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 00:33:56 +1000 (EST)
Date: Fri, 15 May 2009 10:33:54 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/ftrace: fix constraint to be early clobber
Message-ID: <alpine.DEB.2.00.0905141236420.30591@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


After upgrading my distcc boxes from gcc 4.2.2 to 4.4.0, the function 
graph tracer broke. This was discovered on my x86 boxes.

The issue is that gcc used the same register for an output as it did for 
an input in an asm statement. I first thought this was a bug in gcc and 
reported it. I was notified that gcc was correct and that the output had 
to be flagged as an "early clobber".

I noticed that powerpc had the same issue and this patch fixes it.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 70e2a73..68fd74e 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -594,7 +594,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 			PPC_LONG "2b,4b\n"
 		".previous"
 
-		: [old] "=r" (old), [faulted] "=r" (faulted)
+		: [old] "=&r" (old), [faulted] "=r" (faulted)
 		: [parent] "r" (parent), [return_hooker] "r" (return_hooker)
 		: "memory"
 	);
