From: Alan Mimms <alan@packetengines.com>
To: "Linux PPC Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Using LinuxPPC executables on 8xx processors
Date: Wed, 2 Feb 2000 17:36:13 -0800
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <0002021816180C.00733@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I BELIEVE have seen various folks talk about using LinuxPPC executables
directly on MPC8xx processor targets using some kernel floating point
instruction emulation.  As I recall (I'm too lazy to look it up, as I THINK I'm
remembering right), the notes I saw espoused simply building a kernel with the
math emulation turned on and you could use LinuxPPC executables with no changes.

I don't see how this can be true.

There are two significant (at least!) differences between "real" PowerPC and
the embedded flavor: [1] the floating point unit is not present on 8xx and [2]
the cache line size is 16 on 8xx as opposed to 32 bytes on 6xx/7xx.  The kernel
fix for emulating the floating point instructions appears to be touted as a
soluation for #1, but what about #2?

The ONLY way I can see to get MPC8xx kernels to run applications is to use one
of the prebuilt things from Dan's glibc-1.99, or to build a glibc that has the
cache line size fixed in memset (the fixit scripts like Wolfgang's do this by
moving the PowerPC specific one aside and using the generic one that doesn't
use the cache enhanced zeroing) and in dl-machine.c for the data-to-code
operation needed after mmap-ing libraries.

Am I missing something?

 --
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
