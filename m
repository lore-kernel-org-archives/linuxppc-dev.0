Message-ID: <3E6E8612.1080308@mvista.com>
Date: Tue, 11 Mar 2003 17:57:54 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc-2.5 patch for KGDB in arch/ppc/kernel ppc-stub.c
Content-Type: multipart/mixed;
 boundary="------------080903020805080703090909"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080903020805080703090909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is an untested patch for 2.5.

The following patch fixes 2 problems with KGDB:

a) On line 617, '&regs' should be 'regs' in the call to mem2hex().  The
resulting improper response packet confuses the GDB client resulting in
step/next and stepi/nexti GDB commands to "lose their grip" and allow
execution to continue unchecked.

b) When executing an 's' command, we don't want to start single stepping
until we *return** from the current exception that we're handling.
Therefore, the MSR_SE bit should not be set in the MSR until the rfi
from this exception is executed (i.e., only need to set that bit in
'regs->msr' and not do an actual 'mtmsr()' at this point).  If the
'mtmsr(msr | MSR_SE);' line is executed at this point, a single-step
exeption will occur inside the exception handler itself which causes
another exception and the 'printk(KERN_ERR "interrupt while in kgdb,
returning\n");' line at the beginning of handle_exception() to be
executed.  Not fatal but somewhat disturbing to see.

Mark
--

--------------080903020805080703090909
Content-Type: text/plain;
 name="kgdb_2_5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kgdb_2_5.diff"

===== arch/ppc/kernel/ppc-stub.c 1.7 vs edited =====
--- 1.7/arch/ppc/kernel/ppc-stub.c	Sat Jan  4 01:45:43 2003
+++ edited/arch/ppc/kernel/ppc-stub.c	Tue Mar 11 17:54:02 2003
@@ -626,7 +626,7 @@
 	*ptr++ = hexchars[SP_REGNUM >> 4];
 	*ptr++ = hexchars[SP_REGNUM & 0xf];
 	*ptr++ = ':';
-	ptr = mem2hex(((char *)&regs) + SP_REGNUM*4, ptr, 4);
+	ptr = mem2hex(((char *)regs) + SP_REGNUM*4, ptr, 4);
 	*ptr++ = ';';
 #endif

@@ -805,7 +805,11 @@
 			set_msr(msr);
 #else
 			regs->msr |= MSR_SE;
+			/* Don't write MSR now, wait for exception return.
+			 * Otherwise, we'll start single stepping immediately.
+			 * --MAG
 			set_msr(msr | MSR_SE);
+			 */
 #endif
 			unlock_kernel();
 			kgdb_active = 0;

--------------080903020805080703090909--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
