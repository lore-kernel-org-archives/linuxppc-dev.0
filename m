Return-Path: <afleming@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id D86D22BD6A
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 04:24:49 +1000 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id i8FIPuF7001374
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2004 11:25:56 -0700 (MST)
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <82589812-0744-11D9-AA47-000393C30512@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Wed, 15 Sep 2004 13:24:41 -0500
To: "<linuxppc-dev@ozlabs.org> <linuxppc-dev@ozlabs.org>"
	<linuxppc-dev@ozlabs.org>
Cc: "Kumar K. Gala" <kumar.gala@motorola.com>
Subject: [RFC] 85xx Spurious Interrupt Bug
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

About a month ago, OPENPIC_VEC_SPURIOUS got changed to 239, causing a 
bogus value to be put in the PIC for the 85xx, because 85xx reserves 64 
interrupts instead of 16.  So, instead, I'm suggesting we set 
OPENPIC_VEC_SPURIOUS to 255, and use that value, rather than adding an 
offset to it, so it's always 255 for all PowerPC parts.

I've tested this on an MPC8560 ADS board.

Andy Fleming
PowerPC Software Enablement
Freescale Semiconductor, Inc

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or 
higher.
# This patch includes the following deltas:
#                  ChangeSet    1.1913  -> 1.1914
#       include/asm-ppc/open_pic.h      1.18    -> 1.19
#       arch/ppc/syslib/open_pic.c      1.36    -> 1.37
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/09/15      afleming@nerfherder.somerset.sps.mot.com        1.1914
# The Spurious interrupt assignment for OpenPIC was the constant,
# OPENPIC_VEC_SPURIOUS plus the offset passed in.  Due to bugs in some
# OpenPICs, the end value needed to be 255 on those systems.  However,
# the constant was then chosen to be 239, because offset on most
# systems is 16.  The 85xx has an offset of 64, however, and so this
# assignment caused lock-ups during boot.  The proposed solution is to
# declare OPENPIC_VEC_SPURIOUS to be 255, and use that value directly,
# instead of adding the offset to it.
# --------------------------------------------
#
diff -Nru a/arch/ppc/syslib/open_pic.c b/arch/ppc/syslib/open_pic.c
--- a/arch/ppc/syslib/open_pic.c        Wed Sep 15 13:11:02 2004
+++ b/arch/ppc/syslib/open_pic.c        Wed Sep 15 13:11:02 2004
@@ -412,7 +412,7 @@

         /* Initialize the spurious interrupt */
         if (ppc_md.progress) ppc_md.progress("openpic: spurious",0x3bd);
-       openpic_set_spurious(OPENPIC_VEC_SPURIOUS+offset);
+       openpic_set_spurious(OPENPIC_VEC_SPURIOUS);
         openpic_disable_8259_pass_through();
  #ifdef CONFIG_EPIC_SERIAL_MODE
         openpic_eicr_set_clk(7);        /* Slowest value until we know 
better */
@@ -865,7 +865,7 @@
                         irq = cirq;
                         openpic_eoi();
                 }
-        } else if (irq == OPENPIC_VEC_SPURIOUS + open_pic_irq_offset)
+        } else if (irq == OPENPIC_VEC_SPURIOUS)
                 irq = -1;
         return irq;
  }
@@ -988,9 +988,9 @@

         /* OpenPIC sometimes seem to need some time to be fully back 
up... */
         do {
-               
openpic_set_spurious(OPENPIC_VEC_SPURIOUS+open_pic_irq_offset);
+               openpic_set_spurious(OPENPIC_VEC_SPURIOUS);
         } while(openpic_readfield(&OpenPIC->Global.Spurious_Vector, 
OPENPIC_VECT
OR_MASK)
-                       != (OPENPIC_VEC_SPURIOUS + 
open_pic_irq_offset));
+                       != OPENPIC_VEC_SPURIOUS);

         openpic_disable_8259_pass_through();

diff -Nru a/include/asm-ppc/open_pic.h b/include/asm-ppc/open_pic.h
--- a/include/asm-ppc/open_pic.h        Wed Sep 15 13:11:02 2004
+++ b/include/asm-ppc/open_pic.h        Wed Sep 15 13:11:02 2004
@@ -23,7 +23,7 @@

  #define OPENPIC_VEC_TIMER      110     /* and up */
  #define OPENPIC_VEC_IPI                118     /* and up */
-#define OPENPIC_VEC_SPURIOUS   239
+#define OPENPIC_VEC_SPURIOUS   255

  /* OpenPIC IRQ controller structure */
  extern struct hw_interrupt_type open_pic;
