Return-Path: <linuxppc-dev+bounces-24584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF30C4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:39:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h49lv3V8Cz2xlb;
	Tue, 21 Jul 2026 18:39:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784623147;
	cv=none; b=CQz6K4ihvXFHngaU5NebGYYYJsGxnAfx1vqfmqY4cFTCyRrIDV/9KMbCBwM7liUVmWiyOB7tYAaseEAPZFC1Swk/l5P4/Mfp8GMA5GBECZNb8IPOAvrSvirIk8bj522nj8Awq8hNxCMa+Kc2xQHsOYtTxoYSHVjcs7SC/55JDXy0n0yQiHRrw3uubQjCN5doSzTuyxlPgvNOor3FLtK2Q8G4g+jtOp1bgQGJTV5Pu2Hb2E0JDiOefVOHS4zldTBcfOVwlqRqzYx07m43wG5N2ZPGKZc0PEx5GnCWeYzp2V2hxm7cFUtvj6Jg6ngko4Fig3j4m0GqRYWmQEoUDooxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784623147; c=relaxed/relaxed;
	bh=5maZlObb71SVft1hqg+S1xtcX9ZieXBCZ37lv8ju+FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrYMuWwhTXN0bTLOLVeyF4tkDXUBf8aD1loyIX+M3WjKvCik5VIBpghYyhZALJtjzi5xETZ3jPmJR9INp5cXxffyo8DH7neNtDvrHIQICCgApY60g1ST0aM9ZZvi75n36a74qQLN9tL6TqsZa2zbs9NYrSGfZzKyjKCA+GxjfKMctSX+xNVQaZoykUYkg1ueJhuvk8keLkVdieEgRX5UGCaKXGlPzjVtPQfChd/QIohCWhnIc4bsWDQ5cYnzPpUjMocWT3mN41p2FOIRdxorYTWVVl+bunEmn5/51u8Ho8rPG9qBmZyRzKqvdKwhk5rTEpbM0IRu/DtLp6DlV5ohsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cfXP7iat; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cfXP7iat;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h49lt5XBvz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 18:39:06 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCqwS3553300;
	Tue, 21 Jul 2026 08:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5maZlO
	bb71SVft1hqg+S1xtcX9ZieXBCZ37lv8ju+FY=; b=cfXP7iatEbrop2c/y8aG9Z
	H1zoVOo9Xq+ivIHhYEIIjhMn0hxylxNMUJl/yI4Oid1ryHO9301WS0HxOTsSUTOc
	244RdE/2vIFLlvVtGa75jbheRGeDXAmsdQu6Q0zajwCYNKtRSxojrNVotPRDt/7X
	5coT3VoDAzS6dXeSPoIiXavqzLkL2NkJ3LjCgXOLzctAeTOa1ZcetRkhQDEGLbpc
	VQejL6nyP+i9Whx1S5PzxcYujJXrXWvAReleBRgvfvT5z3Ncxm6SN95T5BGH1t3P
	JZLbM0QkPtl8OHW0ynuTX8omE35gMkUYFGar2C6NJ3DOw9T6oK0f9S5S35dMDegA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abbju1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84aGd013933;
	Tue, 21 Jul 2026 08:15:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy948k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8Exh952494652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCCF82004D;
	Tue, 21 Jul 2026 08:14:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08FAB20040;
	Tue, 21 Jul 2026 08:14:57 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:14:56 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and later processors
Date: Tue, 21 Jul 2026 13:44:55 +0530
Message-ID: <178462153941.1974055.9212884139202871921.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260614173437.26352-1-amachhiw@linux.ibm.com>
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfXwh8HdkC0ZDGO
 4G15U5xJWwBIOX6LjTL7JIZncbNv9BIgd+bdl7SyiW/KCFFDyzxSbBlvuIFyMvtSj5tZ85Do/Hm
 rwPPcV1D0IDGwASYzOErUko7IGE6UIGZQRNjBk4r6H9uv1IzSEeC6SICEXlzW6VdDvw4RdN+bfq
 mcEzq8Uid1nqRl8/lum9UloffhpVRE8UJ0G/arPLWjAsB8JAcSjZBRtBtPcIR+LU7pCaJBvuAu1
 rnktnnloO45F/GgULhLWQ2laHi5BIEvgL/pFuovSBJ1T3ZlZOZJyYTIyopD2VoOsZUeeKcatwzX
 KDIhPI0d7AMo7+LRNWJCFJHcuF7NXvvFlVuhG/h/rTGLwbD1C1Rmyx/jZXR9pM2YTcp09ncqoip
 pcdkcZeA2fWm4jxZN3ZgZ777GR0mUqcC2qlPb7wMbg/F45Wllv5CXSCclgOGCyF2Rg2C1lzRfiU
 E3/rMUYVY5lLvM2fhEA==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5f2a89 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=IyTs_d-QMcr_bO2y0b0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Bf2sdHPbYs-etfcCoaB5-GyV-jVoAK9x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX+hIdVZhp25MW
 BoQCE+DkXCH17F6XRs1wJi3+fkf1+bSVsGesn43mXSfyY2cA8cgbBsYCRnU6pw4wwpsrDbpnVR2
 pqczLLlJNYR5oGIsMURqJ74IANsiRgM=
X-Proofpoint-GUID: snN9Jx8g2HDPkLrM-Bn4ukFDxyn103s1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210085

On Sun, 14 Jun 2026 23:04:37 +0530, Amit Machhiwal wrote:
> When using device tree CPU features (dt-cpu-ftrs), the kernel bypasses
> the traditional cputable-based CPU identification and instead derives
> CPU features from the device tree's "ibm,powerpc-cpu-features" node
> provided by firmware.
> 
> However, CPU_FTR_P11_PVR is a kernel-internal feature flag used to
> identify Power11 and later processors, and is not represented in the
> device tree's ISA feature set. While ISA v3.1 support (indicated by
> CPU_FTR_ARCH_31) is present on both Power10 and Power11, the
> CPU_FTR_P11_PVR flag is specifically needed by code that must
> distinguish between Power10 and Power11 processors.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and later processors
      https://git.kernel.org/powerpc/c/e4de1b9cb3b5c981e4fe9bca253a7fb9161f5acd

cheers

