Return-Path: <linuxppc-dev+bounces-18190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D7010706DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Mar 2026 13:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fY2C70S0Wz2xl0;
	Sun, 15 Mar 2026 00:24:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773494690;
	cv=none; b=BbagsRt7Tbd7goKcv1/BOi/eOZtUu8u+/Bi6s0D7ik2d3ANgPb4mbwA2mdjd/5lqTB/h1ydJ4qRkdQ3Q+zfFrGmUNPGEmwHPeuK443WEQyO7kH2h5MLqAugw9HcoKRadgZutiUjRANGFoC6ohOQ/TT55vMO76GNZEC3Vwnkt1RMhJxT++L5vsedQZ9bDOrXSpD+sE1YtYwU/4wQ86zaf2vAHef95cxjJN3K6Fu1VQuCdcDCRUsosQTJrvKyCKaadTHEfLjNeq89NSr/kkq6al7YbND2Snqq28l1lVXryvi8ab9JLXNgoVllQ13HrmBupPa4RoYVz39L2ai3RHpwciw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773494690; c=relaxed/relaxed;
	bh=a0QNStd4lklKKb1lrzFrQinWzrFfAOoTfSEGMrAnBn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVgyPo+bwik+I7c0w8OM5yaODYa6N6n5IGYN0wd+A9xXEKiYQoyfaJmW/a4kJJJ2Z+ipHkOb7x46QPPcqsBpvFuaUUCHY81bntGChlUaNgaonNznNc1ImB6Gg92kKAIGJWjCqYVFFfHIdcHtOKn4LgPHmK1+W6ws8jFWOuFOOWKsyLa2otbf0Dkqr6GLxWrmbqNyOi9m1rkMrUplPRnMyvZLAh97BEbyVKPL9J/tRTxqN0q5V44DDcu+afb0/jzk7kb5o6TIA/M0lSaltfxjhZEOThXgcvQnXO9ywIP+qaUxloyhWkabHu+MyqyGq3YBjvlSAyPBTd1+yHnuyD4jTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TFPzZRaF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TFPzZRaF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fY2C621fWz2xjb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 00:24:49 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62EAoGbV1100409
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a0QNStd4lklKKb1lr
	zFrQinWzrFfAOoTfSEGMrAnBn4=; b=TFPzZRaFRt70AR+sUR4oviSJA6pFBeAmH
	iYdLfjTeFY9iqdbF6eiBpYb5edQqPnqTcU+6BPLZ76ja7pB04GMCkkU3xdEYU/BP
	HGnuA6rHzpMhO4DegkLsuvkDSx/93meABf3VRzvGizWnBN+EJE4lmI0gsdN0yk7z
	C2nSmfob6FImEb8R7lfKtgnloLQZb6PbA4bnwCh3JJCGZ8QMv4EpN8wrNTLbX4VK
	7BxMipmsQ8FBsKPf3+qA3VuDHrnkdRBTUG6aONFE53LswZl3E+aDWGIAammZXNQb
	wYnSnxQ8v2dGicn6f0sLNvxmPlwDgkUlzP0XMqRkQodwp5RsRlLRg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyd398fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62E8Q8SF025686
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8jdmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 13:24:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62EDOhs950069856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Mar 2026 13:24:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4802220040;
	Sat, 14 Mar 2026 13:24:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFCD420043;
	Sat, 14 Mar 2026 13:24:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.218.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Mar 2026 13:24:41 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH 2/3] powerpc/pseries/htmdump: Fix the offset value used in processor configuration dump
Date: Sat, 14 Mar 2026 18:54:31 +0530
Message-Id: <20260314132432.25581-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260314132432.25581-1-atrajeev@linux.ibm.com>
References: <20260314132432.25581-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PbPyRyhd c=1 sm=1 tr=0 ts=69b561a0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=r3PrFMhtbkYojMpozuMA:9
X-Proofpoint-ORIG-GUID: wnI1scmCmHzG5IqD6r7tXz1vxdMWGDtd
X-Proofpoint-GUID: wnI1scmCmHzG5IqD6r7tXz1vxdMWGDtd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDEwMyBTYWx0ZWRfX5yLBZjy2N/F7
 o7h9qGCwgPi4AfDw793mJnjmO4+LhjZ0W/k9e1gg9ImG7qWRxeyip/YD3fdNYWOhdcVH2INz8MG
 +G2dmzxTJfi6rNmLrsrKIHz9Q0JoIoqS3JY5TcTEPwmJU/Rgi/oMiFiBFaEzWZi1haDQZ0OGjvM
 2RL3AAWSg89v3BxrwlXdvCqJPvwb9zdPBtt13pF950p25ii+pA2+GBRML/2KscndgGt9hdRb38O
 m3yeds2iXJbU7Gol0c1YSY+9orfNmyFd1y3IP/PjjFdBCTXIx2/QwYWF4Spng4w6XErUOralvmw
 KdjZs/Ee6bCOZERYZpvAS/t4kCM0OyVcKJrQ5l63DFn1alPuSbb0/F5rLKYTAx+5CGdsxrFqhVH
 e2l7kiuRpFr+Aifw1/VGP4UbDrc+eATbxxayM2kVV5fbSa1TK+ZYPldV8+RNEGI92bGoN1RIL+5
 BJOUV3HXteVESjMB+Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140103

H_HTM call is invoked using three parameters specifying
the address of the buffer, size of the buffer and offset
where to read from. offset used was always zero.
"offset" is value from output buffer header that points
to next entry to dump. zero is the first entry to dump.
next entry is read from the output bufferbyte offset 0x8.
Update htminfo_read() function to use right offset. Return
when offset points to -1

Fixes: dea7384e14e7 ("powerpc/pseries/htmdump: Add htm info support to htmdump module")
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/htmdump.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/htmdump.c b/arch/powerpc/platforms/pseries/htmdump.c
index 93f0cc2dc7fb..34978a794eba 100644
--- a/arch/powerpc/platforms/pseries/htmdump.c
+++ b/arch/powerpc/platforms/pseries/htmdump.c
@@ -277,15 +277,26 @@ static ssize_t htminfo_read(struct file *filp, char __user *ubuf,
 	long rc, ret;
 	u64 *num_entries;
 	u64 to_copy;
+	loff_t offset = 0;
+	u64 info_offset = 0;
 
 	/*
 	 * Invoke H_HTM call with:
 	 * - operation as htm status (H_HTM_OP_STATUS)
 	 * - last three values as addr, size and offset
+	 *   "offset" is value from output buffer header
+	 *   that points to next entry to dump. 0 is the first
+	 *   entry to dump. next entry is read from the output
+	 *   bufferbyte offset 0x8.
 	 */
+	if (*ppos) {
+		info_offset = *(u64 *)(htm_info_data + 0x8);
+		if (info_offset == -1)
+			return 0;
+	}
 	rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
 				   htmtype, H_HTM_OP_DUMP_SYSPROC_CONF, virt_to_phys(htm_info_data),
-				   PAGE_SIZE, 0);
+				   PAGE_SIZE, be64_to_cpu(info_offset));
 
 	ret = htm_return_check(rc);
 	if (ret <= 0) {
@@ -303,7 +314,9 @@ static ssize_t htminfo_read(struct file *filp, char __user *ubuf,
 	 */
 	num_entries = htm_info_data + 0x10;
 	to_copy = 32 + (be64_to_cpu(*num_entries) * 16);
-	return simple_read_from_buffer(ubuf, count, ppos, htm_info_data, to_copy);
+
+	*ppos += to_copy;
+	return simple_read_from_buffer(ubuf, count, &offset, htm_info_data, to_copy);
 }
 
 static ssize_t htmcaps_read(struct file *filp, char __user *ubuf,
-- 
2.47.3


