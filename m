Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04937606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dss6POhi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGHmc41zYz30Vm;
	Fri, 30 Oct 2026 21:45:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793357104;
	cv=none; b=AEZ494DUxCf6wl23lKTIjFULwjSexUmrujMyLeTw4kWWu519JA+agAxmlxbfMhw3TqzJl0zTDHIZyXC5GOmvlRYjDgmIQ6OiE+eByzGy1hv49aRWL90qqGrfXWP5L6wfavdQALQFpEglmoZ4rgePP6M8BMJJe6El6D4wHjJUdXZvQQ3Ki6A7Ie7XTMXbSc9vQo7FgwtrN/EV5r9AdnAQGPbxtBdpaxPmMV+/0/SN6oYx0esZKF5tCzQXrnD5AaygKSYiazlXdUptfycJwQ/jWpzc82goIUL5F9FDIUNsqoh+Rn7AFX7HMDQNrhdVk1Cv1CZVnpj1jF659IgScoDmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793357104; c=relaxed/relaxed;
	bh=+c1ihJ1Xln4zEcrREqgDAfDTBrnVULNOnFAexlBeung=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj3LSz4XT2SKPCu2ukSbihfF39l1mzYRJAv0EEMwG4zWDzYM0e7ZFbDknQM9Klp8vdljapweNRo5n8TiCREAva8mVIHW+ZKIctfZUrogiIhXIs1E3tRgkS9t/jshNyQwTOOm7h9w1yNPKxo+mgcQiuYSqvz9wzqk1tRa1q5zVdWGO6fWZolTyo/mEADAAuhI3HhnN3ezCVT1tSIyMBzw6RGb3CaXmf7VQApBepLXK8SpuI3qcG+0blsTWmuOHbGtZshupNSmOw3qnCnh5V2opInCXYja7+UofDw+KlkkVptjL/TlmNrwq+1xd1tS0mVN9uyh1Aal5HkbluagGByT1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dss6POhi; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=pavrampu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dss6POhi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=pavrampu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGHmZ59ZMz30Vd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 21:45:02 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8ET8p2376743;
	Fri, 30 Oct 2026 10:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+c1ihJ
	1Xln4zEcrREqgDAfDTBrnVULNOnFAexlBeung=; b=dss6POhisLc8cfJCKTifeh
	e+zeaNYuHH/S+VNxv02rsfOpAAnPd4o3EXWVOgIGXK9wUtudQiLRLunlWU3HQbEF
	S+RaUFDI4QzfXTaudAzQsGpG3ulq9R05Lr8IiUi53XbtCC5IhlRkLd02Jj3UHjEf
	4BqxYQLvkunC4NMK6BIf1xCGsuPlWAxHVvfNCoeq3IP9B8Dmu/h2XQgk+MADFPuJ
	SX4qeCc3Gn40ncO7VNprWTsvmwMinfoZaD0Fdjb+T6w4q+QwsicEEUW9BDNaVvkf
	OJwxYVInsMUKK8S2FTdTdK29t27jsAs5n/zYE/1G643+3AszcO47WJxIxHRkWXVw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeay29j6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 10:44:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8Jvbq238919;
	Fri, 30 Oct 2026 10:44:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e47b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 10:44:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69UAiJoN44892546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 10:44:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0651320040;
	Fri, 30 Oct 2026 10:44:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4028220043;
	Fri, 30 Oct 2026 10:44:13 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown [9.43.39.23])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Oct 2026 10:44:13 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: songmuchun@bytedance.com
Cc: akpm@linux-foundation.org, chleroy@kernel.org, corbet@lwn.net,
        david@kernel.org, lance.yang@linux.dev, liam@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, ljs@kernel.org,
        maddy@linux.ibm.com, mhocko@suse.com, mpe@ellerman.id.au,
        muchun.song@linux.dev, npiggin@gmail.com, osalvador@suse.de,
        qi.zheng@linux.dev, rdunlap@infradead.org, ritesh.list@gmail.com,
        rppt@kernel.org, skhan@linuxfoundation.org, sshegde@linux.ibm.com,
        surenb@google.com, pavrampu@linux.ibm.com, vbabka@kernel.org
Subject: Re: [PATCH 0/4] mm: Enforce read-only shared vmemmap tail mappings
Date: Fri, 30 Oct 2026 16:14:10 +0530
Message-ID: <20261030104410.417740-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019090830.1917657-1-songmuchun@bytedance.com>
References: <20261019090830.1917657-1-songmuchun@bytedance.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Cq-D5FMcULtYQJqPtFBU-Ss_evhba_3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MiBTYWx0ZWRfXyG+fs1ghDdeu
 MufdeAtSObpnKs0XjFFcDX2NqGMGt7MHQXUNybXyz53Fpx5amXAtuMm34jTk75sa+4qr1stjkxL
 W4mTEW2Wg+tKYnjBZPaniDSxElpoM6rAiJnRlo+5BEcOeBlWQmiSqtSkWZg/0RqOhdewZE5nCHS
 7F4GF6CU7dxnmGk6bXQZHzXUjhtxmPB8nhEizRkNqNRacXRUjHfBtpcS3vHNNqhbNQdbb2k6SyP
 4iWd5KSjzbKBagjm3VDXKfdYWa6BxZ71PxnqFHfPoO3orZam21OnNKnNL1mznBWbHnLEZR5yiAF
 nDT181Dq8h0ROzEuGXqsq3AAvYUh50njhXSMNxxLZu3pfolJkFLeftBVau3zEFP28NqImjRMB5V
 GyfgLl3sU7eiZvH4nBoBbVhnvQrP9SSBSXEWVfNTwXvjlfqm88/iv3UwT9mdRlxXt22gSpz+Htf
 OPlw6g22K/JelFWbJxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MiBTYWx0ZWRfX5dC/lVTICYYG
 PJrbr8wpoREtd2C2ydh3d2GuaJgASQ9dZh5g7ZaHXI4cuQzosbh6FtReDhmycaMxMNbqAdhNIgz
 Meh5Gf3IkxQBnIaTiPevwSoYHYeShng=
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ae47508 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=Uv9NjG45AAAA:20 a=VnNF1IyMAAAA:8
 a=8zS9G5xvJLahJeJr1kgA:9 a=zgiPjhLxNE0A:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 8kHx2nZ45Fplgz9D0Wt0xILKkBxGZrzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300042
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested on Power10 (ppc64le)

Test configurations validated:
  Page sizes : 4K, 64K, 2MB hugepage, 1GB hugepage

Test suites run:
  - libhugetlbfs test suite
  - LTP hugetlb tests
  - mm selftests (tools/testing/selftests/mm)
  - ndctl test suite via avocado (--map=mem and --map=dev,
    2MB and 1GB alignment)
    https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/memory/ndctl.py
  - HTX mdt.pmem_all
  - Memory savings validation with 1GB alignment
  - Hash mode basic pmem tests

No issues observed. Thanks for the patches.

Tested-by: Pavithra Prakash <pavrampu@linux.ibm.com>

