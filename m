Return-Path: <jwboyer@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 61958DDE17
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 07:30:25 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 17so711144ugm.14
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Dec 2008 12:30:23 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 8 Dec 2008 15:30:11 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/9] powerpc/4xx: Extended DCR support
Message-ID: <20081208203011.GB10929@yoda.jdub.homelinux.org>
References: <1228714789.103940.266501677728.qpush@grosgo>
	<20081208054057.34A5FDDD04@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081208054057.34A5FDDD04@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 08, 2008 at 04:40:03PM +1100, Benjamin Herrenschmidt wrote:
>This adds supports to the "extended" DCR addressing via
>the indirect mfdcrx/mtdcrx instructions supported by some
>4xx cores (440H6 and later)
>
>I enabled the feature for now only on AMCC 460 chips
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>---
>
> arch/powerpc/include/asm/cputable.h   |    7 ++-
> arch/powerpc/include/asm/dcr-native.h |   63 +++++++++++++++++++++++++++-------
> arch/powerpc/kernel/cputable.c        |    4 +-
> arch/powerpc/sysdev/dcr-low.S         |    8 +++-
> 4 files changed, 65 insertions(+), 17 deletions(-)
>
>--- linux-work.orig/arch/powerpc/include/asm/cputable.h	2008-12-08 15:43:12.000000000 +1100
>+++ linux-work/arch/powerpc/include/asm/cputable.h	2008-12-08 15:43:41.000000000 +1100
>@@ -164,6 +164,7 @@ extern const char *powerpc_base_platform
> #define CPU_FTR_NEED_PAIRED_STWCX	ASM_CONST(0x0000000004000000)
> #define CPU_FTR_LWSYNC			ASM_CONST(0x0000000008000000)
> #define CPU_FTR_NOEXECUTE		ASM_CONST(0x0000000010000000)
>+#define CPU_FTR_INDEXED_DCR		ASM_CONST(0x0000000020000000)
> 
> /*
>  * Add the 64-bit processor unique features in the top half of the word;
>@@ -369,6 +370,8 @@ extern const char *powerpc_base_platform
> #define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
> #define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
> #define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
>+#define CPU_FTRS_440H6	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE | \
>+	    CPU_FTR_INDEXED_DCR)

Can we call this CPU_FTRS_440x6 please?  The H really has no relevance
here from what I understand as both the hard and synthysized x6 cores
would do the indexed instructions.

Also, I have some plans in mind for consolidating the mcheck
organization (which has nothing to do with this exactly) and I was
going to use 440x5 to map all the various SoCs that share that core
revision.

Probably a nit, but maybe worth changing.

>Index: linux-work/arch/powerpc/include/asm/dcr-native.h
>===================================================================
>--- linux-work.orig/arch/powerpc/include/asm/dcr-native.h	2008-09-29 14:21:37.000000000 +1000
>+++ linux-work/arch/powerpc/include/asm/dcr-native.h	2008-12-08 15:43:41.000000000 +1100
>@@ -23,6 +23,7 @@
> #ifndef __ASSEMBLY__
> 
> #include <linux/spinlock.h>
>+#include <asm/cputable.h>
> 
> typedef struct {
> 	unsigned int base;
>@@ -39,23 +40,45 @@ static inline bool dcr_map_ok_native(dcr
> #define dcr_read_native(host, dcr_n)		mfdcr(dcr_n + host.base)
> #define dcr_write_native(host, dcr_n, value)	mtdcr(dcr_n + host.base, value)
> 
>-/* Device Control Registers */
>-void __mtdcr(int reg, unsigned int val);
>-unsigned int __mfdcr(int reg);
>+/* Table based DCR accessors */
>+extern void __mtdcr(unsigned int reg, unsigned int val);
>+extern unsigned int __mfdcr(unsigned int reg);
>+
>+/* mfdcrx/mtdcrx instruction based accessors. We hand code
>+ * the opcodes in order not to depend on newer binutils
>+ */
>+static inline unsigned int mfdcrx(unsigned int reg)
>+{
>+	unsigned int ret;
>+	asm volatile(".long 0x7c000206 | (%0 << 21) | (%1 << 16)"
>+		     : "=r" (ret) : "r" (reg));
>+	return ret;
>+}
>+
>+static inline void mtdcrx(unsigned int reg, unsigned int val)
>+{
>+	asm volatile(".long 0x7c000306 | (%0 << 21) | (%1 << 16)"
>+		     : : "r" (val), "r" (reg));
>+}
>+
> #define mfdcr(rn)						\
> 	({unsigned int rval;					\
>-	if (__builtin_constant_p(rn))				\
>+	if (__builtin_constant_p(rn) && rn < 1024)		\
> 		asm volatile("mfdcr %0," __stringify(rn)	\
> 		              : "=r" (rval));			\
>+	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
>+		rval = mfdcrx(rn);				\
> 	else							\
> 		rval = __mfdcr(rn);				\
> 	rval;})
> 
> #define mtdcr(rn, v)						\
> do {								\
>-	if (__builtin_constant_p(rn))				\
>+	if (__builtin_constant_p(rn) && rn < 1024)		\
> 		asm volatile("mtdcr " __stringify(rn) ",%0"	\
> 			      : : "r" (v)); 			\
>+	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
>+		mtdcrx(rn, v);					\
> 	else							\
> 		__mtdcr(rn, v);					\

I'm wondering how much that is worth it.  Aren't you adding a
runtime if here (and in the *dcri functions), which might
impact performance for anything not implementing m*dcrx?

Does anyone know how much impact this has either way, and if
it's significant could it be patched out after the CPU
features are set?

josh
