Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA14B1A0FF6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 20:03:06 +1000 (AEST)
Date: Thu, 11 Jun 2015 12:03:03 +0200
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ppc64 ftrace_with_regs recursion protection
Message-ID: <20150611100303.GE4492@lst.de>
References: <20150611095338.GA4492@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150611095338.GA4492@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an *emergency* parachute to avoid an endless recursion and
consecutively a kernel stack overflow, should any function within some
ftrace framework cause an access fault, which calls _mcount / ftrace_caller
in return and so on. It might also call an ftrace'd function directly.

As Michael Ellerman pointed out, it is a tedious and error-prone task
to maintain a complete list of those functions that _might_ get called
from *_access_fault or any dynamic tracer function. So we'll
concentrate on the most frequent cases to enhance performance later,
while for now sticking with this fill-in. It will later serve as a backup
protection.

  * arch/powerpc/kernel/entry_64.S:
    - test-and-set TRACE_FTRACE_BIT in task_struct's trace_recursion,
      do not call the actual tracer function if set, clear flag on return.

Signed-off-by: Torsten Duwe <duwe@suse.de>
--
 arch/powerpc/kernel/asm-offsets.c |    1 +
 arch/powerpc/kernel/entry_64.S    |   15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)
--
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4717859..ae10752 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -72,6 +72,7 @@ int main(void)
 	DEFINE(THREAD, offsetof(struct task_struct, thread));
 	DEFINE(MM, offsetof(struct task_struct, mm));
 	DEFINE(MMCONTEXTID, offsetof(struct mm_struct, context.id));
+	DEFINE(TASK_TRACEREC, offsetof(struct task_struct, trace_recursion));
 #ifdef CONFIG_PPC64
 	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
 	DEFINE(SIGSEGV, SIGSEGV);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index a4132ef..4768104 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1202,7 +1202,13 @@ _GLOBAL(ftrace_caller)
 	SAVE_8GPRS(16,r1)
 	SAVE_8GPRS(24,r1)
 
-
+	ld	r3, PACACURRENT(r13)
+	ld	r4, TASK_TRACEREC(r3)
+	andi.	r5, r4, 0x0010 // ( 1 << TRACE_FTRACE_BIT )
+	ori	r4, r4, 0x0010
+	std	r4, TASK_TRACEREC(r3)
+	bne-	3f		// ftrace in progress - avoid recursion!
+	
 	LOAD_REG_IMMEDIATE(r3,function_trace_op)
 	ld	r5,0(r3)
 
@@ -1224,9 +1230,14 @@ ftrace_call:
 	bl	ftrace_stub
 	nop
 
+	ld	r3, PACACURRENT(r13)
+	ld	r4, TASK_TRACEREC(r3)
+	andi.	r4, r4, 0xffef // ~( 1 << TRACE_FTRACE_BIT )
+	std	r4, TASK_TRACEREC(r3)
+
 	ld	r3, _NIP(r1)
 	mtlr	r3
-
+3:
 	REST_8GPRS(0,r1)
 	REST_8GPRS(8,r1)
 	REST_8GPRS(16,r1)
