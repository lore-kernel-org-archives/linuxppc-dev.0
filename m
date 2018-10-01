Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C7C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:00:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6787E2084C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6787E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PBRf3LNrzF3By
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 04:59:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PBMk4HkDzF3Cb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 04:56:34 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w91IsXcw007616
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Oct 2018 14:56:32 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2murnxhfw6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 14:56:31 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 1 Oct 2018 12:56:31 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Oct 2018 12:56:26 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w91IuPbI41812070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Oct 2018 11:56:25 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8ACABE058;
 Mon,  1 Oct 2018 12:56:25 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8790DBE051;
 Mon,  1 Oct 2018 12:56:25 -0600 (MDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  1 Oct 2018 12:56:25 -0600 (MDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id 350952087F40;
 Mon,  1 Oct 2018 13:56:25 -0500 (CDT)
Subject: [PATCH] migration/mm: Add WARN_ON to try_offline_node
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mwb@linux.vnet.ibm.com
Date: Mon, 01 Oct 2018 13:56:25 -0500
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100118-8235-0000-0000-00000E0ABA13
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009804; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096428; UDB=6.00566942; IPR=6.00876470; 
 MB=3.00023577; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 18:56:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100118-8236-0000-0000-000042D6EF7D
Message-Id: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010180
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
Cc: Michal Hocko <mhocko@suse.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>, Mathieu Malaterre <malat@debian.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In some LPAR migration scenarios, device-tree modifications are
made to the affinity of the memory in the system.  For instance,
it may occur that memory is installed to nodes 0,3 on a source
system, and to nodes 0,2 on a target system.  Node 2 may not
have been initialized/allocated on the target system.

After migration, if a RTAS PRRN memory remove is made to a
memory block that was in node 3 on the source system, then
try_offline_node tries to remove it from node 2 on the target.
The NODE_DATA(2) block would not be initialized on the target,
and there is no validation check in the current code to prevent
the use of a NULL pointer.  Call traces such as the following
may be observed:

A similar problem of moving memory to an unitialized node has
also been observed on systems where multiple PRRN events occur
prior to a complete update of the device-tree.

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

This patch adds a check for an incorrectly initialized to the
beginning of try_offline_node, and exits the routine.

Another patch is being developed for powerpc to track the
node Id to which an LMB belongs, so that we can remove the
LMB from there instead of the nid as currently interpreted
from the device tree.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 mm/memory_hotplug.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 38d94b7..e48a4d0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1831,10 +1831,16 @@ static int check_and_unmap_cpu_on_node(pg_data_t *pgdat)
 void try_offline_node(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
-	unsigned long start_pfn = pgdat->node_start_pfn;
-	unsigned long end_pfn = start_pfn + pgdat->node_spanned_pages;
+	unsigned long start_pfn;
+	unsigned long end_pfn;
 	unsigned long pfn;
 
+	if (WARN_ON(pgdat == NULL))
+		return;
+
+	start_pfn = pgdat->node_start_pfn;
+	end_pfn = start_pfn + pgdat->node_spanned_pages;
+
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 

