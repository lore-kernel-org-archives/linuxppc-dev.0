To: linuxppc-dev@lists.linuxppc.org
Subject: xine, ppc and illegal instructions
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 24 Mar 2001 00:53:54 +0100
Message-ID: <87bsqs59f1.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried compiling xine-0.4.01 with the ppc-patches by Henry Worth.
Compiling went fine.

When running the resulting binary, I end up with an Illegal instruction.
It doesn't seem to matter what mpegfile I try to use it on, so I assume
it dies before messing with the mpeg.

An strace of the program gives this at the end:

open("/usr/local/lib/xine/plugins/input_net.so", O_RDONLY) = 9
read(9, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\v"..., 1024) = 1024
SYS_197(0x9, 0x7fffec40, 0x7fffec40, 0x101f3170, 0) = 0
mmap(0xf993000, 71456, PROT_READ|PROT_EXEC, MAP_PRIVATE, 9, 0) = 0xf993000
mprotect(0xf995000, 63264, PROT_NONE)   = 0
mmap(0xf9a3000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 9,
0) = 0xf9a3000
close(9)                                = 0
mprotect(0xf993000, 8192, PROT_READ|PROT_WRITE) = 0
mprotect(0xf993000, 8192, PROT_READ|PROT_EXEC) = 0
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++


Kernel version is 2.4.0, with some dmasound-patches applied.
Distribution is Debian (reasonably fresh).
Glibc 2.2.2-1

The binary has been compiled both with and without optimisations, with no
appearent difference.

The above could hint that input_net.so was a problem, so I removed that one,
and then just the next input showed up with a more or less identical trace.
Is this a libc problem? Is it something else? I have no idea where to look.
Since I can't even get a coredump to look in, I guess this isn't really in
the binary.

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
