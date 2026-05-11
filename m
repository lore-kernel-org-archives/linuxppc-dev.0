Return-Path: <linuxppc-dev+bounces-20671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F354CD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 02:29:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDNvs0BWlz2yCM;
	Mon, 11 May 2026 12:29:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778466552;
	cv=none; b=F/LtyOEbF+4s3OKZ/LXiT6SXRzBGQ6UgpG1tp/v9+51/YYHIpTvHDm4FNdpTyjQvbAluwXGSbOWKFRsF2kE1O8ty2ZaD/8YI36mQ1tMOQkjS/cvpzsGfLl/mUTMi5nEVmXrQ9Zne6T6RCfAVKVuGuPRMC/rj8HCEesdbgYXITnuEuhQrOEHsYdjNbYGKqimjMIS/nEYjt3RNQwfbwiRSRGMaPoTYIn5NGZNCYUAgb0Z0/v7lTMmBJS7WsUEIkhUK9vdGkUuGEkaLrFDrp7JqqxSTeobM5uxEGptMu31MsHX6CDKYawBBUuKzQYb2+xyID5VFwaXI8k+DI4IjlxVNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778466552; c=relaxed/relaxed;
	bh=BMoW0trsqlT3iuBrpha7XA3r2rO9+gAYqfZT/Dna5o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lc6a0bU2jycUczb23vBYdEvpDGTA6a32VGEYdiUgwsKqt4S5WpPOkqFrFR1To9Mx25KcBWInOzTyjfBtwTO57YLMAXEyfzPvBadBvQPjY3G/0aCdx1j/314iHkUt/DJISovmHhlWo0mIw7199818O2A+1HHKudYB0d6Qfh7gan4rL717yUDRkYnFkhZu5nuXshMIOS6IFVNDIiohjSH6eVemubuR/wLgJwNEivYz4JnZ40It3Gr0bViq2CTjjURSF+fD3Lfv5alNnRC9YEkVEJ9vmmC2uDo2umGKyTPlEa2XuwxtJSyrZC0XrnM0NeqMb7OOTyPKDLo1Xlo+Rlly6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rkv3D+yo; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rkv3D+yo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDNvr2Dn1z2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 12:29:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AMkGXZ4017310;
	Mon, 11 May 2026 02:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BMoW0t
	rsqlT3iuBrpha7XA3r2rO9+gAYqfZT/Dna5o0=; b=Rkv3D+yovj2JFUr5SivrIj
	rdklm7tCeqA4OPlnlcnPdP4JZsseNgSWfsjyj/G+1ogARXTRimeyJPh3k4CH4GVS
	wO3lR6OCJLApemqnlY5JCJdGoxFRVzXmhILVZwk26dUzinFghqiQzHiyVoJZxXeI
	ko1hEvwTrg0SiMrdl/nPo1qyeddB0gkgqCdkFrlpLd7yO0prBW7cr2GE1kDMj6EZ
	7sEcoYy1dPrmMiNp+m2BTniK8zpn/2624B2vIj9GIyJfl6D7ED3p3rc4LR9QYfVr
	XnjeQr1Mh26pxu9pBi+AcBS2llXigCeyE4fNj7DrDdNNkuyquJMgmEZLx0NceN+A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqp7k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:29:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2OU7G012693;
	Mon, 11 May 2026 02:29:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q3h7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:29:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2SxwN47907078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 02:28:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45DB12004B;
	Mon, 11 May 2026 02:28:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EB7020040;
	Mon, 11 May 2026 02:28:56 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:28:56 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay <shivangu@linux.ibm.com>, stable@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
Date: Mon, 11 May 2026 07:58:55 +0530
Message-ID: <177846637462.1289230.1137772952219441646.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260407124349.1698552-1-sourabhjain@linux.ibm.com>
References: <20260407124349.1698552-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfX2rFs4NThIIEK
 YoQvcWMMR2atJChjS9IvG/EDzWhpdBmm8gVARXVr1/Hk5JM9/jTr72d/BLInCgP56/VS7MMPc2X
 nwqrAfMIdcZu7GamnLqcmPtogvGgMEEqcC84yAAK9xEQrasOW+6tp+pnFfLFro2w0PBpr4FyEgW
 /NSfmPwmVhqFZXYrJivUkCzy0IKpvSQQXDtNxukE4ZqHYYeyghbzUqP1y1mxvyjn4sIB5hhq3mq
 ugg5LCQvRyxFTIAd6mxQLT1zpaty2OciYf/Fu1mZnLmJvRpIBRR6An5b5Vxsi63uB4j9O8I/eQ/
 SrkIh7QqgO0DVA+es1MMJGKpB3xe0ZNzG5hHRtcWYrDDtrjkLkn2QtJy4/zfvjHQq/YO4OWTn17
 VBpnt2my8mxEvYu0a5cDrQOhggLuwiLTIKZb8PZAGkeEhajQbT0DUAY0hSJceIGiH0AUOQK+HIk
 or7maxSbhwStoF2ellQ==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a013ef0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=AHMFlFXem74IdTo9uU4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1fTGHYbQ929IC6wLyLTjU6hW9PiYp2BV
X-Proofpoint-GUID: NPb261swPiS6b5L1HXFJT0VDkJ6DihND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110022

On Tue, 07 Apr 2026 18:13:44 +0530, Sourabh Jain wrote:
> KASAN instrumentation is intended to be disabled for the kexec core
> code, but the existing Makefile entry misses the object suffix. As a
> result, the flag is not applied correctly to core_$(BITS).o.
> 
> So when KASAN is enabled, kexec_copy_flush and copy_segments in
> kexec/core_64.c are instrumented, which can result in accesses to
> shadow memory via normal address translation paths. Since these run
> with the MMU disabled, such accesses may trigger page faults
> (bad_page_fault) that cannot be handled in the kdump path, ultimately
> causing a hang and preventing the kdump kernel from booting. The same
> is true for kexec as well, since the same functions are used there.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
      https://git.kernel.org/powerpc/c/b3a97f9484080c6e71db9e803e3cc1bb372a9bc7
[2/2] powerpc/vmx: avoid KASAN instrumentation in enter_vmx_ops() for kexec
      https://git.kernel.org/powerpc/c/38e989d504fc52900a3786b7144fb53cd67e0389

cheers

