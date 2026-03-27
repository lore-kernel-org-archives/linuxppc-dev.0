Return-Path: <linuxppc-dev+bounces-18904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1030B10BA432
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 07:17:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhsRQ1dLJz3bgw;
	Fri, 27 Mar 2026 18:17:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774595858;
	cv=none; b=azEB54Iy9rb6n8yQxi6oE/tPi47nV9F38IIHQm2n84a4YBMzvRdnO9w2ttxQjDXCL+POLy+sYbVGufMFLQ69ndA9b4ctj8PxcfEFWP+viEYODB9mYlzkz1JcWJzsdL7Argio2SNLAabE4ylcaG6wK0Zdc79GUuNwCpA0Y9MiRbJ1ejifPQGWBjAakRepKzHn5lVuQvyMDNvMRzOilIQPklcqJTtQtixecZbdLCtgq5ArqxZKiFbX7vqdsEUmCZmxdbXyogPCxOylfzJJfB6wlArrfjmyBbyMrnDcT0T+6eokqV6Iqwm5YZPxxtRTfhfHRXRckTUC3JQJV739aCcWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774595858; c=relaxed/relaxed;
	bh=3nsIkBM1wG/MkAMYmdbck8ds+Cs5SpVHNbEVNKZh0hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os18OSfhr6XX6aj2L1hL91gHzCIGRvNsNqI62DKBFBEb6GNH1fagD1XLKmVkirsXcD7mGdjFAOhIGaSz4oH7fzEept9fIuoIoHLJR+8i6MwtU2GVqzK74u8G74ph+20i64sSgEZy0Jwh5KTIwDfgtzLukgYJAZKshnehZ9ViTAtTo5lpUTrEYUMCSABMDvNtkOO/9gUbYwG2+hVv/ouvfKHmQpkkl3oYFxgkWZSb3GgB3RHlJfb/hRv6KanfnrFxFSHXW9pdeLO7fADXxnPbibeMBZHWNrJT8G9WRZNu6I5LZl6xUkT4+C61HHlJjtfywR4PcnjsmWGqI3uhxUCeYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U01kl0Hn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U01kl0Hn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhsRP1xX1z3f4M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 18:17:36 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFxoxW755965;
	Fri, 27 Mar 2026 07:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3nsIkBM1wG/MkAMYm
	dbck8ds+Cs5SpVHNbEVNKZh0hg=; b=U01kl0HnbWbWEn3cLzZHZ+gl5ReyZgHoc
	Gf6Kv7otufWMVDcKB0Uv6sc8wPbEviH823VCUUbsD9zpzYgM6bSisgglr534uf9a
	qrS8NKAl18PKWRsqDApfgxveil2LO6ODYy0Kk7t0dR0IfOW41E37LBM1RWEQ+nnl
	1r5qF4AfHvT/+iFQGhWFOifT8khAam0b88Z0MZO0k0C9kmBqtAjUtr3bqbYULfK/
	Azk0qDQ3l04MBVpjnBWLjhARp/vNdeOhOrLzHcpBfpZL77Alt2FnOQfq+O4IfmLI
	ifcIveyu9HztyEzIPOqzm38yIOQc5pLmZ+CUVLpCvhUU1FPKhWQ8Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty8x9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62R68v5w005976;
	Fri, 27 Mar 2026 07:17:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yxkwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 07:17:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62R7HIq248628078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 07:17:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A563520065;
	Fri, 27 Mar 2026 07:17:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E08FF20043;
	Fri, 27 Mar 2026 07:17:14 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.208.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 07:17:14 +0000 (GMT)
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
Subject: [PATCH v3 01/13] selftests/mm: restore default nr_hugepages value during cleanup in charge_reserved_hugetlb.sh
Date: Fri, 27 Mar 2026 12:45:55 +0530
Message-ID: <2ba0f8d8a00fd049e8ed4b97e9ce8ee6b58a2892.1774591179.git.sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c62f04 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sNPh1B-_HOrnTu1bGgIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA1MyBTYWx0ZWRfX5VJrdN7KDwEf
 x4LlXgWb3g2ro7KXdy8Aa74PP144Vn/m2ts6CcSt/0YWvfbO/BgJeb/lOU7AHM2zu+4fm2QO9ij
 zTQdnZLiLIg5Rfxt1a3BPHuuARV1fR1qvK7Jv7eyjLk40Ii//30IPCK04rv0YzncsIDfKmzo19Y
 5/HTVRImMymJ4jVRJuD/6gcZgX4pvNW8RlHFCC8He1e1q4wwv689EyNBGYJpGBIc5WRUOB2TPf/
 BOyPNBfn9ajcGaModU1d4t6HNRuzu2ItTXjy5GEPltVkbRwZkk7+Rzm9i3K+1FdaSoRR2U0o8gX
 kYbhKJinImAKDDIctAF8ujt8arbg8qC1Bvk35bmds775roKQ6foRiWUhGl6m03ZWG7Ha+gD0+WY
 /r+JeaptpJfBqom2DaN5uCt2yAt3u/ZB42+E/nNWZ5lTS1mHCq+Q895ayCAHsuR9wOywyqlDc3V
 aMgpwaBoYgZdR+agzyA==
X-Proofpoint-GUID: uG984jRJZLhBh8Uf2gfHgtD0VraFWQ2w
X-Proofpoint-ORIG-GUID: FPePvQfa7CAXk7r1VaI15sYSOzHNYwOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270053

During cleanup, the value of /proc/sys/vm/nr_hugepages is currently being
set to 0.  At the end of the test, if all tests pass, the original
nr_hugepages value is restored.  However, if any test fails, it remains
set to 0.
With this patch, we ensure that the original nr_hugepages value is
restored during cleanup, regardless of whether the test passes or fails.

Fixes: 7d695b1c3695b ("selftests/mm: save and restore nr_hugepages value")
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index 447769657634..c9fe68b6fcf9 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -65,7 +65,7 @@ function cleanup() {
   if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
     rmdir $cgroup_path/hugetlb_cgroup_test2
   fi
-  echo 0 >/proc/sys/vm/nr_hugepages
+  echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
   echo CLEANUP DONE
 }
 
-- 
2.52.0


