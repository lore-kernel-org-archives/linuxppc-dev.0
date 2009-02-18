Return-Path: <pochini@shiny.it>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by ozlabs.org (Postfix) with ESMTP id F022CDDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 08:25:26 +1100 (EST)
Date: Wed, 18 Feb 2009 22:18:21 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: CPU hotplug /sys entries are missing on 2.6.28
Message-Id: <20090218221821.ca5d29eb.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

/sys/devices/system/cpu/cpu*/online don't exist anymore.

When the kernel is booted with maxcpus=1 /sys/devices/system/cpu/cpu1 is
also missing:

$ ls -la /sys/devices/system/cpu/
totale 0
drwxr-xr-x 3 root root    0  9 feb 23:15 .
drwxr-xr-x 7 root root    0  9 feb 23:15 ..
drwxr-xr-x 4 root root    0  9 feb 23:15 cpu0
-r--r--r-- 1 root root 4096  9 feb 23:15 online
-r--r--r-- 1 root root 4096  9 feb 23:15 possible
-r--r--r-- 1 root root 4096  9 feb 23:15 present
$ cat /sys/devices/system/cpu/online
0
$ cat /sys/devices/system/cpu/possible
0-1
$ cat /sys/devices/system/cpu/present
0-1
$ uname -a
Linux Jay 2.6.28 #1 SMP Sun Jan 11 22:42:31 CET 2009 ppc 7455, altivec supported PowerMac3,6 GNU/Linux


Looking at the 2.6.28 diff, i noticed there is a patch to
setup_32.c::ppc_init() that removes the following:

	for_each_possible_cpu(cpu) {
		struct cpu *c = &per_cpu(cpu_devices, cpu);
		c->hotpluggable = 1;
		register_cpu(c, cpu);
	}

Reverting it makes the kernel hang at boot.
The only other place where ->hotpluggable is set is in
sysfs.c::topology_init(), but it only happens if ppc_md.cpu_die!=NULL and I
couldn't find where that pointer is set. Any clue ?
TIA,


--
Giuliano.
