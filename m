Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts40-srv.bellnexxia.net (tomts40.bellnexxia.net
	[209.226.175.97]) by ozlabs.org (Postfix) with ESMTP id 05548DDEDD
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 19:23:05 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.240.144])
	by tomts40-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070310082303.YALE1624.tomts40-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 03:23:03 -0500
Date: Sat, 10 Mar 2007 03:23:03 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: akpm@linux-foundation.org, mbligh@google.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] Fix atomicity of TIF update in flush_thread() for powerpc
Message-ID: <20070310082303.GD23144@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix atomicity of TIF update in flush_thread() for powerpc

Fixes it correctly with *_ti_thread_flag.

Race :

parent process executing :
sys_ptrace()
 (lock_kernel())
 (ptrace_get_task_struct(pid))
 arch_ptrace()
   ptrace_detach()
     ptrace_disable(child);
       clear_singlestep(child);
         clear_tsk_thread_flag(child, TIF_SINGLESTEP);
         (which clears the TIF_SINGLESTEP flag atomically from a different
          process)
 (put_task_struct(child))
 (unlock_kernel())

And at the same time, in the child process :
sys_execve()
 do_execve()
   search_binary_handler()
     load_elf_binary()
       flush_old_exec()
         flush_thread()
           doing a non-atomic thread flag update

Applies on 2.6.20.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -476,8 +476,13 @@ void flush_thread(void)
 #ifdef CONFIG_PPC64
 	struct thread_info *t = current_thread_info();
 
-	if (t->flags & _TIF_ABI_PENDING)
-		t->flags ^= (_TIF_ABI_PENDING | _TIF_32BIT);
+	if (test_ti_thread_flag(t, TIF_ABI_PENDING)) {
+		clear_ti_thread_flag(t, TIF_ABI_PENDING);
+		if (test_ti_thread_flag(t, TIF_32BIT))
+			clear_ti_thread_flag(t, TIF_32BIT);
+		else
+			set_ti_thread_flag(t, TIF_32BIT);
+	}
 #endif
 
 	discard_lazy_cpu_state();
-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
