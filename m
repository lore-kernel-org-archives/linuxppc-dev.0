Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id D619A2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Nov 2004 00:06:16 +1100 (EST)
Message-ID: <1100264953.4194b5f9eab0f@webmail.televes.com:443>
Date: Fri, 12 Nov 2004 14:09:13 +0100
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [patch] Solves syslib/m8260_setup.c ROOT_DEV problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

This patch applies against head versions of both linuxppc-2.5 in ppc.bkbits.net
and linux-2.5 in linux.bkbits.net

I don't now if this has been corrected in some other tree.

The patch corrects the following error during compilation

  LD      arch/ppc/lib/built-in.o
  CC      arch/ppc/syslib/m8260_setup.o
arch/ppc/syslib/m8260_setup.c: In function `m8260_setup_arch':
arch/ppc/syslib/m8260_setup.c:56: `ROOT_DEV' undeclared (first use in this
function)
arch/ppc/syslib/m8260_setup.c:56: (Each undeclared identifier is reported only
once
arch/ppc/syslib/m8260_setup.c:56: for each function it appears in.)
arch/ppc/syslib/m8260_setup.c:56: `Root_RAM0' undeclared (first use in this
function)
arch/ppc/syslib/m8260_setup.c: In function `m8260_show_cpuinfo':
arch/ppc/syslib/m8260_setup.c:149: warning: unsigned int format, long unsigned
int arg (arg 5)
arch/ppc/syslib/m8260_setup.c:149: warning: int format, long unsigned int arg
(arg 6)
arch/ppc/syslib/m8260_setup.c:149: warning: unsigned int format, long unsigned
int arg (arg 7)
arch/ppc/syslib/m8260_setup.c:149: warning: unsigned int format, long unsigned
int arg (arg 8)
arch/ppc/syslib/m8260_setup.c:149: warning: unsigned int format, long unsigned
int arg (arg 9)
make[1]: *** [arch/ppc/syslib/m8260_setup.o] Error 1
make: *** [arch/ppc/syslib] Error 2

Here, arch was ppc and configuration was ads8272_defconfig.

Best regards,

Alex


--- arch/ppc/syslib/m8260_setup.c.orig  2004-11-12 11:55:32.000000000 +0100
+++ arch/ppc/syslib/m8260_setup.c       2004-11-12 13:55:00.000000000 +0100
@@ -16,6 +16,9 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/initrd.h>
+#ifdef CONFIG_BLK_DEV_INITRD
+#include <linux/root_dev.h>
+#endif
 #include <linux/seq_file.h>
 #include <linux/irq.h>
