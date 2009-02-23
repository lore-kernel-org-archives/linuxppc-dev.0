Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <689159d7e17a2227e6000b51911750503eed1778.1235355941.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/2] Deindentify identify_cpu()
Date: Mon, 23 Feb 2009 13:25:43 +1100 (EST)
Cc: Paul Mackerras <paulus@samba.org>, shaggy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The for-loop body of identify_cpu() has gotten a little big, so move the
loop body logic into a separate function. No other changes.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/cputable.c |  122 +++++++++++++++++++++-------------------
 1 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 923f87a..944bd01 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1762,74 +1762,80 @@ static struct cpu_spec __initdata cpu_specs[] = {
 
 static struct cpu_spec the_cpu_spec;
 
-struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
+static void __init setup_cpu_spec(unsigned long offset, struct cpu_spec *s)
 {
-	struct cpu_spec *s = cpu_specs;
 	struct cpu_spec *t = &the_cpu_spec;
-	int i;
-
-	s = PTRRELOC(s);
 	t = PTRRELOC(t);
 
-	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++)
-		if ((pvr & s->pvr_mask) == s->pvr_value) {
-			/*
-			 * If we are overriding a previous value derived
-			 * from the real PVR with a new value obtained
-			 * using a logical PVR value, don't modify the
-			 * performance monitor fields.
-			 */
-			if (t->num_pmcs && !s->num_pmcs) {
-				t->cpu_name = s->cpu_name;
-				t->cpu_features = s->cpu_features;
-				t->cpu_user_features = s->cpu_user_features;
-				t->icache_bsize = s->icache_bsize;
-				t->dcache_bsize = s->dcache_bsize;
-				t->cpu_setup = s->cpu_setup;
-				t->cpu_restore = s->cpu_restore;
-				t->platform = s->platform;
-				/*
-				 * If we have passed through this logic once
-				 * before and have pulled the default case
-				 * because the real PVR was not found inside
-				 * cpu_specs[], then we are possibly running in
-				 * compatibility mode. In that case, let the
-				 * oprofiler know which set of compatibility
-				 * counters to pull from by making sure the
-				 * oprofile_cpu_type string is set to that of
-				 * compatibility mode. If the oprofile_cpu_type
-				 * already has a value, then we are possibly
-				 * overriding a real PVR with a logical one, and,
-				 * in that case, keep the current value for
-				 * oprofile_cpu_type.
-				 */
-				if (t->oprofile_cpu_type == NULL)
-					t->oprofile_cpu_type = s->oprofile_cpu_type;
-			} else
-				*t = *s;
-			*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
+	/*
+	 * If we are overriding a previous value derived from the real
+	 * PVR with a new value obtained using a logical PVR value,
+	 * don't modify the performance monitor fields.
+	 */
+	if (t->num_pmcs && !s->num_pmcs) {
+		t->cpu_name = s->cpu_name;
+		t->cpu_features = s->cpu_features;
+		t->cpu_user_features = s->cpu_user_features;
+		t->icache_bsize = s->icache_bsize;
+		t->dcache_bsize = s->dcache_bsize;
+		t->cpu_setup = s->cpu_setup;
+		t->cpu_restore = s->cpu_restore;
+		t->platform = s->platform;
+		/*
+		 * If we have passed through this logic once before and
+		 * have pulled the default case because the real PVR was
+		 * not found inside cpu_specs[], then we are possibly
+		 * running in compatibility mode. In that case, let the
+		 * oprofiler know which set of compatibility counters to
+		 * pull from by making sure the oprofile_cpu_type string
+		 * is set to that of compatibility mode. If the
+		 * oprofile_cpu_type already has a value, then we are
+		 * possibly overriding a real PVR with a logical one,
+		 * and, in that case, keep the current value for
+		 * oprofile_cpu_type.
+		 */
+		if (t->oprofile_cpu_type == NULL)
+			t->oprofile_cpu_type = s->oprofile_cpu_type;
+	} else
+		*t = *s;
+
+	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
 
-			/*
-			 * Set the base platform string once; assumes
-			 * we're called with real pvr first.
-			 */
-			if (*PTRRELOC(&powerpc_base_platform) == NULL)
-				*PTRRELOC(&powerpc_base_platform) = t->platform;
+	/*
+	 * Set the base platform string once; assumes
+	 * we're called with real pvr first.
+	 */
+	if (*PTRRELOC(&powerpc_base_platform) == NULL)
+		*PTRRELOC(&powerpc_base_platform) = t->platform;
 
 #if defined(CONFIG_PPC64) || defined(CONFIG_BOOKE)
-			/* ppc64 and booke expect identify_cpu to also call
-			 * setup_cpu for that processor. I will consolidate
-			 * that at a later time, for now, just use #ifdef.
-			 * we also don't need to PTRRELOC the function pointer
-			 * on ppc64 and booke as we are running at 0 in real
-			 * mode on ppc64 and reloc_offset is always 0 on booke.
-			 */
-			if (s->cpu_setup) {
-				s->cpu_setup(offset, s);
-			}
+	/* ppc64 and booke expect identify_cpu to also call setup_cpu for
+	 * that processor. I will consolidate that at a later time, for now,
+	 * just use #ifdef. We also don't need to PTRRELOC the function
+	 * pointer on ppc64 and booke as we are running at 0 in real mode
+	 * on ppc64 and reloc_offset is always 0 on booke.
+	 */
+	if (s->cpu_setup) {
+		s->cpu_setup(offset, s);
+	}
 #endif /* CONFIG_PPC64 || CONFIG_BOOKE */
+}
+
+struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
+{
+	struct cpu_spec *s = cpu_specs;
+	int i;
+
+	s = PTRRELOC(s);
+
+	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++) {
+		if ((pvr & s->pvr_mask) == s->pvr_value) {
+			setup_cpu_spec(offset, s);
 			return s;
 		}
+	}
+
 	BUG();
+
 	return NULL;
 }
-- 
1.5.5
