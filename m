Return-Path: <cel@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBB532C008B
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2012 23:03:47 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cel@linux.vnet.ibm.com>;
 Fri, 3 Aug 2012 09:03:42 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D4D4CC90045
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2012 09:03:37 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q73D3a1e342352
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2012 09:03:37 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q73D2Pwd024991
 for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2012 07:02:26 -0600
Subject: [PATCH] Power 7+, OProfile: reject samples if marked event and the
 SIAR valid bit is not set.
From: "Carl E. Love" <cel@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
 Maynard Johnson <maynardj@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 03 Aug 2012 08:02:17 -0500
Message-ID: <1343998937.4658.13.camel@oc5652146517.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ben:

Here is the OProfile patch to reject samples for marked events if the
SIAR register is not valid.  Please review and let me know if it looks
OK.  Thanks.

                 Carl Love

-------------------------------------------------------------------------------------

Power 7+, OProfile: reject samples if marked event and the SIAR valid bit is not set.

Starting with Power 7+ we need to check for marked events if the SIAR
register is valid, i.e. it contains the correct address of the instruction
at the time the performance counter overflowed.  The mmcra register on
Power 7+, contains a new bit to indicate that the contents of the SIAR
is valid. If the event is not marked, then the sample is recorded
independently of the SIAR valid bit setting.  For older processors, there
is no SIAR valid bit to check so the samples are always recorded.  This is
done by forcing the cntr_marked_events bit mask to zero.  The code will
always record the sample in this case since the bit mask says the event is
not a marked event even if it really is a marked event.

Signed-off-by: Carl Love <cel@us.ibm.com>
---
 arch/powerpc/oprofile/op_model_power4.c | 100 +++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
index 95ae77d..cb3fc73 100644
--- a/arch/powerpc/oprofile/op_model_power4.c
+++ b/arch/powerpc/oprofile/op_model_power4.c
@@ -21,6 +21,13 @@
 #include <asm/reg.h>
 
 #define dbg(args...)
+#define OPROFILE_PM_PMCSEL_MSK      0xffULL
+#define OPROFILE_PM_UNIT_SHIFT      60
+#define OPROFILE_PM_UNIT_MSK        0xfULL
+#define OPROFILE_MAX_PMC_NUM        3
+#define OPROFILE_PMSEL_FIELD_WIDTH  8
+#define OPROFILE_UNIT_FIELD_WIDTH   4
+#define MMCRA_SIAR_VALID_MASK       0x10000000ULL
 
 static unsigned long reset_value[OP_MAX_COUNTER];
 
@@ -31,6 +38,61 @@ static int use_slot_nums;
 static u32 mmcr0_val;
 static u64 mmcr1_val;
 static u64 mmcra_val;
+static u32 cntr_marked_events;
+
+static int power7_marked_instr_event(u64 mmcr1)
+{
+	u64 psel, unit;
+	int pmc, cntr_marked_events = 0;
+
+	/* Given the MMCR1 value, look at the field for each counter to
+	 * determine if it is a marked event.  Code based on the function
+	 * power7_marked_instr_event() in file arch/powerpc/perf/power7-pmu.c.
+	 */
+	for (pmc = 0; pmc < 4; pmc++) {
+		psel = mmcr1 & (OPROFILE_PM_PMCSEL_MSK
+				<< (OPROFILE_MAX_PMC_NUM - pmc)
+				* OPROFILE_MAX_PMC_NUM);
+		psel = (psel >> ((OPROFILE_MAX_PMC_NUM - pmc)
+				 * OPROFILE_PMSEL_FIELD_WIDTH)) & ~1ULL;
+		unit = mmcr1 & (OPROFILE_PM_UNIT_MSK
+				<< (OPROFILE_PM_UNIT_SHIFT
+				    - (pmc * OPROFILE_PMSEL_FIELD_WIDTH )));
+		unit = unit >> (OPROFILE_PM_UNIT_SHIFT
+				- (pmc * OPROFILE_PMSEL_FIELD_WIDTH));
+
+		switch (psel >> 4) {
+		case 2:
+			cntr_marked_events |= (pmc == 1 || pmc == 3) << pmc;
+			break;
+		case 3:
+			if (psel == 0x3c) {
+				cntr_marked_events |= (pmc == 0) << pmc;
+				break;
+			}
+
+			if (psel == 0x3e) {
+				cntr_marked_events |= (pmc != 1) << pmc;
+				break;
+			}
+
+			cntr_marked_events |= 1 << pmc;
+			break;
+		case 4:
+		case 5:
+			cntr_marked_events |= (unit == 0xd) << pmc;
+			break;
+		case 6:
+			if (psel == 0x64)
+				cntr_marked_events |= (pmc >= 2) << pmc;
+			break;
+		case 8:
+			cntr_marked_events |= (unit == 0xd) << pmc;
+			break;
+		}
+	}
+	return cntr_marked_events;
+}
 
 static int power4_reg_setup(struct op_counter_config *ctr,
 			     struct op_system_config *sys,
@@ -47,6 +109,23 @@ static int power4_reg_setup(struct op_counter_config *ctr,
 	mmcr1_val = sys->mmcr1;
 	mmcra_val = sys->mmcra;
 
+	/* Power 7+ and newer architectures:
+	 * Determine which counter events in the group (the group of events is
+	 * specified by the bit settings in the MMCR1 register) are marked
+	 * events for use in the interrupt handler.  Do the calculation once
+	 * before OProfile starts.  Information is used in the interrupt
+	 * handler.  Starting with Power 7+ we only record the sample for
+	 * marked events if the SIAR valid bit is set.  For non marked events
+	 * the sample is always recorded.
+	 */
+	if (__is_processor(PV_POWER7p))
+		cntr_marked_events = power7_marked_instr_event(mmcr1_val);
+	else
+		cntr_marked_events = 0; /* For older processors, set the bit map
+					 * to zero so the sample will always be
+					 * be recorded.
+					 */
+
 	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i)
 		reset_value[i] = 0x80000000UL - ctr[i].count;
 
@@ -291,6 +370,7 @@ static void power4_handle_interrupt(struct pt_regs *regs,
 	int i;
 	unsigned int mmcr0;
 	unsigned long mmcra;
+	bool siar_valid = false;
 
 	mmcra = mfspr(SPRN_MMCRA);
 
@@ -300,11 +380,29 @@ static void power4_handle_interrupt(struct pt_regs *regs,
 	/* set the PMM bit (see comment below) */
 	mtmsrd(mfmsr() | MSR_PMM);
 
+	/* Check that the SIAR  valid bit in MMCRA is set to 1. */
+	if ((mmcra & MMCRA_SIAR_VALID_MASK) == MMCRA_SIAR_VALID_MASK)
+		siar_valid = true;
+
 	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
 		val = classic_ctr_read(i);
 		if (pmc_overflow(val)) {
 			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_ext_sample(pc, regs, i, is_kernel);
+				/* Power 7+ and newer architectures:
+				 * If the event is a marked event, then only
+				 * save the sample if the SIAR valid bit is
+				 * set.  If the event is not marked, then
+				 * always save the sample.
+				 * Note, the Sample enable bit in the MMCRA
+				 * register must be set to 1 if the group
+				 * contains a marked event.
+				 */
+				if ((siar_valid &&
+				     (cntr_marked_events & (1 << i)))
+				    || !(cntr_marked_events & (1 << i)))
+					oprofile_add_ext_sample(pc, regs, i,
+								is_kernel);
+
 				classic_ctr_write(i, reset_value[i]);
 			} else {
 				classic_ctr_write(i, 0);
-- 
1.7.11.2.249.g31c7954
