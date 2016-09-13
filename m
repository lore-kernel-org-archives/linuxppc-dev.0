Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYGxy4FpJzDsQd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 17:48:21 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Marek <mmarek@suse.cz>,
 linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 linux-next@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: manual merge of the kbuild tree with Linus' tree
Date: Tue, 13 Sep 2016 09:48:03 +0200
Message-ID: <14221699.K7eb6JGeeL@wuerfel>
In-Reply-To: <20160913140257.6d2de178@canb.auug.org.au>
References: <20160912113224.792b24f0@canb.auug.org.au>
 <20160913093945.521a28b4@canb.auug.org.au>
 <20160913140257.6d2de178@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, September 13, 2016 2:02:57 PM CEST Stephen Rothwell wrote:
> [For the new cc's, we are discussing the "thin archives" and "link dead
> code/data elimination" patches in the kbuild tree.]
> 
> On Tue, 13 Sep 2016 09:39:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Mon, 12 Sep 2016 11:03:08 +0200 Michal Marek <mmarek@suse.cz> wrote:
> > >
> > > On 2016-09-12 04:53, Nicholas Piggin wrote:  
> > > > Question, what is the best way to merge dependent patches? Considering
> > > > they will need a good amount of architecture testing, I think they will
> > > > have to go via arch trees. But it also does not make sense to merge these
> > > > kbuild changes upstream first, without having tested them.    
> > > 
> > > I think it makes sense to merge the kbuild changes via kbuild.git, even
> > > if they are unused and untested. Any follow-up fixes required to enable
> > > the first architecture can go through the respective architecture tree.
> > > Does that sound OK?  
> > 
> > And if you guarantee not to rebase the kbuild tree (or at least the
> > subset containing these patches), then each of the architecture trees
> > can just merge your tree (or a tag?) and then implement any necessary
> > arch dependent changes.  I fixes are necessary, they can also be merged
> > into the architecture trees.
> 
> Except, of course, the kbuild tree still has the asm EXPORT_SYMBOL
> patches that produce warnings on PowerPC  (And I am still reverting
> the PowerPC specific one of those patches).

Is that really powerpc specific? I have the same problem on ARM
and I don't see how any architecture would not have it.

I prototyped the patch below, which fixes it for me, but I have
not dared submit that workaround because it's butt ugly.

	Arnd

 arch/arm/include/asm/io.h             |  7 ++++---
 arch/arm/kernel/entry-ftrace.S        | 12 +++++++++---
 arch/arm/kernel/head.S                | 12 ++++++++++--
 arch/arm/kernel/smccc-call.S          |  6 +++++-
 arch/arm/lib/ashldi3.S                |  7 ++++++-
 arch/arm/lib/ashrdi3.S                |  6 +++++-
 arch/arm/lib/bitops.h                 | 19 +++++++++++++++----
 arch/arm/lib/bswapsdi2.S              |  5 +++++
 arch/arm/lib/changebit.S              |  6 ++----
 arch/arm/lib/clear_user.S             | 10 +++++++---
 arch/arm/lib/clearbit.S               |  6 ++----
 arch/arm/lib/copy_from_user.S         |  7 +++++--
 arch/arm/lib/copy_page.S              |  5 +++++
 arch/arm/lib/copy_to_user.S           | 11 +++++++----
 arch/arm/lib/csumipv6.S               |  5 +++++
 arch/arm/lib/csumpartial.S            |  4 ++++
 arch/arm/lib/csumpartialcopy.S        |  7 ++++++-
 arch/arm/lib/csumpartialcopygeneric.S |  1 -
 arch/arm/lib/csumpartialcopyuser.S    |  7 ++++++-
 arch/arm/lib/div64.S                  |  7 ++++++-
 arch/arm/lib/findbit.S                | 23 ++++++++++++++---------
 arch/arm/lib/getuser.S                | 23 +++++++++++++++--------
 arch/arm/lib/io-readsb.S              |  4 ++++
 arch/arm/lib/io-readsl.S              |  4 ++++
 arch/arm/lib/io-readsw-armv3.S        |  4 ++++
 arch/arm/lib/io-readsw-armv4.S        |  5 +++++
 arch/arm/lib/io-writesb.S             |  5 +++++
 arch/arm/lib/io-writesl.S             |  5 +++++
 arch/arm/lib/io-writesw-armv3.S       |  5 +++++
 arch/arm/lib/io-writesw-armv4.S       |  4 ++++
 arch/arm/lib/lib1funcs.S              | 33 ++++++++++++++++++++++-----------
 arch/arm/lib/lshrdi3.S                |  7 ++++++-
 arch/arm/lib/memchr.S                 |  4 ++++
 arch/arm/lib/memcpy.S                 |  5 +++++
 arch/arm/lib/memmove.S                |  7 ++++++-
 arch/arm/lib/memset.S                 |  7 +++++++
 arch/arm/lib/memzero.S                |  6 ++++++
 arch/arm/lib/muldi3.S                 |  7 ++++++-
 arch/arm/lib/putuser.S                | 13 +++++++++----
 arch/arm/lib/setbit.S                 |  6 ++----
 arch/arm/lib/strchr.S                 |  4 ++++
 arch/arm/lib/strrchr.S                |  4 ++++
 arch/arm/lib/testchangebit.S          |  6 ++----
 arch/arm/lib/testclearbit.S           |  6 ++----
 arch/arm/lib/testsetbit.S             |  6 ++----
 arch/arm/lib/ucmpdi2.S                | 12 +++++++++---
 arch/arm/mach-imx/ssi-fiq.S           |  6 +++++-
 scripts/Makefile.build                | 15 ++++++++-------
 48 files changed, 288 insertions(+), 98 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 51458d8273ad..95ca0beda6a9 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -317,10 +317,13 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define writesl(p,d,l)		__raw_writesl(p,d,l)
 
 #ifndef __ARMBE__
+
+extern void mmioset(void *, unsigned int, size_t);
+extern void mmiocpy(void *, const void *, size_t);
+
 static inline void memset_io(volatile void __iomem *dst, unsigned c,
 	size_t count)
 {
-	extern void mmioset(void *, unsigned int, size_t);
 	mmioset((void __force *)dst, c, count);
 }
 #define memset_io(dst,c,count) memset_io(dst,c,count)
@@ -328,7 +331,6 @@ static inline void memset_io(volatile void __iomem *dst, unsigned c,
 static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
 	size_t count)
 {
-	extern void mmiocpy(void *, const void *, size_t);
 	mmiocpy(to, (const void __force *)from, count);
 }
 #define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
@@ -336,7 +338,6 @@ static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
 static inline void memcpy_toio(volatile void __iomem *to, const void *from,
 	size_t count)
 {
-	extern void mmiocpy(void *, const void *, size_t);
 	mmiocpy((void __force *)to, from, count);
 }
 #define memcpy_toio(to,from,count) memcpy_toio(to,from,count)
diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index b629d3f11c3d..b92def6a655a 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -3,7 +3,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#ifdef __GENKSYMS__
+#include <asm/ftrace.h>
+#else
 #include <asm/assembler.h>
 #include <asm/ftrace.h>
 #include <asm/unwind.h>
@@ -154,7 +156,6 @@ ENTRY(mcount)
 	__mcount _old
 #endif
 ENDPROC(mcount)
-EXPORT_SYMBOL(mcount)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 ENTRY(ftrace_caller_old)
@@ -207,7 +208,6 @@ UNWIND(.fnstart)
 #endif
 UNWIND(.fnend)
 ENDPROC(__gnu_mcount_nc)
-EXPORT_SYMBOL(__gnu_mcount_nc)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 ENTRY(ftrace_caller)
@@ -244,3 +244,9 @@ ENTRY(ftrace_stub)
 .Lftrace_stub:
 	ret	lr
 ENDPROC(ftrace_stub)
+#endif
+
+#ifdef CONFIG_OLD_MCOUNT
+EXPORT_SYMBOL(mcount)
+#endif
+EXPORT_SYMBOL(__gnu_mcount_nc)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f41cee4c5746..75d3661eef33 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -11,6 +11,9 @@
  *
  *  Kernel startup code for all 32-bit CPUs
  */
+#ifdef __GENKSYMS__
+#include <asm/memory.h>
+#else
 #include <linux/linkage.h>
 #include <linux/init.h>
 
@@ -728,8 +731,13 @@ __pv_phys_pfn_offset:
 __pv_offset:
 	.quad	0
 	.size	__pv_offset, . -__pv_offset
-EXPORT_SYMBOL(__pv_phys_pfn_offset)
-EXPORT_SYMBOL(__pv_offset)
 #endif
 
 #include "head-common.S"
+
+#endif
+
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+EXPORT_SYMBOL(__pv_phys_pfn_offset);
+EXPORT_SYMBOL(__pv_offset);
+#endif
diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
index 37669e7e13af..5aec876d8d2c 100644
--- a/arch/arm/kernel/smccc-call.S
+++ b/arch/arm/kernel/smccc-call.S
@@ -11,6 +11,9 @@
  * GNU General Public License for more details.
  *
  */
+#ifdef __GENKSYMS__
+#include <linux/arm-smccc.h>
+#else
 #include <linux/linkage.h>
 
 #include <asm/opcodes-sec.h>
@@ -52,7 +55,6 @@ UNWIND(	.fnend)
 ENTRY(arm_smccc_smc)
 	SMCCC SMCCC_SMC
 ENDPROC(arm_smccc_smc)
-EXPORT_SYMBOL(arm_smccc_smc)
 
 /*
  * void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
@@ -62,4 +64,6 @@ EXPORT_SYMBOL(arm_smccc_smc)
 ENTRY(arm_smccc_hvc)
 	SMCCC SMCCC_HVC
 ENDPROC(arm_smccc_hvc)
+#endif
+EXPORT_SYMBOL(arm_smccc_smc)
 EXPORT_SYMBOL(arm_smccc_hvc)
diff --git a/arch/arm/lib/ashldi3.S b/arch/arm/lib/ashldi3.S
index a7e7de89bd75..c8d403d55ad3 100644
--- a/arch/arm/lib/ashldi3.S
+++ b/arch/arm/lib/ashldi3.S
@@ -25,7 +25,10 @@ along with this program; see the file COPYING.  If not, write to
 the Free Software Foundation, 51 Franklin Street, Fifth Floor,
 Boston, MA 02110-1301, USA.  */
 
-
+#ifdef __GENKSYMS__
+extern void __ashldi3(void);
+extern void __aeabi_llsl(void);
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -53,5 +56,7 @@ ENTRY(__aeabi_llsl)
 
 ENDPROC(__ashldi3)
 ENDPROC(__aeabi_llsl)
+#endif
+
 EXPORT_SYMBOL(__ashldi3)
 EXPORT_SYMBOL(__aeabi_llsl)
diff --git a/arch/arm/lib/ashrdi3.S b/arch/arm/lib/ashrdi3.S
index 490336e42518..99d4c06295ea 100644
--- a/arch/arm/lib/ashrdi3.S
+++ b/arch/arm/lib/ashrdi3.S
@@ -25,7 +25,10 @@ along with this program; see the file COPYING.  If not, write to
 the Free Software Foundation, 51 Franklin Street, Fifth Floor,
 Boston, MA 02110-1301, USA.  */
 
-
+#ifdef __GENKSYMS__
+extern void __ashrdi3(void);
+extern void __aeabi_lasr(void);
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -53,5 +56,6 @@ ENTRY(__aeabi_lasr)
 
 ENDPROC(__ashrdi3)
 ENDPROC(__aeabi_lasr)
+#endif
 EXPORT_SYMBOL(__ashrdi3)
 EXPORT_SYMBOL(__aeabi_lasr)
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index df06638b327c..ef60b7504525 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -1,9 +1,22 @@
+#ifdef __GENKSYMS__
+#include <linux/bitops.h>
+#define BITOP(name, instr)
+#define TESTOP(name, instr, store)
+#else
+#include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
 #include <asm/export.h>
 
+#define BITOP(name, instr)		\
+	bitop name, instr
+
+#define TESTOP(name, instr, store)	\
+	testop name, instr, store
+
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	bitop, name, instr
+	.text
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
@@ -26,10 +39,10 @@ UNWIND(	.fnstart	)
 	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 	.macro	testop, name, instr, store
+	.text
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
@@ -57,7 +70,6 @@ UNWIND(	.fnstart	)
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #else
 	.macro	bitop, name, instr
@@ -77,7 +89,6 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 /**
@@ -106,6 +117,6 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #endif
+#endif
diff --git a/arch/arm/lib/bswapsdi2.S b/arch/arm/lib/bswapsdi2.S
index f05f78247304..202dac6e74f9 100644
--- a/arch/arm/lib/bswapsdi2.S
+++ b/arch/arm/lib/bswapsdi2.S
@@ -1,3 +1,7 @@
+#ifdef __GENKSYMS__
+extern void __bswapsi2(void);
+extern void __bswapdi2(void);
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -36,5 +40,6 @@ ENTRY(__bswapdi2)
 	ret lr
 ENDPROC(__bswapdi2)
 #endif
+#endif
 EXPORT_SYMBOL(__bswapsi2)
 EXPORT_SYMBOL(__bswapdi2)
diff --git a/arch/arm/lib/changebit.S b/arch/arm/lib/changebit.S
index f4027862172f..f57c91530bd7 100644
--- a/arch/arm/lib/changebit.S
+++ b/arch/arm/lib/changebit.S
@@ -7,9 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
 #include "bitops.h"
-                .text
 
-bitop	_change_bit, eor
+BITOP(_change_bit, eor)
+EXPORT_SYMBOL(_change_bit)
diff --git a/arch/arm/lib/clear_user.S b/arch/arm/lib/clear_user.S
index b566154f5cf4..b7686501b226 100644
--- a/arch/arm/lib/clear_user.S
+++ b/arch/arm/lib/clear_user.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/uaccess.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
@@ -51,12 +54,13 @@ USER(		strnebt	r2, [r0])
 UNWIND(.fnend)
 ENDPROC(arm_clear_user)
 ENDPROC(__clear_user_std)
-#ifndef CONFIG_UACCESS_WITH_MEMCPY
-EXPORT_SYMBOL(arm_clear_user)
-#endif
 
 		.pushsection .text.fixup,"ax"
 		.align	0
 9001:		ldmfd	sp!, {r0, pc}
 		.popsection
+#endif
 
+#ifndef CONFIG_UACCESS_WITH_MEMCPY
+EXPORT_SYMBOL(arm_clear_user)
+#endif
diff --git a/arch/arm/lib/clearbit.S b/arch/arm/lib/clearbit.S
index f6b75fb64d30..54a03957d3f9 100644
--- a/arch/arm/lib/clearbit.S
+++ b/arch/arm/lib/clearbit.S
@@ -7,9 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
 #include "bitops.h"
-                .text
 
-bitop	_clear_bit, bic
+BITOP(_clear_bit, bic)
+EXPORT_SYMBOL(_clear_bit)
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index f549c57ea435..eef10215c1c5 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -9,7 +9,9 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#ifdef __GENKSYMS__
+#include <asm/uaccess.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
@@ -95,7 +97,6 @@ ENTRY(arm_copy_from_user)
 #include "copy_template.S"
 
 ENDPROC(arm_copy_from_user)
-EXPORT_SYMBOL(arm_copy_from_user)
 
 	.pushsection .fixup,"ax"
 	.align 0
@@ -108,4 +109,6 @@ EXPORT_SYMBOL(arm_copy_from_user)
 	ldr	r0, [sp], #4
 	copy_abort_end
 	.popsection
+#endif
 
+EXPORT_SYMBOL(arm_copy_from_user)
diff --git a/arch/arm/lib/copy_page.S b/arch/arm/lib/copy_page.S
index d97851d4af7a..33ea22bed977 100644
--- a/arch/arm/lib/copy_page.S
+++ b/arch/arm/lib/copy_page.S
@@ -9,6 +9,9 @@
  *
  *  ASM optimised string functions
  */
+#ifdef __GENKSYMS__
+#include <asm/uaccess.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
@@ -46,4 +49,6 @@ ENTRY(copy_page)
 	PLD(	beq	2b			)
 		ldmfd	sp!, {r4, pc}			@	3
 ENDPROC(copy_page)
+#endif
+
 EXPORT_SYMBOL(copy_page)
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index 592c179112d1..e13fbac33846 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -9,7 +9,9 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#ifdef __GENKSYMS__
+#include <asm/uaccess.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
@@ -100,9 +102,6 @@ WEAK(arm_copy_to_user)
 
 ENDPROC(arm_copy_to_user)
 ENDPROC(__copy_to_user_std)
-#ifndef CONFIG_UACCESS_WITH_MEMCPY
-EXPORT_SYMBOL(arm_copy_to_user)
-#endif
 
 	.pushsection .text.fixup,"ax"
 	.align 0
@@ -112,4 +111,8 @@ EXPORT_SYMBOL(arm_copy_to_user)
 	rsb	r0, r0, r2
 	copy_abort_end
 	.popsection
+#endif
 
+#ifndef CONFIG_UACCESS_WITH_MEMCPY
+EXPORT_SYMBOL(arm_copy_to_user)
+#endif
diff --git a/arch/arm/lib/csumipv6.S b/arch/arm/lib/csumipv6.S
index 68603b5ee537..08fb49a4671a 100644
--- a/arch/arm/lib/csumipv6.S
+++ b/arch/arm/lib/csumipv6.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/checksum.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -31,4 +34,6 @@ ENTRY(__csum_ipv6_magic)
 		adcs	r0, r0, #0
 		ldmfd	sp!, {pc}
 ENDPROC(__csum_ipv6_magic)
+#endif
+
 EXPORT_SYMBOL(__csum_ipv6_magic)
diff --git a/arch/arm/lib/csumpartial.S b/arch/arm/lib/csumpartial.S
index 830b20e81c37..524295a89c6c 100644
--- a/arch/arm/lib/csumpartial.S
+++ b/arch/arm/lib/csumpartial.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/checksum.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -141,4 +144,5 @@ ENTRY(csum_partial)
 		bne	4b
 		b	.Lless4
 ENDPROC(csum_partial)
+#endif
 EXPORT_SYMBOL(csum_partial)
diff --git a/arch/arm/lib/csumpartialcopy.S b/arch/arm/lib/csumpartialcopy.S
index 9c3383fed129..2b0d77edce39 100644
--- a/arch/arm/lib/csumpartialcopy.S
+++ b/arch/arm/lib/csumpartialcopy.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/checksum.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
@@ -49,6 +52,8 @@
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_nocheck)
 #define FN_EXIT		ENDPROC(csum_partial_copy_nocheck)
-#define FN_EXPORT	EXPORT_SYMBOL(csum_partial_copy_nocheck)
 
 #include "csumpartialcopygeneric.S"
+#endif
+
+EXPORT_SYMBOL(csum_partial_copy_nocheck)
diff --git a/arch/arm/lib/csumpartialcopygeneric.S b/arch/arm/lib/csumpartialcopygeneric.S
index 8b94d20e51d1..06825566c0f7 100644
--- a/arch/arm/lib/csumpartialcopygeneric.S
+++ b/arch/arm/lib/csumpartialcopygeneric.S
@@ -332,4 +332,3 @@ FN_ENTRY
 		mov	r5, r4, get_byte_1
 		b	.Lexit
 FN_EXIT
-FN_EXPORT
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 5d495edf3d83..45fb846a18c1 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -10,6 +10,9 @@
  * 27/03/03 Ian Molton Clean up CONFIG_CPU
  *
  */
+#ifdef __GENKSYMS__
+#include <asm/checksum.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/errno.h>
@@ -73,7 +76,6 @@
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_from_user)
 #define FN_EXIT		ENDPROC(csum_partial_copy_from_user)
-#define FN_EXPORT	EXPORT_SYMBOL(csum_partial_copy_from_user)
 
 #include "csumpartialcopygeneric.S"
 
@@ -96,3 +98,6 @@
 		bne	9002b
 		load_regs
 		.popsection
+#endif
+
+EXPORT_SYMBOL(csum_partial_copy_from_user)
diff --git a/arch/arm/lib/div64.S b/arch/arm/lib/div64.S
index 0c9e1c18fc9e..b0b05f8bfdb7 100644
--- a/arch/arm/lib/div64.S
+++ b/arch/arm/lib/div64.S
@@ -11,7 +11,10 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#ifdef __GENKSYMS__
+#include <asm/div64.h>
+extern void __do_div64(void);
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
@@ -211,4 +214,6 @@ Ldiv0_64:
 
 UNWIND(.fnend)
 ENDPROC(__do_div64)
+#endif
+
 EXPORT_SYMBOL(__do_div64)
diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 26302b8cd38f..1a238aeec6c3 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -13,6 +13,9 @@
  *   also call with zero size.
  * Reworked by rmk.
  */
+#ifdef __GENKSYMS__
+#include <linux/bitops.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -38,7 +41,6 @@ ENTRY(_find_first_zero_bit_le)
 3:		mov	r0, r1			@ no free bits
 		ret	lr
 ENDPROC(_find_first_zero_bit_le)
-EXPORT_SYMBOL(_find_first_zero_bit_le)
 
 /*
  * Purpose  : Find next 'zero' bit
@@ -59,7 +61,6 @@ ENTRY(_find_next_zero_bit_le)
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 ENDPROC(_find_next_zero_bit_le)
-EXPORT_SYMBOL(_find_next_zero_bit_le)
 
 /*
  * Purpose  : Find a 'one' bit
@@ -81,7 +82,6 @@ ENTRY(_find_first_bit_le)
 3:		mov	r0, r1			@ no free bits
 		ret	lr
 ENDPROC(_find_first_bit_le)
-EXPORT_SYMBOL(_find_first_bit_le)
 
 /*
  * Purpose  : Find next 'one' bit
@@ -101,7 +101,6 @@ ENTRY(_find_next_bit_le)
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 ENDPROC(_find_next_bit_le)
-EXPORT_SYMBOL(_find_next_bit_le)
 
 #ifdef __ARMEB__
 
@@ -121,7 +120,6 @@ ENTRY(_find_first_zero_bit_be)
 3:		mov	r0, r1			@ no free bits
 		ret	lr
 ENDPROC(_find_first_zero_bit_be)
-EXPORT_SYMBOL(_find_first_zero_bit_be)
 
 ENTRY(_find_next_zero_bit_be)
 		teq	r1, #0
@@ -139,7 +137,6 @@ ENTRY(_find_next_zero_bit_be)
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 ENDPROC(_find_next_zero_bit_be)
-EXPORT_SYMBOL(_find_next_zero_bit_be)
 
 ENTRY(_find_first_bit_be)
 		teq	r1, #0
@@ -157,7 +154,6 @@ ENTRY(_find_first_bit_be)
 3:		mov	r0, r1			@ no free bits
 		ret	lr
 ENDPROC(_find_first_bit_be)
-EXPORT_SYMBOL(_find_first_bit_be)
 
 ENTRY(_find_next_bit_be)
 		teq	r1, #0
@@ -174,7 +170,6 @@ ENTRY(_find_next_bit_be)
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 ENDPROC(_find_next_bit_be)
-EXPORT_SYMBOL(_find_next_bit_be)
 
 #endif
 
@@ -202,4 +197,14 @@ EXPORT_SYMBOL(_find_next_bit_be)
 		cmp	r1, r0			@ Clamp to maxbit
 		movlo	r0, r1
 		ret	lr
-
+#endif
+EXPORT_SYMBOL(_find_first_zero_bit_le)
+EXPORT_SYMBOL(_find_next_zero_bit_le)
+EXPORT_SYMBOL(_find_first_bit_le)
+EXPORT_SYMBOL(_find_next_bit_le)
+#ifdef __ARMEB__
+EXPORT_SYMBOL(_find_first_zero_bit_be)
+EXPORT_SYMBOL(_find_next_zero_bit_be)
+EXPORT_SYMBOL(_find_first_bit_be)
+EXPORT_SYMBOL(_find_next_bit_be)
+#endif
diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
index 9d09a38e73af..c8454e1fee32 100644
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -27,6 +27,9 @@
  * Note that ADDR_LIMIT is either 0 or 0xc0000000.
  * Note also that it is intended that __get_user_bad is not global.
  */
+#ifdef __GENKSYMS__
+#include <asm/uaccess.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/errno.h>
@@ -39,7 +42,6 @@ ENTRY(__get_user_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_1)
-EXPORT_SYMBOL(__get_user_1)
 
 ENTRY(__get_user_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad
@@ -60,7 +62,6 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_2)
-EXPORT_SYMBOL(__get_user_2)
 
 ENTRY(__get_user_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad
@@ -68,7 +69,6 @@ ENTRY(__get_user_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_4)
-EXPORT_SYMBOL(__get_user_4)
 
 ENTRY(__get_user_8)
 	check_uaccess r0, 8, r1, r2, __get_user_bad
@@ -82,7 +82,6 @@ ENTRY(__get_user_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_8)
-EXPORT_SYMBOL(__get_user_8)
 
 #ifdef __ARMEB__
 ENTRY(__get_user_32t_8)
@@ -96,7 +95,6 @@ ENTRY(__get_user_32t_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_32t_8)
-EXPORT_SYMBOL(__get_user_32t_8)
 
 ENTRY(__get_user_64t_1)
 	check_uaccess r0, 1, r1, r2, __get_user_bad8
@@ -104,7 +102,6 @@ ENTRY(__get_user_64t_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_1)
-EXPORT_SYMBOL(__get_user_64t_1)
 
 ENTRY(__get_user_64t_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad8
@@ -121,7 +118,6 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_2)
-EXPORT_SYMBOL(__get_user_64t_2)
 
 ENTRY(__get_user_64t_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad8
@@ -129,7 +125,6 @@ ENTRY(__get_user_64t_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_4)
-EXPORT_SYMBOL(__get_user_64t_4)
 #endif
 
 __get_user_bad8:
@@ -156,3 +151,15 @@ ENDPROC(__get_user_bad8)
 	.long	11b, __get_user_bad8
 #endif
 .popsection
+#endif
+
+EXPORT_SYMBOL(__get_user_1)
+EXPORT_SYMBOL(__get_user_2)
+EXPORT_SYMBOL(__get_user_4)
+EXPORT_SYMBOL(__get_user_8)
+#ifdef __ARMEB__
+EXPORT_SYMBOL(__get_user_32t_8)
+EXPORT_SYMBOL(__get_user_64t_1)
+EXPORT_SYMBOL(__get_user_64t_2)
+EXPORT_SYMBOL(__get_user_64t_4)
+#endif
diff --git a/arch/arm/lib/io-readsb.S b/arch/arm/lib/io-readsb.S
index 3dff7a3a2aef..59f6efcd552d 100644
--- a/arch/arm/lib/io-readsb.S
+++ b/arch/arm/lib/io-readsb.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/io.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -122,4 +125,5 @@ ENTRY(__raw_readsb)
 
 		ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(__raw_readsb)
+#endif
 EXPORT_SYMBOL(__raw_readsb)
diff --git a/arch/arm/lib/io-readsl.S b/arch/arm/lib/io-readsl.S
index bfd39682325b..741fa59ffbef 100644
--- a/arch/arm/lib/io-readsl.S
+++ b/arch/arm/lib/io-readsl.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/io.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -78,4 +81,5 @@ ENTRY(__raw_readsl)
 		strb	r3, [r1, #0]
 		ret	lr
 ENDPROC(__raw_readsl)
+#endif
 EXPORT_SYMBOL(__raw_readsl)
diff --git a/arch/arm/lib/io-readsw-armv3.S b/arch/arm/lib/io-readsw-armv3.S
index b3af3db6caac..ea7aab82899c 100644
--- a/arch/arm/lib/io-readsw-armv3.S
+++ b/arch/arm/lib/io-readsw-armv3.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/io.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -103,5 +106,6 @@ ENTRY(__raw_readsw)
 		strneb	r3, [r1]
 
 		ldmfd	sp!, {r4, r5, r6, pc}
+#endif
 
 EXPORT_SYMBOL(__raw_readsw)
diff --git a/arch/arm/lib/io-readsw-armv4.S b/arch/arm/lib/io-readsw-armv4.S
index 3c7a7a40b33e..bebfe63777c5 100644
--- a/arch/arm/lib/io-readsw-armv4.S
+++ b/arch/arm/lib/io-readsw-armv4.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/io.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -130,4 +133,6 @@ ENTRY(__raw_readsw)
 		strneb	ip, [r1]
 		ldmfd	sp!, {r4, pc}
 ENDPROC(__raw_readsw)
+#endif
+
 EXPORT_SYMBOL(__raw_readsw)
diff --git a/arch/arm/lib/io-writesb.S b/arch/arm/lib/io-writesb.S
index fa3633594415..28c27bd6a01b 100644
--- a/arch/arm/lib/io-writesb.S
+++ b/arch/arm/lib/io-writesb.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/io.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -93,4 +96,6 @@ ENTRY(__raw_writesb)
 
 		ldmfd	sp!, {r4, r5, pc}
 ENDPROC(__raw_writesb)
+#endif
+
 EXPORT_SYMBOL(__raw_writesb)
diff --git a/arch/arm/lib/io-writesl.S b/arch/arm/lib/io-writesl.S
index 98ed6aec0b47..51c087c8f2a4 100644
--- a/arch/arm/lib/io-writesl.S
+++ b/arch/arm/lib/io-writesl.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/io.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -66,4 +69,6 @@ ENTRY(__raw_writesl)
 		bne	6b
 		ret	lr
 ENDPROC(__raw_writesl)
+#endif
+
 EXPORT_SYMBOL(__raw_writesl)
diff --git a/arch/arm/lib/io-writesw-armv3.S b/arch/arm/lib/io-writesw-armv3.S
index 577184c082bb..691529d3d780 100644
--- a/arch/arm/lib/io-writesw-armv3.S
+++ b/arch/arm/lib/io-writesw-armv3.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/io.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -125,4 +128,6 @@ ENTRY(__raw_writesw)
 		strne	ip, [r0]
 
 		ldmfd	sp!, {r4, r5, r6, pc}
+#endif
+
 EXPORT_SYMBOL(__raw_writesw)
diff --git a/arch/arm/lib/io-writesw-armv4.S b/arch/arm/lib/io-writesw-armv4.S
index e335f489d1fc..606900a24824 100644
--- a/arch/arm/lib/io-writesw-armv4.S
+++ b/arch/arm/lib/io-writesw-armv4.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <asm/io.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -99,4 +102,5 @@ ENTRY(__raw_writesw)
 		strneh	ip, [r0]
 		ret	lr
 ENDPROC(__raw_writesw)
+#endif
 EXPORT_SYMBOL(__raw_writesw)
diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
index f541bc013bff..f93e6784e693 100644
--- a/arch/arm/lib/lib1funcs.S
+++ b/arch/arm/lib/lib1funcs.S
@@ -31,8 +31,16 @@ You should have received a copy of the GNU General Public License
 along with this program; see the file COPYING.  If not, write to
 the Free Software Foundation, 59 Temple Place - Suite 330,
 Boston, MA 02111-1307, USA.  */
-
-
+#ifdef __GENKSYMS__
+extern void __udivsi3(void);
+extern void __aeabi_uidiv(void);
+extern void __umodsi3(void);
+extern void __divsi3(void);
+extern void __aeabi_idiv(void);
+extern void __modsi3(void);
+extern void __aeabi_uidivmod(void);
+extern void __aeabi_idivmod(void);
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
@@ -239,8 +247,6 @@ UNWIND(.fnstart)
 UNWIND(.fnend)
 ENDPROC(__udivsi3)
 ENDPROC(__aeabi_uidiv)
-EXPORT_SYMBOL(__udivsi3)
-EXPORT_SYMBOL(__aeabi_uidiv)
 
 ENTRY(__umodsi3)
 UNWIND(.fnstart)
@@ -259,7 +265,6 @@ UNWIND(.fnstart)
 
 UNWIND(.fnend)
 ENDPROC(__umodsi3)
-EXPORT_SYMBOL(__umodsi3)
 
 #ifdef CONFIG_ARM_PATCH_IDIV
 	.align 3
@@ -307,8 +312,6 @@ UNWIND(.fnstart)
 UNWIND(.fnend)
 ENDPROC(__divsi3)
 ENDPROC(__aeabi_idiv)
-EXPORT_SYMBOL(__divsi3)
-EXPORT_SYMBOL(__aeabi_idiv)
 
 ENTRY(__modsi3)
 UNWIND(.fnstart)
@@ -333,7 +336,6 @@ UNWIND(.fnstart)
 
 UNWIND(.fnend)
 ENDPROC(__modsi3)
-EXPORT_SYMBOL(__modsi3)
 
 #ifdef CONFIG_AEABI
 
@@ -350,7 +352,6 @@ UNWIND(.save {r0, r1, ip, lr}	)
 
 UNWIND(.fnend)
 ENDPROC(__aeabi_uidivmod)
-EXPORT_SYMBOL(__aeabi_uidivmod)
 
 ENTRY(__aeabi_idivmod)
 UNWIND(.fnstart)
@@ -364,8 +365,6 @@ UNWIND(.save {r0, r1, ip, lr}	)
 
 UNWIND(.fnend)
 ENDPROC(__aeabi_idivmod)
-EXPORT_SYMBOL(__aeabi_idivmod)
-
 #endif
 
 Ldiv0:
@@ -378,3 +377,15 @@ UNWIND(.save {lr})
 	ldr	pc, [sp], #8
 UNWIND(.fnend)
 ENDPROC(Ldiv0)
+#endif
+
+#ifdef CONFIG_AEABI
+EXPORT_SYMBOL(__udivsi3)
+EXPORT_SYMBOL(__aeabi_uidiv)
+EXPORT_SYMBOL(__umodsi3)
+EXPORT_SYMBOL(__divsi3)
+EXPORT_SYMBOL(__aeabi_idiv)
+EXPORT_SYMBOL(__modsi3)
+EXPORT_SYMBOL(__aeabi_uidivmod)
+EXPORT_SYMBOL(__aeabi_idivmod)
+#endif
diff --git a/arch/arm/lib/lshrdi3.S b/arch/arm/lib/lshrdi3.S
index e40833981417..7d33fcf5f066 100644
--- a/arch/arm/lib/lshrdi3.S
+++ b/arch/arm/lib/lshrdi3.S
@@ -25,7 +25,10 @@ along with this program; see the file COPYING.  If not, write to
 the Free Software Foundation, 51 Franklin Street, Fifth Floor,
 Boston, MA 02110-1301, USA.  */
 
-
+#ifdef __GENKSYMS__
+extern void __lshrdi3(void);
+extern void __aeabi_llsr(void);
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -53,5 +56,7 @@ ENTRY(__aeabi_llsr)
 
 ENDPROC(__lshrdi3)
 ENDPROC(__aeabi_llsr)
+#endif
+
 EXPORT_SYMBOL(__lshrdi3)
 EXPORT_SYMBOL(__aeabi_llsr)
diff --git a/arch/arm/lib/memchr.S b/arch/arm/lib/memchr.S
index 44182bf686a5..9c4458ee1b56 100644
--- a/arch/arm/lib/memchr.S
+++ b/arch/arm/lib/memchr.S
@@ -9,6 +9,9 @@
  *
  *  ASM optimised string functions
  */
+#ifdef __GENKSYMS__
+#include <linux/string.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -25,4 +28,5 @@ ENTRY(memchr)
 2:	movne	r0, #0
 	ret	lr
 ENDPROC(memchr)
+#endif
 EXPORT_SYMBOL(memchr)
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index 1be5b6ddf37c..0f883fa80c82 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -9,6 +9,10 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <linux/string.h>
+#include <asm/io.h>
+#else
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
@@ -69,5 +73,6 @@ ENTRY(memcpy)
 
 ENDPROC(memcpy)
 ENDPROC(mmiocpy)
+#endif
 EXPORT_SYMBOL(memcpy)
 EXPORT_SYMBOL(mmiocpy)
diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
index 71dcc5400d02..c396ce2eea6d 100644
--- a/arch/arm/lib/memmove.S
+++ b/arch/arm/lib/memmove.S
@@ -9,7 +9,10 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#ifdef __GENKSYMS__
+#include <asm/io.h>
+#include <linux/string.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
@@ -226,4 +229,6 @@ ENTRY(memmove)
 18:		backward_copy_shift	push=24	pull=8
 
 ENDPROC(memmove)
+#endif
+
 EXPORT_SYMBOL(memmove)
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 7b72044cba62..ab45aec73b15 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -9,6 +9,11 @@
  *
  *  ASM optimised string functions
  */
+#ifdef __GENKSYMS__
+#include <linux/string.h>
+#include <linux/io.h>
+#else
+
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
@@ -136,5 +141,7 @@ UNWIND( .fnstart            )
 UNWIND( .fnend   )
 ENDPROC(memset)
 ENDPROC(mmioset)
+#endif
+
 EXPORT_SYMBOL(memset)
 EXPORT_SYMBOL(mmioset)
diff --git a/arch/arm/lib/memzero.S b/arch/arm/lib/memzero.S
index 6dec26ed5bcc..b9803fae82a7 100644
--- a/arch/arm/lib/memzero.S
+++ b/arch/arm/lib/memzero.S
@@ -7,6 +7,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#ifdef __GENKSYMS__
+#include <linux/string.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
@@ -136,4 +139,7 @@ UNWIND(	.fnstart			)
 	ret	lr			@ 1
 UNWIND(	.fnend				)
 ENDPROC(__memzero)
+#endif
+
 EXPORT_SYMBOL(__memzero)
+
diff --git a/arch/arm/lib/muldi3.S b/arch/arm/lib/muldi3.S
index b8f12388ccac..a677a402f6ca 100644
--- a/arch/arm/lib/muldi3.S
+++ b/arch/arm/lib/muldi3.S
@@ -9,7 +9,10 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#ifdef __GENKSYMS__
+extern void __muldi3(void);
+extern void __aeabi_lmul(void);
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -47,5 +50,7 @@ ENTRY(__aeabi_lmul)
 
 ENDPROC(__muldi3)
 ENDPROC(__aeabi_lmul)
+#endif
+
 EXPORT_SYMBOL(__muldi3)
 EXPORT_SYMBOL(__aeabi_lmul)
diff --git a/arch/arm/lib/putuser.S b/arch/arm/lib/putuser.S
index 11de126e2ed6..07afefc98748 100644
--- a/arch/arm/lib/putuser.S
+++ b/arch/arm/lib/putuser.S
@@ -27,6 +27,9 @@
  * Note that ADDR_LIMIT is either 0 or 0xc0000000
  * Note also that it is intended that __put_user_bad is not global.
  */
+#ifdef __GENKSYMS__
+#include <linux/uaccess.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/errno.h>
@@ -39,7 +42,6 @@ ENTRY(__put_user_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__put_user_1)
-EXPORT_SYMBOL(__put_user_1)
 
 ENTRY(__put_user_2)
 	check_uaccess r0, 2, r1, ip, __put_user_bad
@@ -64,7 +66,6 @@ ENTRY(__put_user_2)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__put_user_2)
-EXPORT_SYMBOL(__put_user_2)
 
 ENTRY(__put_user_4)
 	check_uaccess r0, 4, r1, ip, __put_user_bad
@@ -72,7 +73,6 @@ ENTRY(__put_user_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__put_user_4)
-EXPORT_SYMBOL(__put_user_4)
 
 ENTRY(__put_user_8)
 	check_uaccess r0, 8, r1, ip, __put_user_bad
@@ -86,7 +86,6 @@ ENTRY(__put_user_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__put_user_8)
-EXPORT_SYMBOL(__put_user_8)
 
 __put_user_bad:
 	mov	r0, #-EFAULT
@@ -101,3 +100,9 @@ ENDPROC(__put_user_bad)
 	.long	5b, __put_user_bad
 	.long	6b, __put_user_bad
 .popsection
+#endif
+
+EXPORT_SYMBOL(__put_user_1)
+EXPORT_SYMBOL(__put_user_2)
+EXPORT_SYMBOL(__put_user_4)
+EXPORT_SYMBOL(__put_user_8)
diff --git a/arch/arm/lib/setbit.S b/arch/arm/lib/setbit.S
index 618fedae4b37..0a3dd9d36929 100644
--- a/arch/arm/lib/setbit.S
+++ b/arch/arm/lib/setbit.S
@@ -7,9 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
 #include "bitops.h"
-		.text
 
-bitop	_set_bit, orr
+BITOP(_set_bit, orr)
+EXPORT_SYMBOL(_set_bit)
diff --git a/arch/arm/lib/strchr.S b/arch/arm/lib/strchr.S
index 7301f6e6046c..14aae6132e98 100644
--- a/arch/arm/lib/strchr.S
+++ b/arch/arm/lib/strchr.S
@@ -9,6 +9,9 @@
  *
  *  ASM optimised string functions
  */
+#ifdef __GENKSYMS__
+#include <linux/string.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -26,4 +29,5 @@ ENTRY(strchr)
 		subeq	r0, r0, #1
 		ret	lr
 ENDPROC(strchr)
+#endif
 EXPORT_SYMBOL(strchr)
diff --git a/arch/arm/lib/strrchr.S b/arch/arm/lib/strrchr.S
index aaf9fd98b754..5e640e61605f 100644
--- a/arch/arm/lib/strrchr.S
+++ b/arch/arm/lib/strrchr.S
@@ -9,6 +9,9 @@
  *
  *  ASM optimised string functions
  */
+#ifdef __GENKSYMS__
+#include <linux/string.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -25,4 +28,5 @@ ENTRY(strrchr)
 		mov	r0, r3
 		ret	lr
 ENDPROC(strrchr)
+#endif
 EXPORT_SYMBOL(strrchr)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4becdc3a59cb..c3d9df7c83e2 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -7,9 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
 #include "bitops.h"
-                .text
 
-testop	_test_and_change_bit, eor, str
+TESTOP(_test_and_change_bit, eor, str)
+EXPORT_SYMBOL(_test_and_change_bit)
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 918841dcce7a..afe81e3f8688 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -7,9 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
 #include "bitops.h"
-                .text
 
-testop	_test_and_clear_bit, bicne, strne
+TESTOP(_test_and_clear_bit, bicne, strne)
+EXPORT_SYMBOL(_test_and_clear_bit)
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index 8d1b2fe9e487..d9f6115a3208 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -7,9 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/linkage.h>
-#include <asm/assembler.h>
 #include "bitops.h"
-                .text
 
-testop	_test_and_set_bit, orreq, streq
+TESTOP(_test_and_set_bit, orreq, streq)
+EXPORT_SYMBOL(_test_and_set_bit)
diff --git a/arch/arm/lib/ucmpdi2.S b/arch/arm/lib/ucmpdi2.S
index 127a91af46f3..e70cd62005c8 100644
--- a/arch/arm/lib/ucmpdi2.S
+++ b/arch/arm/lib/ucmpdi2.S
@@ -9,7 +9,10 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-
+#ifdef __GENKSYMS__
+extern void __ucmpdi2(void);
+extern void __aeabi_ulcmp(void);
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -36,7 +39,6 @@ ENTRY(__ucmpdi2)
 	ret	lr
 
 ENDPROC(__ucmpdi2)
-EXPORT_SYMBOL(__ucmpdi2)
 
 #ifdef CONFIG_AEABI
 
@@ -50,7 +52,11 @@ ENTRY(__aeabi_ulcmp)
 	ret	lr
 
 ENDPROC(__aeabi_ulcmp)
-EXPORT_SYMBOL(__aeabi_ulcmp)
 
 #endif
+#endif
 
+EXPORT_SYMBOL(__ucmpdi2)
+#ifdef CONFIG_AEABI
+EXPORT_SYMBOL(__aeabi_ulcmp)
+#endif
diff --git a/arch/arm/mach-imx/ssi-fiq.S b/arch/arm/mach-imx/ssi-fiq.S
index fd7917f1c204..db9611e17068 100644
--- a/arch/arm/mach-imx/ssi-fiq.S
+++ b/arch/arm/mach-imx/ssi-fiq.S
@@ -5,7 +5,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
+#ifdef __GENKSYMS__
+#include <linux/platform_data/asoc-imx-ssi.h>
+#else
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
@@ -145,6 +147,8 @@ imx_ssi_fiq_tx_buffer:
 		.word 0x0
 .L_imx_ssi_fiq_end:
 imx_ssi_fiq_end:
+#endif
+
 EXPORT_SYMBOL(imx_ssi_fiq_tx_buffer)
 EXPORT_SYMBOL(imx_ssi_fiq_rx_buffer)
 EXPORT_SYMBOL(imx_ssi_fiq_start)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 81e0d70e7dd4..3eb30b551c26 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -160,7 +160,7 @@ $(obj)/%.i: $(src)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)
 
 cmd_gensymtypes =                                                           \
-    $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
+    $(CPP) -D'EXPORT_SYMBOL(x)=EXPORT_SYMBOL(x);' -D__GENKSYMS__ $(c_flags) $< | \
     $(GENKSYMS) $(if $(1), -T $(2))                                         \
      $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
@@ -180,9 +180,11 @@ $(obj)/%.symtypes : $(src)/%.c FORCE
 # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
+quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
 
 ifndef CONFIG_MODVERSIONS
 cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
+cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
 
 else
 # When module versioning is enabled the following steps are executed:
@@ -198,6 +200,7 @@ else
 #   the actual value of the checksum generated by genksyms
 
 cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
+cmd_as_o_S = $(CC) $(a_flags) -c -o $(@D)/.tmp_$(@F) $<
 cmd_modversions =								\
 	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
 		$(call cmd_gensymtypes,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
@@ -275,6 +278,7 @@ endef
 
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)					  \
+	$(cmd_modversions)						  \
 	$(cmd_objtool)
 endef
 
@@ -311,6 +315,9 @@ $(obj)/%.lst: $(src)/%.c FORCE
 
 modkern_aflags := $(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL)
 
+$(obj)/%.o: $(src)/%.S $(objtool_obj) FORCE
+	$(call if_changed_rule,as_o_S)
+
 $(real-objs-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 $(real-objs-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
 
@@ -320,12 +327,6 @@ cmd_cpp_s_S       = $(CPP) $(a_flags) -o $@ $<
 $(obj)/%.s: $(src)/%.S FORCE
 	$(call if_changed_dep,cpp_s_S)
 
-quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
-cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<
-
-$(obj)/%.o: $(src)/%.S $(objtool_obj) FORCE
-	$(call if_changed_rule,as_o_S)
-
 targets += $(real-objs-y) $(real-objs-m) $(lib-y)
 targets += $(extra-y) $(MAKECMDGOALS) $(always)
 
