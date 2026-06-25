Return-Path: <linuxppc-dev+bounces-22976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B855CDB479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 12:41:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmJML2vTfz2xwH;
	Thu, 25 Jun 2026 22:41:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782391278;
	cv=none; b=S09OuQYCpYd9IsxTRLtODwK4Yxag0DuJ/B8nJ9qCIf8CeaQPLcoW31hGqgZ3bgt4vhLKe8iErrnuxWGNZUnrUjmSxGXFXCsYpuVdjplq4kh5MVmy/V9BKiWRl8VQUPbQEe0AVe0+TRwCCa+S98gm4sxaW3atkOouKiEjFC1Z0QloRUrYDfG4zYSIroZy1bYKCn9/u5Le6pCDLyHIICqZLuxXV9oum2je5XZmG11n+SL4iS+VVQGV6PlYvK+va+whEHD4JmxAr4Fk41vwqWv4sAaEiXaL0jAe5zPZ/JZfQkAMBngYLYGzBS8FpJmyBtrnJK3o2CSyXbVtpp44plZ/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782391278; c=relaxed/relaxed;
	bh=/FIcy5VYAad+2tZYzaneZS90/1op071eXRZTRdPJDdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6fLRFPePw6OOdU1EYgHBtKIwp4qxiiFvCopuQ8ZCvIP1wWURKwEWXd0XzU1FNtBnitnG+tQ2mZ0hyimAu93jCdRmaPdH/S4jlaJw+NpzZsT4lo+c4+QDGlRQni9m6m93CEZOd75T0tmkRRjj0y+ArRGpDkfsVpbU5QzYBqnmk68djfDbK82A9gefoVDUBIe6fCcFQ9dsNgn3Ta+7lq7qnQ7uA2SLCm8VTnE/8Sd1ugZJJt7pYl4zV9CdWbTzH2V8RJ6VH2LeQ1zc3nEaURcPm9VZl7IKjk2cS7or8hY6GGpyJ6wgJXjOMsk32Rbgt/wZLpmp1STwk0tga57uIphzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aN2OkwrG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aN2OkwrG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmJMK22wTz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 22:41:16 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3n2Fo2890175;
	Thu, 25 Jun 2026 12:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/FIcy5VYAad+2tZYzaneZS90/1op071eXRZTRdPJD
	dc=; b=aN2OkwrGpBVNXntWIYCMfe2M4t8Q/kZv2943OxYC0D14S9TejoPEQn5EF
	Zmu0qwIceLDq5j11z1mfoyDj1Aix8wonJAdMMbZ1srdehQIVvKt2DevrL2DNJdVL
	Tv0LujdhhXdQ0uW07R/ebnYdBwlDHwp2Yu9rVpOoANSsyAIssD5X3BOFV//qFRac
	OBky/IUJfh8S3iRkiEQTY8cQnp8BX778wGQe2cQ/f5hl76nCRsG+NXn6pTid/t3/
	TT/xqd/dai8rCSGe8aZtHzuM29bgtE6dYePy3U/UyHkawavBmdiSzGFMYE4+wDp/
	yK3wu5TVN+fk6rrpOOOocAQ+YdQhQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgt1bgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 12:40:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PCYeif013544;
	Thu, 25 Jun 2026 12:40:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwp8p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 12:40:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PCetiN49807862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 12:40:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26F9420043;
	Thu, 25 Jun 2026 12:40:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42BD020040;
	Thu, 25 Jun 2026 12:40:51 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.39.21.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 12:40:51 +0000 (GMT)
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
Subject: [PATCH 0/2] selftests/mm: avoid false failures in hugetlb and KSM tests
Date: Thu, 25 Jun 2026 18:10:15 +0530
Message-ID: <cover.1782365671.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEwNiBTYWx0ZWRfX+pzfsgCI9YfC
 rqm84zEZZGm9qXuQY06LMuBL6O6Wg2WuEDAXX2WS5q6/UGjbzldMT/iIu/Q6+UT/Ttsrl3uu11F
 JKZ9DabKLi5AYneABAPok1XLFrUW41D1xtR9WIUoB/E3RMGcItRo3R0y2oY+i1IUD66nYCT4Y/A
 mmJAbLKjktDaqZqvpza4/iekgvH3RskKxeaQoGM3iXt3CzZ1TU9UxDphixG6XrekOGoLybjDXvo
 kZ+Twiwtd9HhzTUZvxeDXQWqFPPvxTzgGG7rhOshYB8J7WnDf5zknrRi9VwiPG0e+zZJEk01r5l
 LGflhkiVEu2HlZLi2wlSQmbIc/1K0uzUhrjhLgtdP+riWHQS3EjofRB1NEXGT4PaRsNSJs2DzLL
 8/6NJR4Ery0FL2cZ7zxKPbgsaTWXaiG/nPEF953KywThxOgNy2VEjSAfPpZmWsArPzvJ4kYiXVW
 TK3/fZ42WpqJMKgO/kQ==
X-Proofpoint-GUID: wvXnOcw3yMUp1B6tzhXcaLeWOiadoVVq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEwNiBTYWx0ZWRfX5WTv3XNCjeaX
 XWbm5MNpKHuDvG/Osihk8fpDtuOHgfjHbGB1d9NRUciwmJNDjKuYBDDk9c7lo/6UdcOk5W7Cf+S
 Z0HOr4EJV4gTnnP/yPdhXRY0RbBqaa0=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3d21dc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=-j2Td5Va5la4C7oUbE8A:9
X-Proofpoint-ORIG-GUID: axG6r6divsSaBiTKZElGReQERRgE4s27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250106

Hi all,

This series fixes issues in the hugetlb and KSM MM selftest categories
that can report failures when the prerequisites for the tests are not
satisfied.

Patch 1 updates the hugetlb selftest helpers to handle -EINVAL when
attempting to configure gigantic HugeTLB pages via nr_hugepages. 
PowerPC hash MMU pSeries systems expose gigantic hugepage sizes 
but do not allow runtime allocation of such pages,
causing the sysfs write to fail. Handle this case gracefully and
continue running the test instead of aborting.

Patch 2 fixes the KSM NUMA merge test on systems with memoryless NUMA
nodes. The test currently relies on the number of configured NUMA nodes
and may attempt allocations on nodes that have no memory, resulting in
spurious failures. Count only NUMA nodes that contain memory and skip
the test when fewer than two such nodes are available.

These changes improve handling of unsupported test configurations and
unmet test prerequisites, avoiding spurious failures.

Thanks,
Sayali

Sayali Patil (2):
  selftests/mm: handle EINVAL when configuring gigantic hugepages
  selftests/mm: fix ksm NUMA merge test for systems with memoryless NUMA
    nodes

 tools/testing/selftests/mm/ksm_tests.c | 26 ++++++++++++++++++--------
 tools/testing/selftests/mm/vm_util.c   |  7 +++++++
 2 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.52.0


