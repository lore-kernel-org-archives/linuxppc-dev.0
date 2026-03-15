Return-Path: <linuxppc-dev+bounces-18197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52BCD58B0B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 04:02:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYPgD3Jk0z2xVT;
	Sun, 15 Mar 2026 15:02:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773547320;
	cv=none; b=MLeovwIDMyN1p6WYvpX6f+BGr/YwllVkvnNRcFCl/B547s7sX5M6fK8Vd+X8leUOPZMk4K637+cANko8f/Wug41q/3GjGGJraVl7NhQdDpKQUmyOn41bxW3kOLtM0XnRjomhg5MbYioA6O7xPf5vCekf5+s0gvfMcZJz3g1h7xauNHewOaZ3+Um21Lh3SYrNhK02Bm8abIpQrEPr4Ik+YCdJjudx6TUMzLUl3UZKTQRhKfM0xZzjsW54Eva5XAo5a6UTIyq7IGMvhp9OFVWPiJJsfq4w2k9kd2Z2tdHPpkNg5Nms4m0SYVtHHPTj3jg0a/ziPe34O4DOg5qb2a/aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773547320; c=relaxed/relaxed;
	bh=fPCZVuHXaGBL7k+m3AwOPZrCMcm7bBmTSIPiLyo+lvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUakZUN/QWSJRoq/kkBSfXO9Ay1y1+TIP5ytHNsX3vN8Ll9JmglVaYeOMH3xWwt7axr9h2e2ZQUFW2sBuhPU9ou0d1c5X8KenRg1mAF0z2dDrVKvGCkKwzhmv91gxbt0cNSyRuRJqmdlJkX/KdDhjDH0n/CHXgYx9wMjjTvCqXb+7N453C4hN+kj8DTPVEwwGSx1DhLbElqMmEKtT2Ry5KxYS+QMzxP95r9ruKyjuuINijX6Le2uu5TgXwRDeUbDijl9sIolsIpjaBZx9IoqVICStD+8cjKckGypdHoU1++9l3Wzx82W3T/qPDtP2ImkrQU5UD8i3F39ibEmXyU5vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HIWGBUvV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HIWGBUvV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYPgC5jlNz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 15:01:59 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62F1aSfM2776227;
	Sun, 15 Mar 2026 04:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fPCZVu
	HXaGBL7k+m3AwOPZrCMcm7bBmTSIPiLyo+lvY=; b=HIWGBUvVhucUUEeKtLMVMG
	lcUGPhZfM3A6+BjkP/doo5QwxK4mAd6zgWJQ6wtqlQV8DQRa7bovi9kSmwC9p4TU
	qgAX3PASljfRfIQhXK0kE+0exftYIl7NfyNTtEleOmDvzmWWbIlGHOxzvvB7u/U6
	vJM4UZ3bdXQzksSQTQDeA3dfB9SZ1VtommA2q5a4RfSbmUwIH0WgXupp7PAeFJBq
	/LCDbgVaIoUNA+mJLqyE7sS95B98lQAc9b2MZnPN9FYc8mfm3GRF0k1akGfCgBsb
	KtN/VvqLnFEk941gbRcyWEcu5iR3+YAq2qlKstU9wCgzDqflBfsEslu+tkbZZVSw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybru288-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 04:01:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62F1rI9p028708;
	Sun, 15 Mar 2026 04:01:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk08ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Mar 2026 04:01:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62F41imB45547804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Mar 2026 04:01:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6EC120043;
	Sun, 15 Mar 2026 04:01:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA00C20040;
	Sun, 15 Mar 2026 04:01:40 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.97.251])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Mar 2026 04:01:40 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sayali Patil <sayalip@linux.ibm.com>
Cc: aboorvad@linux.ibm.com, sshegde@linux.ibm.com, chleroy@kernel.org,
        riteshh@linux.ibm.com, hbathini@linux.ibm.com, ming.lei@redhat.com,
        csander@purestorage.com, czhong@redhat.com, venkat88@linux.ibm.com
Subject: Re: [PATCH v4 1/2] powerpc: fix KUAP warning in VMX usercopy path
Date: Sun, 15 Mar 2026 09:31:39 +0530
Message-ID: <177354720783.2367911.16048624886269310692.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304122201.153049-1-sayalip@linux.ibm.com>
References: <20260304122201.153049-1-sayalip@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b62f2d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=6T4Y4fKdaYDxuHJJVFoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: whSHWTSiAeVTn4oaUvcSxFZmRPa4cCIz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE1MDAyNiBTYWx0ZWRfX8aqNnWfKwign
 MX6cjq0JN9JNHQ0KK3zbmZ12DosTxDdSXBw1QPhu7BQve6i5bTuHwzqlo0Vz1rPSkT6a4wQOA/S
 td+5yASZApS2s/sZ/yAQ2kM6WHEZFU7M2EbeQIj83PL1Kr70IesISpYzT9c2F/NAt6/0/Zf8F9b
 syVZ/63BFxiDqa/xzgqUmwdVOfuVtc1kNGWeAGLpT7ObLEVDjHoKxqPgJPDdmHiF1m5PBU5mf0x
 ZPloZOnkkElypYUyPVy/tWyn+VENQ/9fCA6LboQX1ck/pwH0oSFE4bvBaKjUnVdMHrAHh6t+QOi
 y2OMPPIQhpLTyhHFdgeBrzIZ575SAVSuNL6qC0eBvYWcbD4Hzz0pesZTU+o+FMI93tXZ7iO1yen
 4fJN/8S4BtIyDpQnVqpU4L+ghqwrdvF0Kzjnr+g9xJDomDq0dTBUZWh38IAzqYBijlfmHYTMv67
 OnYuqqwsIHgO1vDmVlQ==
X-Proofpoint-GUID: whSHWTSiAeVTn4oaUvcSxFZmRPa4cCIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-15_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603150026

On Wed, 04 Mar 2026 17:52:00 +0530, Sayali Patil wrote:
> On powerpc with PREEMPT_FULL or PREEMPT_LAZY and function tracing enabled,
> KUAP warnings can be triggered from the VMX usercopy path under memory
> stress workloads.
> 
> KUAP requires that no subfunctions are called once userspace access has
> been enabled. The existing VMX copy implementation violates this
> requirement by invoking enter_vmx_usercopy() from the assembly path after
> userspace access has already been enabled. If preemption occurs
> in this window, the AMR state may not be preserved correctly,
> leading to unexpected userspace access state and resulting in
> KUAP warnings.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc: fix KUAP warning in VMX usercopy path
      https://git.kernel.org/powerpc/c/6bc9c0a905228bea5c53ec195fe54f5f0233dccc
[2/2] powerpc/selftests/copyloops: extend selftest to exercise __copy_tofrom_user_power7_vmx
      https://git.kernel.org/powerpc/c/146c9ab38b48004b40735b6c1e1c2b5adf6436f9

cheers

