Subject: Errors in arch/ppc/boot/prep/misc.c
From: Ingvar Hagelund <ingvar@route.linpro.no>
To: linuxppc-dev@lists.linuxppc.org, mgreer@mvista.com
Content-Type: text/plain
Message-Id: <1073670566.28850.46.camel@route.linpro.no>
Mime-Version: 1.0
Date: Fri, 09 Jan 2004 18:49:26 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello, list

I recently rsynced the tree from source.mvista.com::linuxppc_2_4_devel,
and tried to build it for my good old 7248 (PReP). It didn't work. I got

misc.c: In function `decompress_kernel':
misc.c:158: `OFW_interface' undeclared (first use in this function)

There seems to be a small error in the prototype declaration of
decompress_kernel(...). The trivial patch below fixes this.

Getting past this hurdle, I got another error:

misc.o(.text+0x4b0): In function `decompress_kernel':
: undefined reference to `mpc10x_get_mem_size'

Having one more look at misc.c, I see that it tries to

#include "mpc10x.h"

but there is no mpc10x.h in arch/ppc/boot/prep (and according to the
includes misc.c, others seem to be missing too).

There does exist an include/asm-ppc/mpc10x.h, but it has a different
prototype. Commenting out the actual function call (lines 285-290, "See
if we are on an MPC10x.") makes the kernel build complete. Trying to
make the prototype match the one in /asm-ppc/mpc10x.h, and including
that file instead leads nowhere.

I guess someone forgot to upload his version of the file.

Ingvar



diff -u -r linux-2.4_ppc_dev.orig/arch/ppc/boot/prep/misc.c
linux-2.4_ppc_dev/arch/ppc/boot/prep/misc.c
--- linux-2.4_ppc_dev.orig/arch/ppc/boot/prep/misc.c	2004-01-09
17:55:19.000000000 +0100
+++ linux-2.4_ppc_dev/arch/ppc/boot/prep/misc.c	2004-01-09
17:57:01.000000000 +0100
@@ -139,7 +139,7 @@

 unsigned long
 decompress_kernel(unsigned long load_addr, int num_words, unsigned long
cksum,
-		  RESIDUAL *residual)
+		  RESIDUAL *residual, void *OFW_interface)
 {
 #ifdef INTERACTIVE_CONSOLE
 	int timer = 0;


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
