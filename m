Date: Thu, 10 Jun 2004 12:46:30 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: ok, so a statically-built minit seems to work
Message-ID: <Pine.LNX.4.58.0406101241110.8061@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  argh.  took the time to go back to the build, increase the ramdisk size,
then built minit statically (size jumped from 13K to 450K, hence the need
to boost the ramdisk size.)

  built my new downloadable image, booted and:

...
ttyS00 at 0x0280 is a SMC
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 52k init
Trying run_init_process with /sbin/minit
FIFOs opened successfully.        <-- ah, success, minit is starting
About to start default service.
(hang)

so we're pretty much back to where we started -- hanging shortly after
getting to user space.  but i'm pretty sure that minit used to get this
far when it was dynamically linked.  so, in that sense, things seem to
have regressed, unless there's some magic option i should be setting in
this build that i never needed in the 2.4 build for dynamically-linked
executables.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
