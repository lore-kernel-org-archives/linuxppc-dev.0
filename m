Return-Path: <srs0=hvng=lc=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41tk0y2SzbzF0vb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 03:08:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41tk0y1c4kz8tCQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 03:08:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41tk0x3NG2z9s0n
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2018 03:08:33 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7JH3R6Y065883
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2018 13:08:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ky0pe9596-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2018 13:08:31 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Sun, 19 Aug 2018 18:08:29 +0100
Subject: [PATCH v8 3/5] powerpc/pseries: Display machine check error details.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Ananth Narayan <ananth@in.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>
Date: Sun, 19 Aug 2018 22:38:24 +0530
In-Reply-To: <153469837203.21878.11524005112982522827.stgit@jupiter.in.ibm.com>
References: <153469837203.21878.11524005112982522827.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153469850442.21878.3744080902550556000.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Extract the MCE error details from RTAS extended log and display it to
console.

With this patch you should now see mce logs like below:

[  142.371818] Severe Machine check interrupt [Recovered]
[  142.371822]   NIP [d00000000ca301b8]: init_module+0x1b8/0x338 [bork_kernel]
[  142.371822]   Initiator: CPU
[  142.371823]   Error type: SLB [Multihit]
[  142.371824]     Effective address: d00000000ca70000

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/rtas.h      |    5 +
 arch/powerpc/platforms/pseries/ras.c |  132 ++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index adefa6493d29..0183e9595acc 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -197,6 +197,11 @@ static inline uint8_t rtas_error_extended(const struct rtas_error_log *elog)
 	return (elog->byte1 & 0x04) >> 2;
 }
 
+static inline uint8_t rtas_error_initiator(const struct rtas_error_log *elog)
+{
+	return (elog->byte2 & 0xf0) >> 4;
+}
+
 #define rtas_error_type(x)	((x)->byte3)
 
 static inline
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 73500a24e9c2..d042f852afe9 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -524,6 +524,135 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
 	return 0; /* need to perform reset */
 }
 
+#define VAL_TO_STRING(ar, val)	((val < ARRAY_SIZE(ar)) ? ar[val] : "Unknown")
+
+static void pseries_print_mce_info(struct pt_regs *regs,
+						struct rtas_error_log *errp)
+{
+	const char *level, *sevstr;
+	struct pseries_errorlog *pseries_log;
+	struct pseries_mc_errorlog *mce_log;
+	uint8_t error_type, err_sub_type;
+	uint64_t addr;
+	uint8_t initiator = rtas_error_initiator(errp);
+	int disposition = rtas_error_disposition(errp);
+
+	static const char * const initiators[] = {
+		"Unknown",
+		"CPU",
+		"PCI",
+		"ISA",
+		"Memory",
+		"Power Mgmt",
+	};
+	static const char * const mc_err_types[] = {
+		"UE",
+		"SLB",
+		"ERAT",
+		"TLB",
+		"D-Cache",
+		"Unknown",
+		"I-Cache",
+	};
+	static const char * const mc_ue_types[] = {
+		"Indeterminate",
+		"Instruction fetch",
+		"Page table walk ifetch",
+		"Load/Store",
+		"Page table walk Load/Store",
+	};
+
+	/* SLB sub errors valid values are 0x0, 0x1, 0x2 */
+	static const char * const mc_slb_types[] = {
+		"Parity",
+		"Multihit",
+		"Indeterminate",
+	};
+
+	/* TLB and ERAT sub errors valid values are 0x1, 0x2, 0x3 */
+	static const char * const mc_soft_types[] = {
+		"Unknown",
+		"Parity",
+		"Multihit",
+		"Indeterminate",
+	};
+
+	if (!rtas_error_extended(errp)) {
+		pr_err("Machine check interrupt: Missing extended error log\n");
+		return;
+	}
+
+	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
+	if (pseries_log == NULL)
+		return;
+
+	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
+
+	error_type = mce_log->error_type;
+	err_sub_type = rtas_mc_error_sub_type(mce_log);
+
+	switch (rtas_error_severity(errp)) {
+	case RTAS_SEVERITY_NO_ERROR:
+		level = KERN_INFO;
+		sevstr = "Harmless";
+		break;
+	case RTAS_SEVERITY_WARNING:
+		level = KERN_WARNING;
+		sevstr = "";
+		break;
+	case RTAS_SEVERITY_ERROR:
+	case RTAS_SEVERITY_ERROR_SYNC:
+		level = KERN_ERR;
+		sevstr = "Severe";
+		break;
+	case RTAS_SEVERITY_FATAL:
+	default:
+		level = KERN_ERR;
+		sevstr = "Fatal";
+		break;
+	}
+
+	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
+		disposition == RTAS_DISP_FULLY_RECOVERED ?
+		"Recovered" : "Not recovered");
+	if (user_mode(regs)) {
+		printk("%s  NIP: [%016lx] PID: %d Comm: %s\n", level,
+			regs->nip, current->pid, current->comm);
+	} else {
+		printk("%s  NIP [%016lx]: %pS\n", level, regs->nip,
+			(void *)regs->nip);
+	}
+	printk("%s  Initiator: %s\n", level,
+				VAL_TO_STRING(initiators, initiator));
+
+	switch (error_type) {
+	case MC_ERROR_TYPE_UE:
+		printk("%s  Error type: %s [%s]\n", level,
+			VAL_TO_STRING(mc_err_types, error_type),
+			VAL_TO_STRING(mc_ue_types, err_sub_type));
+		break;
+	case MC_ERROR_TYPE_SLB:
+		printk("%s  Error type: %s [%s]\n", level,
+			VAL_TO_STRING(mc_err_types, error_type),
+			VAL_TO_STRING(mc_slb_types, err_sub_type));
+		break;
+	case MC_ERROR_TYPE_ERAT:
+	case MC_ERROR_TYPE_TLB:
+		printk("%s  Error type: %s [%s]\n", level,
+			VAL_TO_STRING(mc_err_types, error_type),
+			VAL_TO_STRING(mc_soft_types, err_sub_type));
+		break;
+	default:
+		printk("%s  Error type: %s\n", level,
+			VAL_TO_STRING(mc_err_types, error_type));
+		break;
+	}
+
+	addr = rtas_mc_get_effective_addr(mce_log);
+	if (addr)
+		printk("%s    Effective address: %016llx\n", level, addr);
+}
+
 static int mce_handle_error(struct rtas_error_log *errp)
 {
 	struct pseries_errorlog *pseries_log;
@@ -580,8 +709,11 @@ static int recover_mce(struct pt_regs *regs, struct rtas_error_log *err)
 	int recovered = 0;
 	int disposition = rtas_error_disposition(err);
 
+	pseries_print_mce_info(regs, err);
+
 	if (!(regs->msr & MSR_RI)) {
 		/* If MSR_RI isn't set, we cannot recover */
+		pr_err("Machine check interrupt unrecoverable: MSR(RI=0)\n");
 		recovered = 0;
 
 	} else if (disposition == RTAS_DISP_FULLY_RECOVERED) {
