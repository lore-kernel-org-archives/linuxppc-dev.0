Return-Path: <linuxppc-dev+bounces-20672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DA5CD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 02:29:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDNvv5ySGz2yDs;
	Mon, 11 May 2026 12:29:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778466555;
	cv=none; b=eNS7evVPeGrKwsaYm9WJZwwfjmg+EPNtjuREu1kZTBgz/RXiGakYC5W7Gej9IcGeljl0d/2GKg3J5kGXUu3kfLyI1QNRc7FpyKsprPqSubmc47GUwbSX5bDvP3ZvEfm8PtGXUkcVFslRvXQZ0yw8XBGb4/JptKuI/llr/FLCW+HIc5lxbTVR1TEk7LIYzXldwdZ/4V8LldMafRHHF2T8HjjXqfH311KIFy5DDrgNtg3jWAr6K1BoKt+a1Za2Wrgup39dOc8tKQplNEVIEISAAryxgowAmr/TQjEzeyWT9VzJYI4Ndp55tPZhak7sAw678TedLu5jzvM9n0ty+3M6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778466555; c=relaxed/relaxed;
	bh=QVPP6RZ1HSyCn2jZtvVWMH5Z5kSFMy8Itri0dwD2tcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCH6/ZQ/AnSw2XVfL6np1QUlzr45E5/3hWpuplkDgwrbnqECDp9ZwW0gtzlRMhhwLoRBQDQksy3TcV2mRzJ/fa2dxZ6Y/x6FZnrceLcrrJZDKXqYJ8xryd9xAaT56DUcqSq/99jtvYq9+xGgbk3j+m0sPtGM/QA/VzVFnYyhcHqd4MB4fkX+sJCPz/vAd/4sjh+aEEjZGrFzzx6oTjQnijqL4xaJ8Msa34U9+T1VyYW9Y/YKsVoegA+WOJbAHWFC3JEITtXB/92bPaq3PLtW16CrXJmwyJoCaaKB/kRwED+hz9lmBY0kzDY2JNsuDPY3TgtU5Jv8BZCIxcbBXABPDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HhGSv0ni; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HhGSv0ni;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDNvt6Q9dz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 12:29:14 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AFP0gH3186808;
	Mon, 11 May 2026 02:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QVPP6R
	Z1HSyCn2jZtvVWMH5Z5kSFMy8Itri0dwD2tcg=; b=HhGSv0niY02nEA77xDY6Kr
	FS0PyCygpa05YrXDxTb411cQy6KEY5NUJT0vl6LUdi4hMg4jEpYNZh0Qft3WMIN+
	qoEyrLjiZixiXLDJ9SWZ/N+fEJIR/dOwd2VhM+1IjsCn5JoihkMqvsudKvmTgxJn
	VCCW3bCCEE5APG8oYslb8FO7K4HWZKFZrrE+BAqAsqf5ziiKaNTnY+rGEiWVRdJ5
	Xkq9a8ODcWXrCrqLuR6Bc9JclxLDvd5q9jnjariWl5U2FvMZEODcgXzc4ZzLMs5M
	86OHeiG5T2SHndtzUxFHme9U3pPIuQFUpKAGBVD2lAPCIFG1YahXilupBm+UrmMw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqp7js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:28:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2OVMp007094;
	Mon, 11 May 2026 02:28:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvufw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:28:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2Sj1N39256420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 02:28:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A156A20040;
	Mon, 11 May 2026 02:28:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A7120043;
	Mon, 11 May 2026 02:28:42 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:28:42 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Geoff Levand <geoff@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH RESEND 1/2] powerpc/ps3: Drop redundant result assignment
Date: Mon, 11 May 2026 07:58:41 +0530
Message-ID: <177846637466.1289230.8085972286295062509.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfX0wVhF9RsFYOi
 bOcD8dQhZ5Lt5gQ5txQ+URL2ms3H6lemg31nbnM7XwVmomvNwijTxAry9P9Ugp86CURxr98zzFx
 /8rKq8jU50nau23Lpmgj/aF5B9s+8nAkWY+k3X89e9bUmG6koaLlnA8gs+9HxHMONFxC7V2P6XQ
 aQJDY0vqlpdlLAyYV3vVAY8miUyNP4nYGH6AILx1mTJYE8oDjl0NY/nw6qiS/aSPNp8VmaOeGiR
 5bvmXJTmVAXcmM2LZR6L/kXup58ZOXU/qlWkJW8ybx3A65aFb8o63ChpVf0/TsiwZCNZShYmFDG
 mhdlRfuKLLxWzJ121aa6bEO4tZSTAxANmiFbLBsjBanC0DDo80/PgG7hJmbFQ3ZYcYAX3TOwTli
 jR3v7VgbtvYS5xNcHSDV7dF4+xF0+42/4kIcGNNozKFPXiBlSUdgNDQ4eB2oWucqlNVNbt1lt2I
 gHW24IYx8DKfZTE15xg==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a013ee1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=Ws6guhHAfqZ2DLpO_VEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R7MksT0g69tVq3jTLcNCae3WWx9pFqu5
X-Proofpoint-GUID: Lo5L5mHCiUyQrgMnnEsWerWipQTJCMol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110022

On Tue, 17 Mar 2026 14:08:24 +0100, Krzysztof Kozlowski wrote:
> Return value of ps3_start_probe_thread() is not used, so code can be
> simplified to fix W=1 clang warnings:
> 
>   arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 'result' set but not used [-Werror,-Wunused-but-set-variable]
> 
> 

Applied to powerpc/fixes.

[1/2] powerpc/ps3: Drop redundant result assignment
      https://git.kernel.org/powerpc/c/8333e4916040e529bd5b56b82d573aba51e88a14
[2/2] powerpc/pasemi: Drop redundant res assignment
      https://git.kernel.org/powerpc/c/f583bd5f64d40e083dde5bb22846c4d93e59d471

cheers

