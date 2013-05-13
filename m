Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2] powerpc: provide __bswapdi2
In-reply-to: <9813.1368428999@ale.ozlabs.ibm.com>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
 <9813.1368428999@ale.ozlabs.ibm.com>
Date: Mon, 13 May 2013 17:20:15 +1000
Message-ID: <12161.1368429615@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: David Woodhouse <David.Woodhouse@intel.com>

Some versions of GCC apparently expect this to be provided by libgcc.

Updates from Mikey to fix 32 bit version and adding "r" to registers.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 19e096b..3bcaa7ee 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -657,6 +657,17 @@ _GLOBAL(__ucmpdi2)
 	li	r3,2
 	blr
 
+_GLOBAL(__bswapdi2)
+	rotlwi  r9,r4,8
+	rotlwi  r10,r3,8
+	rlwimi  r9,r4,24,0,7
+	rlwimi  r10,r3,24,0,7
+	rlwimi  r9,r4,24,16,23
+	rlwimi  r10,r3,24,16,23
+	mr      r4,r10
+	mr      r3,r9
+	blr
+
 _GLOBAL(abs)
 	srawi	r4,r3,31
 	xor	r3,r3,r4
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 5cfa800..637bd82 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -234,6 +234,18 @@ _GLOBAL(__flush_dcache_icache)
 	isync
 	blr
 
+_GLOBAL(__bswapdi2)
+	srdi	r8,r3,32
+	rlwinm	r7,r3,8,0xffffffff
+	rlwimi	r7,r3,24,0,7
+	rlwinm	r9,r8,8,0xffffffff
+	rlwimi	r7,r3,24,16,23
+	rlwimi	r9,r8,24,0,7
+	rlwimi	r9,r8,24,16,23
+	sldi	r7,r7,32
+	or	r7,r7,r9
+	mr	r3,r7
+	blr
 
 #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
 /*
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 78b8766..c296665 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -143,7 +143,8 @@ EXPORT_SYMBOL(__lshrdi3);
 int __ucmpdi2(unsigned long long, unsigned long long);
 EXPORT_SYMBOL(__ucmpdi2);
 #endif
-
+long long __bswapdi2(long long);
+EXPORT_SYMBOL(__bswapdi2);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
