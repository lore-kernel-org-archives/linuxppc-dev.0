Mime-Version: 1.0 (Apple Message framework v613)
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Message-Id: <BE309A52-8807-11D8-B1DF-000A95A07384@sands-edge.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-2--103630612
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Altivec Vector code bug
Date: Tue, 6 Apr 2004 16:19:44 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Apple-Mail-2--103630612
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

The attached patch corrects the following problem with the Altivec
vector:

When running Linux 2.6.5-rc2 (Altivec NOT configured in) on a 7410-base
platform, and running a program that attempts to use a vector register,
the kernel will lock up.  This is due to vectoring to 0xf20, which is
in the middle of the exception prolog as the exception handler is now
written.

To correct this, I reverted to the method used by the 2.4.25 kernel
(arch/ppc/kernel/head.S):

	. = 0xf00
	b Trap_0f

	. = 0xf20
#ifdef CONFIG_ALTIVEC
	b AltiVecUnavailable
#endif
Trap_0f:
	<exception handling code>

This causes the kernel to not lock up, regardless of the altivec
configuration.

John


--Apple-Mail-2--103630612
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0600;
	name="altivec.patch"
Content-Disposition: attachment;
	filename=altivec.patch

--- linuxppc-2.6.5-rc2.orig/arch/ppc/kernel/head.S	2004-04-01 14:21:53.000000000 -0500
+++ linuxppc-2.6.5-rc2/arch/ppc/kernel/head.S	2004-04-06 16:12:12.000000000 -0400
@@ -493,13 +493,14 @@
  * We effectively remap it to 0x3000.
  */
 	. = 0xf00
-
-#ifdef CONFIG_ALTIVEC
 	b	Trap_0f
+
 	. = 0xf20
+#ifdef CONFIG_ALTIVEC
 	b	AltiVecUnavailable
-Trap_0f:
 #endif
+
+Trap_0f:
 	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE(0xf00, UnknownException)

--Apple-Mail-2--103630612--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
