Return-Path: <geoff@infradead.org>
Message-Id: <f9fda8ea9d2ef07dd5b3313892ec20b6cbad2ce8.1360810584.git.geoff@infradead.org>
In-Reply-To: <cover.1360810584.git.geoff@infradead.org>
References: <cover.1360810584.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 4/4] powerpc: Move boot_paca into early_setup
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 14 Feb 2013 03:03:16 +0000
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc boot_paca symbol is now only used within the
early_setup() routine, so move it from its global definition
into early_setup().

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/include/asm/paca.h |    1 -
 arch/powerpc/kernel/paca.c      |    2 --
 arch/powerpc/kernel/setup_64.c  |    2 ++
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e9e7a69..45e87b7 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -167,7 +167,6 @@ struct paca_struct {
 };
 
 extern struct paca_struct *paca;
-extern __initdata struct paca_struct boot_paca;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
 extern void setup_paca(struct paca_struct *new_paca);
 extern void allocate_pacas(void);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index cd6da85..f8f2468 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -120,8 +120,6 @@ struct slb_shadow slb_shadow[] __cacheline_aligned = {
 struct paca_struct *paca;
 EXPORT_SYMBOL(paca);
 
-struct paca_struct boot_paca;
-
 void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 {
        /* The TOC register (GPR2) points 32kB into the TOC, so that 64kB
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6da881b..f2514e1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -177,6 +177,8 @@ early_param("smt-enabled", early_smt_enabled);
 
 void __init early_setup(unsigned long dt_ptr)
 {
+	static __initdata struct paca_struct boot_paca;
+
 	/* -------- printk is _NOT_ safe to use here ! ------- */
 
 	/* Identify CPU type */
-- 
1.7.9.5
