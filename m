Return-Path: <linuxppc-dev+bounces-21282-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B0CCD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 06:49:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLfBx6V3Xz3bp1;
	Thu, 21 May 2026 16:48:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779346137;
	cv=none; b=LQ4HLWrGF01mtsamsitfun0Sf1Bq8g7kbGOUuw86haJY+jTmd9pAFfLCAcURJdKnrc2WiLmbdchGTGLSOoqLDz8RsXK3KSZAOU2uXzqoPhxjK2Ee6+kdhLYKvD04pDk4FvGctJDv7cqUTf7lnWCGcaGI6wJKuWb1lb4e+lDX0FoFXSuraPovuaXtgqAI6xokJ3UmxNP/WYJlpdFOpJwJy3th5HRx2M5nwptZM3E3CFl+q5YPVQmtfPvgQ1QAYizt5/o2FmI8+aaSDOCr/8jwB0+J33FLGD2xaGbr8xbA73qFrFKKLOgWzjpeZVTLahfiabmS/+9VBOZ0ajg7VlQreA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779346137; c=relaxed/relaxed;
	bh=Nq5DzWgRtL4E1DjO2dFfdwfaryhi9dLpfVcJI5A/LOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFtY/l2gw2nHdso6fuGOOQaLJ84e//9GwqWKC77kJxR3aekExNgm8AckUgSHh+oBwWwUVCdo71swqMYFRQpUjeYTgwkXJdrpW4zogH7wW9pODnVVNL9dJnmZiyTwaSTE8AlsR5Z3LxCPr4T0Md/c2CATQFG3LXkQ2ch6FTCxVE1QH7xTnTNz3fwIMZ5HxqGNPvF9ZcwDMyrryt9Ry1TnNTwx2CjYjdwkbD6kfwCKOMkCZEYY4ET3JZDmd3yBfyEph9CIvHHOUESqP8m4Ts/CGUuMc1tLbx4Ysgk8f1JX8RRh3IGnusLLiFfMcAZgaTS2FP0Cp84SyBBmnwaLdCTnXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WyHTV82z; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WyHTV82z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLfBx187Tz3bnx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:48:56 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KIvSiV2082630;
	Thu, 21 May 2026 06:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Nq5DzWgRtL4E1DjO2
	dFfdwfaryhi9dLpfVcJI5A/LOU=; b=WyHTV82z1KFFn4BB8fy5BaybULEjJQZZ1
	wrf4oGmjLxBsjRBXCifazLl+LnLdbVX6ZLKMyYUjgjgNuNN+PnZLAgoaqU7Z7k/n
	qgmAYiIov68p62Ysgd7keNQwPYPyZFWYXg2sBtWyE4D01VGgHoNCaH8xLE9m5CEZ
	D4RXvKyKzgSyw1xM46a5bTmml5+Nf7yrGn6fXCvJ2rvFd/O2M1WDLEaZYqlDBs3g
	Zn663AYQfT+/mhCSeVYta3eUBzVS2+QoHPxOGdooKrCU/BJr2g81t4annnXEBNI6
	VB5WO/mC8uR3G3m9sUfjGmZoi0bi4TXYzsgX+416ZyFiEm+1dblqw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88mcey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L6dHiD009806;
	Thu, 21 May 2026 06:48:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhtrr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 06:48:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L6mZKB24248794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 06:48:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3F392004B;
	Thu, 21 May 2026 06:48:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A23D920040;
	Thu, 21 May 2026 06:48:32 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 06:48:32 +0000 (GMT)
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
Subject: [PATCH v7 13/13] selftests/mm: clarify alternate unmapping in compaction_test
Date: Thu, 21 May 2026 12:17:53 +0530
Message-ID: <da5e0a8d5152e54152c0d2f456aac2fac35af291.1779296493.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779296493.git.sayalip@linux.ibm.com>
References: <cover.1779296493.git.sayalip@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 1pF53W5BIdKYW_lxTRZ2eoamRBw1P_PD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2MiBTYWx0ZWRfX06tcHDJDJrMG
 YTFU4A6E26qTAclF1E1qDWHIUoF9KXE8DEwb/pMYeYuOeVyLcCLybY1x5fGVUCSim145a1mlZD8
 GfjwxHYaqL2E4zu6APXvFl4rvBOA4ziF4hAXjNex9HYZzny/0JqUC1PI96EWVlUyuKLm31amdnI
 MLDCNdnJjFQHS0LKK48qb2Dd68yCdxjC+F4RQKg0JSs8vmfAv4i8vu8tAjmIQSKfFVEKgZt/eLp
 dBsWKBBBd9hmQJWBqYYvbLFiIIFWI+sIwZ446xwW4jiiBje7q3NqOsvfCRDAjbjZ8Nsn3EUT+v9
 WweWPONzdSF+DHLTri2ON7OuR2cTZM2OYVnLtvEAheoLqsxAGp93I3rwBgT/CwEjjEEEuEHL4eW
 C/NbNTJmy0naTFHV6RSZI0FYgik0rTGbFyzXyKpTWjNMbPZ3oL21U0f1bdxNmbr9FGAoZkH1xEw
 35JkQVNyzF1ljtxr0CA==
X-Proofpoint-GUID: ypZ8jMGmHbV48Chdn4zcz8L_7sFw0qly
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0eaac8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=THlBPJCoSQ4NST9nLWYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210062

Add a comment explaining that every other entry in the list is
unmapped to intentionally create fragmentation with
locked pages before invoking check_compaction().

Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 tools/testing/selftests/mm/compaction_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index de0633f9a7e5..5b582588e015 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -181,6 +181,9 @@ int main(int argc, char **argv)
 		mem_fragmentable_MB -= MAP_SIZE_MB;
 	}
 
+	/* Unmap every other entry in the list to create fragmentation with
+	 * locked pages before invoking check_compaction().
+	 */
 	for (entry = list; entry != NULL; entry = entry->next) {
 		munmap(entry->map, MAP_SIZE);
 		if (!entry->next)
-- 
2.52.0


