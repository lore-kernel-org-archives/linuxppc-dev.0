Message-Id: <20010710210004.Postino-030256@smtp01.highway.ne.jp>
Date: Tue, 10 Jul 2001 21:00:04 +0900
To: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Kernel-2.4.7.pre5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I had this problem in linuxppc_2_4 bk tree's linux-2.4.7.pre5.
Is my fix correct ?

Kaoru

------------- fix ---------------
diff -urN base/include/asm-ppc/hardirq.h fixed/include/asm-ppc/hardirq.h
--- base/include/asm-ppc/hardirq.h	Tue Jul 10 14:42:03 2001
+++ fixed/include/asm-ppc/hardirq.h	Tue Jul 10 20:26:26 2001
@@ -20,6 +20,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	unsigned int __last_jiffy_stamp;
+	struct task_struct * __ksoftirqd_task;
 } ____cacheline_aligned irq_cpustat_t;

 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above
*/

--------------------------------
-------- problem -------------
gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/linux/include -Wall -Wstrict-prototypes -
Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -
fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
  -c -o softirq.o softirq.c
softirq.c: In function `wakeup_softirqd':
softirq.c:58: structure has no member named `__ksoftirqd_task'
softirq.c: In function `ksoftirqd':
softirq.c:393: structure has no member named `__ksoftirqd_task'
softirq.c: In function `spawn_ksoftirqd':
softirq.c:420: structure has no member named `__ksoftirqd_task'
make[2]: *** [softirq.o] Error 1
make[2]: Leaving directory `/usr/src/redhat/BUILD/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/linux/kernel'
make: *** [_dir_kernel] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.33988 (%build)
-----------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
