From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.denews-innominate.list.sgi.xfs@innominate.de>
Reply-To: Thomas Graichen <graichen@innominate.de>
Subject: SGI XFS on ppc
Date: 31 Jul 2000 00:33:57 GMT
Message-ID: <news2mail-8m2hhl$758$1@mate.bln.innominate.de>
Reply-To: thomas.graichen@innominate.de
To: linuxppc-dev@lists.linuxppc.org, linux-xfs@oss.sgi.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[this mal goes to two mailinglists: the sgi xfs list and the ppc-dev
list because i think i concerns both groups - so keep that in mind
for your replys]

i was a bit curious about how hard/easy it would be to get xfs working
on non intel machines - and this is what i found out about it so far ...

first the results till now:

[root@aqua /root]# uname -a
Linux aqua 2.4.0-test1 #11 Mon Jul 31 01:02:00 CEST 2000 ppc unknown
[root@aqua /root]# cat /proc/filesystems
nodev	shm
nodev	pipefs
nodev	proc
	ext2
	msdos
	vfat
	iso9660
	hfs
nodev	autofs
	xfs
nodev	nfs
nodev	devpts
[root@aqua /root]#

so - i got the kernel compiled with xfs support - it even runs
stable but it hangs on the try to mount and xfs filesystem :-(

ok - now some more details about my tries to get it at least built
and some questions ...

* tried to compile it brute force and looked at the errors
* the typo in arch/ppc/kernel/misc.c was easily fixed
* first thing in the pagebuf code was that at the ppc the local_bh_count
  seems to be defined in softirq.h instead of hardirq.h at the x86 - i
  just added softirq.h to page_buf.c (i think the ppc-dev people
  should have a look at how to fix this in a clean way)
* kernel now compiled fine but did not link due to unclear ifdefs
  for the kallsyms stuff (this should be propagated back to
  whom ever is maintaining the kallsyms stuff)
* kernel still did not link due to missing kernel support for
  some integer functions in the kernel (udivdi3 etc.)
* looks like sgi added support for this to arch/i386/lib via the
  file divdi3.c - so i did for arch/ppc/lib by copying the divdi3.c
  over from the i386 dir and replacing the asm's with the ppc
  asm's from gcc-2.95.2's longlong.h (question to the ppc-dev
  people: is that done correctly or does there some code for
  udiv_qrnnd or sdiv_qrnnd (would result in a simpler udiv_qrnnd
  than the one used) exist ? - for more details look at the
  gcc/longlong.h file)
* kernel linked now!
* building the tools is a problem due to too deep dependencies of
  them currently to the system headers - but sgi people are
  working on it to make them compilable without a lot of problems
  (right ?)
* kernel boots! and runs stable so far
* how to test the xfs filesystem without the tools? - i just made
  a small 32mb xfs filesystem on an x86 and dd'ed to a file which
  you can easily dd onto any partition and mount it as xfs fs there
  (verified to work on x86)
* trying to mount the dd'ed filesystem just hangs the machine - no
  output so far (xfs is compiled with debug and vnode tracing and
  syslog will give *.* to the console) ...

so - what next? - for me to go to bed now (it's half past two over
now :-) but i hope i have delivered enough info for others to jump
onto it and get this thing going - i am happy to test new and other
things if someone from the two camps (sgi or ppc-dev) have an idea
but so far i am at the end of my knowledge here :-(

all the diffs, configs, logs etc. i used for my tests can be found at

  http://innominate.org/~graichen/projects/xfs-ppc/

t

--
thomas.graichen@innominate.de
technical director                                       innominate AG
clustering & security                                networking people
fon: +49.30.308806-13 fax: -77 web: http://innominate.de pgp: /pgp/tgr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
