Message-ID: <63127.213.107.143.228.1049052624.squirrel@www.solinno.co.uk>
Date: Sun, 30 Mar 2003 20:30:24 +0100 (BST)
Subject: OpenPIC spurious vector
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

Early RS/6000 7024-E20 and 7024-E30 models have weird openpics.  One of
the problems with them is that the spurious vector doesn't seem to work
properly.  Even though the spurious vector is being set to (127 + 16),
on these particular machines it always returns 255.

I've thought of a couple of ways of fixing this, but the simplest seems
to be to change OPENPIC_VEC_SPURIOUS to 239.  Thus, it is always set to
the value (239 + 16 = 255) that just happens to be the only one available
on these boxes.

I've applied the patch below on my 140 and it seems to work fine, but I
don't know if there are any unintended consequences to this change.

Can anyone think of any?

Thanks in advance,

Leigh.

diff -urNX /home/leigh/.diffex prev/include/asm-ppc/open_pic.h
linuxppc_2_4_devel-2.4.19-local/include/asm-ppc/open_pic.h
--- prev/include/asm-ppc/open_pic.h	2003-03-30 17:46:56.000000000 +0100
+++ linuxppc_2_4_devel-2.4.19-local/include/asm-ppc/open_pic.h	2003-03-30
19:59:39.000000000 +0100
@@ -26,7 +26,7 @@

 #define OPENPIC_VEC_TIMER	64	/* and up */
 #define OPENPIC_VEC_IPI		72	/* and up */
-#define OPENPIC_VEC_SPURIOUS	127
+#define OPENPIC_VEC_SPURIOUS	239

 /*
  * For the OpenPIC_InitSenses table, we include both the sense


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
