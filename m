Return-Path: <linuxppc-dev+bounces-20669-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBF2CD37B7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 02:29:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDNvd5vYsz2y8p;
	Mon, 11 May 2026 12:29:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778466541;
	cv=none; b=Bu3x2TH6PQG2NUH/X5VGTKIyC+hInIBq+o2YSa2/sfcVaGb/RvzLCQHld8EyKRG8DpBkXmry4ABlqd1ePtoCDjmqPceK26GfyJ+9UiK+nHkZoAK/joYeOQNKq9B7xGzFN0UD/EhpqCB5WFMMUBSqeD/QwC3l6Kyy7Nw/KH7CmxmA/QHnHPiAFiREvlHNxL2O/ndmq/8ARNshHF36A13x+K6h42T9OdcjlCX2g8V/3rzq8PZ/yLRkQ2Pr5er16BkOZARwQNzOov6gaI/f8HPv1FMnav4hblxEd1PQoE/pEXrVsaKDdV6f5eefycYHu6dwRTK5OEtel88ApgP9p+1v+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778466541; c=relaxed/relaxed;
	bh=QR3XJzd9zH2M7WfBOr4QVC8IOlKI6qLpSkjaSrdEKVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k04hJW7hMSasbHujCVvCsL5ecErrZn06B3QfDZyweUu6paCBvjS3GDolxdg3fmzRMuatDJwCZRYN1OH5uQxpHOkv3I/p3ua5GDO9zLYWE5hcxVf98vBzgnlvc1qmANQvcsmI3ZUXUtvl9jBq6j+8G+vdf0Dg8VebhwiCkKm1RFXkWjH84bwQ7dXPcW3YAfgs1PHRUar4jLlhkxxV4o+CGJdt9JwoquYnEdLtT5qZ0Zlzm8Cenx4hfR5I/rqMcCrjYJMyNvuiamWTQ9h4WDtaF8bIiYv7od1Sj0ZkppcLfR2BjqCQxciPwomyUzdGL6Bi7Jm3/FTsaRC1S4ymCtOSkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NQfBN3Ex; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NQfBN3Ex;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDNvc664Mz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 12:29:00 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64A9g14f2604219;
	Mon, 11 May 2026 02:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QR3XJz
	d9zH2M7WfBOr4QVC8IOlKI6qLpSkjaSrdEKVE=; b=NQfBN3Ex8nuqxN2XZsg0mN
	z5iASeeqR1H0JEi/YLgoJpXWnUdErCaCieR0nXkBNe4QyKTCD/uADQkpoSJKxlik
	Zj7KL9kIaZMvznZPdarxjFude5XZFuW7vv/qdcT/YO3LQp82YVKHItxpdbqgJP4W
	iQOx3KKQQOm0Ne+4VI2Yd5VwVtsQ8dokuui0+dbSELMDwTA50kze8JyMlTdkrSRE
	CgxwXDcYAxqBtsqfEr+TMoFlt7euSIK3CVUdbW/m0ethtpjIaZfxTOdQ33Kg6pWy
	SwTb5ykfaZyAbHcXn2L84dZrB8T2hp9KNfCsJu5zd1JvPzxpKsUpB7/4MPxqFuXw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju5rrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:28:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2OWDr012703;
	Mon, 11 May 2026 02:28:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q3h7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:28:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2Sq1g48169456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 02:28:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11AFF20043;
	Mon, 11 May 2026 02:28:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 429E220040;
	Mon, 11 May 2026 02:28:50 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:28:50 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] pseries/papr-hvpipe: Fix deadlock, races and misc cleanups
Date: Mon, 11 May 2026 07:58:49 +0530
Message-ID: <177846637460.1289230.17888555993005220499.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a013ee8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=UbnoUuVJNVHop5aAMTIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S-szk4u596Nl2iYkbQtTAW-3yo3DQ6oP
X-Proofpoint-ORIG-GUID: YRkqPCjMZ2uv3WkgGJKm8Iir9Yhd9iU4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfXxV40EVake/86
 8UMYy2dgF0aJznUKSCiIdh0aAm40WL+/Bp4sjauqj2jZaYU+k7/e0aq1wK5FSN0L+11FE+9Dlpy
 gkcb0VoAkEsiq68/ZOOmCtIZLBkqldmhOWOvVP8RgbAEz0QFIDuS//mHz/L2bzbIKFiVC12yQ3V
 HtPVspii7hafF9EeWZgzDhpon5qCQ9oV5QJqaKLgk2FW3yJPMGsdWZrOJMdGKUVmvwSXM4kh4HE
 342wiGLjvV0kSM7eo1rZafeiLUhSy9o/Mv+BG2kTIj9+05tC/33G6+VMQIvVr6NUMme5xDzJGEC
 MWdMJq9tBlks5Cs+ggQ8CWx1YyX9ObTJQgZ22893uXz0FfvJg22MkrzwmN3Qcv50Gnwrz40+dHk
 sP28m2PekLgtdaoibvB+TYWaSKb2GRkkDVxJbnVXId9nHLa/wo+qzy4pxqgyUy0aSNC9tL8Tyj8
 C/CJycyp2slPN2GBCUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110022

On Fri, 01 May 2026 09:41:39 +0530, Ritesh Harjani (IBM) wrote:
> While going over papr-hvpipe code, there were a few fixes which were identified.
> This patch series is an attempt to fix those along with some misc cleanups.
> Me and Haren are trying to get these patches verified on a real HW. The tests
> are not straight forward and we are waiting for the results.
> Will update on the test results once we hear back from the internal test team.
> 
> v2->v3:
> ======
> 1. Rearranged the patches in such a way that it is easier to backport the fixes
>    if required.
> 2. Clubbed patch-8 and patch-10 (of v2) since they both were changing the same function.
> 3. Handled ret>=0 case in copy_to_user patch, when the user itself may request
>    for 0 effective bytes (after the HDR_LEN).
> 
> [...]

Applied to powerpc/fixes.

[1/9] pseries/papr-hvpipe: Fix race with interrupt handler
      https://git.kernel.org/powerpc/c/7a4f0846ee6cc8cf44ae0046ed42e3259d1dd45b
[2/9] pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
      https://git.kernel.org/powerpc/c/cefeed44296261173a806bef988b26bc565da4be
[3/9] pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle()
      https://git.kernel.org/powerpc/c/1b9f7aafa44f5ce852c00509104d10fd9eb0f402
[4/9] pseries/papr-hvpipe: Fix & simplify error handling in papr_hvpipe_init()
      https://git.kernel.org/powerpc/c/713e468cdbc2277db6ce949c32c1acbd83501733
[5/9] pseries/papr-hvpipe: Fix the usage of copy_to_user()
      https://git.kernel.org/powerpc/c/d48654bd8b1a75f662e224d257db54de475120dc
[6/9] pseries/papr-hvpipe: Simplify spin unlock usage in papr_hvpipe_handle_release()
      https://git.kernel.org/powerpc/c/2eeac577480848801b35885b3a8201aa35f46236
[7/9] pseries/papr-hvpipe: Kill task_struct pointer from struct hvpipe_source_info
      https://git.kernel.org/powerpc/c/4e2d83c80495a9327141e8636f25dde13155f14f
[8/9] pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
      https://git.kernel.org/powerpc/c/fe53d2ae82c06aa2d6402624af01e8f8ddfcd5b3
[9/9] pseries/papr-hvpipe: Fix style and checkpatch issues in enable_hvpipe_IRQ()
      https://git.kernel.org/powerpc/c/629d1a901de57490d29a495273df11e64993ec04

cheers

