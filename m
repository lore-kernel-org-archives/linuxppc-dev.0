Return-Path: <srs0=ktuc=lz=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428nLQ4ND0zF38Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 00:27:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 428nLQ3X4tz8tRT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 00:27:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 428nLP71hfz9s1x
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2018 00:27:25 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8BEO2Fo030774
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2018 10:27:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2medv7n03g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2018 10:27:23 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 11 Sep 2018 15:27:21 +0100
Subject: [PATCH v10 4/5] powerpc/pseries: Dump the SLB contents on SLB MCE
 errors.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 11 Sep 2018 19:57:15 +0530
In-Reply-To: <153667588649.24785.4453485245076541196.stgit@jupiter.in.ibm.com>
References: <153667588649.24785.4453485245076541196.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153667603567.24785.2487478387388307299.stgit@jupiter.in.ibm.com>
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
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    7 +++
 arch/powerpc/include/asm/paca.h               |    6 ++
 arch/powerpc/mm/slb.c                         |   70 +++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/ras.c          |   17 ++++++
 arch/powerpc/platforms/pseries/setup.c        |   13 +++++
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b3520b549cba..e577ccffe301 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -495,11 +495,18 @@ static inline void hpte_init_pseries(void) { }
 
 extern void hpte_init_native(void);
 
+struct slb_entry {
+	u64	esid;
+	u64	vsid;
+};
+
 extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
 void slb_flush_all_realmode(void);
 void __slb_restore_bolted_realmode(void);
 void slb_restore_bolted_realmode(void);
+void slb_save_contents(struct slb_entry *slb_ptr);
+void slb_dump_contents(struct slb_entry *slb_ptr);
 
 extern void slb_vmalloc_update(void);
 extern void slb_set_size(u16 size);
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index ad4f16164619..7b6e23af3808 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -250,6 +250,12 @@ struct paca_struct {
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
index 9f574e59d178..e941189d9bd6 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -184,6 +184,76 @@ void slb_flush_and_rebolt(void)
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
+			       GET_ESID_1T(e),
+			       (v & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T, llp);
+		} else {
+			pr_err(" 256M ESID=%9lx  VSID=%13lx LLP:%3lx\n",
+			       GET_ESID(e),
+			       (v & ~SLB_VSID_B) >> SLB_VSID_SHIFT, llp);
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
+}
+
 void slb_vmalloc_update(void)
 {
 	unsigned long vflags;
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 26268f324b46..6f06156db0b1 100644
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
@@ -675,7 +681,16 @@ static int mce_handle_error(struct rtas_error_log *errp)
 		switch (error_type) {
 		case	MC_ERROR_TYPE_SLB:
 		case	MC_ERROR_TYPE_ERAT:
-			/* Store the old slb content someplace. */
+			/*
+			 * Store the old slb content in paca before flushing.
+			 * Print this when we go to virtual mode.
+			 * There are chances that we may hit MCE again if there
+			 * is a parity error on the SLB entry we trying to read
+			 * for saving. Hence limit the slb saving to single
+			 * level of recursion.
+			 */
+			if (local_paca->in_mce == 1)
+				slb_save_contents(local_paca->mce_faulty_slbs);
 			flush_and_reload_slb();
 			disposition = RTAS_DISP_FULLY_RECOVERED;
 			rtas_set_disposition_recovered(errp);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index a0a3d4d341f7..7dd20692259a 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -107,6 +107,10 @@ static void __init fwnmi_init(void)
 	u8 *mce_data_buf;
 	unsigned int i;
 	int nr_cpus = num_possible_cpus();
+#ifdef CONFIG_PPC_BOOK3S_64
+	struct slb_entry *slb_ptr;
+	size_t size;
+#endif
 
 	int ibm_nmi_register = rtas_token("ibm,nmi-register");
 	if (ibm_nmi_register == RTAS_UNKNOWN_SERVICE)
@@ -132,6 +136,15 @@ static void __init fwnmi_init(void)
 		paca_ptrs[i]->mce_data_buf = mce_data_buf +
 						(RTAS_ERROR_LOG_MAX * i);
 	}
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* Allocate per cpu slb area to save old slb contents during MCE */
+	size = sizeof(struct slb_entry) * mmu_slb_size * nr_cpus;
+	slb_ptr = __va(memblock_alloc_base(size, sizeof(struct slb_entry),
+					   ppc64_rma_size));
+	for_each_possible_cpu(i)
+		paca_ptrs[i]->mce_faulty_slbs = slb_ptr + (mmu_slb_size * i);
+#endif
 }
 
 static void pseries_8259_cascade(struct irq_desc *desc)
