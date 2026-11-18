Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170EA606A32F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=blVx0OLM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTkv90kcjz30RN;
	Wed, 18 Nov 2026 12:45:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794966325;
	cv=none; b=C7X23PnXrjL1o3YTt6/B7hI+zhsqDSAWHOW24bYfp0CejobGqdI40Poqwz9wGvnH7DhIqC+nDWlTK4zVjPr1Rfeh7p1EMNhpH4nmmgMHRDwRfejRie9eWwSIdFJKuo7DQ4rImGi5/MjYGXp0Onyoh1FY4jpagVlClXU7nLG4dMqg4tJlvpmfhZbpjEqCs2hf9zK1ENThPLQ2Xt8Kp7CJYsX8LTeKNczgO9rhNYPO6jO/oicOR3fDC1HUzay1zt19tvfyoy9FYzZcnM8+rbf8VMjq1gG5Az5/fdSyytGZcI9pRHI9HRwDSm6m6YPa9cnkJMzvrEF3dDKRrKJqyzd6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794966325; c=relaxed/relaxed;
	bh=i4nI/nGsHLuUOISqApXbnSjEK9RP0wL9VOS2XfAFigs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIlxSqpFE8ZBDQ90SoIE3rNThrl7PY0xMuiC4U+zzCW8zxbSfeJR/k2QzlCndmZ80R1vibmSY1MZek9vWkcxKzGYfVSzBb5wpnScrQ3xHQYdQU3/j+I4CNkCmC/9+WiXBSKWrN1Zn7k02k+wfzSAi+MRsZKTyzZvIB/kX8/93C1Echd0IshT64L7d95X3EeK+9tQz+ZRArSjJzmctnvFxUhnImQC/YF9KelivRiT5xlpoQG+OD7LXfnL+X+cuB3D468Y5SFfEkKn9fn9PhYU9r8Jj/DaS2KDPWfDFxtA0k8y3a1mERPJfeZeWBMXL5A17kaWM7hvl+rQk8dxi64fhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=blVx0OLM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=blVx0OLM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTkv82bFxz30Qv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 12:45:24 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMuaAS3803166;
	Wed, 18 Nov 2026 01:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i4nI/n
	GsHLuUOISqApXbnSjEK9RP0wL9VOS2XfAFigs=; b=blVx0OLMITYuO/04Az1SzJ
	f02cq3vKEvHkh+sLbM8QA/2ggCB4dvKn0kKqN++vAR3ABrOOalgogGttWvy4FUMV
	82A5i3bndsDpEzNHKnHTWQbHnFLpSwpEpgvtP1QuqqV2f5orJltEj86Pks2hL5C+
	+MgJklQUOrQjdoPEY2oI/cLvmKkY6aUOZGtsV1icfR6+kRZYgj0rTHni8R5wuQ6o
	UVvsdKAYq9XlisiE9P5/AKwgrRp+Tdf1XJWua3CWkxbVf0pLNyIN7KngBKLPJ0ga
	cb8KpHZY1+4rrpZl28kD+NqAU4ujyOJT0ibStazhbXT1D87jlURuxeb68t5HdbPA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n8d6d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMo1LD1188989;
	Wed, 18 Nov 2026 01:45:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dffbqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1jCKD52298044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:45:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2686620040;
	Wed, 18 Nov 2026 01:45:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE0F20049;
	Wed, 18 Nov 2026 01:45:09 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:45:08 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Kees Cook <kees@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/smp: Handle of_property_count_u32_elems() error in parse_thread_groups()
Date: Wed, 18 Nov 2026 07:15:07 +0530
Message-ID: <179496619901.633156.4190112511467693829.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org>
References: <20261109-powerpc-smp-handle-count-err-v1-1-e777fde7f71a@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX3MHuoGPksoT1
 hMVq2rgftNp55qiYOSX2IQIHr8+iARHkvlu/+FfC2CkJm/2rIIuOkU+lLPtJy3NAecZ+9d1stcr
 X5Q1udKFsGExKWugOcbq/eR5cRR0JT5LAfrmyQlQERc87a1JVc0ZPtu9ZZWmZOr8S82iaRl1016
 eTvSqG0FHBhdtYaGjJ3gV0iCBjww9w7nPfrCSEO9MOlSoYmUozkvPHn05CvNQ9yePn/XBD2szwo
 uUPaBcAuLl0fX3TmoKQnhUgZosJQ0j1MaXGLVqbOeXNsY0GhIDz3T6WZZ7GE0dtkskjx8UQ+9gF
 mG3vFB/Urkig8WbKzKjagWYA0C++vK6AD3qn0QpZIPFgs+jk1YzuHL6a54zXjIpkQYYc4EEkKGf
 FA65tpBIr4p9TsGJgbqYgGHs8n3nN/25ESj50+Ubvvn8MLWFC6zm2SvM4HzyV1CsOhF5GJd08mX
 mEfjAJkcGFf38JnS+pg==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd032b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=2nG9PUl6fz9NDV3o59UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O3ttnmlwKcPAh0qzKgiPNiAPOWp-Brn9
X-Proofpoint-ORIG-GUID: AEQXc6J2EO7azwpfepseI5ct_KHCa8SG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX8tIkY6xBfkYt
 g71YpGmAh7FsGQOYdgjRgn/T/3aiSRwBwhwaWxZsyC+e0alPouWQVxT1hEJ4j+r0Stc9fSTcN+X
 I9Frkad6637PNqEJ9ew+EO5OID9ctQ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180005
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 13:00:12 -0500, Nathan Chancellor wrote:
> After commit 0af298e62e5c ("treewide: refresh kmalloc_obj()
> conversions"), there is a warning on boot for several PowerPC
> configurations in QEMU:
> 
>   WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x174/0x1b0, CPU#0: swapper/0/1
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.4.0-rc1-00262-g0af298e62e5c #1 PREEMPT(lazy)
>   NIP [c0000000006074e4] ___kmalloc_large_node+0x174/0x1b0
>   LR [c00000000060782c] __kmalloc_large_node_noprof+0x3c/0x150
>   Call Trace:
>   ...
>   [c00000000369fb60] [c000000000614ff0] __kmalloc_noprof+0x490/0x690
>   [c00000000369fbe0] [c000000000051308] _kzalloc_noprof.constprop.0+0x1c/0x74
>   [c00000000369fc00] [c00000000200b450] init_thread_group_cache_map+0xc0/0x2c4
>   ...
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/smp: Handle of_property_count_u32_elems() error in parse_thread_groups()
      https://git.kernel.org/powerpc/c/126b47221b7b98d83c118781ce724c0515d86d9c

cheers

