Return-Path: <linuxppc-dev+bounces-22101-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9645DCD6E74
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 05:54:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWrGX6f68z3bpG;
	Fri, 05 Jun 2026 15:53:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780638836;
	cv=none; b=Ht8TClLb53JEVI/NEvseXbC/5PfXKDZVO/wDniuiXtUX2SrYRf35s2oEa1ZrDoA9McLc08yVC76xlAXx2am9TiK89XN+qxTNH30V/J51O0xcYLxi9Twf9IG8nYHpXGQ5u3M+O05GVKPR98UP498XiMxlMtPnvTxejuphHpExCrkqx7G9n0nKRV4c2fi4mQB3LRTn9ItbyXbVVNZqPwlAvSRqEHoqIYcLHrXf4FwpTGocIo6B2SrsAwgWtwxFPCBcPN45BP6cVVUS1Pazrf4k39U7OPocriZlDZtN6sQzdeUqLq5IiCY9YwUQTZ1xVK+2JGrCrObYeHSMJPpM0O6eWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780638836; c=relaxed/relaxed;
	bh=5WYeihtnTlnwJ9cQHQuVHkmlBKA+jjJTS/mt1/MIHQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4wnMEnBwQNag0lSpbo002P7nyWpRYHhxIHzMOOYkXC9V7wRcZD+6FfC4uS/yugJkg3ko+BFoK6CRugGMte9BhLfUeRvMN7L1v6FDPiP0+EoouAL0cL5n3K+P5TtxuEa7pnU+KLe16BjpQ4GH+KjmyNPo1IsI/XgtgScUEwla4Cp/pwMY1qIQRrNMusbED4tr7ntMbbmbj7+VQGMJRf+IdcHLI8ujVRxpEsnLQanLG/UXTkXMgTYe6m9CxpWA+CXJCZN5r2qSKxaGrUvQx2KBWz0kT8qUEZgbFWL6pkv3o3uVE5r8ec2WnRnXsXYHXRovMLHep/CRi7diEsA3I5EPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KIf4jjBQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KIf4jjBQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWrGX13rHz3btY;
	Fri, 05 Jun 2026 15:53:55 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654LdXg8867987;
	Fri, 5 Jun 2026 05:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5WYeihtnTlnwJ9cQH
	QuVHkmlBKA+jjJTS/mt1/MIHQY=; b=KIf4jjBQ+huIEluhZ0ifmSpAYwZMNYw4i
	j22O4ejqhUlbqfFxK4MAFEhDzB92Zkc1SC1Fh5xNXIheGXnQC+hNfmk4RPaqSUEi
	tRqVsAKnl/i3RQbJwWhxo0jzIDQuVtGRFXSC59rpaLBCqZTDWWzKdt1kMi8Zy/ZR
	J5umaZmkflk4zQtC3jkq5FZQjXHbVNBh9YS9kDUu3xi/34kdfLMrLIcG7r81neu2
	5hEvEKUNh2iN4UaznJAKwT+/9sIN1eQWQq7FaLWreHWSZC0Pxg8xvtvGUEnb+Kmj
	F96gkxPyUeA1D7tO9l+rhp90PL/vcCktKRkJ09sbPYzkPAyRhRXFg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqk13e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 05:53:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6555d7WW022140;
	Fri, 5 Jun 2026 05:53:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw8ewh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 05:53:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6555rdYB26608106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 05:53:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25D3720043;
	Fri,  5 Jun 2026 05:53:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEDB320040;
	Fri,  5 Jun 2026 05:53:36 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.123.90.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 05:53:36 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
        chleroy@kernel.org, Srikar Dronamraju <srikar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] powerpc/numa: Simplify find_primary_domain_index
Date: Fri,  5 Jun 2026 11:22:44 +0530
Message-ID: <20260605055242.1757485-6-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605055242.1757485-5-srikar@linux.ibm.com>
References: <20260605055242.1757485-5-srikar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: vNyUUngd-qmQvpkYtOehehRBaqag5qfp
X-Proofpoint-GUID: ZmdDbsnRPPh9sjizOCXILvH11C4QCxVZ
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a226468 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=PUaLgzmSHm3KdX723h0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA1MSBTYWx0ZWRfXy0JUwPIDzm9h
 0MZMA2RcSONSWnntqerdw5FwxRNK2rPgMXWRgbP7LHWdnEXBJhJarLbtNiHSCC4DWS1GoFoFi4e
 lcz54W0OLLXqwfZjJlLrDf+MASHUeq6My5ydpjfh8I2sqwOox4va6qlIXFZqHlEWoPetvebIVsc
 WtMw6j4htq+orYiSn/nGql+ONjCktimQXbTDj8hA1Kx0zpndN91oKCkt9bd3UnwqjY137KN016d
 qGXcY1+XDT4DNdFHk4BCnEmu+mtZf67HrNzjdyChrNPAG/7c+9pLD0I+LmcrmK19RqrPMK6l7lb
 FCGhRP9+tz/gl5ZgBq+Zfv6NJ0FNfH6bb2U3YXPsixpwJ5f7ClykNGnC5GJs9WTd8LDl/rw5NaV
 8S4kY/lpq1/1vO/iFnDrKHfu7tM0lM4I0qHIV1QO1mevYbhRiB3J/Ot8mnlis6rvevLWoOBsA3f
 K18FYmh3f1JiekZFUCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050051

Initialize the return value once and use a single exit path in
find_primary_domain_index().

This is a small cleanup that keeps the existing behavior unchanged while
making the control flow easier to follow.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
Changelog from v1:
- Handle comments from Christophe Leroy

 arch/powerpc/mm/numa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f4cf3ae036de..c44a80d8fc11 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -432,7 +432,7 @@ static void __init initialize_form2_numa_distance_lookup_table(void)
 
 static int __init find_primary_domain_index(void)
 {
-	int index;
+	int index = -1;
 	struct device_node *root;
 
 	/*
@@ -502,12 +502,9 @@ static int __init find_primary_domain_index(void)
 		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
 	}
 
-	of_node_put(root);
-	return index;
-
 err:
 	of_node_put(root);
-	return -1;
+	return index;
 }
 
 static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
-- 
2.43.0


