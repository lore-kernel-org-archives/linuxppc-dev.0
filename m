Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 04/14] powerpc: Make load_hander handle upto 64k offset
Date: Fri,  9 Nov 2012 17:19:02 +1100
Message-Id: <1352441953-29096-5-git-send-email-mikey@neuling.org>
In-Reply-To: <1352441953-29096-1-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we change load_hander() to use an ori instead of addi, we can load handlers
upto 64k away provided we are still 64k aligned.
---
 arch/powerpc/include/asm/exception-64s.h |    3 ++-
 arch/powerpc/kernel/exceptions-64s.S     |    4 ++--
 arch/powerpc/kernel/setup_64.c           |    5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index a43c147..9258daa 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -55,7 +55,8 @@
  * word.
  */
 #define LOAD_HANDLER(reg, label)					\
-	addi	reg,reg,(label)-_stext;	/* virt addr of handler ... */
+	/* Handlers must be within 64K of kbase, which must be 64k aligned */ \
+	ori	reg,reg,(label)-_stext;	/* virt addr of handler ... */
 
 /* Exception register prefixes */
 #define EXC_HV	H
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index de02964..0969b7f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -585,8 +585,8 @@ __end_interrupts:
  * Code from here down to __end_handlers is invoked from the
  * exception prologs above.  Because the prologs assemble the
  * addresses of these handlers using the LOAD_HANDLER macro,
- * which uses an addi instruction, these handlers must be in
- * the first 32k of the kernel image.
+ * which uses an ori instruction, these handlers must be in
+ * the first 64k of the kernel image.
  */
 
 /*** Common interrupt handlers ***/
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index efb6a41..6da881b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -601,6 +601,11 @@ void __init setup_arch(char **cmdline_p)
 
 	kvm_linear_init();
 
+	/* Interrupt code needs to be 64K-aligned */
+	if ((unsigned long)_stext & 0xffff)
+		panic("Kernelbase not 64K-aligned (0x%lx)!\n",
+		      (unsigned long)_stext);
+
 	ppc64_boot_msg(0x15, "Setup Done");
 }
 
-- 
1.7.9.5
