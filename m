Message-Id: <200001281853.NAA18227@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Questions about using shell and tools linked with glibc2.1
Date: Fri, 28 Jan 2000 13:53:24 -0500
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to get my MPC860 board to work with binaries linked against
glibc2.1.  The kernel has math emulation support and when I pull down a
prebuilt bash & glibc & libtermcap packages from ftp.linuxppc.org and I try
to use them I end up hanging.  I went into fs/namei.c and put a printk at
the top of open_namei to see if I could track down which library was causing
the problem and I ended up with this output.

open_namei(): attempting to open "/dev/console".
open_namei(): attempting to open "/sbin/init".
open_namei(): attempting to open "/etc/init".
open_namei(): attempting to open "/bin/init".
open_namei(): attempting to open "/bin/sh".
open_namei(): attempting to open "/lib/ld.so.1".
open_namei(): attempting to open "/etc/ld.so.preload".
open_namei(): attempting to open "/etc/ld.so.cache".
open_namei(): attempting to open "/lib/libtermcap.so.2".

so it finds /bin/sh and starts to load it but it looks like it is blowing up
with libtermcap.so.2 which is a link to libtermcap.so.2.0.8

Does anyone have any suggestions, or is does anyone have tools linked
against glibc working on their boards?

Thanks in advance,
Jason

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
