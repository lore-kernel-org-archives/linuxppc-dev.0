Message-ID: <38871701.291C923B@colorfullife.com>
Date: Thu, 20 Jan 2000 15:09:05 +0100
From: Manfred Spraul <manfreds@colorfullife.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, cort@ppc.kernel.org
Subject: locking updates
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I noticed a few locking problems/improvements in the ppc code:

* arch/ppc/kernel/syscalls.c:

- printk() is SMP safe, the lock_kernel() calls around printk() are
superflous.
- the complete sysv ipc code is smp safe.

- sys_uname(): you should acquire the uts_sem semaphore before accessing
the members of system_utsname [applies to both 2.2 and 2.3].

* arch/ppc/kernel/signal.c:

- do_exit(SIGSEGV) doesn't need lock_kernel().


It's always interesting to compare 2 architectures: I also spotted a bug
in the i386 code ;)

--
	Manfred


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
