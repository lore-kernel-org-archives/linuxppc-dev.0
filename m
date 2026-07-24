Return-Path: <linuxppc-dev+bounces-24782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8254EC531F9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 14:14:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h693973z3z2ygL;
	Sat, 25 Jul 2026 00:14:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784902453;
	cv=none; b=iZgGTiYIiNqTT2zhHnCcCylTHSvTPr46g3r5nyLvF85Grq0wDDA4Yz4ixteMNJa3mREP4znsjVlxk5UueqbY+r7TgcOnwyDu+hckz9wsUGOxPQ793LsjZb+ipN/q0LE94a1D01QufrSXbEBSjfhSz8Xh4lVr+zbLdQZLKaTc0KVS2Ey8ZaN6UHoOAG2/RkiBg1YzJ5vaKKLyukKmaO7cT/uEeQAB8vj9SFDhL2PfXIxacRey4T7DJIei5bFM++WZnWfD5x2+46wddGOOmeur//8JV2NOI9yLBSkoH1spzTviFUFyBl9z5ZO4L7bk+F79Ero8bUWlwZdZ3GcQ2TRUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784902453; c=relaxed/relaxed;
	bh=adKhPbEcftGU4WeiVoCsxYFJ0G0quz1bO44+2RAF0n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYzfsEZz/8iZuj9RoRYmTe/cRHHg0iczVONzynv4KtLCnAYXVbkSJLI7zbTxOPWeD7mkw7LNI5dse67s99mL2lIrhjXjd8oxq2kiDFMGSRVOGaNBJDXPZ/ElDvd2h6ruyDsKZsBXhamk97mfe7Ce90gASTDJ/olPSFltgEzU+98ucta15OPO9lP5CFWNfUsikI4jJ1SQD2/Yh77qszzrQGGm/IgMI0KTu5+Jz0wxqrSRc+XoHjx2902hNid/Tr7VW56o4FLDGUh4AR+li4Lu1eT/ETjJ3m0DNcLHSFkLqKiXRCIREoulyHR5avW486NQiwnaz6iqtL5XPLhMpOgn9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mzE1Ed0E; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mzE1Ed0E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h69391Dv4z2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 00:14:12 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODg6ML1899349;
	Fri, 24 Jul 2026 14:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=adKhPbEcftGU4WeiV
	oCsxYFJ0G0quz1bO44+2RAF0n8=; b=mzE1Ed0ES8jxIC09r777JyiQ/nDyCbTmK
	AZOpFUpyiMGVgcIDvhkBtQcmjUwkIV3hCMb0HRMq1ZTRs1Dnxu2pJFcTNZAWAkcm
	/PGPkTmAbgEGJ9rVd0TDWxuF7N+neEWXFtEXdq+6JYHAS8zzen8363qrQBkaonpt
	cCIc57mlaoV13m2VkKLcVzRd1d2WY5cWgx9MQ+Ow8i7FZzMa9NnoQh57lwacOZJe
	sY+QW9VI1ZnQ08i6oTkhTMAQtg9zCQP3TeiRojQjIFZsd/JWYc6SumENn1QZxOAa
	svP+LFQdzQV2qE/NE+WyQkByF0pmdwedez98oikE06tnJOokD8djQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kmf5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:14:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4iTJ013251;
	Fri, 24 Jul 2026 14:14:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whaq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:14:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEE2NI45941168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:14:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DA8B20230;
	Fri, 24 Jul 2026 14:14:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65C512021D;
	Fri, 24 Jul 2026 14:13:58 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.22.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:58 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [PATCH v3 5/5] perf trace-event: Fix infinite loop in skip()
Date: Fri, 24 Jul 2026 19:43:16 +0530
Message-ID: <20260724141316.99507-6-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724141316.99507-1-tshah@linux.ibm.com>
References: <20260724141316.99507-1-tshah@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a63732f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1smD9fHUAMlVQ18p2oYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfXx7H3yCQ69SGI
 PSOKCu8R/d3Fom41J5onQXNUSqHA+p3pucCj5G1qh7PQEyWYOtM8uLoZ63du3Jvp0Qaw2+vatrR
 byb+tU5geyqS6OUuEwPjOnYkELHlTU0oaOIoWdfM5+AUWJ1NiuBZ6GbBxgs0Tdj6MBdswexKw3/
 YXNaCl7LCdlBJnv2PLPHClXcSpN2Bf2rs1p7FvtPOMkVjdXkpLZdCkIM43n2D+6Gjtn6iaMhGD1
 fuxONTTzPd4wx+M3xvf9oiAt2i8l21BvUj68FYfwch+m938A7mjmLuEjTZgjeta231WrmRbyFzQ
 zycB9mrmX0ZhLPAiwsq/S9CFgIRC9e+GUua3tcsEWuc5+hy1CO2cb2AaFoJEwj1Q6batN+LaUC5
 XGl7x/YiR791VSNsZWczvQAv0OThQn9DNQKgIDQCNPOG1EJh7oYLdOhTxe+HTJjTCoOwMzMZfav
 LbY9K10ANvxMNT+Ikfw==
X-Proofpoint-ORIG-GUID: ac3HzqFPgRvRDIhr0mLdS4GfMV7mtPqg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfXzoSGQZ5PjoPd
 R2FXRdy8WdS5A/S1DhZ46dq1x1QtyRnIpmTt+iOvO9ISSlVH735By89xeUs0BkcfmEj4L0+ZHJ1
 9id1v1PJjj1Ok/7lEPdfY5q/i4zm1I4=
X-Proofpoint-GUID: XPFDH4gJfw8P4hHUVBEmE12m3dgKgKio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240128

skip() ignores do_read()'s return value and unconditionally
subtracts the requested chunk size from 'size' on every iteration.
This was previously bounded by size being 'int': a maliciously
large 64-bit value was truncated on assignment, capping the loop
early by accident.

Now that size is size_t, a crafted file supplying a very large
size causes skip() to keep requesting BUFSIZ-sized reads and
subtracting BUFSIZ from size regardless of whether do_read()
actually succeeds, spinning indefinitely even after EOF or a read
error.

Check do_read()'s return value and break out of the loop on
failure or EOF, so forward progress is only counted when a read
actually succeeds.

Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
---
 tools/perf/util/trace-event-read.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 147a3b95ce06..529a56c3730f 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -71,12 +71,16 @@ static ssize_t do_read(void *data, size_t size)
 static void skip(size_t size)
 {
 	char buf[BUFSIZ];
-	size_t r;
+	ssize_t ret;
 
 	while (size) {
-		r = size > BUFSIZ ? BUFSIZ : size;
-		do_read(buf, r);
-		size -= r;
+		size_t len = size > BUFSIZ ? BUFSIZ : size;
+
+		ret = do_read(buf, len);
+		if (ret <= 0)
+			break;
+
+		size -= ret;
 	}
 }
 
-- 
2.47.3


