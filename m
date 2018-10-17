Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA8ECDE3B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:43:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4022086E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4022086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42b2fR1w7QzF3Hn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 06:43:27 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42b2Xg2M0mzF3Zy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 06:38:27 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9HJYw9T142976
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 15:38:25 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n6981nfjq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 15:38:25 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 17 Oct 2018 15:38:24 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Oct 2018 15:38:22 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9HJcLdn45940848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Oct 2018 19:38:22 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D51B9124052;
 Wed, 17 Oct 2018 19:38:21 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8A19124054;
 Wed, 17 Oct 2018 19:38:21 +0000 (GMT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 17 Oct 2018 19:38:21 +0000 (GMT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id 6BCF72087F42;
 Wed, 17 Oct 2018 14:38:21 -0500 (CDT)
Subject: [PATCH v07 2/5] powerpc/drmem: Add internal_flags feature
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Wed, 17 Oct 2018 14:38:21 -0500
In-Reply-To: <20181017193745.4844.11915.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181017193745.4844.11915.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101719-0072-0000-0000-000003B75594
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009893; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01104107; UDB=6.00571556; IPR=6.00884159; 
 MB=3.00023798; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-17 19:38:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101719-0073-0000-0000-000049CA6EB1
Message-Id: <20181017193814.4844.35048.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-16_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170162
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

powerpc/drmem: Add internal_flags field to each LMB to allow
marking of kernel software-specific operations that need not
be exported to other users.  For instance, if information about
selected LMBs needs to be maintained for subsequent passes
through the system, it can be encoded into the LMB array itself
without requiring the allocation and maintainance of additional
data structures.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in v04:
  -- Add another initialization of 'lmb->internal_flags' to
     init_drmem_v2_lmbs.
---
 arch/powerpc/include/asm/drmem.h |   18 ++++++++++++++++++
 arch/powerpc/mm/drmem.c          |    3 +++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index cfe8598..dbb3e6c 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -17,6 +17,7 @@ struct drmem_lmb {
 	u32     drc_index;
 	u32     aa_index;
 	u32     flags;
+	u32     internal_flags;
 };
 
 struct drmem_lmb_info {
@@ -94,6 +95,23 @@ static inline bool drmem_lmb_reserved(struct drmem_lmb *lmb)
 	return lmb->flags & DRMEM_LMB_RESERVED;
 }
 
+#define DRMEM_LMBINT_UPDATE	0x00000001
+
+static inline void drmem_mark_lmb_update(struct drmem_lmb *lmb)
+{
+	lmb->internal_flags |= DRMEM_LMBINT_UPDATE;
+}
+
+static inline void drmem_remove_lmb_update(struct drmem_lmb *lmb)
+{
+	lmb->internal_flags &= ~DRMEM_LMBINT_UPDATE;
+}
+
+static inline bool drmem_lmb_update(struct drmem_lmb *lmb)
+{
+	return lmb->internal_flags & DRMEM_LMBINT_UPDATE;
+}
+
 u64 drmem_lmb_memory_max(void);
 void __init walk_drmem_lmbs(struct device_node *dn,
 			void (*func)(struct drmem_lmb *, const __be32 **));
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index ded9dbf..f199fe5 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -207,6 +207,7 @@ static void read_drconf_v1_cell(struct drmem_lmb *lmb,
 
 	lmb->aa_index = of_read_number(p++, 1);
 	lmb->flags = of_read_number(p++, 1);
+	lmb->internal_flags = 0;
 
 	*prop = p;
 }
@@ -265,6 +266,7 @@ static void __walk_drmem_v2_lmbs(const __be32 *prop, const __be32 *usm,
 
 			lmb.aa_index = dr_cell.aa_index;
 			lmb.flags = dr_cell.flags;
+			lmb.internal_flags = 0;
 
 			func(&lmb, &usm);
 		}
@@ -441,6 +443,7 @@ static void init_drmem_v2_lmbs(const __be32 *prop,
 
 			lmb->aa_index = dr_cell.aa_index;
 			lmb->flags = dr_cell.flags;
+			lmb->internal_flags = 0;
 		}
 	}
 }

