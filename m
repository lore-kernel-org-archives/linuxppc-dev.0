Return-Path: <linuxppc-dev+bounces-28504-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E478CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 15:32:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvMc04s4Qz30W9;
	Wed, 30 Sep 2026 01:32:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790695920;
	cv=none; b=MCGSrm1/UVAg6Xx1aNwwKJd026K3fhfXBhHtzU7eAmYVjEgbNdq5BRNuM43pqSY04OnbFo24Z5KnuuuL/iaStNjVyxIgKnB7XgHrqw2wYVSv/q60o7SiiE8yttF93DUG8iKdO17q86rZHhE9ahsVe75rvk7S5hOyFuD1wbIOL9RiX7W5/8/ENdxVYj19mkQ30EyZ3fygYfOu9RyYFgHx5TUphTNxF1C/9nrMbll5DCoEGAPhmjoqYEK+gE7Sgm1u2g71lxmyhJwbwD/4LkiKYgo3HDWkse2ugoUnx6YF/dFm1fVWlX3XcnqtzviIS4elLYRmKpwedL1IO0F9rEqigg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790695920; c=relaxed/relaxed;
	bh=hRcwiEsVxLpMpM8Cas9aJOlJb6BNKB59c4rzI10SOak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpcLy1q/TJqBitSM7s98JWQZhfrG+1JVSouslSY7dtF/rQRDMAi6yK1CX3aqUzFjCmDcl3V+E6sKvaFWSugKbwP2K7w+yA47begliTBxCZmbd/mT8EnkRu3R3UVJ9Gj9p7sRI1t0gEehMmqwmGwXggiODsSUBYnaruvmcExL2nwOqiBv+T1RGG7jdSsLnbZaoK41h2LdzuiUw7UxnMPrlImaC9T+cLrm0hMXMCVFr08dSpM/CfthFNGZyG+Mv/fK4FbVADoKh5z9EsoUoCyMv95bU7uMAbMxV707VIjunRFosQO3qpK8o9SSc6WywPNf0BhnQogePLHV79x114EgYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LoqJgTO5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LoqJgTO5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvMbz2Fp8z30PJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 01:31:59 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5n1Q4018055;
	Tue, 29 Sep 2026 11:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hRcwiE
	sVxLpMpM8Cas9aJOlJb6BNKB59c4rzI10SOak=; b=LoqJgTO5lRgHekTDW1LLuu
	zVZFVFfiQUBtQJ6Hs8TdyecXdCZyOlXLCFQlEPK8A9BI2Ay7fyyMzcgZEIepFzVh
	tE5IvHNTFsV4/zPnFU27d392vnMQk3AowYlCaj3taGRaj2FGRDiNo6grfYLzx0pi
	Oa9Bx4XVisBEnW0PZgZHfPbEU6QIm0istZCkqQxtLUO8eXTbaBEy8/5kIzhoT2Lg
	8SE9T9/5gDXhwoSJbA79h4NtnQfzwFahw2jZzeOdLdhRAhJqNwn+0/KpueLpbheC
	jRpdVCETgULWV9OnSIx+TxArnvrElFVyFeJIElFKf6yGOWRjuUvVyaLb2Wov/EVg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt5ymn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlhnt1608057;
	Tue, 29 Sep 2026 11:30:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck9f6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBUkxx49480072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:30:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B5782004B;
	Tue, 29 Sep 2026 11:30:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 971DB20040;
	Tue, 29 Sep 2026 11:30:43 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.88.139])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:30:43 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Thorsten Blum <blum@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/sysfs: Remove redundant wait time clamps
Date: Tue, 29 Sep 2026 17:00:42 +0530
Message-ID: <179066556652.265207.17736539340344825251.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916151254.120629-2-blum@kernel.org>
References: <20260916151254.120629-2-blum@kernel.org>
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
X-Proofpoint-ORIG-GUID: c3srm_n49U41mAYeewu1YRlQs0I_cQR_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX4Ng+WexXJhye
 n+RAHMLPbFewm7sh8k0Mwq870uJggarN9xl6zx5u0j61TZsqWWChHsYuujBk03lIOD/zxaYXKRl
 ISep1m9jq0b1cDcdqiri3dI71CjEz1hklegsfYC6IsM6jdF1DP9o/4IXHBIczljwVM1C7Uev8iw
 TiB6BGAVR4OdfQ9BV74ay1p4J70Ebf1/1OWb4TQP2iHTv6yw5JroDAhh1VQ+rXLwsgfRteeLfAM
 MBdGLAfxMRRcSx/YRBm+UZWWyBd2oRKy/CVNMsNun3SaHJ/oBOR2NGc3qKZFIDJ5+UwJtHnn/lD
 7Awjw848GdgAxtYnubXjNbJZEreY6hShypACY0XurlcqX2BgQomEaEO4JSk2P8Igk/CyBNzy7l8
 xGLki3/HXrR7D5lCZPwTAP8PXKsZqNe1GTPoGsPVQiwrgpeZXOBN7SyaAhYnKdLyA7vadhyiG1v
 UVJ4aiBEcSsKtTzbqqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfXwlAdYvj5AxCM
 vcYJ/tDfTTqpeOvVZFdrsYZVxGU9vl8cOs9jlGdq7GD+dwDcCbAyrpk9tMYoJOCBUx8ouh+N1oy
 JGRlRJgdB82+C1XjmQfXSrKQTPgt3Hs=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abba169 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=-MndoXCyHQlNvhxjK5oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1oSNlotS8mt_LwWcZuKNfAvpU0jaVy07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290044

On Wed, 16 Sep 2026 17:12:54 +0200, Thorsten Blum wrote:
> The wait times are u64 and cannot be negative. Remove the redundant
> clamps.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/sysfs: Remove redundant wait time clamps
      https://git.kernel.org/powerpc/c/12d238d584ba485a99e02e033746100fc7099184

cheers

