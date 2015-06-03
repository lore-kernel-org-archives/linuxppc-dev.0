Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB6301A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 23:22:17 +1000 (AEST)
Date: Wed, 3 Jun 2015 15:22:14 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ppc64 ftrace recursion protection
Message-ID: <20150603132214.GE19424@lst.de>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
 <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
 <1432006027.8339.3.camel@ellerman.id.au>
 <alpine.LNX.2.00.1505191150420.8186@pobox.suse.cz>
 <20150603130257.GA19424@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150603130257.GA19424@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As suggested by You and Jikos, a flag in task_struct's trace_recursion
is used to block a tracer function to recurse into itself, especially
on a data access fault. This should catch all functions called by the
fault handlers which are not yet attributed notrace.

Signed-off-by: Torsten Duwe <duwe@suse.de>

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
+	bne	3f		// ftrace in progress - avoid recursion!
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
