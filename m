Message-ID: <3A82EECF.EF4D5A8@opensource.se>
Date: Thu, 08 Feb 2001 20:09:03 +0100
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: bk-linuxppc_2_4 mpc8xx compile fix
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I recently tried to compile a fresh bitkeeper linuxppc_2_4 tree for
mpc8xx:

arch/ppc/kernel/kernel.o: In function `SoftwareEmulation':
arch/ppc/kernel/kernel.o(.text+0xa04): undefined reference to
`Soft_emulate_8xx'
arch/ppc/kernel/kernel.o(.text+0xa04): relocation truncated to fit:
R_PPC_REL24 Soft_emulate_8xx
make: *** [vmlinux] Error 1

The relevant .config line:

# CONFIG_MATH_EMULATION is not set

I will probably not get the nobelprize for the fix,
but is works for me... =)

Cheers /

Magnus



diff -urN linux-2.4.1/arch/ppc/kernel/Makefile
linux-2.4.1-cllf_ok/arch/ppc/kern
el/Makefile
--- linux-2.4.1/arch/ppc/kernel/Makefile        Tue Jan 23 00:41:15 2001
+++ linux-2.4.1-cllf_ok/arch/ppc/kernel/Makefile        Wed Feb  7
11:32:08 2001
@@ -56,7 +56,13 @@
 else
 obj-$(CONFIG_PPC)              += hashtable.o
 endif
-obj-$(CONFIG_MATH_EMULATION)   += softemu8xx.o
+
+ifeq ($(CONFIG_8xx),y)
+ifneq ($(CONFIG_MATH_EMULATION),y)
+obj-$(CONFIG_8xx)              += softemu8xx.o
+endif
+endif
+
 obj-$(CONFIG_MBX)              += i8259.o
 obj-$(CONFIG_APUS)             += apus_setup.o
 obj-$(CONFIG_ALL_PPC)          += pmac_pic.o pmac_setup.o pmac_time.o
prom.o \

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
