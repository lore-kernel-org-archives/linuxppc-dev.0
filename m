Return-Path: <anton@ozlabs.org>
Date: Sun, 11 Jun 2006 01:15:55 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: system call micro optimisation
Message-ID: <20060610151555.GV23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


In the syscall path we currently have:

       crclr   so
       mfcr    r9

If we shift the crclr up we can avoid a stall on some CPUs.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kernel/arch/powerpc/kernel/entry_64.S
===================================================================
--- kernel.orig/arch/powerpc/kernel/entry_64.S	2006-04-26 08:03:05.380651922 -0500
+++ kernel/arch/powerpc/kernel/entry_64.S	2006-04-26 08:03:28.076523958 -0500
@@ -59,6 +59,7 @@ system_call_common:
 	beq-	1f
 	ld	r1,PACAKSAVE(r13)
 1:	std	r10,0(r1)
+	crclr	so
 	std	r11,_NIP(r1)
 	std	r12,_MSR(r1)
 	std	r0,GPR0(r1)
@@ -77,7 +78,6 @@ system_call_common:
 	std	r11,GPR11(r1)
 	std	r11,GPR12(r1)
 	std	r9,GPR13(r1)
-	crclr	so
 	mfcr	r9
 	mflr	r10
 	li	r11,0xc01
