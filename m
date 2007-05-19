Return-Path: <anton@ozlabs.org>
Date: Sat, 19 May 2007 00:22:41 -0500
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org
Subject: [PATCH] Add missing pmc_type fields in cpu_table
Message-ID: <20070519052241.GA510@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


A number of cpu_table entries were missing the pmc_type field. Add them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Candidate for stable.

Considering the number of places missed, I wonder if it makes sense for
the fallback case to be PPC_PMC_IBM. 

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9cb24d2..e054409 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -235,6 +235,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_ppc970,
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970MP",
@@ -251,6 +252,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
+		.pmc_type		= PPC_PMC_IBM,
 		.cpu_setup		= __setup_cpu_ppc970MP,
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970MP",
@@ -317,6 +320,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power6",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
@@ -335,6 +339,7 @@ static struct cpu_spec cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power6",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
