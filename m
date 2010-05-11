Return-Path: <anton@ozlabs.org>
Date: Tue, 11 May 2010 12:25:51 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, mikey@neuling.org, miltonm@bga.com,
	michael@ellerman.id.au, paulus@samba.org
Subject: [PATCH 2/3] powerpc: kdump: CPUs assume the context of the oopsing CPU
Message-ID: <20100511022551.GF12203@kryten>
References: <20100511022329.GE12203@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100511022329.GE12203@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We wrap the crash_shutdown_handles[] calls with longjmp/setjmp, so if any
of them fault we can recover. The problem is we add a hook to the debugger
fault handler hook which calls longjmp unconditionally.

This first part of kdump is run before we marshall the other CPUs, so there
is a very good chance some CPU on the box is going to page fault. And when
it does it hits the longjmp code and assumes the context of the oopsing CPU.
The machine gets very confused when it has 10 CPUs all with the same stack,
all thinking they have the same CPU id. I get even more confused trying
to debug it.

The patch below adds crash_shutdown_cpu and uses it to specify which cpu is
in the protected region. Since it can only be -1 or the oopsing CPU, we don't
need to use memory barriers since it is only valid on the local CPU - no other
CPU will ever see a value that matches it's local CPU id.

Eventually we should switch the order and marshall all CPUs before doing the
crash_shutdown_handles[] calls, but that is a bigger fix.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/crash.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/crash.c	2010-05-10 23:48:35.775954185 +1000
+++ linux-2.6/arch/powerpc/kernel/crash.c	2010-05-11 08:39:14.423453660 +1000
@@ -281,10 +281,12 @@ int crash_shutdown_unregister(crash_shut
 EXPORT_SYMBOL(crash_shutdown_unregister);
 
 static unsigned long crash_shutdown_buf[JMP_BUF_LEN];
+static int crash_shutdown_cpu = -1;
 
 static int handle_fault(struct pt_regs *regs)
 {
-	longjmp(crash_shutdown_buf, 1);
+	if (crash_shutdown_cpu == smp_processor_id())
+		longjmp(crash_shutdown_buf, 1);
 	return 0;
 }
 
@@ -325,6 +327,7 @@ void default_machine_crash_shutdown(stru
 	 */
 	old_handler = __debugger_fault_handler;
 	__debugger_fault_handler = handle_fault;
+	crash_shutdown_cpu = smp_processor_id();
 	for (i = 0; crash_shutdown_handles[i]; i++) {
 		if (setjmp(crash_shutdown_buf) == 0) {
 			/*
@@ -338,6 +341,7 @@ void default_machine_crash_shutdown(stru
 			asm volatile("sync; isync");
 		}
 	}
+	crash_shutdown_cpu = -1;
 	__debugger_fault_handler = old_handler;
 
 	/*
