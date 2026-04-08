Return-Path: <linuxppc-dev+bounces-19463-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF4CFD5F61
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:29:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr96w6jNFz2yv2;
	Wed, 08 Apr 2026 14:28:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622520;
	cv=none; b=R5ZPNn4NjxSF3gQske7fE7orabRF9OPsZpu3CL5BlI3z+kDzsw9sBUkhSeN3wbuDHUSAQerwxz7xV40lliY+oJhlO/MAShSkNMsllWbyKzIQrxKt0himYAMMD3oFCGW0H2y6p+NHiVNDY1qCEf1JVB9n6ZDSmTKku86UP/AFb+yQT6Qdj+fT//pjk48pMcDQ/oyJ9QdO+uoMFWfvmB8DyC/QH3+k1cgLWqOF+qVQFvBq44b/E3fanOSud+iE743V7mmcgEtLU/NpYnXYTqnri8t1nyhbBfvQn+FPaInVNAhEGE0qOImeUIcnrq2Gvp+qYZ6IK339NNZXcpz3u11SDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622520; c=relaxed/relaxed;
	bh=+CV0lW2AmnaLlnMxsfoHkIfx/7WrIrl4keHbuZG+0CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfN93J/MV7MimjiulaUWU5PKj0woZ8+dPiKvJmoAHc5Q1xrgFdTe1Ver9H3T6wk7fRMFg+64WC9alRWhuYfMO8Mzd9RG9wNpfqAtjMeI4u4kQufvYb8bBlC0rgORRD/nC7/HHfpn9Dr7kIL/mnDtP5ntWZyE993YAdTl09dkz3NCcPNMpY9GCPXxMta+uRMtlcLDHt+S2ZDHWsKYxoFkZk+LUR7kZ25mBx7TwTkzVklA2aa/27tuUi1oh4JYZ735Y/r1tZV9hChYT/6FoRxl5qrXqvXLS2M+5HJGWzYE6F4ORjJAVLOfUqhGValmo9aDSE1DvBo/iqz8W4GVjbFWGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GC2+4dkA; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GC2+4dkA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr96w2g8Tz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:39 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637E3EZp2302533;
	Wed, 8 Apr 2026 04:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+CV0lW
	2AmnaLlnMxsfoHkIfx/7WrIrl4keHbuZG+0CQ=; b=GC2+4dkA2G+K7iMHLKRxt/
	Mk7CQbe0dNnk2ZdaYf/7QH38t0d46UETDLihc9EzadwN1SyfmKh4iDDEk6xRslN0
	CYFkRWuk2KVgal/akNY/Sm5dTN+46QkcezHChXQ4cGNoXVCYkCK8hewFyWC2phJW
	TRtw0ZU1/KZ0v0ACuqSeu5B1L39iOWtkVeyPKfs/JYRgoB/UdknGc9tqBAIvBQ5h
	r1kc82FiOX+ge+WQ3ufxW8/9gD/WC0++y6gPwlzLrEJqTUlrBza1pZmWwttNLL0W
	9YFYi0hE03av2HjVNnXHgDqGH3tdbaJyIkK/srfRivjTQaAWCPVzXtm5VEuMBRWw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fe778-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63804dGg014352;
	Wed, 8 Apr 2026 04:28:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4nyff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SQds7537122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0283620040;
	Wed,  8 Apr 2026 04:28:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B79262004B;
	Wed,  8 Apr 2026 04:28:24 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:24 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/futex: Use masked user access
Date: Wed,  8 Apr 2026 09:58:23 +0530
Message-ID: <177562236432.1381144.5377221388647272030.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e29f6a5c14e5938df68d94bfac6b2f762fb922aa.1773136636.git.chleroy@kernel.org>
References: <e29f6a5c14e5938df68d94bfac6b2f762fb922aa.1773136636.git.chleroy@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX+rhm8VrC+mBU
 ZlEd9E5Q4jEpoZPFkXyCY+bTFTkc3blze8Pl+1HPxppPGbxIYZmblENrx7zYMJCTUoXJMknQ0Au
 qF1bbeu2XhQTDpomINQLmW66HnANS4fWlZtLLnYRBUtHaEnpxFc1MsledvW91pREOXr8H+S6G7F
 6d8erbnZd0IDfpZ2V/MUGXb6nfpbPPg9w4H9VkC17gbeh+dQ4wsrA8eFMH3lOapI+rAAWWWyDqV
 JnqCrz1PpF3TAjXRYfFHQwj5TKXf5l2PP2O8Q4/vskh8WNsIjBOL4ZVG1Uc4Udsg3dSr9oAOcwQ
 XletNmCO0yA/nwMDO7mpiIDfcPrtPo5zIR8Pn8NnOGuWnJVHhvH3M3TypQN+Btf/cEHp/voMg7H
 49AfTLGnsaYwcQePyaG24ZMtoMPBaQkPUfo8pZp6C/IUhiRwno0+SrTCjpVK4T75uxPaPVgiiDc
 18pVKsSoMloFAN/67PA==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d5d96d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=Xnn0j8UZnTOuyrh_SIYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: VYazaeEUOPtm6YwyjNg8TZJqO-YsNWE5
X-Proofpoint-GUID: LHn1s5b3YvZTah4DwMKOlLzmKGHaRh8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 10 Mar 2026 10:59:58 +0100, Christophe Leroy (CS GROUP) wrote:
> Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
> provides optimised user access by avoiding the cost of access_ok().
> 
> Use masked user access in arch_futex_atomic_op_inuser()
> 
> 

Applied to powerpc/next.

[1/1] powerpc/futex: Use masked user access
      https://git.kernel.org/powerpc/c/40a1b9d044c7dbbc2976f0432e32dc57d4896b00

cheers

