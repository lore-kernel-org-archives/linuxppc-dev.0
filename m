Return-Path: <linuxppc-dev+bounces-19739-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC01ED7B84
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 08:24:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvy375X1Fz30dt;
	Tue, 14 Apr 2026 18:23:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776155011;
	cv=none; b=cNrhTEyTs4QMg5b8nzOTALHYEcdRHVDqSHa1sd/U75O01E7BM7Ur77SGBZPpJldn97tI026+ftmWtPC6hHe0od5msXJjXOMY533OeX0sWxC7l0n/yQJ9waCopR35YBXSre8JCR4EAD+XwrgLgqlgR9WQcGl/3WfnDY53AqXqxZT2OFfG+6zGczuqREplpxJTg5dbPypFkphtszl389wXRu1zHv/yTtLsfs2gUM/c5ZcIocCxs6uz7vZ8P0J+UA9FrkEmzwWnzT1Nbl16zqpFutX7t1G1yF1jXW6SFeI++FigO1xIdLTb8mu/1Rp8pMdIWCDE1XEJUoMc3TUbHIBpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776155011; c=relaxed/relaxed;
	bh=91SGkots8hY8yhefJjvScb8bSKAk7Ka9vIM3IAFA2DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGw0zziVQWdtnS6IjsmcqmEVNRkjF6U1O1RbwuyXiOLVozElAZyLaME8GO4TGAUpXWapE2z7XpJJ8mV/gDCeg8w/Ff/DSGiP8P7StPJE8vow6gdqiASNc0Yxt2RV+7ah9eyyM6pb61EPuowe9CUeSStzCbRON2FUU+kAG5sWEOzn9VfckrLXRSk3QrHgDV8DGrP41KwPoAhNU3S5n+FSXXFkn9Dalx7pUehaedDdytRsbkNEkYsrZMW6rM/GQtlZ730bQKrjp59q5wtSyY2OCYog5i2PYCQUaab65+STjoDJimsHMwElFFzTaw0FL6uAYbVcXLeDQfLseRHsg7xjdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SPOq9MBR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SPOq9MBR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvy36759zz2yvN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 18:23:30 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLIEOT1733620;
	Tue, 14 Apr 2026 08:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=91SGkots8hY8yhefJ
	jvScb8bSKAk7Ka9vIM3IAFA2DQ=; b=SPOq9MBRrtseY+PPq/lZQIZTZ6w7NlbUH
	+wscxIsYOfaxHdUbzW+V56nL24HofMt/3X8668FVSTD+v/dCIgeptJ40Iboqc3A5
	fw8HzQxcRUUxXeSNtaQe+hrq2GN7UwscEOjVe8Z5qROXFFb+T0Jjcl+O6FmdaXtb
	n5DRFNRMAcoPwDQ8Jw1WEEb3ZbPRpDKaskYTI0gCuBUqZp0+t8bzNT1JFC4l+smX
	li1XV2ZtKCAv9XN/tJhsfkRBAHFAbxnxBmJ4atHpSU1ZwMncIQdPmbKfShx8pY+g
	TDMFHa/TtxKh1wPJdaa2uhPGAU+qNhxWH4W1zCT158NXdsazJEZzg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m1pq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:23:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E4brAi003568;
	Tue, 14 Apr 2026 08:23:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn8m9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 08:23:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63E8ND2q43975104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 08:23:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E0822004D;
	Tue, 14 Apr 2026 08:23:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 044AD20043;
	Tue, 14 Apr 2026 08:23:09 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.26.223])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 08:23:08 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Miaohe Lin <linmiaohe@huawei.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH v5 12/14] selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero
Date: Tue, 14 Apr 2026 13:52:06 +0530
Message-ID: <395d3477a67919780887afcfd15e49bfe3816060.1776150071.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776150071.git.sayalip@linux.ibm.com>
References: <cover.1776150071.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69ddf976 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QLFraA1qSxkZgXf6QZAA:9
X-Proofpoint-GUID: K10mC2YQ1iqrMdW55jWm6W66Yak07L-O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3NyBTYWx0ZWRfX2fNpRd1TUIPe
 7wta+e6LTGyKs5lgjomH7GQY5o6CU8GnGofm64xce8MfEXjW9QVFyKC3jWlYYuiAX5iHeY1oDfH
 6up+vSZwrFTqhWu3EztD1iqbvjv8w9udP8cw1NkW0SgWIh5SeVJ9OXo4cDx6Ke3qji5mMF7hDPi
 CymIBl8osbPlB/GUnAvX+n9g8jhL9mCArv+p2fxH/MyFgVymh3uuUFSJInretMQ1QFOvpF04UNX
 NDeOBQd+uwrreGh69AIIk40RW0UXnQx52mzwD6qq5ibdU502bwjKIdw209HDh1B+E5AqHSBU1GX
 UbgpwRkcwPsCUqiYDF+zneXe1nkfbcNVbeI0Jt3CA721E/styibVlZjg/UHiSexUAa1/iUulIGv
 /w1ig7CmBMn1CDXmer5WwzKHEIPZ1invI/o2V/bRkKUEs3YuQe2cGtks+eRkKxQX+ZvtufzVIBX
 iTK6bV3XbG6hVp+5kCg==
X-Proofpoint-ORIG-GUID: LSo4tFsccqouHiMR0_Jb0aKF-uiVCRfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140077

uffd-stress currently fails when the computed nr_pages_per_cpu
evaluates to zero:

nr_pages_per_cpu = bytes / page_size / nr_parallel

This can occur on systems with large hugepage sizes (e.g. 1GB) and a
high number of CPUs, where the total allocated memory is sufficient
overall but not enough to provide at least one page per cpu.

In such cases, the failure is due to insufficient test resources
rather than incorrect kernel behaviour. Update the test
to treat this condition as a test skip instead of reporting an error.

Fixes: db0f1c138f18 ("selftests/mm: print some details when uffd-stress gets bad params")
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 700fbaa18d44..b8f22ea859a6 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -491,9 +491,9 @@ int main(int argc, char **argv)
 
 	gopts->nr_pages_per_cpu = bytes / gopts->page_size / gopts->nr_parallel;
 	if (!gopts->nr_pages_per_cpu) {
-		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
-			bytes, gopts->page_size, gopts->nr_parallel);
-		usage();
+		ksft_print_msg("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)\n",
+			       bytes, gopts->page_size, gopts->nr_parallel);
+		return KSFT_SKIP;
 	}
 
 	bounces = atoi(argv[3]);
-- 
2.52.0


