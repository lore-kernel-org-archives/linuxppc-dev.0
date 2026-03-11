Return-Path: <linuxppc-dev+bounces-17999-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9D5FD88D6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:15:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvTT5xnhz3cBW;
	Wed, 11 Mar 2026 13:14:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195293;
	cv=none; b=E0oPm7TF1nDLOAi6MeCmqqR1QxS0juHJ1NV7orOKBTK/B39Brk4RVt0dYeOR+25lc5jYPXbsBxV7eQCaA3D/VFXp8a9b4vHylr9shyheWPnJGE57VqnxrIrdUAzrAQE11biVkBgYhWB3L4jKfhzOuv+/PLokgKYMTi9UyQ2q71ZO6UMxvD3hkNicSpSyd7DuBi9z2wCnwDRgWzAz+fiV2/MaXq11sj9PvgVwbs6zzWZMhCKuTRiWonGcSUDy2lgeiaYTV0LnLvVWVTyN7uVPAdtMYr3YJEkANb005UNNCGJ99cSMmV6c5rtuHYTXBKEqY6fOk2AfoUH10TQqU0AU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195293; c=relaxed/relaxed;
	bh=heNMGgqSiwi2l2BKHhFV1pLw45X/sUvuHUk6UwWa2fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+o8u6DBGRjeOJgOZithby5pVt3CwPrUEbjgsagn5mNSqGUlxivVWI0osDT2RDd2z1beG0z1j2GiBsS36ZwYBbSsTh9sImdROBBgCjt3bD/rfu5Kk+oDJOXz86vXGLUgb/eAXG6+/nOipoFbtfd02Qs6bYftHDIKKmdTSW1wxKB0j0bK16oHkJTDrEi2gX5xYlPCHpdnYNwI/1N/J09nIhRxywS8yhRERdn1lXqHV+AqH+kxPCBVJpXIWY2qFuGwQVIQsyZl8klO3RWAUsipYQB7LKmJ8BcOCCB2/k+CBYXFBFb9Kexe/RZC7tEMKvKyP1a0uSfLs1UBAHBy047olQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YZMfoO3x; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YZMfoO3x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvTT1Lvkz3c9r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:53 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AL9oEY1649593;
	Wed, 11 Mar 2026 02:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=heNMGg
	qSiwi2l2BKHhFV1pLw45X/sUvuHUk6UwWa2fk=; b=YZMfoO3xqogKk/Z9YSac5p
	E7oZB9xBNndM01/eyxplSj/hVmNWBYcJmZwIlFdvORo5NqUwxE79HOa6AGyPJm+k
	62kcUZrYA2WzLZdlM/tjoI9VYzJoHfxSXl0NIAreVhcNUF78ABiin2TLdAP5MRPh
	OsivZP8VVcbk2rdVXm6GaeYg+JHW80hTN00pO84nxn6ogWrQp8gsjpnSVn8t5EH2
	ACKFLhB4mq4apsm0pJDUg6h6kaV0HrvdfUx8rYdb8BfDOpqAjg6M8YX93EegG0IW
	bpHrfVgTJQZ6HxxpYrABtxy41D4nCgkLdJMWQ+9KIEriXCe4G7m8rHyFIS7CJUaA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmdugh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AKki9d025041;
	Wed, 11 Mar 2026 02:14:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk3fte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2EfE346727466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 854AC2004B;
	Wed, 11 Mar 2026 02:14:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DA9720067;
	Wed, 11 Mar 2026 02:14:39 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:38 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/crash: adjust the elfcorehdr size
Date: Wed, 11 Mar 2026 07:44:38 +0530
Message-ID: <177319508341.269267.3219325956530114508.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227171801.2238847-1-sourabhjain@linux.ibm.com>
References: <20260227171801.2238847-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-GUID: VFn4gYrYWqvYSoltLwL451SkkTC7MuVm
X-Proofpoint-ORIG-GUID: gEPgKhNqF9oZHUmY_B3oEdZn-aCzHpRD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX979Yfcu9h4Tz
 RC2rgx8MwKwNjqQGybOlH7Xfw4Lc2Zr/+LbYJCjlqARf/T3vDa/e0FcZonOtGK9l/cxcu1/rpi+
 JxoQEAQZRdXen2rTbrCVlpSvIaKYtOAo4hc5MEvPu6gbC07X4HFE5qgYT4CUxZya6cPVsFlzAB9
 r07+wQq8tTYJvDBM1kGe76aVPVFCgms0HxrupdCOBODlty10uclMnW56UC4oEWdWJnzdBy+L6/L
 UJQgWYyhu9e+zRpuvmpTORN8/F0gZAdSiU53wCgDEP8GSzmgRmXhCbFlX+gFSg5q7gLiWqLGG6i
 xt4FyaNDhO6Zuh9+EbuD7I7LArqDs7JOmpaMbWMevhK0rgOLkkLX+8MGsP8U/0Z7KB85UY71lr6
 +8ueXJBnGhjBZIrQP5qTAmbbUKq+sHtYUxqqF5RltPGZZ1U2NP7d7CtjIrxutpfNmhggxot8ssa
 KJ1qbQAcr19esD18dig==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b0d016 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pxTcbLMBTAsFQKf-W5sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Fri, 27 Feb 2026 22:48:01 +0530, Sourabh Jain wrote:
> With crash hotplug support enabled, additional memory is allocated to
> the elfcorehdr kexec segment to accommodate resources added during
> memory hotplug events. However, the kdump FDT is not updated with the
> same size, which can result in elfcorehdr corruption in the kdump
> kernel.
> 
> Update elf_headers_sz (the kimage member representing the size of the
> elfcorehdr kexec segment) to reflect the total memory allocated for the
> elfcorehdr segment instead of the elfcorehdr buffer size at the time of
> kdump load. This allows of_kexec_alloc_and_setup_fdt() to reserve the
> full elfcorehdr memory in the kdump FDT and prevents elfcorehdr
> corruption.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/crash: adjust the elfcorehdr size
      https://git.kernel.org/powerpc/c/04e707cb77c272cb0bb2e2e3c5c7f844d804a089

cheers

