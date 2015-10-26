Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDDF51A0D17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 04:58:47 +1100 (AEDT)
Date: Mon, 26 Oct 2015 18:58:44 +0100
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [PATCH v3 4/8] ppc64 ftrace_with_regs: spare early boot and low level
Message-ID: <20151026175844.GE29592@lst.de>
References: <20151026174930.GA29592@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151026174930.GA29592@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using -mprofile-kernel on early boot code not only confuses the
checker but is also useless, as the infrastructure is not yet in
place. Proceed like with -pg (remove it from CFLAGS), equally with
time.o and ftrace itself.

  * arch/powerpc/kernel/Makefile:
    - remove -mprofile-kernel from low level and boot code objects'
      CFLAGS for FUNCTION_TRACER configurations.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/kernel/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ba33693..0f417d5 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -16,14 +16,14 @@ endif
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog -mprofile-kernel
 # do not trace tracer code
-CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog -mprofile-kernel
 # timers used by tracing
-CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog -mprofile-kernel
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
-- 
1.8.5.6
