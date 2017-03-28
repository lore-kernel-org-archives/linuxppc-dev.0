Return-Path: <srs0=5ini=3f=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsscb6wY4zDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 00:46:23 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vsscb6J9nz8t1b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 00:46:23 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vsscb3Kknz9s8Q
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 00:46:23 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2SDiEMI091728
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2017 09:46:16 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29frvp0snf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2017 09:46:12 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 23:45:57 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2SDjlRN38469846
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 00:45:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2SDjMT4001713
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 00:45:22 +1100
Subject: [PATCH 1/2] powerpc/book3s: Display more info for MCE error console
 log.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 28 Mar 2017 19:15:04 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149070869902.18309.14355142133222424050.stgit@jupiter.in.ibm.com>
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
that caused MC. In addition to print NIP, print kernel function name as well.

After this patch the MCE console log would look like:

[  291.444281] Severe Machine check interrupt [Recovered]
[  291.444477]   NIP [d00000001bc70194]: init_module+0x194/0x2b0 [bork_kernel]
[  291.444707]   Initiator: CPU
[  291.444761]   Error type: SLB [Parity]
[  291.444793]     Effective address: d000000026de0000

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/mce.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 399aeaf..e82d4ee 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -311,7 +311,8 @@ void machine_check_print_event_info(struct machine_check_event *evt)
 	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
 	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
 	       "Recovered" : "Not recovered");
-	printk("%s  NIP: %016llx\n", level, evt->srr0);
+	printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
+							(void *)evt->srr0);
 	printk("%s  Initiator: %s\n", level,
 	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
 	switch (evt->error_type) {
