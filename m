Message-ID: <3CE2C260.5070307@mvista.com>
Date: Wed, 15 May 2002 13:17:36 -0700
From: Jun Sun <jsun@mvista.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ralf@oss.sgi.com,
	linux-mips@oss.sgi.com, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] smp sched typo
Content-Type: multipart/mixed;
 boundary="------------000503080306050607030009"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------000503080306050607030009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Linus,

I found this bug in 2.4 kernel. I have verified that the bug exists on MIPS
SMP and PPC SMP, but not on i386 SMP.  See the detailed explanation inside the
patch.

2.5 sched.c has been re-written quite a bit and does not have this problem.


http://linux.junsun.net/patches/generic/submitted/020515-2.4.18-smp-sched-typo.patch

Jun


--------------000503080306050607030009
Content-Type: text/plain;
 name="020515-2.4.18-smp-sched-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="020515-2.4.18-smp-sched-typo.patch"


Gcc will optimizie out the whole 'if' branch on platforms where
cycles_t is not unsigned long long (such as MIPS, PPC).

The symptom for this bug is not fatal - perhaps that is ther reason
why nobody has found it so far.  Higher priority process will be delayed
to start its execution.  One of my tests shows on a heavy-loaded system
the delay is about 5 to 6 jiffies.

Jun, 020515

diff -Nru link/kernel/sched.c.orig link/kernel/sched.c
--- link/kernel/sched.c.orig	Fri Dec 21 09:42:04 2001
+++ link/kernel/sched.c	Wed May 15 12:38:12 2002
@@ -282,7 +282,7 @@
 				target_tsk = tsk;
 			}
 		} else {
-			if (oldest_idle == -1ULL) {
+			if (oldest_idle == (cycles_t)-1) {
 				int prio = preemption_goodness(tsk, p, cpu);

 				if (prio > max_prio) {

--------------000503080306050607030009--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
