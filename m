Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402JGx2hTWzF16f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 06:16:25 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 David Gibson <david@gibson.dropbear.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Tobin C. Harding" <me@tobin.cc>, Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 3/9] powerpc/64: Use barrier_nospec in syscall entry
Date: Thu, 15 Mar 2018 20:15:52 +0100
Message-Id: <b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc syscall entry is done in assembly so patch in an explicit
barrier_nospec.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/entry_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2cb5109a7ea3..7bfc4cf48af2 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -36,6 +36,7 @@
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
+#include <asm/barrier.h>
 #include <asm/export.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
@@ -159,6 +160,7 @@ system_call:			/* label this so stack traces look sane */
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	.Lsyscall_dotrace		/* does not return */
 	cmpldi	0,r0,NR_syscalls
+	barrier_nospec
 	bge-	.Lsyscall_enosys
 
 .Lsyscall:
@@ -319,6 +321,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r10,TI_FLAGS(r10)
 
 	cmpldi	r0,NR_syscalls
+	barrier_nospec
 	blt+	.Lsyscall
 
 	/* Return code is already in r3 thanks to do_syscall_trace_enter() */
-- 
2.13.6
