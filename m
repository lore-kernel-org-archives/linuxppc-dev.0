Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CCBC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 18:11:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9E12084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 18:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9E12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42R1Cj0nVjzF3M7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:10:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42R19755dlzF3KB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 04:08:43 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w94HsZGM017863
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Oct 2018 14:08:41 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mwpd3c8gc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 14:08:40 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 4 Oct 2018 14:08:40 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 4 Oct 2018 14:08:38 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w94I8bqi46727360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Oct 2018 18:08:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C32C12405E;
 Thu,  4 Oct 2018 15:08:31 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6133C12406B;
 Thu,  4 Oct 2018 15:08:31 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  4 Oct 2018 15:08:31 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id AE173225B2ED;
 Thu,  4 Oct 2018 13:08:36 -0500 (CDT)
Subject: [PATCH] powerpc/migration: Init nodes before remove memory
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Thu, 04 Oct 2018 13:08:36 -0500
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100418-0064-0000-0000-0000035A182D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009822; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01097852; UDB=6.00567797; IPR=6.00877892; 
 MB=3.00023615; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-04 18:08:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100418-0065-0000-0000-00003ADE74F9
Message-Id: <20181004180658.17620.16497.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-04_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810040164
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
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In some LPAR migration scenarios, device-tree modifications are
made to the affinity of the memory in the system.  For instance,
it may occur that memory is installed to nodes 0,3 on a source
system, and to nodes 0,2 on a target system.  Node 2 may not have
been initialized/allocated on the target system.

During normal DLPAR memory 'hot add' operations, unitialized nodes
are initialized/allocated prior to use.  After migration, if a
RTAS PRRN memory remove operation is made on a memory block that
was in node 3 on the source system, then try_offline_node tries
to remove it from node 2 on the target assuming that it was in
node 2 on the source system and that node 2 had been setup.
The NODE_DATA(2) block is not initialized on the target, and
there is no validation check to prevent the use of a NULL pointer.
Call traces such as the following may be observed:

pseries-hotplug-mem: Attempting to update LMB, drc index 80000002
Offlined Pages 4096
...
Oops: Kernel access of bad area, sig: 11 [#1]
...
Workqueue: pseries hotplug workque pseries_hp_work_fn
...
NIP [c0000000002bc088] try_offline_node+0x48/0x1e0
LR [c0000000002e0b84] remove_memory+0xb4/0xf0
Call Trace:
[c0000002bbee7a30] [c0000002bbee7a70] 0xc0000002bbee7a70 (unreliable)
[c0000002bbee7a70] [c0000000002e0b84] remove_memory+0xb4/0xf0
[c0000002bbee7ab0] [c000000000097784] dlpar_remove_lmb+0xb4/0x160
[c0000002bbee7af0] [c000000000097f38] dlpar_memory+0x328/0xcb0
[c0000002bbee7ba0] [c0000000000906d0] handle_dlpar_errorlog+0xc0/0x130
[c0000002bbee7c10] [c0000000000907d4] pseries_hp_work_fn+0x94/0xa0
[c0000002bbee7c40] [c0000000000e1cd0] process_one_work+0x1a0/0x4e0
[c0000002bbee7cd0] [c0000000000e21b0] worker_thread+0x1a0/0x610
[c0000002bbee7d80] [c0000000000ea458] kthread+0x128/0x150
[c0000002bbee7e30] [c00000000000982c] ret_from_kernel_thread+0x5c/0xb0

A similar problem of moving memory to an unitialized node has also
been observed on systems where multiple PRRN events occur prior to
a complete update of the device-tree.

This patch attempts to detect and initialize an uninitialized node
in the memory_add_physaddr_to_nid -> hot_add_scn_to_nid functions
used by powerpc DLPAR memory operations to compute the node of a
emory address based on the device-tree affinity configuration
after migration.  This occurs before try_offline_node is used by
remove_memory.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0ade0a1..d6f6e24 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1020,6 +1020,13 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 	if (nid < 0 || !node_possible(nid))
 		nid = first_online_node;
 
+	if (NODE_DATA(nid) == NULL) {
+		if (try_online_node(nid))
+			nid = first_online_node;
+		else
+			pr_debug("new nid %d for %#010lx\n", nid, scn_addr);
+	}
+
 	return nid;
 }
 

