To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.3 compile error on ppc
References: <Pine.LNX.3.96L.990519131538.1355C-100000@unix47.andrew.cmu.edu>
From: Andreas Bogk <andreas@andreas.org>
Date: 19 May 1999 20:09:22 +0200
In-Reply-To: Hollis R Blanchard's message of "Wed, 19 May 1999 13:19:20 -0400 (EDT)"
Message-ID: <m31zgd0w4t.fsf@soma.andreas.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis R Blanchard <hollis+@andrew.cmu.edu> writes:

> be broken for us for a little. Were you having problems with 2.2.x?

There is a problem with 2.2.9, and here's the patch:

diff -r -u linux-2.2.9/arch/ppc/kernel/syscalls.c linux/arch/ppc/kernel/syscalls.c
--- linux-2.2.9/arch/ppc/kernel/syscalls.c	Sat May  8 20:14:01 1999
+++ linux/arch/ppc/kernel/syscalls.c	Wed May 19 18:36:23 1999
@@ -30,6 +30,7 @@
 #include <linux/shm.h>
 #include <linux/stat.h>
 #include <linux/mman.h>
+#include <linux/file.h>
 #include <linux/sys.h>
 #include <linux/ipc.h>
 #include <linux/utsname.h>

I wonder why such trivial problems creep into so-called stable
releases of the Linux kernel again and again. Does nobody care that on
i386, you just go to ftp.kernel.org and download the latest version
and it just works, whereas on PowerPC you have to find out:

- what CVS is
- what vger is
- what CVS tags are
- which tag the one is which gives you a stable version ?

I don't care that the development kernel breaks on PPC. But that the
official stable kernel breaks is a huge problem.

Andreas

-- 
Reality is two's complement. See:
ftp://ftp.netcom.com/pub/hb/hbaker/hakmem/hacks.html#item154

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
