Return-Path: <linuxppc-dev+bounces-26580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACBFC624D3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 01:27:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcG0V50w5z2ygW;
	Sat, 05 Sep 2026 11:27:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788571642;
	cv=none; b=VEhrOmHoWKoYQ8dcIOKWrG/Mw3tn26xCfX7KpMZJbGoAK27TzqlXLzlqjwSAU8dQI+vmU4i7KO354rHTqGCAFzcAVazHHWBEvYjh33OglEWSDc/gYxx0GkIGzu+cTWUZT39+PsHl8D7Oi8nvfv9z8CReiNn2+hNJ4fYWrze9LH0N3UHNhJLCG9pTqmhmGL/HMsXrx9TyzpfIHLN60p6xV1/0zSqZAGoWkTyGGSDcvm5048zy1919exaCB+mTogWTZjw8w96/ALXHHCeFMyCH55t0POUZrd1iwDYjbh1qE+LvEbroIqGW87vGZyvmAc7WLGvLTEwUjxHKvMdpk6x7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788571642; c=relaxed/relaxed;
	bh=RQeG4t6RgDgfjDxKYj9HDrRTVI3xstNuvVQdnS4ItBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvnSarc2TX+vz+REdZGOWeL+1WW9PPhxiba5aN2gtnDW4SJcIWr6CVj+27Rn5KuysRQbgtbn5c3fwPdNgia0ohQCVKXfq5XCswOznfVGC1t8CNzCKAZxyn63UrnJvUL6aGCIFh3FoAtofPlUOGM0VVXgKkngsOybb3QYG0o1m5XSTwdsInL7CbE0RPN/AYLjCykHcpigQzGgdFRHr6Zq5jsOLAiumjREzWlWrPdth7KNhr5tOk2sKRPAKYIq6cjpnLWGKZr7qACMpUfydWP7hu5zt+uNcekHU3uis613PRGbb4vZuSnUvkm9OLdM1JdYPnnOHfNB5K3LT+rNQbGd/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YC7vltUv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YC7vltUv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcG0T5jNyz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 11:27:21 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68511enD2147132;
	Sat, 5 Sep 2026 01:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RQeG4t6RgDgfjDxKYj9HDrRTVI3xstNuvVQdnS4It
	BA=; b=YC7vltUvidQ8sjEYUFXItOhPy+05q4yqlWoBOt6/yLNytXmBYoiUZrj2K
	BDgjD1rFcUC4yaymH0wj/CVdv7To6QtgRF+xud7y3BY8QPQaM3KO/1PulsNKDieg
	AVtp/NM0w8RR5eBVpyHAhODCxCdtPRftyKLbIayt2TnGRoRBnqRtT1LTZpMhJ9AK
	r2XKvvOy82YLxyAYE4TQc/gqVyz6OIVhnmRqc4xAQws622APfLUiXAT33eJc+Hvo
	EUzDsL/K1EgxBjlFM3OJa11gmr/1rF9FzUefT3/GDdcRNl5K+7CvZWuP8wlD2gph
	DBxMbck2L284xIaNCOOisKd4ovTOg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnuedhnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Sep 2026 01:27:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6851QZlI016404;
	Sat, 5 Sep 2026 01:27:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyqx8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Sep 2026 01:27:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6851RBiS43188710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 5 Sep 2026 01:27:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA2420043;
	Sat,  5 Sep 2026 01:27:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFAAF20040;
	Sat,  5 Sep 2026 01:27:08 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.111.88.25])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  5 Sep 2026 01:27:08 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "scripts/faddr2line: Combine three readelf calls into one"
Date: Sat,  5 Sep 2026 06:54:49 +0530
Message-ID: <20260905012449.3872882-2-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: lVbDn-yUaWWnVLwlLryQkg8KISfcmFbp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDAwNiBTYWx0ZWRfX46LOESWLIoeg
 HOK2XonStFS8oiAEbDaJBKooJxwH3s70KCiz1QcJF8ge9tsgSePRIW/tB9g2BDSHPIBt29qxmTJ
 gruCbJFtmiDY9m+g4dJZEbX7nH9WtpGEqbgd1TIJRVwU3cEax6QhvIGrvCfL3UzVPUMlbmvUsTk
 pv+8HF1w5XkCALiZkS52TbHKd+EAhiNuCiC9HeihSZATqjLMZsoaPqLrrFq0apGgpjmmpGDSDX9
 qP29Ns2VrqmnHykVZmm8fcQoxKDp1de/DEmqXKL1+ooeh5olkZvomhp6CpmAs7qx2m655OnP61K
 kuWBRsdCDsyPOUdmZBPZNDy5kVDxdmN2clsQEE4/bXFkO2++qRrff9/XDyqzpKXrfhka9WgNUO6
 lcbGQbuVHKX40aSFfF+n7sKqqHE0sTtDSy8BEyyT2Ifqb9sLUcA14l1eKjhsvN8rj1CVQMMuEbv
 2B/FCzW5mjZGJjFQUGw==
X-Proofpoint-ORIG-GUID: evY0fGSfewimcj2WHFjXIgl-ej3vtSpi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDAwNiBTYWx0ZWRfX+NXvA0f5AfJR
 KagdOJslyTzMgtxs+nLZD3xiDz33czjkh7Cr2Gxeh9//U3+VU6Iw9KdCQOyfk7qJs5mTUatwiG/
 rCG/2Io/Vp3IldXih2BD2djXE63BdMk=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9b6ff4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=oZuti8gFUO8STRSf8oIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050006

This reverts commit b8d9d9496c1e ("scripts/faddr2line: Combine three
readelf calls into one")

scripts/faddr2line stopped working on PowerPc systems with this commit.

Output  of scripts/faddr2line on latest kernel sources
$ scripts/faddr2line ./vmlinux need_active_balance+0x1d4/0x21c
$
Output of scripts/faddr2line with revert
$ scripts/faddr2line ./vmlinux need_active_balance+0x1d4/0x21c
need_active_balance+0x1d4/0x21c:
imbalanced_active_balance at kernel/sched/fair.c:12047
(inlined by) need_active_balance at kernel/sched/fair.c:12061
$

readelf on Powerpc when passed with --file-header --section-headers
--symbol --wide option doesnt show the line
 "There are 62 section headers, starting at offset 0x16f1a850:"

Hence faddr2line parsing gets broken.

It could be a bug in Powerpc readelf that this line doesnt get printed.
However since its breaking with existing readelf, its better to be
reverted.

With the revert, we end up calling readelf three times but this should
still be fine since calling faddr2line is a debug tool.

Fixes: b8d9d9496c1e ("scripts/faddr2line: Combine three readelf calls into one")
Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 scripts/faddr2line | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 622875396bcf..bf2098beefbe 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -111,19 +111,10 @@ find_dir_prefix() {
 
 run_readelf() {
 	local objfile=$1
-	local tmpfile
-	tmpfile=$(mktemp)
 
-	${READELF} --file-header --section-headers --symbols --wide "$objfile" > "$tmpfile"
-
-	# This assumes that readelf first prints the file header, then the section headers, then the symbols.
-	# Note: It seems that GNU readelf does not prefix section headers with the "There are X section headers"
-	# line when multiple options are given, so let's also match with the "Section Headers:" line.
-	ELF_FILEHEADER=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p' "$tmpfile")
-	ELF_SECHEADERS=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' "$tmpfile" | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
-	ELF_SYMS=$(sed -n '/Symbol table .* contains [0-9]* entries:/,$p' "$tmpfile")
-
-	rm -f -- "$tmpfile"
+	ELF_FILEHEADER=$(${READELF} --file-header $objfile)
+	ELF_SECHEADERS=$(${READELF} --section-headers --wide $objfile)
+	ELF_SYMS=$(${READELF} --symbols --wide $objfile)
 }
 
 check_vmlinux() {
-- 
2.52.0


