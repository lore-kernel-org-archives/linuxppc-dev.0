Date: Mon, 26 Jul 1999 10:21:53 +1000
Message-Id: <199907260021.KAA01971@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: karimi@cs.uregina.ca
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.SGI.3.91.990723194451.18857P-100000@MERCURY.CS.UREGINA.CA>
	(message from Kamran Karimi on Fri, 23 Jul 1999 19:48:31 -0600 (CST))
Subject: Re: DIPC for PowerPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.SGI.3.91.990723194451.18857P-100000@MERCURY.CS.UREGINA.CA>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kamran Karimi <karimi@cs.uregina.ca> wrote:

>  I did a blind port of DIPC (http://wallybox.cei.net/dipc) to PowerPC

I tried it on the weekend.  I had to make a couple of small changes to
get the kernel to compile: asm-ppc/ipc.h didn't define DIPC, and PPC
systems (at least the vast majority of the systems that Linux will run
on) are 32-bit, not 64-bit.  I have appended below the diffs for
include/asm-ppc (ipc.h and dipc.h).

I had to hack the userland stuff a bit to get it to compile, due to
the fact that we use glibc-2.1 which doesn't define union semun.  It
seems to work fine on one machine, but when I tried using two, dipcd
on the second machine wasn't creating the ~dipcd/referee_backdoor
socket which seems to be necessary.  I haven't figured out why yet.

Paul.

diff -urN linux/include/asm-ppc/dipc.h pmac/include/asm-ppc/dipc.h
--- linux/include/asm-ppc/dipc.h	Thu Jan  1 10:00:00 1970
+++ pmac/include/asm-ppc/dipc.h	Sun Jul 25 19:45:44 1999
@@ -0,0 +1,10 @@
+/*
+ * (C) Kamran Karimi
+ */
+ 
+#ifndef _ASM_DIPC_H
+#define _ASM_DIPC_H
+
+#define MY_DIPC_ARCH LINUX_BIG_32
+
+#endif _ASM_DIPC_H
diff -urN linux/include/asm-ppc/ipc.h pmac/include/asm-ppc/ipc.h
--- linux/include/asm-ppc/ipc.h	Fri May 14 22:08:03 1999
+++ pmac/include/asm-ppc/ipc.h	Sun Jul 25 20:04:09 1999
@@ -23,6 +23,9 @@
 #define SHMGET		23
 #define SHMCTL		24
 
+/* Used by the DIPC package, try and avoid reusing it */
+#define DIPC            25
+
 #define IPCCALL(version,op)	((version)<<16 | (op))
 
 #endif /* __PPC_IPC_H__ */

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
