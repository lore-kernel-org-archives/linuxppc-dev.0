Date: Fri, 14 May 1999 08:35:54 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Patch for Motorola MTX,MVME,MCP systems
Message-ID: <Pine.LNX.3.96.990514083226.3742A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After comparing versus a local version of the kernel, I found the
interrupt handling stuff got mangled on the way to the official release.
This patch fixes MPIC support (causes kernel hang on boot) in 2.2.8,
2.2.9, 2.3.0.  Also has the sys_mmap build fix in it.

diff -urd linux.orig/arch/ppc/kernel/prep_pci.c linux/arch/ppc/kernel/prep_pci.c
--- linux.orig/arch/ppc/kernel/prep_pci.c	Tue May 11 08:24:32 1999
+++ linux/arch/ppc/kernel/prep_pci.c	Thu May 13 15:41:53 1999
@@ -38,6 +38,8 @@
 /* Used for Motorola to store system config register */
 static unsigned long	*ProcInfo;
 
+extern void chrp_do_IRQ(struct pt_regs *,int , int);
+
 /* Tables for known hardware */   
 
 /* Motorola PowerStackII - Utah */
@@ -730,6 +732,8 @@
 
 	OpenPIC_InitSenses = mvme2600_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof(mvme2600_openpic_initsenses);
+
+	ppc_md.do_IRQ = chrp_do_IRQ;
 
 	/* If raven is present on Motorola store the system config register
 	 * for later use.
diff -urd linux.orig/arch/ppc/kernel/syscalls.c linux/arch/ppc/kernel/syscalls.c
--- linux.orig/arch/ppc/kernel/syscalls.c	Sat May  8 11:14:01 1999
+++ linux/arch/ppc/kernel/syscalls.c	Thu May 13 15:42:06 1999
@@ -33,6 +33,7 @@
 #include <linux/sys.h>
 #include <linux/ipc.h>
 #include <linux/utsname.h>
+#include <linux/file.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
