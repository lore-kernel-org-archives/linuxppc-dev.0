Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <30c3ca265326d7aaa86cc75367d23739398a7b23.1235355941.git.michael@ellerman.id.au>
In-Reply-To: <689159d7e17a2227e6000b51911750503eed1778.1235355941.git.michael@ellerman.id.au>
References: <689159d7e17a2227e6000b51911750503eed1778.1235355941.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] Make sure we copy all cpu_spec features except PMC
	related ones
Date: Mon, 23 Feb 2009 13:25:45 +1100 (EST)
Cc: Paul Mackerras <paulus@samba.org>, shaggy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When identify_cpu() is called a second time with a logical PVR, it
only copies a subset of the cpu_spec fields so as to avoid overwriting
the performance monitor fields that were initialized based on the
real PVR.

However some of the other, non performance monitor related fields are
also not copied:
 * pvr_mask
 * pvr_value
 * mmu_features
 * machine_check

The fact that pvr_mask is not copied can result in show_cpuinfo()
showing the cpu as "unknown", if we override an unknown PVR with a
logical one - as reported by Shaggy.

So change the logic to copy all fields, and then put back the PMC
related ones in the case that we're overwriting a real PVR with a
logical one.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/cputable.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 944bd01..77febd3 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1765,22 +1765,27 @@ static struct cpu_spec the_cpu_spec;
 static void __init setup_cpu_spec(unsigned long offset, struct cpu_spec *s)
 {
 	struct cpu_spec *t = &the_cpu_spec;
+	struct cpu_spec old;
+
 	t = PTRRELOC(t);
+	old = *t;
+
+	/* Copy everything, then do fixups */
+	*t = *s;
 
 	/*
 	 * If we are overriding a previous value derived from the real
 	 * PVR with a new value obtained using a logical PVR value,
 	 * don't modify the performance monitor fields.
 	 */
-	if (t->num_pmcs && !s->num_pmcs) {
-		t->cpu_name = s->cpu_name;
-		t->cpu_features = s->cpu_features;
-		t->cpu_user_features = s->cpu_user_features;
-		t->icache_bsize = s->icache_bsize;
-		t->dcache_bsize = s->dcache_bsize;
-		t->cpu_setup = s->cpu_setup;
-		t->cpu_restore = s->cpu_restore;
-		t->platform = s->platform;
+	if (old.num_pmcs && !s->num_pmcs) {
+		t->num_pmcs = old.num_pmcs;
+		t->pmc_type = old.pmc_type;
+		t->oprofile_type = old.oprofile_type;
+		t->oprofile_mmcra_sihv = old.oprofile_mmcra_sihv;
+		t->oprofile_mmcra_sipr = old.oprofile_mmcra_sipr;
+		t->oprofile_mmcra_clear = old.oprofile_mmcra_clear;
+
 		/*
 		 * If we have passed through this logic once before and
 		 * have pulled the default case because the real PVR was
@@ -1794,10 +1799,9 @@ static void __init setup_cpu_spec(unsigned long offset, struct cpu_spec *s)
 		 * and, in that case, keep the current value for
 		 * oprofile_cpu_type.
 		 */
-		if (t->oprofile_cpu_type == NULL)
+		if (old.oprofile_cpu_type == NULL)
 			t->oprofile_cpu_type = s->oprofile_cpu_type;
-	} else
-		*t = *s;
+	}
 
 	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
 
-- 
1.5.5
