MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16174.17597.565364.862198@cargo.ozlabs.ibm.com>
Date: Mon, 4 Aug 2003 21:34:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Miles Lane <miles.lane@comcast.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.0-test2-bk2 (linus' tree) --
	arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to
	`cpufreq_frequency_table_verify'
In-Reply-To: <1059948097.602.1.camel@gaston>
References: <200308031456.11550.miles.lane@comcast.net>
	<1059948097.602.1.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:

> That's some Kconfig not up-to-date yet. I'm sorting out various
> missing pmac patches for Linus and will send them over next week,
> including that. You basically need CPU_FREQ_TABLE for now.

Here is what I have in a tree locally to go to Linus.  I can't push it
out because ppc.bkbits.net seems to be down.

Paul.

diff -urN linux-2.5/arch/ppc/Kconfig for-linus-ppc/arch/ppc/Kconfig
--- linux-2.5/arch/ppc/Kconfig	2003-08-04 09:47:00.000000000 +1000
+++ for-linus-ppc/arch/ppc/Kconfig	2003-08-04 14:05:07.000000000 +1000
@@ -473,7 +473,6 @@
 	help
 	  Select SANDPOINT if configuring for a Motorola Sandpoint X3
 	  or X3(b).
-	  X3 (any flavor).

 config ADIR
 	bool "SBS-Adirondack"
@@ -693,6 +692,11 @@

 	  If in doubt, say N.

+config CPU_FREQ_TABLE
+	bool
+	depends on CPU_FREQ
+	default y
+
 config CPU_FREQ_PROC_INTF
 	bool "/proc/cpufreq interface (DEPRECATED)"
 	depends on CPU_FREQ && PROC_FS
diff -urN linux-2.5/arch/ppc/kernel/setup.c for-linus-ppc/arch/ppc/kernel/setup.c
--- linux-2.5/arch/ppc/kernel/setup.c	2003-08-02 09:37:29.000000000 +1000
+++ for-linus-ppc/arch/ppc/kernel/setup.c	2003-08-04 14:00:35.000000000 +1000
@@ -15,6 +15,7 @@
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/cpu.h>

 #include <asm/residual.h>
 #include <asm/io.h>
diff -urN linux-2.5/arch/ppc/lib/string.S for-linus-ppc/arch/ppc/lib/string.S
--- linux-2.5/arch/ppc/lib/string.S	2003-01-13 22:17:02.000000000 +1100
+++ for-linus-ppc/arch/ppc/lib/string.S	2003-08-04 14:32:06.000000000 +1000
@@ -78,6 +78,8 @@
 	bne	1b
 	blr

+/* This clears out any unused part of the destination buffer,
+   just as the libc version does.  -- paulus */
 _GLOBAL(strncpy)
 	cmpwi	0,r5,0
 	beqlr
@@ -88,6 +90,12 @@
 	cmpwi	0,r0,0
 	stbu	r0,1(r6)
 	bdnzf	2,1b		/* dec ctr, branch if ctr != 0 && !cr0.eq */
+	bnelr			/* if we didn't hit a null char, we're done */
+	mfctr	r5
+	cmpwi	0,r5,0		/* any space left in destination buffer? */
+	beqlr			/* we know r0 == 0 here */
+2:	stbu	r0,1(r6)	/* clear it out if so */
+	bdnz	2b
 	blr

 _GLOBAL(strcat)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
