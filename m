Message-ID: <40771841.8040001@g-house.de>
Date: Fri, 09 Apr 2004 23:40:17 +0200
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: still unable to compile with kgdb enabled
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hi,

happily compiling kernels from 2.5 to 2.6 i finally wanted to give KGDB
a try as suggested often enough. but i fail to do this.

i tried different kernels:

vanilla 2.4.25, results are here:

http://nerdbynature.de/bits/sheep/kgdb/kgdberror_linux-2.4.25.txt

i was looking for a kgdb patch on kgdb.sourceforge.net, but the latest
version there is KGDB 2.0.1-2.0.5, which is for linux-2.6.1 only. on
http://spop.free.fr/kgdb/ i found a kgdb-1.9-for-2.4.25.patch.bz2,
applying cleanly, but still gives me errors and does not compile:

http://nerdbynature.de/bits/sheep/kgdb/kgdberror_linux-2.4.25+kgdb-1.9.txt

2.4.25-ben1 (updated daily via rsync), results are here:
http://nerdbynature.de/bits/sheep/kgdb/kgdberror_linux-2.4.25-ben1.txt

again, i patched with kgdb-1.9-for-2.4.25.patch.bz2, giving me one
reject in kernel/Makefile.rej:


~  obj-$(CONFIG_PM) += pm.o
+ obj-$(CONFIG_KGDB) += kgdbstub.o



results are here:
http://nerdbynature.de/bits/sheep/kgdb/kgdberror_linux-2.4.25-ben1+kgdb-1.9.txt

2.6.5-rc3-ben0 (updated daily via rsync), results are here:
http://nerdbynature.de/bits/sheep/kgdb/kgdberror_linux-2.6.5-rc3-ben0.txt

i was not able to apply the patches from KGDB 2.0.1-2.0.5 nor the
patches from http://www.codemonkey.org.uk/projects/bitkeeper/kgdb/
(lots of rejects...details needed?)

so i my kernels still lack proper kgdb support :-(
any hints?

powerpc-linux-ld -V
GNU ld version 2.14 20030612
~  Supported emulations:
~   elf32ppclinux
~   elf32ppc
~   elf32ppcsim

powerpc-linux-gcc --version
powerpc-linux-gcc (GCC) 3.3.2

(crosscompile toolchain under x86, running debian/unstable)

Thank you,
Christian.
- --
BOFH excuse #258:

That's easy to fix, but I can't be bothered.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
