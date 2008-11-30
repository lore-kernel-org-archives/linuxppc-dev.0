Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18739.2681.351794.669476@cargo.ozlabs.ibm.com>
Date: Mon, 1 Dec 2008 08:49:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix system calls on Cell entered with XER.SO=1
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It turns out that on Cell, on a kernel with CONFIG_VIRT_CPU_ACCOUNTING
= y, if a program sets the SO (summary overflow) bit in the XER and
then does a system call, the SO bit in CR0 will be set on return
regardless of whether the system call detected an error.  Since CR0.SO
is used as the error indication from the system call, this means that
all system calls appear to fail.

The reason is that the workaround for the timebase bug on Cell uses a
compare instruction.  With CONFIG_VIRT_CPU_ACCOUNTING = y, the
ACCOUNT_CPU_USER_ENTRY macro reads the timebase, so we end up doing a
compare instruction, which copies XER.SO to CR0.SO.  Since we were
doing this in the system call entry patch after clearing CR0.SO but
before saving the CR, this meant that the saved CR image had CR0.SO
set if XER.SO was set on entry.

This fixes it by moving the clearing of CR0.SO to after the
ACCOUNT_CPU_USER_ENTRY call in the system call entry path.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Same as before, just with a comment added to explain the problem for
anybody hacking on this code in future.

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index e6d5284..e0bcf93 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -57,12 +57,18 @@ system_call_common:
 	beq-	1f
 	ld	r1,PACAKSAVE(r13)
 1:	std	r10,0(r1)
-	crclr	so
 	std	r11,_NIP(r1)
 	std	r12,_MSR(r1)
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
 	ACCOUNT_CPU_USER_ENTRY(r10, r11)
+	/*
+	 * This "crclr so" clears CR0.SO, which is the error indication on
+	 * return from this system call.  There must be no cmp instruction
+	 * between it and the "mfcr r9" below, otherwise if XER.SO is set,
+	 * CR0.SO will get set, causing all system calls to appear to fail.
+	 */
+	crclr	so
 	std	r2,GPR2(r1)
 	std	r3,GPR3(r1)
 	std	r4,GPR4(r1)
