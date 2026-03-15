Return-Path: <linuxppc-dev+bounces-18196-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1C1D58B0A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 04:02:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYPgB63Q1z2yft;
	Sun, 15 Mar 2026 15:01:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773547318;
	cv=none; b=jRt3gQciDroktXM9ECmHLpXDUsTnr6iFJas9hQlzkmXoF1CAwINlpuq870DidKv2rILrXw5Kw/z7GSCklsL3eutqqEhEiL3uLM8QfZ1QVgtggMjdw7JQC5/Q+hqFEdYs4hHoGrsTXFZPPS4f2KhsqlYEgUEACiQPQBuC8gbRsLcy9EP76bKg+lBOn1DIyINrF9XGdI9UKe5eGQ4MtmopvDaieemdmf4YD0GP1HZ+MJu3UNoT4sWbdqvA9AZ07YAfQmBjbbHEnGj0MNqnjwYn8RDXJs150TSm+/V21VPxAG6hfFdEy0mPWDq3V8bx89MbNk0vD51n5kdTLMKvje1Cew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773547318; c=relaxed/relaxed;
	bh=PCPGD2zae4hTeInDIhqub/VNO35JJ2u+zu4SZpM1c+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vgn3caUpCPT0KWWe366vnkm55Rho0L8msaF51ti6DveVRChyJvSQt0lRZv1B48/Zob/CTrM1H+cBOKbfHdx7/pMLobu65xGyPMQrfQjFM0BVBWFsRvi+IwCei1hf3QIPRod7Z/UkDEaqGgCwHCoGlTvSkjUYGHzffPIxHDqnBEA8+mEpPWL6srHhoAO0lcYAcYaaxxij6MlTwOSK2NlegGCglIAEW2xTivAYyv57Qst/Q99a5c+2HvE581B0C/doUCmjRAy/Dmhw/jGXmmCK6hx0HXPWxhfIMwpmeBMIvvPGsKbjA5wu34g6JwWVCsQbokA0soQJbMsvGMDfVk+hzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bbh8IHqn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bbh8IHqn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYPg95ykNz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 15:01:57 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62F2SSHe2890189;
	Sun, 15 Mar 2026 04:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PCPGD2
	zae4hTeInDIhqub/VNO35JJ2u+zu4SZpM1c+Y=; b=bbh8IHqncn/4VVkqHIKrmL
	C6UUIDlogCf2+1ARx+LQIHTGb0/qK+o+vRcmAlnxrprP0qFt9Rleh/+iFHrOmNSn
	Hhs/lvACta3/cAbK2IO3wj9qbPGvS8YN82/ByiHAmWa+WSoAphDpi+hmMv7KSbMo
	flrNVhrgGttwypPb8bb/9rMv+esJWNt+C2okJtpDFqn8lkeYEfyUP2yRFmr1fZXi
	KkxzPbLPyVw7aj7lWRpufQGOwXzdiM2e69OhuLqagrkkOiAoVcV06UHJFcITLZ91
	R52IYnoPu17isExtbY7euGReiDxVqLL+Ka54+UXPXokTkPJJ4JHF2IXVYzyJi1YA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hk58g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 04:01:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62F2gMX4032320;
	Sun, 15 Mar 2026 04:01:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jg56c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 04:01:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62F41deb29950270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 04:01:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 323AC2004B;
	Sun, 15 Mar 2026 04:01:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C972B20040;
	Sun, 15 Mar 2026 04:01:36 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.97.251])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Mar 2026 04:01:36 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Donet Tom <donettom@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mem: Move CMA reservations to arch_mm_preinit
Date: Sun, 15 Mar 2026 09:31:35 +0530
Message-ID: <177354720777.2367911.7154288884175799421.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6e532cf0db5be99afbe20eed699163d5e86cd71f.1772303986.git.ritesh.list@gmail.com>
References: <6e532cf0db5be99afbe20eed699163d5e86cd71f.1772303986.git.ritesh.list@gmail.com>
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
X-Proofpoint-GUID: N2FVgG2p4Lu-WTReS9VTNJDNO-h09wpK
X-Proofpoint-ORIG-GUID: cBDUdsstWvV5-jpkXRtB8AEdX2CXlz7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDAyNiBTYWx0ZWRfX7TVYeuLykjmI
 gcnoWNrMSsHCTjGcUGp607ywbJUCL6YseTByyZa7yYyVAbXDRZ0F/gZrJZt2QOZ3bxwpvow+w68
 5Y6vc/eDUDw0gIoe99b80+LBiTRXMTa6wXo3FKdSNdLIsVmli1FZz35+MbO+qjQRZ48oldKR+cg
 EuyBEMPDfeOBTG+lwd12UByxERh5SiDVkrI/L0Z5HJPFHPt27AkdgxGJWSRiJl8NGEkahw0EaoO
 pqQGWMEpNbq7yoVYjDhybQCI1jJeFaXwUJrQL8WeuNDqLiernqDguG7SlDH18/xM9qqkBLnQaXY
 hdep81FY3XjzAqSTrT6Sv3xpfgdKNxISXthzVypQUCBoC42KkSIugE4e7pI2ayyD3RT2DXWQKPe
 3lLY1NQ3AVVXoGzaK0gE3LAVTGXV9Ll2g/U4DQt+IVswil44Kl7mLBXVKOOxMA/F+XjU6xmlLqr
 p3se1q2VC006HC+lf/w==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b62f28 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=vRg_hqKlNKNa9p9_vvAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603150026

On Sun, 01 Mar 2026 00:17:59 +0530, Ritesh Harjani (IBM) wrote:
> commit 4267739cabb8 ("arch, mm: consolidate initialization of SPARSE memory model"),
> changed the initialization order of "pageblock_order" from...
> start_kernel()
>     - setup_arch()
>        - initmem_init()
>          - sparse_init()
>            - set_pageblock_order();  // this sets the pageblock_order
>        - xxx_cma_reserve();
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/mem: Move CMA reservations to arch_mm_preinit
      https://git.kernel.org/powerpc/c/0a8321dde01ffdbd9455a028194d57484def59eb

cheers

