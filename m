Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4CD1A104E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 00:35:03 +1000 (AEST)
Date: Tue, 26 May 2015 16:34:59 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64 ftrace: mark data_access callees "notrace" (pt.1)
Message-ID: <20150526143459.GA24656@lst.de>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
 <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
 <1432006027.8339.3.camel@ellerman.id.au> <20150520090325.GA11577@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150520090325.GA11577@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 20, 2015 at 11:03:25AM +0200, Torsten Duwe wrote:
> On Tue, May 19, 2015 at 01:27:07PM +1000, Michael Ellerman wrote:
> > On Mon, 2015-05-18 at 14:29 +0200, Jiri Kosina wrote:
> > > 
> > > ftrace already handles recursion protection by itself (depending on the 
> > > per-ftrace-ops FTRACE_OPS_FL_RECURSION_SAFE flag).
> > 
> > OK, so I wonder why that's not working for us?
> 
> IIRC a data access fault happens just before that flag is looked at ;-)
> 
> I'm now thinking about a hybrid solution: mark the most critical functions
> "notrace", especially those directly involved with MMU loading, and add
> a per-thread flag to catch the not-so-obvious cases.

I realised the trace_recursion in the "current" task struct is not so far away,
and it should not fault, right? So that part of the solution would look like this
on top of my previous ftrace patch set.
It would impact performance further so I'd stick with the "notrace" on
certain hot functions, like hash_page. What do you think?

	Torsten

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
index a4132ef..7842092 100644
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
+	andi	r4, r4, 0xffef // ~( 1 << TRACE_FTRACE_BIT )
+	std	r4, TASK_TRACEREC(r3)
+
 	ld	r3, _NIP(r1)
 	mtlr	r3
-
+3:
 	REST_8GPRS(0,r1)
 	REST_8GPRS(8,r1)
 	REST_8GPRS(16,r1)
