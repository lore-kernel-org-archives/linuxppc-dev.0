Message-ID: <39625545.370FE91F@ne.mediaone.net>
Date: Tue, 04 Jul 2000 17:21:09 -0400
From: mark phillips <msss@ne.mediaone.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems with HardHat/NFS root filesystems
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all, great list!

I've been working with HardHat Linux on an Embedded Planet CLLF board
(mpc860T processor).  Initial progress was great, but I've run into a
dead end.
I have been able to run the mbxroot.min filesystem (both on NFS and as
an initrd).  However, I am unable to run either mbxroot.full or the
HardHat "target" filesystem
(Both obviously under NFS due to their size).  I am convinced that my
problem has something to do with the shared libraries (But I've been
wrong before!).

In addition, I've noticed that if I run ldconfig on the mbxroot.min
filesystem, it no longer boots.  Removing etc/ld.so.cache fixes the
problem.  I believe both the mbxroot-full filesystem and the HardHat
"target" filesystem are untouched from their original versions.

My host is an i386/RedHat 6.2 Can I run this ldconfig on a ppc
filesystem, or do I need a cross-platform version? (command line:
/sbin/ldconfig -r <target_dir> )

Basically, the symptoms are that the kernel can't find an init.  I ran
tcpdump while booting, and everything looked pretty normal; lots of NFS
queries (but not much or no actual data transfer).  Interestingly the
trace ends with a bunch of queries to
/opt/hardhat/devkit/ppc/8xx/target/opt.

I would greatly appreciate it if anyone has any solution to this
problem, or even if someone could propose a debugging strategy for me?
I've tried both the HardHat CDK 1.0 and the newer Journeyman (CDK 1.1),
both with the same results.
Thanks in advance,
Mark Phillips


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
