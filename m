Return-Path: <anton@ozlabs.org>
Date: Tue, 9 Jan 2007 02:37:16 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix corruption in hcall9
Message-ID: <20070108153716.GB7508@krispykreme>
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


It looks to me like we are corrupting r12 in the hcall9 function.
Although we have r0 free we cant use offsets against it, so save
away r12 in there instead.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff -ru linux-2.6.20-rc3-orig/arch/powerpc/platforms/pseries/hvCall.S linux-2.6.20-rc3/arch/powerpc/platforms/pseries/hvCall.S
--- linux-2.6.20-rc3-orig/arch/powerpc/platforms/pseries/hvCall.S	2006-11-29 15:57:37.000000000 -0600
+++ linux-2.6.20-rc3/arch/powerpc/platforms/pseries/hvCall.S	2007-01-08 07:34:45.000000000 -0600
@@ -145,6 +145,7 @@
 
 	HVSC				/* invoke the hypervisor */
 
+	mr	r0,r12
 	ld	r12,STK_PARM(r4)(r1)
 	std	r4,  0(r12)
 	std	r5,  8(r12)
@@ -154,7 +155,7 @@
 	std	r9, 40(r12)
 	std	r10,48(r12)
 	std	r11,56(r12)
-	std	r12,64(r12)
+	std	r0, 64(r12)
 
 	HCALL_INST_POSTCALL
 
