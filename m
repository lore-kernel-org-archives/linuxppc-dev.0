Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC7C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 03:43:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0258D2077B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 03:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0258D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JyP21CDwzDqJN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 14:43:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JyM63NpDzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 14:41:52 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2D3dK0b136736
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 23:41:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r6p5th8va-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 23:41:50 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 13 Mar 2019 03:41:48 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Mar 2019 03:41:45 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2D3fi6W33423418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2019 03:41:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04D044C040;
 Wed, 13 Mar 2019 03:41:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6F404C04E;
 Wed, 13 Mar 2019 03:41:43 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 Mar 2019 03:41:43 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 50EF2A00D1;
 Wed, 13 Mar 2019 14:41:40 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: 
Subject: [PATCH 1/1] arch/powerpc: Don't assume start_text & head_end align
Date: Wed, 13 Mar 2019 14:38:51 +1100
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031303-0012-0000-0000-00000301E979
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031303-0013-0000-0000-000021390D73
Message-Id: <20190313033852.13028-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-13_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=830 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130024
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
Cc: Alastair D'Silva <alastair@d-silva.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Alastair D'Silva <alastair@d-silva.org>

When building LTO kernels, the start_text symbol is not guaranteed to mark
the end of the head section.

Instead, look explicitly for __head_end.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/tools/head_check.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_check.sh
index ad9e57209aa4..1b0f634038c3 100644
--- a/arch/powerpc/tools/head_check.sh
+++ b/arch/powerpc/tools/head_check.sh
@@ -44,7 +44,7 @@ nm="$1"
 vmlinux="$2"
 
 # gcc-4.6-era toolchain make _stext an A (absolute) symbol rather than T
-$nm "$vmlinux" | grep -e " [TA] _stext$" -e " t start_first_256B$" -e " a text_start$" -e " t start_text$" -m4 > .tmp_symbols.txt
+$nm "$vmlinux" | grep -e " [TA] _stext$" -e " t start_first_256B$" -e " a text_start$" -e " T __head_end$" -m4 > .tmp_symbols.txt
 
 
 vma=$(cat .tmp_symbols.txt | grep -e " [TA] _stext$" | cut -d' ' -f1)
@@ -63,12 +63,12 @@ fi
 
 top_vma=$(echo $vma | cut -d'0' -f1)
 
-expected_start_text_addr=$(cat .tmp_symbols.txt | grep " a text_start$" | cut -d' ' -f1 | sed "s/^0/$top_vma/")
+expected_head_end_addr=$(cat .tmp_symbols.txt | grep " a text_start$" | cut -d' ' -f1 | sed "s/^0/$top_vma/")
 
-start_text_addr=$(cat .tmp_symbols.txt | grep " t start_text$" | cut -d' ' -f1)
+head_end_addr=$(cat .tmp_symbols.txt | grep " T __head_end$" | cut -d' ' -f1)
 
-if [ "$start_text_addr" != "$expected_start_text_addr" ]; then
-	echo "ERROR: start_text address is $start_text_addr, should be $expected_start_text_addr"
+if [ "$head_end_addr" != "$expected_head_end_addr" ]; then
+	echo "ERROR: __head_end address is $head_end_addr, should be $expected_head_end_addr"
 	echo "ERROR: try to enable LD_HEAD_STUB_CATCH config option"
 	echo "ERROR: see comments in arch/powerpc/tools/head_check.sh"
 
-- 
2.20.1

