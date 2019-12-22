Return-Path: <SRS0=bN8i=2M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8344C2D0C0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Dec 2019 11:32:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926CB208C3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Dec 2019 11:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926CB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ggMD25WczDqQN
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Dec 2019 22:32:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47gg3G3XzTzDqV3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Dec 2019 22:18:49 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBMBHRJm093100; Sun, 22 Dec 2019 06:18:38 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2x21f77vn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 22 Dec 2019 06:18:38 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBMBIc6o094909;
 Sun, 22 Dec 2019 06:18:38 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2x21f77vn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 22 Dec 2019 06:18:38 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBMBH0F5016992;
 Sun, 22 Dec 2019 11:18:37 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma03dal.us.ibm.com with ESMTP id 2x1b164h5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 22 Dec 2019 11:18:37 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBMBIaxl28246508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Dec 2019 11:18:36 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDAD778060;
 Sun, 22 Dec 2019 11:18:35 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DDE07805C;
 Sun, 22 Dec 2019 11:18:35 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sun, 22 Dec 2019 11:18:35 +0000 (GMT)
Subject: [PATCH V4 10/14] powerpc/vas: Print CRB and FIFO values
From: Haren Myneni <haren@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1577012478.12797.71.camel@hbabu-laptop>
References: <1577012478.12797.71.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Dec 2019 03:18:26 -0800
Message-ID: <1577013506.12797.86.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-22_01:2019-12-17,2019-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=959
 suspectscore=1 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912220105
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mikey@neuling.org, herbert@gondor.apana.org.au, npiggin@gmail.com,
 hch@infradead.org, oohall@gmail.com, sukadev@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Dump FIFO entry values if could not find send window and print CRB
for debugging.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-fault.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/vas-fault.c b/arch/powerpc/platforms/powernv/vas-fault.c
index 1d31d8d..cf776d2 100644
--- a/arch/powerpc/platforms/powernv/vas-fault.c
+++ b/arch/powerpc/platforms/powernv/vas-fault.c
@@ -26,6 +26,28 @@
  */
 #define VAS_FAULT_WIN_FIFO_SIZE	(4 << 20)
 
+static void dump_crb(struct coprocessor_request_block *crb)
+{
+	struct data_descriptor_entry *dde;
+	struct nx_fault_stamp *nx;
+
+	dde = &crb->source;
+	pr_devel("SrcDDE: addr 0x%llx, len %d, count %d, idx %d, flags %d\n",
+		be64_to_cpu(dde->address), be32_to_cpu(dde->length),
+		dde->count, dde->index, dde->flags);
+
+	dde = &crb->target;
+	pr_devel("TgtDDE: addr 0x%llx, len %d, count %d, idx %d, flags %d\n",
+		be64_to_cpu(dde->address), be32_to_cpu(dde->length),
+		dde->count, dde->index, dde->flags);
+
+	nx = &crb->stamp.nx;
+	pr_devel("NX Stamp: PSWID 0x%x, FSA 0x%llx, flags 0x%x, FS 0x%x\n",
+		be32_to_cpu(nx->pswid),
+		be64_to_cpu(crb->stamp.nx.fault_storage_addr),
+		nx->flags, be32_to_cpu(nx->fault_status));
+}
+
 /*
  * Update the CSB to indicate a translation error.
  *
@@ -144,6 +166,23 @@ static void update_csb(struct vas_window *window,
 			pid_vnr(pid), rc);
 }
 
+static void dump_fifo(struct vas_instance *vinst, void *entry)
+{
+	int i;
+	unsigned long *fifo = entry;
+
+	pr_err("Fault fifo size %d, max crbs %d, crb size %lu\n",
+			vinst->fault_fifo_size,
+			vinst->fault_fifo_size / CRB_SIZE,
+			sizeof(struct coprocessor_request_block));
+
+	pr_err("Fault FIFO Entry Dump:\n");
+	for (i = 0; i < CRB_SIZE; i += 4, fifo += 4) {
+		pr_err("[%.3d, %p]: 0x%.16lx 0x%.16lx 0x%.16lx 0x%.16lx\n",
+			i, fifo, *fifo, *(fifo+1), *(fifo+2), *(fifo+3));
+	}
+}
+
 /*
  * Process CRBs that we receive on the fault window.
  */
@@ -204,6 +243,7 @@ irqreturn_t vas_fault_handler(int irq, void *data)
 				vinst->vas_id, vinst->fault_fifo, fifo,
 				vinst->fault_crbs);
 
+		dump_crb(crb);
 		window = vas_pswid_to_window(vinst,
 				be32_to_cpu(crb->stamp.nx.pswid));
 
@@ -214,6 +254,7 @@ irqreturn_t vas_fault_handler(int irq, void *data)
 			 * even clean it up (return credit).
 			 * But we should not get here.
 			 */
+			dump_fifo(vinst, (void *)crb);
 			pr_err("VAS[%d] fault_fifo %p, fifo %p, pswid 0x%x, fault_crbs %d bad CRB?\n",
 				vinst->vas_id, vinst->fault_fifo, fifo,
 				be32_to_cpu(crb->stamp.nx.pswid),
-- 
1.8.3.1



