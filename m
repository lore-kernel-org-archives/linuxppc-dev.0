Return-Path: <linuxppc-dev+bounces-27205-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095D1C88E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:21:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjxQt0TdTz2yDm;
	Mon, 14 Sep 2026 17:21:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789370486;
	cv=none; b=Y5PRTkaw1A+F6yFJdLw9Y1dEG00m6NWyoL1gc3itCc8bVEyibNlOEVWno35Je0lEnQlpcbOD03pS5nmmDrsS0jridUg7ho++qRxdl00gVh6kHLMrc61hZ2QhXIVdAmd/agGescOThdUfAFTwZXXefFH+PPlNByPkmQu++bL7GhfAt/JADKHufslDOBO1tt09zsKlBClWmgiokZjW2KFkQI35zAnudTbO6FtUMIuVeGF374CSmYk7+pIiiSrKKA2XwGXiL2G/S8Xmgmou5EzP4Y2mQn25Cb4OutnxB0qJRPUy4rsWadUgi5yNKu6ccIQ2sOMD+tl7ryzI7VJB+sO0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789370486; c=relaxed/relaxed;
	bh=vkSsW/YiYIxr2kcixGxovIRFYIOnEmpWPSa0DA+PTsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX1+ApHr1JI/3JMVAaguRM9GUGrvguBof9AubaH8dvJS1g9ZGKin/ryTjnrDRH8h+YW1w0DL0btADTgPxA9AK9lMRVYL0F0Fvrb41jtsnHxRaUpRXR+C0vsHOElS/mlO/wMuoAQ4QRBrK+Bra9YOrdYM9ZVoMeUti2ku4u1XN85nJIozR2YH7iMpoJfgp3pXkxP4utSNEcEkFrNj1iSBEHnuU4rK3FhzmKg6YVw9eeSqbeA/lqvi14EFbn4Kputbqy+Cyl7WBXei+w3lnqtsucTU7vyhUhOxmqZbXgJZwwNzsWM/0o3TPMHla1FzmOgnkLScH9eRpZ0erNRYc+7xdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p3i4FPNG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p3i4FPNG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjxQs2T55z2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:21:25 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E61Rwa1214259;
	Mon, 14 Sep 2026 07:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vkSsW/
	YiYIxr2kcixGxovIRFYIOnEmpWPSa0DA+PTsQ=; b=p3i4FPNGlVUjp6ZBviJ55Q
	grDiX0eKTOzbl5rXD/weOxq7p0thCgZJjwSprOlJd3D/WUazbu/SHUgk5JhGASWV
	79zUwiQ6C8SYE8PMbhoIbUKfQpYLcHfbNhvxYNQoUQrCSNKlL6j9FT0rBiobJP5f
	gctTa8nAUnXUqYcQ7yL9NSVWL6eGvh5Ttc+2rwX6kuepkE99mSKPCHIOK+nOTlc6
	lZIJV/WR2ldhZUwCLocNqZI1tjNP+KtxQ5A1LAznENXzkgfOQvPKVRiASgKSUPge
	KtGCjbK0CGFcurTPYpefDiilO0lfwmjRUijZYRigsv2I0lQrSyihNz/46LYuSbsg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83ftht-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5oAtJ1787585;
	Mon, 14 Sep 2026 07:21:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnjjgmfwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68E7L96349873210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 07:21:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 721E92004B;
	Mon, 14 Sep 2026 07:21:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1015120043;
	Mon, 14 Sep 2026 07:21:05 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.93.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 07:21:04 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Aditya Gupta <adityag@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/prom: Remove redundant early_init_dt_scan_root() call
Date: Mon, 14 Sep 2026 12:51:03 +0530
Message-ID: <178919368043.441103.10019829068499885695.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260418091250.134111-1-sourabhjain@linux.ibm.com>
References: <20260418091250.134111-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfXyYI6HXZzfj3W
 1NB9AteNb9vY6hTfxhqYvJbzxxrYKUmiiBu4rBNnNNvTsMwYnnUDWYLw5fXn5wutCg3yZUJ+OeO
 tFrutRgklXgXaqYQfmvM8JUVyusFzRgZ7CPbAc6ZRJnXeuOnr92BIICxhE6YWdM+6ozzVl8LnMB
 rtYN+2zZlyv+fX73aaamctpJ1t4Ebfy7XGURRFRrVXC4e7Rj4nI6gN8KxKbwtNDANjnF6VQFy8b
 T0uhhF9KjJqp3o6FT+JLkemHXmpstIKN9JYMx/Fx2rnoA7NiQ8kDnGEOjm1dh2B1MZ2/SX5TL1x
 POSebTVaBozDOFsAfn5ncYp1HRL038hLuZ1DuY1xoVXthXuSyaDWT+ZenogQ5aRI7Y/040M3CUv
 LKKzxydgRC3hQjqMrERhTzjK4lTSgd31ybWk12Tulk9AhYBrr2K+h9w9LKBI/kdHXKPBDaKOyCb
 VxGLkhGUYmdhDqdkp/g==
X-Proofpoint-ORIG-GUID: qzabzMd1ZeT3s7Hbm9foK0tWWci0jy5q
X-Proofpoint-GUID: 2N8UGprZKgA6tPD_JfdsiKOI0N4ZYf6b
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX1x2QSk2at+/U
 FXU4hFiYcWzezEBfdmmk8xVETFg8wRDND/EfaEBrTMJPnWvT5xsEQt327khLNP9PnnktQtThAED
 L3K8IWGJscHdxck3MU+QAByT58t9MUg=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aa7a06c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=mrly7fLVJiLaC4xhfc0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140098

On Sat, 18 Apr 2026 14:42:50 +0530, Sourabh Jain wrote:
> Commit 554b66233623 ("of/fdt: Scan the root node properties earlier")
> moved the invocation of early_init_dt_scan_root() into
> early_init_dt_verify().
> 
> early_init_devtree() already calls early_init_dt_verify(), so the root
> node properties are parsed before reaching the explicit call in this
> function.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/prom: Remove redundant early_init_dt_scan_root() call
      https://git.kernel.org/powerpc/c/15f3ce3aa218f6d4cece9101f1af4332e8712e39

cheers

