Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 19 Sep 2005 23:18:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050919231831.6ffa7530.sfr@canb.auug.org.au>
In-Reply-To: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
References: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/6] powerpc: rename op_ppc{32, 64}_model to op_powerpc_model
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/ppc/oprofile/common.c             |    2 +-
 arch/ppc/oprofile/op_impl.h            |    2 +-
 arch/ppc/oprofile/op_model_fsl_booke.c |    2 +-
 arch/ppc64/oprofile/common.c           |    2 +-
 arch/ppc64/oprofile/op_model_power4.c  |    2 +-
 arch/ppc64/oprofile/op_model_rs64.c    |    2 +-
 include/asm-ppc/perfmon.h              |    2 +-
 include/asm-ppc64/cputable.h           |    4 ++--
 include/asm-ppc64/oprofile_impl.h      |    6 +++---
 9 files changed, 12 insertions(+), 12 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

2be7f59a0dbd2d2b0eb48384c64977980cca061e
diff --git a/arch/ppc/oprofile/common.c b/arch/ppc/oprofile/common.c
--- a/arch/ppc/oprofile/common.c
+++ b/arch/ppc/oprofile/common.c
@@ -25,7 +25,7 @@
 
 #include "op_impl.h"
 
-static struct op_ppc32_model *model;
+static struct op_powerpc_model *model;
 
 static struct op_counter_config ctr[OP_MAX_COUNTER];
 static struct op_system_config sys;
diff --git a/arch/ppc/oprofile/op_impl.h b/arch/ppc/oprofile/op_impl.h
--- a/arch/ppc/oprofile/op_impl.h
+++ b/arch/ppc/oprofile/op_impl.h
@@ -31,7 +31,7 @@ struct op_system_config {
 };
 
 /* Per-arch configuration */
-struct op_ppc32_model {
+struct op_powerpc_model {
 	void (*reg_setup) (struct op_counter_config *,
 			   struct op_system_config *,
 			   int num_counters);
diff --git a/arch/ppc/oprofile/op_model_fsl_booke.c b/arch/ppc/oprofile/op_model_fsl_booke.c
--- a/arch/ppc/oprofile/op_model_fsl_booke.c
+++ b/arch/ppc/oprofile/op_model_fsl_booke.c
@@ -176,7 +176,7 @@ static void fsl_booke_handle_interrupt(s
 	pmc_start_ctrs(1);
 }
 
-struct op_ppc32_model op_model_fsl_booke = {
+struct op_powerpc_model op_model_fsl_booke = {
 	.reg_setup		= fsl_booke_reg_setup,
 	.start			= fsl_booke_start,
 	.stop			= fsl_booke_stop,
diff --git a/arch/ppc64/oprofile/common.c b/arch/ppc64/oprofile/common.c
--- a/arch/ppc64/oprofile/common.c
+++ b/arch/ppc64/oprofile/common.c
@@ -19,7 +19,7 @@
 #include <asm/cputable.h>
 #include <asm/oprofile_impl.h>
 
-static struct op_ppc64_model *model;
+static struct op_powerpc_model *model;
 
 static struct op_counter_config ctr[OP_MAX_COUNTER];
 static struct op_system_config sys;
diff --git a/arch/ppc64/oprofile/op_model_power4.c b/arch/ppc64/oprofile/op_model_power4.c
--- a/arch/ppc64/oprofile/op_model_power4.c
+++ b/arch/ppc64/oprofile/op_model_power4.c
@@ -300,7 +300,7 @@ static void power4_handle_interrupt(stru
 	mtspr(SPRN_MMCR0, mmcr0);
 }
 
-struct op_ppc64_model op_model_power4 = {
+struct op_powerpc_model op_model_power4 = {
 	.reg_setup		= power4_reg_setup,
 	.cpu_setup		= power4_cpu_setup,
 	.start			= power4_start,
diff --git a/arch/ppc64/oprofile/op_model_rs64.c b/arch/ppc64/oprofile/op_model_rs64.c
--- a/arch/ppc64/oprofile/op_model_rs64.c
+++ b/arch/ppc64/oprofile/op_model_rs64.c
@@ -209,7 +209,7 @@ static void rs64_handle_interrupt(struct
 	mtspr(SPRN_MMCR0, mmcr0);
 }
 
-struct op_ppc64_model op_model_rs64 = {
+struct op_powerpc_model op_model_rs64 = {
 	.reg_setup		= rs64_reg_setup,
 	.cpu_setup		= rs64_cpu_setup,
 	.start			= rs64_start,
diff --git a/include/asm-ppc/perfmon.h b/include/asm-ppc/perfmon.h
--- a/include/asm-ppc/perfmon.h
+++ b/include/asm-ppc/perfmon.h
@@ -16,7 +16,7 @@ void pmc_start_ctrs(int enable);
 void pmc_stop_ctrs(void);
 void dump_pmcs(void);
 
-extern struct op_ppc32_model op_model_fsl_booke;
+extern struct op_powerpc_model op_model_fsl_booke;
 #endif
 
 #endif /* __PERFMON_H */
diff --git a/include/asm-ppc64/cputable.h b/include/asm-ppc64/cputable.h
--- a/include/asm-ppc64/cputable.h
+++ b/include/asm-ppc64/cputable.h
@@ -36,7 +36,7 @@
  * via the mkdefs mechanism.
  */
 struct cpu_spec;
-struct op_ppc64_model;
+struct op_powerpc_model;
 
 typedef	void (*cpu_setup_t)(unsigned long offset, struct cpu_spec* spec);
 
@@ -65,7 +65,7 @@ struct cpu_spec {
 	char		*oprofile_cpu_type;
 
 	/* Processor specific oprofile operations */
-	struct op_ppc64_model *oprofile_model;
+	struct op_powerpc_model *oprofile_model;
 };
 
 extern struct cpu_spec		cpu_specs[];
diff --git a/include/asm-ppc64/oprofile_impl.h b/include/asm-ppc64/oprofile_impl.h
--- a/include/asm-ppc64/oprofile_impl.h
+++ b/include/asm-ppc64/oprofile_impl.h
@@ -37,7 +37,7 @@ struct op_system_config {
 };
 
 /* Per-arch configuration */
-struct op_ppc64_model {
+struct op_powerpc_model {
 	void (*reg_setup) (struct op_counter_config *,
 			   struct op_system_config *,
 			   int num_counters);
@@ -49,8 +49,8 @@ struct op_ppc64_model {
 	int num_counters;
 };
 
-extern struct op_ppc64_model op_model_rs64;
-extern struct op_ppc64_model op_model_power4;
+extern struct op_powerpc_model op_model_rs64;
+extern struct op_powerpc_model op_model_power4;
 
 static inline unsigned int ctr_read(unsigned int i)
 {
