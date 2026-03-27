Return-Path: <linuxppc-dev+bounces-18912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370CD10BA431
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 07:18:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhsS11ZSDz3fK1;
	Fri, 27 Mar 2026 18:18:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774595889;
	cv=none; b=N3ugzcQ4SMW0rKAm0CrDDQFb1x7KfL4ltWWLTCzf/54ttQUWYzGZyJ45/QIOj0bA4DUlBg/+6slt3XAP3eFapHqyX/NWkYXvMbP4NdnMM8QZKHTLy/qWCqA6cDqATI9Tn0D9+iYSoALcocXuhEqV0DiVctoQuDmLGMQLJjNBPsJOmVRwtszjqFG0TioY7/zonMdcYQP+HBRvW1ZXLEZgISfkducceCSmH+OHoQaRterFzM37Nz6krSWFVAry4mhjoJl689fBYIbI7c+2UDeRN44IWgUUfEmXR+521xJESLd1UZcuCJA/PVoOnZoi1U0hq+ijK+wpa3DyPLBUDV2XHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774595889; c=relaxed/relaxed;
	bh=5xKgzXiNSjPsI3xL6CBUcueD9iNfMUrfEZZj3ej3r5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqTJXX2mqW+rlP5xDwZsT0R1lEnmaQtf0Wcr27v80LSQQvEx2VEgJugJNYuoqGI674sf9LirL91Q2adFbBvWmAkHw7+5W9BP1S72RkDbvjpiasDvVIZVJrpDv+jSumUr1zvMdLY1IsAFLqdbn6D7RDFYTrHhbsLbM8m3QBbrZjAKCIEvf/NF2OPhZSKxsDQr8+kYQik3cegPCDBmofvHwSmm7FtzXQKYj5sHLHdYQ2/UQypAB8e1a3z4GFBLpgxVJ++fLToxgAe9WHuwVs6lpaGabUF7PjtKKUXLhrUK/zQsIrNH/OUuqNO+AcufeBctvopoYp3jEMoMcvKXJl7+EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LiEclG8f; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LiEclG8f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhsS037cfz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 18:18:08 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QIGcsp2477909;
	Fri, 27 Mar 2026 07:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5xKgzXiNSjPsI3xL6
	CBUcueD9iNfMUrfEZZj3ej3r5o=; b=LiEclG8frPoXgeGENPcHnZcNAecW6VR0o
	eoeDqXILKxcu6T4iDDqS1zR/nYHDgUgVEAZvTwKfDJXZexoebD8SC4zULAAmM4Pr
	rj3o/+geNP0lExV7+A1nJWRFvi4KAqX7yJTYlNxIVcunkp0xX4YcTaZONiaSVe0k
	5NEpsH2zLEy3OcL0cSKZnDeTB3KRSxMNflzosAfugMwN7YxCLiePMFOcWWwQh9XG
	AB0xJxpSFk5cGIyozVT7cszuJ3VKFxijWeuf9VzhQAhB9uO9RQ6YwdzwMv8duDkE
	LbCFJ2Ji5k9CqAEVp3AP0DyM+9sF5T53GZu6Ezd8TjDFUxGEUUEeA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumywhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R6YJ43026695;
	Fri, 27 Mar 2026 07:17:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m6dpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R7HrAT48890352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 07:17:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C93342004F;
	Fri, 27 Mar 2026 07:17:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A96520040;
	Fri, 27 Mar 2026 07:17:50 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.208.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 07:17:49 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>, Oscar Salvador <osalvador@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com,
        linuxppc-dev@lists.ozlabs.org, Sayali Patil <sayalip@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3 10/13] selftests/mm: skip uffd-stress test when nr_pages_per_cpu is zero
Date: Fri, 27 Mar 2026 12:46:04 +0530
Message-ID: <0a4106d7c594c5bb471a48ca37348883e204d295.1774591179.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774591179.git.sayalip@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: frLCNW1iVTSq9AaZCHJVFXBO5zcD0Dc-
X-Proofpoint-ORIG-GUID: MYRXE58sXUGpmeOMyvvjqTyXBDqY2Bzw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA1MyBTYWx0ZWRfX495l3EIu1lud
 ScaXI4PF3+Kv4YIo47PIOEjZjsSpTggeXXdCG6FWOzul3f/CVHld7wY4jwdkuM6gAJwoRYo526J
 eAyYF/xJctANrBsbxTiT8yMrvQA+mPTPx4gVKsKmhF2ESM8cIz7l4e00QceSWqx/ayRruicNJWm
 dibmHfV390a6yhay1ILqVljkYO8JELQ7FzUoiG7uH/4kSHxfw/sU+F3ImlT1lr3N5Zr637FqDM5
 09boSfNJ85wZyTCJjhHm3wl9nJE8nYvRnblkNPIXQuQASd24otUYXIebBJtqOzfKgfVRZXdzfP0
 VwFf4MhfFhAUXPTAR+gbZs6e4vHgCOpjxk2rXFklY9dqyCOrUyFstDslBZeoXEwjrJdnI9FkAhA
 Dnn3egtK6rh31R8WCFBkidRutv4ElcxN+dAmRI/dyZWVt+bVbuQoXH3NmhvVLH19eK9HVsXNPql
 KbnS5z6bi0jX4exD3Kw==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c62f27 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=-JjagEEUfC1zOw73BwIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270053

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


