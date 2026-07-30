Return-Path: <linuxppc-dev+bounces-25054-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CC3C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:42:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dPF1c8Mz2yng;
	Thu, 30 Jul 2026 15:41:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390113;
	cv=none; b=mVy2Ur1+cDJZXfC+CvBh0KytA5pYazBAMB36go/kMAqeM/LzBuM4sySfLqWXwiHL8tS0AG0mcupO/3PvsgkiUjX3VkJOljveIX+a0L0WiNNESYuA307SPvVDhxGJyHsJvrOn1vHtN09vC7NKH6TOgdPDH7PDd4vgTmdmNmJtvDh5QdEQr5uEtOBSPay+OAztiEAFlFahfTLaOUd5fAp5TGwAVdZYNhXPD9JNqlqhdJ5/oRYE+3EEAb/8kb7w2F/X1xrqlIqoIm456Q0CMdPYE7SGj4QtFuluLGko5e1ZG8M0wtwbRdOrddb3BSu43klshvZKqiS4LzKR+aUqei0Xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390113; c=relaxed/relaxed;
	bh=ul+u14myCsAUk38IO0+sa8MpFpNSA5KFSlof0JatuvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6DdXG/hDaaEid7hNu111A3f4m028XHsKltSk/s23NE7aeco6ZnBjb/6AgfBcKfNIVrGYLNcCwI/i2OtSPQK2B2F5Tlq1mqdN+AsRgAUgfEc7zbeJzK/Io2cpsgGZTcNV6me22JuuUYzb1K5MlHiLhdX+wN7KM0gOoKO2aSfUqk+CJmG73Q6MU+7CW7y1K4tHmSYTgPhYBlbE8LXsxZJEG5Vbwr7EqXZawlUwrqAzIPJAyovP1rwniH8PX2MU7EQMyBP6QYmcydPq8oWORhjwRuCir2X+ULYJW95Q0RsrAaWfm9ixpYL1n/8OetIQP9/J7ubKBMZgpov6RVr5+QUwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z3hW51cC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z3hW51cC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dPD44PBz2yrF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:41:52 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mAhx1830463;
	Thu, 30 Jul 2026 05:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ul+u14
	myCsAUk38IO0+sa8MpFpNSA5KFSlof0JatuvM=; b=Z3hW51cCRYoQh/Fz7SUQVN
	DI+rwPRHwoXO0ZC67fYAKWc724Y1Q0Xcf3uvk7FJx9mgE9uIoqNSvc7rIOyJHKjC
	wDDp07lAy11EU9u7Mcyyc4PtjnykqgNOrdye8Kr80TIl2GjGpDobMMn7XA2n+BBN
	ZunOfy+hyM0kynxrPH/xPuoSHfq8UyO8sEp8lY/2ulpgKzz1Bw8o7wkJY6AkP9XN
	Z1hbJhTeakATNuGjP3D4XZXT1jKb4e4cJQzeunh4c7yPEoKYXAB0L/UYDDP88fF8
	4ZzFMtlpoSPCDn6/JNJJSMMyrZF2fJBrG10nddEe1/43uEyiYZJSv0EZnznxCyTg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nwass-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fKXT012973;
	Thu, 30 Jul 2026 05:41:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk9xey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5fP7851380618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1255320043;
	Thu, 30 Jul 2026 05:41:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1718F20040;
	Thu, 30 Jul 2026 05:41:21 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: oleg@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        david@kernel.org, akpm@linux-foundation.org, yeoreum.yun@arm.com,
        sshegde@linux.ibm.com, thuth@redhat.com, agordeev@linux.ibm.com,
        mchauras@linux.ibm.com, segher@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>
Subject: Re: [PATCH] powerpc: Fix exit_flags field placement in pt_regs for ptrace
Date: Thu, 30 Jul 2026 11:11:19 +0530
Message-ID: <178538948391.1278583.4141106305535032892.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723194809.4046600-1-mkchauras@gmail.com>
References: <20260723194809.4046600-1-mkchauras@gmail.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX7loYIzIV16IP
 fFawbAZoRG3kCt3uPxJgN1px+kuYTmvfuFLKTWq/6DHv+KLJWaZDS8xVZBFffLFs+OCmQUEBKQo
 fdb6iUiDBBlBAToCUr1T/rfqSr0MqYs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX+Go9oZRt6rR0
 Ixg3AJ+g/JDJjvt+PDA1c0IFYATUacoB2UXcOltkTI0hiGr9qHtaA1hV4UeOfUie7Y8p7U70TRe
 GU8rudsYtqCtlu/1faJOyc0Ut8ElwPHsGz00QInMVC6uundckzWgPQiqRLOKJ3zoxBw3nP5KgIQ
 aFkc91kbuWLo7uLBuV1iEOnbFD9XBjaYOlJm1ixOkIT0WlsZ2HgeRtTptTIJx8dJ+L6LF87ATuK
 MENkXrpsP+YP3n/nuZAuKAk5CvP528KjHtqy7uioSzECcfGIGUlHQuL4IKWhcJthmysAXSHxc/+
 JcvzOG2Cw9HYs2I14S8QQzjQxmS7C8JgbTJk/MXYiQD3a153bZd1/aDZhsUw6x0MbCXILuPNrVP
 8nXQFGjaQ19lxrNK0z9iqkJDlwH/rH9R6y4AeODYtq40B7oDcu6IwZkhNVoWwns+P+CwBD5W9aP
 g1yEettrtTTeb5zgglA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6ae40a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=iA68NVvoHCIC6b59knoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bCBLiD4PhHLVHykaBb6sjwY6VaGAHILI
X-Proofpoint-ORIG-GUID: 8DIxTYhPhBsLFvgOwowBOyZ4-UpUjt20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Fri, 24 Jul 2026 01:18:09 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Commit d7a6797e0bc1 ("powerpc: add exit_flags field in pt_regs") added
> the exit_flags field to struct pt_regs to pass internal exit control
> flags (e.g. _TIF_RESTOREALL) from syscall_exit_prepare() to the
> low-level assembly exit path.
> 
> However, the field was placed in a way that was visible to userspace
> tools such as strace via PTRACE_GETREGS, or caused a struct layout or
> size regression observable through ptrace. The field is purely
> kernel-internal and must not be exposed beyond the user_pt_regs
> boundary.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Fix exit_flags field placement in pt_regs for ptrace
      https://git.kernel.org/powerpc/c/263e5159e00aa46bf26f3496ff7aae1fc9a6c826

cheers

