Return-Path: <linuxppc-dev+bounces-25467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A84C55ABA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 04:17:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFvBb1Gdmz308H;
	Thu, 06 Aug 2026 14:17:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785989847;
	cv=none; b=bsLJqQzvfy/ECT+j+Rq2rqYST1llVKqlxKS2HxoQH0nhDR5ScqTwBm1vSLsFMdCzUZrdrQDjIRoh+DiNdHYL3dCYsvEduBe7q1iwmqckR9j76vWV3sJX+vby533sJP6Zq81sSkG3pvhLpUa/M6RI5iBJThNl5o6fxGGq4O+FAxGqK5cBmvWq2NqKv1ZuF06nmpQhSIfNrYWTiTxqI7SJ7UKfhqTLaqBQhjum7n3beX0eEIyFuGRqDqg1wndeAYAdN+YEIKfQ0BGrcGbKkqnviaAErefJHQwQoaUyO5dQD4GcYZpUbCRFBEtbW7RFzftUPwMbtQRaXokJMAjTBUOCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785989847; c=relaxed/relaxed;
	bh=pnDWuQot9w7qHDC5fg7gIqoA4Q7Q7kLQPKMomndjnPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/nI7UB1I/OjDSYs/qUiIJBeSZFEv/Zmh/D/goJ037A2kHq7p5qp2kJprpWJDiLhrW7frDEzDU6FMRz0EVDfLjLRZv9lcKHTlHErnOSfufrH4xB9iPCnII25RSzhrLAnGZXJ0FdPygsN+jcqakmzSLp17gpejBCIUTJ3WBJEhdjQ/kBss7+X+K8NoZrJrHzYDw2+B35HofeMEI3jFh1Yb6MiTqmZa8z2Ox1grd5ZEiUU2/KsBd4b4XYQ/Ljf/CyaxVWkH1K1EKJiz9oqaIK9Zl2MUeB+35uNImqC8PQ1zHL1krRA2EDwY6hu4uBmbfFWZuYWAaDDPBZUd1xsHX0dIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ok1OPevg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ok1OPevg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFvBZ2yn3z2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 14:17:26 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nn0kM3405507;
	Thu, 6 Aug 2026 04:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pnDWuQ
	ot9w7qHDC5fg7gIqoA4Q7Q7kLQPKMomndjnPA=; b=Ok1OPevg6efRYyIQhWiQDf
	ZemGPdZ+Q2CwloibB+9hU3uLX6O5fdNfw1VDsMSeWJ3qzTNoGUf+/YT6oSMgl27K
	UnvwqqnnHzobdx5Awy/so8KNi8ujjCu25Hwx5mcWS0RxXl+bJf4IS1nPbMJaUk+a
	EuuuEowprPxGqMi9ywgxzwR1cTK0pDTsyx22qkiTbmWToJzsfMu+SQlIfZHb5aJa
	ciDxrkR4p07XMibBccSPY9ErLrugZjDW0HW75fcR/jCp2LWQ4GzH+IFJe2uXKvO2
	srKCW1tQ5eYOWotaBNHgNkxd+sDf/UAncHztBVxYYYOntrmJBvQ5BeZiexswyr4A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqx6x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6764BJex006525;
	Thu, 6 Aug 2026 04:16:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qsq6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6764GMIM29819454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 04:16:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47E6220043;
	Thu,  6 Aug 2026 04:16:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DEF020040;
	Thu,  6 Aug 2026 04:16:17 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 04:16:17 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        namcao@linutronix.de, peterz@infradead.org, sshegde@linux.ibm.com,
        kees@kernel.org, lgs201920130244@gmail.com, srikar@linux.ibm.com,
        ynorov@nvidia.com, nilay@linux.ibm.com, clg@kaod.org,
        benh@kernel.crashing.org, miltonm@bga.com, mkchauras@gmail.com,
        akpm@linux-foundation.org, Gou Hao <gouhao@uniontech.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gouhaojake@163.com, kernel@uniontech.com
Subject: Re: [PATCH v3 0/5] powerpc/xive: remove __GFP_NOFAIL and fix IPI error handling
Date: Thu,  6 Aug 2026 09:46:16 +0530
Message-ID: <178598971864.942627.7914448330996687839.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727104215.184786-1-gouhao@uniontech.com>
References: <20260727104215.184786-1-gouhao@uniontech.com>
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
X-Proofpoint-GUID: MgqZz9TJ2Uo-wwLko0TlEEQ8Cdq9D7Ea
X-Proofpoint-ORIG-GUID: BdrvJ4o-JJ-InWCxYARNEtr8rTQwT-Cu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX+YSYs7ieGT1a
 hyGRhtV2MxALuzqGrGXLGrPnQ+gEjdLe/OuvsqAuHU088xrpW8+/Rprnh5A+qjRzKB+RBWf6grn
 VdtCbfYKMyZEdqZCFfZKS9NtPa1MvZk=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a740a9b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=FJgj3P23nZfueXLWCA8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX1pMJNDmRK18N
 EEB31yY+E6LSsuMISJLzcnH5UKnV5EcBTe72cOWDOJReoU5vAej0M8RtTzdzX9OGAgqeZhcsHHc
 v3K5FrCcIU31prwyJwpOEaLQ+qkE0hJS1FML1KsGaD8CEnIzWzfSk9bJpViLzjOxn89wXzGYslH
 E6hh6uB9+6vpz6Dy7mBDoqZhgw/n++0LmskNKFZu8Wjf8TpyAlQ+OAChrTbyykNNF/QvzMSNtfw
 O2Oz0RNLkuj1MZd9lDrHYpf1WvPU42+NcLRSTW0Ywr+adaxoBVlaM0c0HgQmANBU67bQ2+nbU00
 e3ASTc9eGnLSLzVrHQT62JNASvtLZGkqFH7GAJe0CbHvZcgHeraes0cl4gi8trHi0NbMG2cZJ1U
 9302oIT5yZxNWnEC5LL0X0PuuN/iaXE3tyFV7i+y1kJfZTKy6viH/adw5qR+r6l3imU7xiZotB+
 W2nq1GrF6gR6awPJQhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060025

On Mon, 27 Jul 2026 18:42:10 +0800, Gou Hao wrote:
> Changes in v3:
> - Split into a separate xive-only series; the drm, test_hmm
>   and cxgb4 patches are unchanged since v1 and will no longer be updated here.
> - Rework the first patch: instead of simply removing the unreachable
>   NULL check, remove __GFP_NOFAIL from the IPI allocation and make
>   all xive_ipis access paths NULL-safe (suggested by Andrew Morton [1]
>   and Cédric Le Goater).
> - Add a patch to defer setting cause_ipi until IPI init succeeds,
>   so that smp_muxed_ipi_message_pass() does not call into a
>   half-initialized IPI path.
> - Add a defensive NULL guard for cause_ipi in
>   smp_muxed_ipi_message_pass() as a safety net.
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc/xive: make xive IPI allocation NULL-safe
      https://git.kernel.org/powerpc/c/f068fca7e8b7014014296b0e458ba9c5aa77f954
[2/5] powerpc/xive: add error return value to xive_smp_probe()
      https://git.kernel.org/powerpc/c/ab5ae5dceb86614f6c9e7488f91b652000edfdc5
[3/5] powerpc/xive: propagate IPI init errors to prevent use-after-free
      https://git.kernel.org/powerpc/c/411a3c016e7a95f5fa105a0587e07d0647a77727
[4/5] powerpc/xive: defer setting cause_ipi until IPI init succeeds
      https://git.kernel.org/powerpc/c/37d401c9c4b89c3c193726e177493ef06c657f40
[5/5] powerpc/smp: add NULL guard for cause_ipi in smp_muxed_ipi_message_pass
      https://git.kernel.org/powerpc/c/5aabc192702defb8950e7c81b05c3f4ca8ee43ec

cheers

