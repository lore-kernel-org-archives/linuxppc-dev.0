Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E7801B703E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 14:01:07 +1100 (EST)
Message-ID: <1324263652.30454.13.camel@pasglop>
Subject: Re: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user
 using VMX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Mon, 19 Dec 2011 14:00:52 +1100
In-Reply-To: <20111208171145.3ab3c423@kryten>
References: <20111208160227.2ef2d526@kryten>
 <FC884692-A7C3-47F6-BDD5-9E3D955ABF9B@kernel.crashing.org>
 <5188.1323323649@neuling.org> <20111208171145.3ab3c423@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, paulus@samba.org,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-08 at 17:11 +1100, Anton Blanchard wrote:
> Implement a POWER7 optimised copy_to_user/copy_from_user using VMX.
> For large aligned copies this new loop is over 10% faster, and for
> large unaligned copies it is over 200% faster.

Breaks !CONFIG_ALTIVEC build an pops some WARN's with preempt & lockdep,
this seems to fix them:

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index b90b3e7..7735a2c 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -17,13 +17,14 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
 			   checksum_wrappers_64.o hweight_64.o \
-			   copyuser_power7.o copyuser_power7_vmx.o
+			   copyuser_power7.o
 obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
 obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
 
 ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
+obj-$(CONFIG_ALTIVEC)	+= copyuser_power7_vmx.o
 endif
 
 obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index 4395939..9a21b08 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -85,6 +85,7 @@
 
 
 _GLOBAL(__copy_tofrom_user_power7)
+#ifdef CONFIG_ALTIVEC
 	cmpldi	r5,16
 	cmpldi	cr1,r5,4096
 
@@ -94,6 +95,15 @@ _GLOBAL(__copy_tofrom_user_power7)
 
 	blt	.Lshort_copy
 	bgt	cr1,.Lvmx_copy
+#else
+	cmpldi	r5,16
+
+	std	r3,48(r1)
+	std	r4,56(r1)
+	std	r5,64(r1)
+
+	blt	.Lshort_copy
+#endif
 
 .Lnonvmx_copy:
 	/* Get the source 8B aligned */
@@ -273,6 +283,7 @@ err1;	stb	r0,0(r3)
 	addi	r1,r1,STACKFRAMESIZE
 	b	.Lnonvmx_copy
 
+#ifdef CONFIG_ALTIVEC
 .Lvmx_copy:
 	mflr	r0
 	std	r0,16(r1)
@@ -667,3 +678,4 @@ err3;	stb	r0,0(r3)
 
 15:	addi	r1,r1,STACKFRAMESIZE
 	b	.exit_vmx_copy		/* tail call optimise */
+#endif /* CONFiG_ALTIVEC */
diff --git a/arch/powerpc/lib/copyuser_power7_vmx.c b/arch/powerpc/lib/copyuser_power7_vmx.c
index c37b949..6e1efad 100644
--- a/arch/powerpc/lib/copyuser_power7_vmx.c
+++ b/arch/powerpc/lib/copyuser_power7_vmx.c
@@ -26,10 +26,16 @@ int enter_vmx_copy(void)
 	if (in_interrupt())
 		return 0;
 
-	enable_kernel_altivec();
-
+	/* This acts as preempt_disable() as well and will make
+	 * enable_kernel_altivec(). We need to disable page faults
+	 * as they can call schedule and thus make us lose the VMX
+	 * context. So on page faults, we just fail which will cause
+	 * a fallback to the normal non-vmx copy.
+	 */
 	pagefault_disable();
 
+	enable_kernel_altivec();
+
 	return 1;
 }
 
