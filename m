Message-Id: <200009122018.WAA00786@piglet.grunz.lu>
Date: Tue, 12 Sep 2000 22:18:48 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: zeroing pages in the idle task?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've come across a 'forgotten' feature of the PPC kernels: namely
zeroing pages 'in advance' in the idle task.

It's a feature Cort implemented some time ago, but which is disabled by
default. I've tried to enable it:

[root@piglet ~]# echo 1 > /proc/sys/kernel/zero-paged

and it seems to work OK:

(this is after system boot, no apps started yet except 3 xterms)

[mlan@piglet ~]$ cat /proc/cpuinfo
processor       : 0
cpu             : 750
temperature     : 0 C
clock           : 195MHz
                  ^^^^^^
(by the way, this is wrong. Anybody with a fix?)

revision        : 2.2
bogomips        : 575.08
zero pages      : total 264 (1056Kb) current: 96 (384Kb) hits: 168/255 (65%)
machine         : Power Macintosh
motherboard     : AAPL,7500 MacRISC
memory          : 112MB
pmac-generation : OldWorld

So, a few questions:

- is there any problem with using this feature?

- if not, would it be a good idea to enable it by default?

- or, would it be better to add it to rc.sysinit, leaving it to each
  distribution whether to enable it or not?

I've not benchmarked anything (how would one do that?); but it seems to
me it's a no-cost optimisation. Even if there's little advantage, since
it's for free...

Comments?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
