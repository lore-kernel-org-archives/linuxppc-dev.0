Return-Path: <linuxppc-dev+bounces-28495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C831CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:05:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvJMN27nLz30Vn;
	Tue, 29 Sep 2026 23:05:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790687152;
	cv=none; b=i/pXrWna4vJ9ZwbTEtvUjh+RUkDlWP1kuGlbAhex71yghHW2iRX+6kNo21d+LWdD9JnWtOGCxSwP2SHT+Yxk8ZuUWr6cMC8YjRxBjrdy70wE+Yl3G0ExYxdqr6AjBD+e/F6+Jh1c0rbbPJggX0nTKf7VulwY/HuQGl6TTgdC9r9pCwtPRYTjVndqLbcQNq7/Svzj5KFt+U4iv2/0E8/tWGZ9vx68lSZU1dYyb9hUV9jP3y8td17BzyQoCLXbOKqLwgPpn1TOmDpnfW9L2rNZWO9MudOebIBB3pE5ls7J60CEc/nUQz9KnLFCk8VP/6vcPjI2e4ARK3SnmRQvwSxFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790687152; c=relaxed/relaxed;
	bh=Noe9vWNYAyWkJNW1N3e+zPWf0iDGQdkjDTTrpvwtMQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RN4Pp5wy+TxZTjzB8bj0kYKKWDpNBXu4jWDAbycbva7qS8rQJrjO5N7n4P5TthU5GQ/Ae99ZGu7pHPA2w/9OgLI9a4niCIihfqvUaLSbblwCN5de6XoEE3W5JneL/dL/ZDBhprdXi+RYB9kyaTpXZOdxYLJ9UWv6jBwUPZ9w7P6DxS1wVYYEtVIHPWyJtSqv5/ReqfF2IpCpwPPT6hSx2Ytve/JulpnLc3ehf1AIPoHvvlAcARYxsT3SqrttsVQTeBlGFEwvkWz9MD3oIeWbDpJs5ngKCLGPi4fRQZbKiizfCrsImz5hiAuRDcjFrEKlpqYo9YTAqT4pUkH16ALEUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XlLUc+XP; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XlLUc+XP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvJMM1qh4z30V6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 23:05:50 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5jqV3836778;
	Tue, 29 Sep 2026 11:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Noe9vW
	NYAyWkJNW1N3e+zPWf0iDGQdkjDTTrpvwtMQg=; b=XlLUc+XPT2dKJmrgdR4ppS
	Bm1VQVkHbk9ohA2c8+B1f3lQgXfLYe6/R2LjX4JU3KK8gPW92fVTURG0FVQVelg2
	iTE2bIN/2N6BU37TDBhcLYJ5gR+0b2+7JcIwASNv9/8qb9OKcj0YPOo2kromE/y+
	suCk5WmqkDa5PlAWf9wLJ19dTiXhtX9kzHLI/m5JBydOloZRZMCfSeR9EfUS7HMK
	NtJpmMWDwh4eizdvegtZz1Y7OgWaAW4jYAp6HAWmZMXLtwt2smtOjSeY0LNj/2Xp
	h5Yw6FhAbZ1T2sYIqIMJyS6gBjtTc3vqjrBlEIMn7Mk7KY0OGhMiaclB3TfaDgKA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk6bnd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:31:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlkc91657634;
	Tue, 29 Sep 2026 11:31:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpsnfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:31:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBV7kW53412170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:31:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26E432004D;
	Tue, 29 Sep 2026 11:31:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82D8F20040;
	Tue, 29 Sep 2026 11:31:04 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.88.139])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:31:04 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, hbathini@linux.ibm.com,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v2] powerpc/ftrace: Don't restore r13 during ftrace_regs_caller
Date: Tue, 29 Sep 2026 17:01:03 +0530
Message-ID: <179066556649.265207.17586795790331377487.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921072151.35531-1-sshegde@linux.ibm.com>
References: <20260921072151.35531-1-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: f5ZWfvlQ0imUHj7Rh3B-9wbxnYb53jYW
X-Proofpoint-GUID: RnlRpO4fLDroHI2gto4OrdRKyAmUihYI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX3ScRDP+XhVoA
 b9UxhqdWsp9k00whlgUhLrNemMzRTzJ57by/AeOEiDcBHSwOt2jnlwyL5/SVxTzrArohhJfKKSi
 YKu0omFtDQYPNign/vJONFrLgYK3DFU=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abba180 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=TsoWHe6mYCxSqgRXxVIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX8e4QTeLPGOij
 7RzFHyptVNcQVo4G5n8amkGK2XhlwuXFteF1v0Uupl2Oxlt/1qzYSqx5U0R5OFyHwr+FQWFQtvA
 LrgEKW7C8olyvafoEzDN0w8BMlFIxWnvz8IkFol+wTtzB1SA87yJ0Ty/QFw+/kL8/vp9C9E+eCx
 0O0SRWldw5IWVzBln2IRLfIxf2P7l+xOzy81CHpHeXIrE/Zu29378+0b80AftWzFjX1uvgA73Sv
 s0iXuQBKc4azuWxCy2RClX/gltdxYlGkbrsIkQuUQhmzoq1FuAc8e5lTaxpxxvDcljBNrnUEAJf
 kQa0ZigNOLqFeGvnXZvx57F6qIAWJpbw5nwGmvRL1nHMY5EEUt9B1HB0SmY6f6CT3kmAoK93X4j
 bioF0iesNhBX9c0EA1EaAKPbe6CSo0nmZAZEvjMnmj9LE/BD+U8tvMZPGi0PsbfOY2zm7hmVaKS
 8t6NH5GMJKwxQXTCNXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044

On Mon, 21 Sep 2026 12:51:50 +0530, Shrikanth Hegde wrote:
> Michal reported a stack-protector failure and subsequent panic when
> running kernel builds. This was observed with full/lazy preemption.
> Initially it was suspected as KVM, but later turned out to be due
> to a bcc tool running in parallel.
> 
> Issue was recreated using a bcc tool.
> For example, running below in parallel leads to crash.
> ./funccount sched* -d 100 and make -j 64
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ftrace: Don't restore r13 during ftrace_regs_caller
      https://git.kernel.org/powerpc/c/af5f0870883ae4aea7f668d06cbb7ad0e12824c8

cheers

