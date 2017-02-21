Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS3Rr1gXSzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:53:12 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS3Rq4T5Lz9s7n
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:53:11 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L1nHQX088727
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:53:09 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28r2pnncgt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:53:09 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 07:23:06 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E7B69125804F
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:23:09 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L1r0hC37879832
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:23:00 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L1r2kC014901
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:23:03 +0530
Subject: [RFC PATCH 6/7] powerpc/book3s: Display more info for MCE error
 console log.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 21 Feb 2017 07:23:02 +0530
In-Reply-To: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148764198185.19289.4303686878566814766.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

For D-side errors we print data load/store address as 'Effective address'
that caused MC. In addition to that print NIP also at which interrupt was
taken.

After this patch the MCE console log would look like:

[1150485.962090] Severe Machine check interrupt [Recovered]
[1150485.962114]   Initiator: CPU
[1150485.962139]   NIP [c000000000018b00]: sched_clock+0x8/0x34
[1150485.962166]   Error type: ERAT [Multihit]
[1150485.962190]     Effective address: 00003fff8f6b0000

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/mce.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index da12992..035ef53 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -320,6 +320,8 @@ void machine_check_print_event_info(struct OpalMachineCheckEvent *evt)
 	       "Recovered" : "[Not recovered");
 	printk("%s  Initiator: %s\n", level,
 	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
+	printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
+							(void *)evt->srr0);
 	switch (evt->error_type) {
 	case MCE_ERROR_TYPE_UE:
 		subtype = evt->u.ue_error.ue_error_type <
