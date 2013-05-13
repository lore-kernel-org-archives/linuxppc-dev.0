Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3] powerpc: provide __bswapdi2
Date: Mon, 13 May 2013 20:23:38 +1000
Message-Id: <1368440618-27383-1-git-send-email-mikey@neuling.org>
In-Reply-To: <20130513073319.GA5886@visitor2.iram.es>
References: <20130513073319.GA5886@visitor2.iram.es>
Cc: mikey@neuling.org, David Woodhouse <David.Woodhouse@intel.com>,
 linuxppc-dev@lists.ozlabs.org, viro@zeniv.linux.org.uk,
 David Woodhouse <dwmw2@infradead.org>
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
---
Fixes from Gabriel.

 arch/powerpc/kernel/misc_32.S   |   11 +++++++++++
 arch/powerpc/kernel/misc_64.S   |   11 +++++++++++
 arch/powerpc/kernel/ppc_ksyms.c |    3 ++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 19e096b..e469f30 100644
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
+	mr      r3,r9
+	mr      r4,r10
+	blr
+
 _GLOBAL(abs)
 	srawi	r4,r3,31
 	xor	r3,r3,r4
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 5cfa800..6820e45 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -234,6 +234,17 @@ _GLOBAL(__flush_dcache_icache)
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
+	or	r3,r7,r9
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
-- 
1.7.10.4
