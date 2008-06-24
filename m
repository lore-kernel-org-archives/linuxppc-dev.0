Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <4405563e1705f79e64477ec96f39abb4d57397dc.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 12/14] powerpc: Add logic to patch alternative feature sections
Date: Tue, 24 Jun 2008 11:33:02 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the logic to patch alternative sections. This is fairly
straight forward, except for branches. Relative branches that jump from
inside the else section to outside of it, need to be translated as they're
moved, otherwise they will jump to the wrong location.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/lib/feature-fixups.c |   79 ++++++++++++++++++++++++++++++-------
 1 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 973d547..174c1eb 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -26,24 +26,66 @@ struct fixup_entry {
 	long		alt_end_off;
 };
 
-static void patch_feature_section(unsigned long value, struct fixup_entry *fcur)
+static unsigned int *calc_addr(struct fixup_entry *fcur, long offset)
 {
-	unsigned int *pstart, *pend, *p;
+	/*
+	 * We store the offset to the code as a negative offset from
+	 * the start of the alt_entry, to support the VDSO. This
+	 * routine converts that back into an actual address.
+	 */
+	return (unsigned int *)((unsigned long)fcur + offset);
+}
+
+static int patch_alt_instruction(unsigned int *src, unsigned int *dest,
+				 unsigned int *alt_start, unsigned int *alt_end)
+{
+	unsigned int instr;
+
+	instr = *src;
+
+	if (instr_is_relative_branch(*src)) {
+		unsigned int *target = (unsigned int *)branch_target(src);
+
+		/* Branch within the section doesn't need translating */
+		if (target < alt_start || target >= alt_end) {
+			instr = translate_branch(dest, src);
+			if (!instr)
+				return 1;
+		}
+	}
+
+	patch_instruction(dest, instr);
+
+	return 0;
+}
+
+static int patch_feature_section(unsigned long value, struct fixup_entry *fcur)
+{
+	unsigned int *start, *end, *alt_start, *alt_end, *src, *dest;
+
+	start = calc_addr(fcur, fcur->start_off);
+	end = calc_addr(fcur, fcur->end_off);
+	alt_start = calc_addr(fcur, fcur->alt_start_off);
+	alt_end = calc_addr(fcur, fcur->alt_end_off);
+
+	if ((alt_end - alt_start) > (end - start))
+		return 1;
 
 	if ((value & fcur->mask) == fcur->value)
-		return;
+		return 0;
 
-	pstart = ((unsigned int *)fcur) + (fcur->start_off / 4);
-	pend = ((unsigned int *)fcur) + (fcur->end_off / 4);
+	src = alt_start;
+	dest = start;
 
-	for (p = pstart; p < pend; p++) {
-		*p = PPC_NOP_INSTR;
-		asm volatile ("dcbst 0, %0" : : "r" (p));
+	for (; src < alt_end; src++, dest++) {
+		if (patch_alt_instruction(src, dest, alt_start, alt_end))
+			return 1;
 	}
-	asm volatile ("sync" : : : "memory");
-	for (p = pstart; p < pend; p++)
-		asm volatile ("icbi 0,%0" : : "r" (p));
-	asm volatile ("sync; isync" : : : "memory");
+
+	for (; dest < end; dest++)
+		patch_instruction(dest, PPC_NOP_INSTR);
+
+	return 0;
 }
 
 void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
@@ -53,6 +95,15 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 	fcur = fixup_start;
 	fend = fixup_end;
 
-	for (; fcur < fend; fcur++)
-		patch_feature_section(value, fcur);
+	for (; fcur < fend; fcur++) {
+		if (patch_feature_section(value, fcur)) {
+			__WARN();
+			printk("Unable to patch feature section at %p - %p" \
+				" with %p - %p\n",
+				calc_addr(fcur, fcur->start_off),
+				calc_addr(fcur, fcur->end_off),
+				calc_addr(fcur, fcur->alt_start_off),
+				calc_addr(fcur, fcur->alt_end_off));
+		}
+	}
 }
-- 
1.5.5
