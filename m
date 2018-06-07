Return-Path: <srs0=fawz=iz=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411h7114mqzF346
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 20:07:41 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 411h710YLfz98t0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 20:07:41 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 411h702d0gz9s1R
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2018 20:07:39 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57A4ZCn052988
 for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2018 06:07:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jf1wv26y3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Jun 2018 06:07:37 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 11:07:35 +0100
Subject: [v2 PATCH 4/5] powerpc/pseries: Display machine check error details.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 07 Jun 2018 15:37:31 +0530
In-Reply-To: <152836568375.29173.3046879842311381046.stgit@jupiter.in.ibm.com>
References: <152836568375.29173.3046879842311381046.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152836604276.29173.3739970120509235437.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Extract the MCE eror details from RTAS extended log and display it to
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
 arch/powerpc/platforms/pseries/ras.c |  128 +++++++++++++++++++++++++++++++++-
 2 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 3f2fba7ef23b..8100a95c133a 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -190,6 +190,11 @@ static inline uint8_t rtas_error_extended(const struct rtas_error_log *elog)
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
index 7470a216cd6b..afdf05444bc2 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -422,7 +422,130 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
 	return 0; /* need to perform reset */
 }
 
-static int mce_handle_error(struct rtas_error_log *errp)
+#define VAL_TO_STRING(ar, val)	((val < ARRAY_SIZE(ar)) ? ar[val] : "Unknown")
+
+static void pseries_print_mce_info(struct pt_regs *regs,
+				struct rtas_error_log *errp, int disposition)
+{
+	const char *level, *sevstr;
+	struct pseries_errorlog *pseries_log;
+	struct pseries_mc_errorlog *mce_log;
+	uint8_t error_type, err_sub_type;
+	uint8_t initiator = rtas_error_initiator(errp);
+	uint64_t addr;
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
+	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
+	if (pseries_log == NULL)
+		return;
+
+	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
+
+	error_type = rtas_mc_error_type(mce_log);
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
+	case PSERIES_MC_ERROR_TYPE_UE:
+		printk("%s  Error type: %s [%s]\n", level,
+			VAL_TO_STRING(mc_err_types, error_type),
+			VAL_TO_STRING(mc_ue_types, err_sub_type));
+		break;
+	case PSERIES_MC_ERROR_TYPE_SLB:
+		printk("%s  Error type: %s [%s]\n", level,
+			VAL_TO_STRING(mc_err_types, error_type),
+			VAL_TO_STRING(mc_slb_types, err_sub_type));
+		break;
+	case PSERIES_MC_ERROR_TYPE_ERAT:
+	case PSERIES_MC_ERROR_TYPE_TLB:
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
+static int mce_handle_error(struct pt_regs *regs, struct rtas_error_log *errp)
 {
 	struct pseries_errorlog *pseries_log;
 	struct pseries_mc_errorlog *mce_log;
@@ -442,6 +565,7 @@ static int mce_handle_error(struct rtas_error_log *errp)
 		slb_flush_and_rebolt();
 		disposition = RTAS_DISP_FULLY_RECOVERED;
 	}
+	pseries_print_mce_info(regs, errp, disposition);
 
 out:
 	return disposition;
@@ -461,7 +585,7 @@ static int recover_mce(struct pt_regs *regs, struct rtas_error_log *err)
 	int recovered = 0;
 	int disposition;
 
-	disposition = mce_handle_error(err);
+	disposition = mce_handle_error(regs, err);
 
 	if (!(regs->msr & MSR_RI)) {
 		/* If MSR_RI isn't set, we cannot recover */
