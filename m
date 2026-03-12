Return-Path: <linuxppc-dev+bounces-18107-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C99C105A594
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:27:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWn141Nq6z3cG3;
	Thu, 12 Mar 2026 23:26:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773318408;
	cv=none; b=kVBQw0wvz0i2hJwIpBFQ3rTKHUa8ieCG1dsmOk8uiEWh/HSyt+OZBspyKiT6mglFlsfAtTivJiiZFr+FL9Q3r+B6FlkMWb9BDDOHxdhj+OI92g8ec9QWFaEYrWbK4jWksQngBH3HwrDAP7QFWa2ZKG2oUKZPLVTrdH9b0t+kG9MUpb+NSVJu2Cn10q9Yaabdk6FNCaP1Iq/JpaaJR9LLPmOH+y/NdqoCkmI/ZBV7h2xl1LI6CHrqONRQRyPeV5+KOQmMsW+ZDfLhTdKv0xMz/CjSSb1dm/pVOL/vYvsABfcqinYMCr6I29FfG1TuWMCQQilr5IqCHspQcS3PF7mF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773318408; c=relaxed/relaxed;
	bh=cP5DnIGqX+IWoGTaswpG4DKOIk5RWcGIq4sPAjVal+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OftEmnP3ayh3+SCHiZEqB75OWuYgKdQ6i4ZZcazgQLty0X04c/5B6HEx/lghxGxiB6nakKrWq6/KJi2TMEcH1cNuD35nwgHdBTFF4642RuYts5JH1zF+Hb0aW6WN+EnFLU22DDk+O1NiGeOswa7OxVonddKcfC0yfVXJuK7r/DyaRK7VRJ91Xktzw5zrC+ZdafOT5hziID9TPE1sdlkZmZMaIZPjy/8ONIHVhzI4RmX902vdkGChzkWOKSsEuX2+OM+LUQeGt2x6WJ9EYkcrfinDC+6b/GedOFeaLT1TP7O0Q09VeJMOMPhJrbKnrPiTZO3XeKvbwjsYC196qe3SxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fYPClEaA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fYPClEaA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWn132QZdz3cSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 23:26:47 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMW4mA2205603;
	Thu, 12 Mar 2026 12:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cP5DnIGqX+IWoGTas
	wpG4DKOIk5RWcGIq4sPAjVal+4=; b=fYPClEaAW4o2h6rfEXazjLNd86rTc5AX2
	aC1dJdL0MuhctKpu87NoPvN3kOW3BKvhGkCbMhqdbLoLEColKwey8VawvbWIe2lq
	0Tfiy49BBPodhAprbps/C7EbNGbKhCri/01UfZUvyg0tNYDr12YXNrJp6Sof0NWe
	cbEJXlVI1cnmVjHNA5ejEzMC81BjqdBcz6BphPdk8YMh5kTmn79hJO5t8pvR4qg/
	9Yxp8IUewd50vsF/7vX6v+YGxnOrcmWgb5dCUEqwFogb4P4xvZIsq4kEjW/zJOmC
	PXbxQedPL4hU18MVbx9X8uJn0+pwjnzqLY6GplBoJ2B4NwJ7+WxdQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98ag6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9WLLa025750;
	Thu, 12 Mar 2026 12:26:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8a92p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 12:26:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CCQZ1032309628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 12:26:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BC3D2004F;
	Thu, 12 Mar 2026 12:26:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4644820043;
	Thu, 12 Mar 2026 12:26:32 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.in.ibm.com (unknown [9.109.243.201])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 12:26:32 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: [PATCH v2 10/13] selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero
Date: Thu, 12 Mar 2026 17:55:37 +0530
Message-ID: <2516cad1d9dcbe613619a1006aed1991302c9bee.1773305678.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773305677.git.sayalip@linux.ibm.com>
References: <cover.1773305677.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b2b0fe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=007535ZYCZBjDdtOErIA:9
X-Proofpoint-GUID: EODHtCal7aKmrKKS_qj29Bs5gVqcXyH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5NSBTYWx0ZWRfX4hf0OjoomiiW
 A1eCfyOP+cepbPP01EOz8bRny0BaRaXlFez13ztLBJi8q0I2pxMliNygXfxUqRe6aFzDVd9X1Ux
 NQOJK8oI+oYDH6GWpVAHSLarzKraiYmNPm298T7KmWldQGHgf/PloCXbbyo+AfjNyFzDPm1k6MO
 DQC5qCzC6wOa/w7DY0L+WDXe3rg2//z6bEuGfyC/D9xotBjar2LzZiXK0gRdJtYaZCJcXKhsIKR
 PNOSiLy7pmhkCdbD7w1H7YRhoi05q6PlPUjCqqVyOtocc3fjiIaaBDeGHUlyKoZFzmKotxKPAYa
 eBhN9vWoO/a8QeL8lvZ5RULmIiDHVZC6wnxBrem2rSBaOZdaFjGxIkLdzS+17J5o1UrdjL57G+s
 OY9xk1s/gGT4H4CK2Mm26VtYhZNmdChqBCztdUUvoIyYZHOq1BBVhnYzE1t5SXerS7NirouUAvu
 rgEVTbVRixrXCctZ9oQ==
X-Proofpoint-ORIG-GUID: 1txIhhYvwZehc3zeAahpyWjBUMEm9eRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120095

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


