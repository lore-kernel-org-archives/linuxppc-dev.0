Date: Thu, 20 Nov 2003 21:12:49 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: insmod ipv6 freezes current linuxppc-2.5 and 2.5-benh
Message-ID: <20031120201249.GB29432@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I was trying to get a recent linuxppc-2.5 (or benh) kernel running on my
G4 Titanium Powerbook IV, and it wouldn't even finish to boot.

After some debugging, I found it was always crashing when sshd started.
That in turn was, because the kernel tried to autoload the ipv6.ko
module for sshd to listen at ::.

booting into single user mode and manually issuing 'insmod ipv6' shows
exactly the same behaviour:  A full freeze, no more cursor at the
console, but still responds to pings from the network.

Firing up xmon seems to reveal it is looping somewhere:

pc is always between (count_relocs+0x34) and (count_relocs+0x40),
backtrace:
(t get_plt_size+0x60)
(T module_frob_arch_sections+0xdc)
(t load_module+0x474)
(t sys_init_module+0x78)
(T ret_from_syscall+0x0)

btw: The system is running a current debian 'testing'.

Is this a known issue? Any ideas?

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
