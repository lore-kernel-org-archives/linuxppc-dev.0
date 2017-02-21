Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS3SD6z1tzDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:53:32 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS3SD3Pdxz9s9N
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:53:32 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L1rVee131905
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:53:31 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r2sjnh3y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:53:30 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 11:53:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ED6742CE8057
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:53:22 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L1rELv50004116
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:53:22 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L1qonW023993
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:52:50 +1100
Subject: [RFC PATCH 4/7] powerpc/book3s: Print additional MCE errors
 introduced in power9.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 21 Feb 2017 07:22:32 +0530
In-Reply-To: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148764195184.19289.16239329776889945673.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Print out details about new MCE errors from Power9.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/mce.c |   68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 36da14a3..da12992 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -264,6 +264,29 @@ void machine_check_print_event_info(struct OpalMachineCheckEvent *evt)
 		"Indeterminate",
 		"Parity",
 		"Multihit",
+		"Tlbiel programming error",
+	};
+	static const char *mc_nest_types[] = {
+		"Ifetch due to foreign link time out",
+		"Instruction tablewalk due to foreign link time out",
+		"Foreign Link Time out for load",
+		"Foreign Link Time out for tablewalk",
+	};
+	static const char *mc_cresp_types[] = {
+		"Real Address error for an ifetch",
+		"Real Address error for an ifetch tablewalk",
+		"Bad real address for a load",
+		"Bad address for load/store tablewalk",
+	};
+	static const char *mc_fspace_types[] = {
+		"Instruction Fetch to foreign address space",
+		"I-side tablewalk host real addr in the foreign address range",
+		"Host real addess to foreign space",
+		"Load/store real address went to a foreign address",
+	};
+	static const char *mc_async_types[] = {
+		"Real address error (CRESP) from store",
+		"Foreign link time out (nest abort) due to a store instruction",
 	};
 
 	/* Print things out */
@@ -341,6 +364,43 @@ void machine_check_print_event_info(struct OpalMachineCheckEvent *evt)
 			printk("%s    Effective address: %016llx\n",
 			       level, evt->u.tlb_error.effective_address);
 		break;
+	case MCE_ERROR_TYPE_NEST:
+		subtype = evt->u.nest_error.nest_error_type <
+			ARRAY_SIZE(mc_nest_types) ?
+			mc_nest_types[evt->u.nest_error.nest_error_type]
+			: "Unknown";
+		printk("%s  Error type: NEST ABORT [%s]\n", level, subtype);
+		if (evt->u.nest_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.nest_error.effective_address);
+		break;
+	case MCE_ERROR_TYPE_CRESP:
+		subtype = evt->u.cresp_error.cresp_error_type <
+			ARRAY_SIZE(mc_cresp_types) ?
+			mc_cresp_types[evt->u.cresp_error.cresp_error_type]
+			: "Unknown";
+		printk("%s  Error type: CRESP [%s]\n", level, subtype);
+		if (evt->u.cresp_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.cresp_error.effective_address);
+		break;
+	case MCE_ERROR_TYPE_FSPACE:
+		subtype = evt->u.fspace_error.fspace_error_type <
+			ARRAY_SIZE(mc_fspace_types) ?
+			mc_fspace_types[evt->u.fspace_error.fspace_error_type]
+			: "Unknown";
+		printk("%s  Error type: FOREIGN SPACE [%s]\n", level, subtype);
+		if (evt->u.fspace_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt->u.fspace_error.effective_address);
+		break;
+	case MCE_ERROR_TYPE_ASYNC:
+		subtype = evt->u.async_error.async_error_type <
+			ARRAY_SIZE(mc_async_types) ?
+			mc_async_types[evt->u.async_error.async_error_type]
+			: "Unknown";
+		printk("%s  Error type: ASYNC MC [%s]\n", level, subtype);
+		break;
 	default:
 	case MCE_ERROR_TYPE_UNKNOWN:
 		printk("%s  Error type: Unknown\n", level);
@@ -367,6 +427,14 @@ uint64_t get_mce_fault_addr(struct OpalMachineCheckEvent *evt)
 		if (evt->u.tlb_error.effective_address_provided)
 			return evt->u.tlb_error.effective_address;
 		break;
+	case MCE_ERROR_TYPE_NEST:
+		if (evt->u.nest_error.effective_address_provided)
+			return evt->u.nest_error.effective_address;
+		break;
+	case MCE_ERROR_TYPE_CRESP:
+		if (evt->u.cresp_error.effective_address_provided)
+			return evt->u.cresp_error.effective_address;
+		break;
 	default:
 	case MCE_ERROR_TYPE_UNKNOWN:
 		break;
