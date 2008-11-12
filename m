Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Nov 2008 13:02:43 +1100
Subject: [PATCH] powerpc: Fix 460EX/460GT machine check handling
Message-Id: <20081112020409.4FFBCDDDDB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Those cores use the 440A type machine check (ie, they have
MCSRR0/MCSRR1). They thus need to call the appropriate fixup
function to hook the right variant of the exception.

Without this, all machine checks become fatal due to loss
of context when entering the exception handler.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/cpu_setup_44x.S |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/cpu_setup_44x.S	2008-11-12 12:51:24.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cpu_setup_44x.S	2008-11-12 13:01:03.000000000 +1100
@@ -34,7 +34,12 @@ _GLOBAL(__setup_cpu_440grx)
 	blr
 _GLOBAL(__setup_cpu_460ex)
 _GLOBAL(__setup_cpu_460gt)
-	b	__init_fpu_44x
+	mflr	r4
+	bl	__init_fpu_44x
+	bl	__fixup_440A_mcheck
+	mtlr	r4
+	blr
+
 _GLOBAL(__setup_cpu_440gx)
 _GLOBAL(__setup_cpu_440spe)
 	b	__fixup_440A_mcheck
