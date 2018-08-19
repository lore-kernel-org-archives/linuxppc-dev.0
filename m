Return-Path: <srs0=hvng=lc=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41tk174bwJzF1QJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 03:08:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41tk173g5gz8vq5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 03:08:43 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41tk165nnxz9s0n
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 03:08:42 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7JH3QPw128093
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2018 13:08:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ky0xn0fu4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2018 13:08:40 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Sun, 19 Aug 2018 18:08:38 +0100
Subject: [PATCH v8 4/5] powerpc/pseries: Dump the SLB contents on SLB MCE
 errors.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>
Date: Sun, 19 Aug 2018 22:38:32 +0530
In-Reply-To: <153469837203.21878.11524005112982522827.stgit@jupiter.in.ibm.com>
References: <153469837203.21878.11524005112982522827.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153469851207.21878.16970346624861719956.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

If we get a machine check exceptions due to SLB errors then dump the
current SLB contents which will be very much helpful in debugging the
root cause of SLB errors. Introduce an exclusive buffer per cpu to hold
faulty SLB entries. In real mode mce handler saves the old SLB contents
into this buffer accessible through paca and print it out later in virtual
mode.

With this patch the console will log SLB contents like below on SLB MCE
errors:

[  507.297236] SLB contents of cpu 0x1
[  507.297237] Last SLB entry inserted at slot 16
[  507.297238] 00 c000000008000000 400ea1b217000500
[  507.297239]   1T  ESID=   c00000  VSID=      ea1b217 LLP:100
[  507.297240] 01 d000000008000000 400d43642f000510
[  507.297242]   1T  ESID=   d00000  VSID=      d43642f LLP:110
[  507.297243] 11 f000000008000000 400a86c85f000500
[  507.297244]   1T  ESID=   f00000  VSID=      a86c85f LLP:100
[  507.297245] 12 00007f0008000000 4008119624000d90
[  507.297246]   1T  ESID=       7f  VSID=      8119624 LLP:110
[  507.297247] 13 0000000018000000 00092885f5150d90
[  507.297247]  256M ESID=        1  VSID=   92885f5150 LLP:110
[  507.297248] 14 0000010008000000 4009e7cb50000d90
[  507.297249]   1T  ESID=        1  VSID=      9e7cb50 LLP:110
[  507.297250] 15 d000000008000000 400d43642f000510
[  507.297251]   1T  ESID=   d00000  VSID=      d43642f LLP:110
[  507.297252] 16 d000000008000000 400d43642f000510
[  507.297253]   1T  ESID=   d00000  VSID=      d43642f LLP:110
[  507.297253] ----------------------------------
[  507.297254] SLB cache ptr value = 3
[  507.297254] Valid SLB cache entries:
[  507.297255] 00 EA[0-35]=    7f000
[  507.297256] 01 EA[0-35]=        1
[  507.297257] 02 EA[0-35]=     1000
[  507.297257] Rest of SLB cache entries:
[  507.297258] 03 EA[0-35]=    7f000
[  507.297258] 04 EA[0-35]=        1
[  507.297259] 05 EA[0-35]=     1000
[  507.297260] 06 EA[0-35]=       12
[  507.297260] 07 EA[0-35]=    7f000

Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---

Changes in V8:
- Limit the slb saving to single level of mce recursion.
- Move mce_faulty_slbs and slb_save_cache_ptr under CONFIG_PPC_BOOK3S_64
  instead of CONFIG_PPC_PSERIES.
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    7 ++
 arch/powerpc/include/asm/paca.h               |    6 ++
 arch/powerpc/mm/slb.c                         |   73 +++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/ras.c          |   17 +++++-
 arch/powerpc/platforms/pseries/setup.c        |   13 ++++
 5 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index afca8c11d996..925271d95122 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -485,11 +485,18 @@ static inline void hpte_init_pseries(void) { }
 
 extern void hpte_init_native(void);
 
+struct slb_entry {
+	u64	esid;
+	u64	vsid;
+};
+
 extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
 extern void slb_flush_all_realmode(void);
 extern void __slb_restore_bolted_realmode(void);
 extern void slb_restore_bolted_realmode(void);
+extern void slb_save_contents(struct slb_entry *slb_ptr);
+extern void slb_dump_contents(struct slb_entry *slb_ptr);
 
 extern void slb_vmalloc_update(void);
 extern void slb_set_size(u16 size);
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 7f22929ce915..8767abb521c2 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -255,6 +255,12 @@ struct paca_struct {
 #ifdef CONFIG_PPC_PSERIES
 	u8 *mce_data_buf;		/* buffer to hold per cpu rtas errlog */
 #endif /* CONFIG_PPC_PSERIES */
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* Capture SLB related old contents in MCE handler. */
+	struct slb_entry *mce_faulty_slbs;
+	u16 slb_save_cache_ptr;
+#endif /* CONFIG_PPC_BOOK3S_64 */
 } ____cacheline_aligned;
 
 extern void copy_mm_to_paca(struct mm_struct *mm);
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 6dd9913425bc..09a2f325b231 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -187,6 +187,79 @@ void slb_flush_and_rebolt(void)
 	get_paca()->slb_cache_ptr = 0;
 }
 
+void slb_save_contents(struct slb_entry *slb_ptr)
+{
+	int i;
+	unsigned long e, v;
+
+	/* Save slb_cache_ptr value. */
+	get_paca()->slb_save_cache_ptr = get_paca()->slb_cache_ptr;
+
+	if (!slb_ptr)
+		return;
+
+	for (i = 0; i < mmu_slb_size; i++) {
+		asm volatile("slbmfee  %0,%1" : "=r" (e) : "r" (i));
+		asm volatile("slbmfev  %0,%1" : "=r" (v) : "r" (i));
+		slb_ptr->esid = e;
+		slb_ptr->vsid = v;
+		slb_ptr++;
+	}
+}
+
+void slb_dump_contents(struct slb_entry *slb_ptr)
+{
+	int i, n;
+	unsigned long e, v;
+	unsigned long llp;
+
+	if (!slb_ptr)
+		return;
+
+	pr_err("SLB contents of cpu 0x%x\n", smp_processor_id());
+	pr_err("Last SLB entry inserted at slot %lld\n", get_paca()->stab_rr);
+
+	for (i = 0; i < mmu_slb_size; i++) {
+		e = slb_ptr->esid;
+		v = slb_ptr->vsid;
+		slb_ptr++;
+
+		if (!e && !v)
+			continue;
+
+		pr_err("%02d %016lx %016lx\n", i, e, v);
+
+		if (!(e & SLB_ESID_V)) {
+			pr_err("\n");
+			continue;
+		}
+		llp = v & SLB_VSID_LLP;
+		if (v & SLB_VSID_B_1T) {
+			pr_err("  1T  ESID=%9lx  VSID=%13lx LLP:%3lx\n",
+				GET_ESID_1T(e),
+				(v & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T,
+				llp);
+		} else {
+			pr_err(" 256M ESID=%9lx  VSID=%13lx LLP:%3lx\n",
+				GET_ESID(e),
+				(v & ~SLB_VSID_B) >> SLB_VSID_SHIFT,
+				llp);
+		}
+	}
+	pr_err("----------------------------------\n");
+
+	/* Dump slb cache entires as well. */
+	pr_err("SLB cache ptr value = %d\n", get_paca()->slb_save_cache_ptr);
+	pr_err("Valid SLB cache entries:\n");
+	n = min_t(int, get_paca()->slb_save_cache_ptr, SLB_CACHE_ENTRIES);
+	for (i = 0; i < n; i++)
+		pr_err("%02d EA[0-35]=%9x\n", i, get_paca()->slb_cache[i]);
+	pr_err("Rest of SLB cache entries:\n");
+	for (i = n; i < SLB_CACHE_ENTRIES; i++)
+		pr_err("%02d EA[0-35]=%9x\n", i, get_paca()->slb_cache[i]);
+
+}
+
 void slb_vmalloc_update(void)
 {
 	unsigned long vflags;
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index d042f852afe9..61103a3c5651 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -612,6 +612,12 @@ static void pseries_print_mce_info(struct pt_regs *regs,
 		break;
 	}
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* Display faulty slb contents for SLB errors. */
+	if (error_type == MC_ERROR_TYPE_SLB)
+		slb_dump_contents(local_paca->mce_faulty_slbs);
+#endif
+
 	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
 		disposition == RTAS_DISP_FULLY_RECOVERED ?
 		"Recovered" : "Not recovered");
@@ -673,7 +679,16 @@ static int mce_handle_error(struct rtas_error_log *errp)
 #ifdef CONFIG_PPC_BOOK3S_64
 	if ((disposition == RTAS_DISP_NOT_RECOVERED) &&
 			(error_type == MC_ERROR_TYPE_SLB)) {
-		/* Store the old slb content someplace. */
+		/*
+		 * Store the old slb content in paca before flushing. Print
+		 * this when we go to virtual mode.
+		 * There are chances that we may hit MCE again if there
+		 * is a parity error on the SLB entry we trying to read
+		 * for saving. Hence limit the slb saving to single level
+		 * of recursion.
+		 */
+		if (local_paca->in_mce == 1)
+			slb_save_contents(local_paca->mce_faulty_slbs);
 		flush_and_reload_slb();
 		disposition = RTAS_DISP_FULLY_RECOVERED;
 		rtas_set_disposition_recovered(errp);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index cbd1adf3e14f..47b2b91c759b 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -106,6 +106,10 @@ static void __init fwnmi_init(void)
 	u8 *mce_data_buf;
 	unsigned int i;
 	int nr_cpus = num_possible_cpus();
+#ifdef CONFIG_PPC_BOOK3S_64
+	struct slb_entry *slb_ptr;
+	size_t size;
+#endif
 
 	int ibm_nmi_register = rtas_token("ibm,nmi-register");
 	if (ibm_nmi_register == RTAS_UNKNOWN_SERVICE)
@@ -131,6 +135,15 @@ static void __init fwnmi_init(void)
 		paca_ptrs[i]->mce_data_buf = mce_data_buf +
 						(RTAS_ERROR_LOG_MAX * i);
 	}
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* Allocate per cpu slb area to save old slb contents during MCE */
+	size = sizeof(struct slb_entry) * mmu_slb_size * nr_cpus;
+	slb_ptr = __va(memblock_alloc_base(size, sizeof(struct slb_entry),
+							ppc64_rma_size));
+	for_each_possible_cpu(i)
+		paca_ptrs[i]->mce_faulty_slbs = slb_ptr + (mmu_slb_size * i);
+#endif
 }
 
 static void pseries_8259_cascade(struct irq_desc *desc)
