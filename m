Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC13BC282C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 00:23:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4F920873
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 00:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4F920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yRNY1gLtzDqDQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 11:23:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yRJl3GqLzDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 11:20:38 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1B09O89121287
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 19:20:36 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qjrwab4jt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 19:20:36 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 11 Feb 2019 00:20:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 11 Feb 2019 00:20:31 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1B0KUdd5243196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Feb 2019 00:20:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6812F42042;
 Mon, 11 Feb 2019 00:20:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16D2F42041;
 Mon, 11 Feb 2019 00:20:30 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 11 Feb 2019 00:20:30 +0000 (GMT)
Received: from intelligence.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id ED98CA01D9;
 Mon, 11 Feb 2019 11:20:27 +1100 (AEDT)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] powerpc/64s: Fix logic when handling unknown CPU
 features
Date: Mon, 11 Feb 2019 11:20:01 +1100
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19021100-0028-0000-0000-00000346ED29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021100-0029-0000-0000-00002405063D
Message-Id: <20190211002002.26038-1-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-10_19:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110000
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
Cc: syzkaller@googlegroups.com, npiggin@gmail.com, dvyukov@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michael Ellerman <mpe@ellerman.id.au>

In cpufeatures_process_feature(), if a provided CPU feature is unknown and
enable_unknown is false, we erroneously print that the feature is being
enabled and return true, even though no feature has been enabled, and
may also set feature bits based on the last entry in the match table.

Fix this so that we only set feature bits from the match table if we have
actually enabled a feature from that table, and when failing to enable an
unknown feature, always print the "not enabling" message and return false.

Coincidentally, some older gccs (<GCC 7), when invoked with
-fsanitize-coverage=trace-pc, cause a spurious uninitialised variable
warning in this function:

  arch/powerpc/kernel/dt_cpu_ftrs.c: In function ‘cpufeatures_process_feature’:
  arch/powerpc/kernel/dt_cpu_ftrs.c:686:7: warning: ‘m’ may be used uninitialized in this function [-Wmaybe-uninitialized]
    if (m->cpu_ftr_bit_mask)

An upcoming patch will enable support for kcov, which requires this option.
This patch avoids the warning.

Fixes: 5a61ef74f269 ("powerpc/64s: Support new device tree binding for discovering CPU features")
Reported-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[ajd: add commit message]
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---
v1->v2:
- fix the other logic errors in this function (segher, mpe)

---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 8be3721d9302..e49bd5efcfe6 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -666,8 +666,10 @@ static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
 		m = &dt_cpu_feature_match_table[i];
 		if (!strcmp(f->name, m->name)) {
 			known = true;
-			if (m->enable(f))
+			if (m->enable(f)) {
+				cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
 				break;
+			}
 
 			pr_info("not enabling: %s (disabled or unsupported by kernel)\n",
 				f->name);
@@ -675,17 +677,12 @@ static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
 		}
 	}
 
-	if (!known && enable_unknown) {
-		if (!feat_try_enable_unknown(f)) {
-			pr_info("not enabling: %s (unknown and unsupported by kernel)\n",
-				f->name);
-			return false;
-		}
+	if (!known && (!enable_unknown || !feat_try_enable_unknown(f))) {
+		pr_info("not enabling: %s (unknown and unsupported by kernel)\n",
+			f->name);
+		return false;
 	}
 
-	if (m->cpu_ftr_bit_mask)
-		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
-
 	if (known)
 		pr_debug("enabling: %s\n", f->name);
 	else
-- 
2.11.0

