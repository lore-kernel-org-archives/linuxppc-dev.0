Message-ID: <3878A857.CA837DD3@denise.shiny.it>
Date: Sun, 09 Jan 2000 16:25:11 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [forward]
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



We have to choose a good value for PROC_TLB_FLUSH_PENALTY.


------------cut---------------------------------------------------------
Subject: 
        sched fixes 2.3.36
   Date: 
        Sat, 8 Jan 2000 17:28:04 +0100 (CET)
   From: 
        Andrea Arcangeli <andrea@suse.de>
     To: 
        Linus Torvalds <torvalds@transmeta.com>
    CC: 
        linux-kernel@vger.rutgers.edu




I spotted some scheduler bug in 2.3.36. I also increased the advantage of
avoiding a TLB flush. I did not benchmarks to check it's better but +1 is
way too low IMHO. Also it make a lots of sense to make it a per-arch thing
as tlb flushes hit changes across different archs (IA32 is probably one of
the most disavantaged without ASN). Now it's a define so every arch can
tune it:

diff -urN 2.3.36/include/asm-alpha/smp.h 2.3.36-sched/include/asm-alpha/smp.h
--- 2.3.36/include/asm-alpha/smp.h      Wed Dec 29 22:55:04 1999
+++ 2.3.36-sched/include/asm-alpha/smp.h        Thu Jan  6 01:37:38 2000
@@ -39,6 +39,7 @@
 extern struct cpuinfo_alpha cpu_data[NR_CPUS];

 #define PROC_CHANGE_PENALTY     20
+#define PROC_TLB_FLUSH_PENALTY  5
 
 /* Map from cpu id to sequential logical cpu number.  This will only
    not be idempotent when cpus failed to come on-line.  */
diff -urN 2.3.36/include/asm-i386/smp.h 2.3.36-sched/include/asm-i386/smp.h
--- 2.3.36/include/asm-i386/smp.h       Fri Dec 31 00:03:32 1999
+++ 2.3.36-sched/include/asm-i386/smp.h Thu Jan  6 00:56:32 2000
@@ -259,7 +259,8 @@
  *     processes are run.
  */
  
-#define PROC_CHANGE_PENALTY    15              /* Schedule penalty */
+#define PROC_CHANGE_PENALTY    15              /* CPU Switch penalty */
+#define PROC_TLB_FLUSH_PENALTY 5               /* TLB flush penalty */
 
 #endif
 #endif
diff -urN 2.3.36/kernel/sched.c 2.3.36-sched/kernel/sched.c
--- 2.3.36/kernel/sched.c       Wed Jan  5 17:42:52 2000
+++ 2.3.36-sched/kernel/sched.c Thu Jan  6 01:35:54 2000
@@ -141,8 +141,8 @@
 #endif
 
        /* .. and a slight advantage to the current MM */
-       if (p->mm == this_mm)
-               weight += 1;
+       if (p->mm == this_mm || !p->mm)
+               weight += PROC_TLB_FLUSH_PENALTY;
        weight += p->priority;
 
 out:
@@ -173,7 +173,7 @@
  */
 static inline int preemption_goodness(struct task_struct * prev, struct
task_struct * p, int cpu)
 {
-       return goodness(p, cpu, prev->mm) - goodness(prev, cpu, prev->mm);
+       return goodness(p, cpu, prev->active_mm) - goodness(prev, cpu,
prev->active_mm);
 }
 
 /*

Andrea
------------cut---------------------------------------------------------



Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
