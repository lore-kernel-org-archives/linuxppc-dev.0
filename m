Date: Wed, 10 Mar 2004 16:49:01 +0000
From: errandir_news@mph.eclipse.co.uk
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel oops with realtime LSM + qjackctl
Message-ID: <20040310164900.GA884@palantir7.mph.eclipse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm running the 2.6.3 kernel (rsync from source.mvista.com::linuxppc-2.5)
with the realtime capabilities module (http://www.joq.us/realtime/realtime-0.0.3.tar.gz)
The realtime module needs the small patch attached to work. To load the module:

# modprobe realtime gid=29 allcapps=1

After that I start JACK (Jack Audio Connection Kit, an audio server) using:
$ qjackctl &
-> Start JACK

When I start using the machine I get the oops below within 10 or 15 seconds. After that
commands like 'ps -a' or lsof hang. poweroff/reboot sometimes hangs as well.
Other audio users run similar configurations without getting the oops, but my guess is they
don't run on a PPC.
I've tried adding 'mlock=0' to the modprobe, running everyting as root. The only thing
that works is if I use jackstart in stead of qjackctl to run JACK. So the oops is probably
cause by something in qjackctl, but what?

I'm no expert at this, but my guess is that:
- One thread exits with a stack dump
- During cleanup of another thread the oops is generated

Is it because the first thead still holds a spinlock that the 2nd thread wants? From
get_user_pages:
                spin_lock(&mm->page_table_lock);
                do {
		        struct page *map;
                        int lookup_write = write;
	                while (!(map = follow_page(mm, start, lookup_write))) {
                                spin_unlock(&mm->page_table_lock);

The first thread exits inside follow_page(), so spin_unlock() is never called (is it?).
If so, what can be done? Any hints/tips welcome!

Martin

-----
processor	: 0
cpu		: 7455, altivec supported
clock		: 800MHz
revision	: 2.1 (pvr 8001 0201)
bogomips	: 798.32
machine		: PowerBook3,4
motherboard	: PowerBook3,4 MacRISC2 MacRISC Power Macintosh
detected as	: 73 (PowerBook Titanium III)
pmac flags	: 0000000b
L2 cache	: 256K unified
memory		: 512MB
pmac-generation	: NewWorld


----- Oops -----
Mar 10 13:18:43 palantir7 kernel: Oops: kernel access of bad area, sig: 11 [#1]
Mar 10 13:18:43 palantir7 kernel: PREEMPT
Mar 10 13:18:43 palantir7 kernel: NIP: C004BD10 LR: C004BC84 SP: DBC67E30 REGS: dbc67d80 TRAP: 0301    Not tainted
Mar 10 13:18:43 palantir7 kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Mar 10 13:18:43 palantir7 kernel: DAR: A5A5A5D9, DSISR: 40000000
Mar 10 13:18:43 palantir7 kernel: TASK = dc2c2000[711] 'qjackctl' Last syscall: 152
Mar 10 13:18:43 palantir7 kernel: GPR00: A5A5A5A5 DBC67E30 DC2C2000 C21C0000 DC486000 00000001 00002000 00000001
Mar 10 13:18:43 palantir7 kernel: GPR08: 00000000 A5A5A5A5 00000000 00000000 22004424
Mar 10 13:18:43 palantir7 kernel: Call trace:
Mar 10 13:18:43 palantir7 kernel:  [c004bf20] get_user_pages+0xcc/0x3d8
Mar 10 13:18:43 palantir7 kernel:  [c004f1b8] make_pages_present+0x7c/0xa8
Mar 10 13:18:43 palantir7 kernel:  [c004f858] mlock_fixup+0xf4/0x110
Mar 10 13:18:43 palantir7 kernel:  [c004fbc0] do_mlockall+0x80/0xb0
Mar 10 13:18:43 palantir7 kernel:  [c004fcac] sys_mlockall+0xbc/0xcc
Mar 10 13:18:43 palantir7 kernel:  [c0007bcc] ret_from_syscall+0x0/0x4c
Mar 10 13:18:43 palantir7 kernel: note: qjackctl[711] exited with preempt_count 1
Mar 10 13:18:43 palantir7 kernel: Call trace:
Mar 10 13:18:43 palantir7 kernel:  [c000ba88] dump_stack+0x18/0x28
Mar 10 13:18:43 palantir7 kernel:  [c0019cbc] schedule+0x81c/0x820
Mar 10 13:18:43 palantir7 kernel:  [c00d5a4c] rwsem_down_read_failed+0xec/0x1e8
Mar 10 13:18:43 palantir7 kernel:  [c0021484] do_exit+0x544/0x584
Mar 10 13:18:43 palantir7 kernel:  [c0008614] die+0xd8/0xe0
Mar 10 13:18:43 palantir7 kernel:  [c0013044] bad_page_fault+0x5c/0x60
Mar 10 13:18:43 palantir7 kernel:  [c0012ca0] do_page_fault+0x70/0x3b8
Mar 10 13:18:43 palantir7 kernel:  [c00081d8] ret_from_except+0x0/0x1c
Mar 10 13:18:43 palantir7 kernel:  [c004bd10] follow_page+0xf8/0x23c
Mar 10 13:18:43 palantir7 kernel:  [c004bf20] get_user_pages+0xcc/0x3d8
Mar 10 13:18:43 palantir7 kernel:  [c004f1b8] make_pages_present+0x7c/0xa8
Mar 10 13:18:43 palantir7 kernel:  [c004f858] mlock_fixup+0xf4/0x110
Mar 10 13:18:43 palantir7 kernel:  [c004fbc0] do_mlockall+0x80/0xb0
Mar 10 13:18:43 palantir7 kernel:  [c004fcac] sys_mlockall+0xbc/0xcc
Mar 10 13:18:43 palantir7 kernel:  [c0007bcc] ret_from_syscall+0x0/0x4c

----- realcap.diff -----
--- realcap.orig	2004-03-10 12:12:51.000000000 +0000
+++ realcap.c	2004-03-10 12:42:51.000000000 +0000
@@ -72,12 +72,14 @@
 		    (gid != current->gid)) {
 			int i;
 			rt_ok = 0;
-			for (i = 0; i < NGROUPS; ++i) {
-				if (gid == current->groups[i]) {
+			get_group_info(current->group_info);
+			for (i = 0; i < current->group_info->ngroups; ++i) {
+				if (gid == GROUP_AT(current->group_info, i)) {
 					rt_ok = 1;
 					break;
 				}
 			}
+			put_group_info(current->group_info);
 		}

 		if (rt_ok)  {


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
