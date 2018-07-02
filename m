Return-Path: <srs0=9r9h=js=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Jx9S5dvXzF1Nj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 15:47:40 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41Jx9S4p7Nz8wD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 15:47:40 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41Jx9S1Fqvz9s1B
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Jul 2018 15:47:39 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w625iUWu020189
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2018 01:47:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jy68turss-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 02 Jul 2018 01:47:38 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 2 Jul 2018 06:47:36 +0100
Subject: [PATCH v5 7/7] powerpc/pseries: Dump the SLB contents on SLB MCE
 errors.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>
Date: Mon, 02 Jul 2018 11:17:30 +0530
In-Reply-To: <153051022088.30541.5610525713141009848.stgit@jupiter.in.ibm.com>
References: <153051022088.30541.5610525713141009848.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153051044592.30541.11982872561593100879.stgit@jupiter.in.ibm.com>
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

[ 3022.938065] SLB contents of cpu 0x3
[ 3022.938066] 00 c000000008000000 400ea1b217000500
[ 3022.938067]   1T  ESID=   c00000  VSID=      ea1b217 LLP:100
[ 3022.938068] 01 d000000008000000 400d43642f000510
[ 3022.938069]   1T  ESID=   d00000  VSID=      d43642f LLP:110
[ 3022.938070] 05 f000000008000000 400a86c85f000500
[ 3022.938071]   1T  ESID=   f00000  VSID=      a86c85f LLP:100
[ 3022.938072] 06 00007f0008000000 400a628b13000d90
[ 3022.938073]   1T  ESID=       7f  VSID=      a628b13 LLP:110
[ 3022.938074] 07 0000000018000000 000b7979f523fd90
[ 3022.938075]  256M ESID=        1  VSID=   b7979f523f LLP:110
[ 3022.938076] 08 c000000008000000 400ea1b217000510
[ 3022.938076]   1T  ESID=   c00000  VSID=      ea1b217 LLP:110
[ 3022.938077] 09 c000000008000000 400ea1b217000510
[ 3022.938078]   1T  ESID=   c00000  VSID=      ea1b217 LLP:110

Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    7 +++
 arch/powerpc/include/asm/paca.h               |    1 
 arch/powerpc/mm/slb.c                         |   57 +++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/ras.c          |   10 ++++
 arch/powerpc/platforms/pseries/setup.c        |   10 ++++
 5 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index cc00a7088cf3..5a3fe282076d 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -485,9 +485,16 @@ static inline void hpte_init_pseries(void) { }
 
 extern void hpte_init_native(void);
 
+struct slb_entry {
+	u64	esid;
+	u64	vsid;
+};
+
 extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
 extern void slb_flush_and_rebolt_realmode(void);
+extern void slb_save_contents(struct slb_entry *slb_ptr);
+extern void slb_dump_contents(struct slb_entry *slb_ptr);
 
 extern void slb_vmalloc_update(void);
 extern void slb_set_size(u16 size);
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index b441fef53077..653f87c69423 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -253,6 +253,7 @@ struct paca_struct {
 #endif
 #ifdef CONFIG_PPC_PSERIES
 	u8 *mce_data_buf;		/* buffer to hold per cpu rtas errlog */
+	struct slb_entry *mce_faulty_slbs;
 #endif /* CONFIG_PPC_PSERIES */
 } ____cacheline_aligned;
 
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 5b1813b98358..476ab0b1d4e8 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -151,6 +151,63 @@ void slb_flush_and_rebolt_realmode(void)
 	get_paca()->slb_cache_ptr = 0;
 }
 
+void slb_save_contents(struct slb_entry *slb_ptr)
+{
+	int i;
+	unsigned long e, v;
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
+	int i;
+	unsigned long e, v;
+	unsigned long llp;
+
+	if (!slb_ptr)
+		return;
+
+	pr_err("SLB contents of cpu 0x%x\n", smp_processor_id());
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
+}
+
 void slb_vmalloc_update(void)
 {
 	unsigned long vflags;
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 7d4d2b8bc019..d33c88e65fa1 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -515,6 +515,10 @@ static void pseries_print_mce_info(struct pt_regs *regs,
 		break;
 	}
 
+	/* Display faulty slb contents for SLB errors. */
+	if (error_type == PSERIES_MC_ERROR_TYPE_SLB)
+		slb_dump_contents(local_paca->mce_faulty_slbs);
+
 	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
 		disposition == RTAS_DISP_FULLY_RECOVERED ?
 		"Recovered" : "Not recovered");
@@ -575,7 +579,11 @@ static int mce_handle_error(struct rtas_error_log *errp)
 
 	if ((disposition == RTAS_DISP_NOT_RECOVERED) &&
 			(error_type == PSERIES_MC_ERROR_TYPE_SLB)) {
-		/* Store the old slb content someplace. */
+		/*
+		 * Store the old slb content in paca before flushing. Print
+		 * this when we go to virtual mode.
+		 */
+		slb_save_contents(local_paca->mce_faulty_slbs);
 		slb_flush_and_rebolt_realmode();
 		disposition = RTAS_DISP_FULLY_RECOVERED;
 		rtas_set_disposition_recovered(errp);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 249b02bc5c41..76d15e46a152 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -105,6 +105,9 @@ static void __init fwnmi_init(void)
 	u8 *mce_data_buf;
 	unsigned int i;
 	int nr_cpus = num_possible_cpus();
+	struct slb_entry *slb_ptr;
+	size_t size;
+
 
 	int ibm_nmi_register = rtas_token("ibm,nmi-register");
 	if (ibm_nmi_register == RTAS_UNKNOWN_SERVICE)
@@ -130,6 +133,13 @@ static void __init fwnmi_init(void)
 		paca_ptrs[i]->mce_data_buf = mce_data_buf +
 						(RTAS_ERROR_LOG_MAX * i);
 	}
+
+	/* Allocate per cpu slb area to save old slb contents during MCE */
+	size = sizeof(struct slb_entry) * mmu_slb_size * nr_cpus;
+	slb_ptr = __va(memblock_alloc_base(size, sizeof(struct slb_entry),
+							ppc64_rma_size));
+	for_each_possible_cpu(i)
+		paca_ptrs[i]->mce_faulty_slbs = slb_ptr + (mmu_slb_size * i);
 }
 
 static void pseries_8259_cascade(struct irq_desc *desc)
