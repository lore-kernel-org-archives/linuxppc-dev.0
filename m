Return-Path: <linuxppc-dev+bounces-17994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17028FD88D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:14:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvT74xfMz3cCC;
	Wed, 11 Mar 2026 13:14:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195275;
	cv=none; b=HtQG2OXPYtWjoB2wHGVX8Hnu8n4a3Xpxskd+Rafp8B9We/yZUTx7v/r3QEWV6P83ZqC6NcdjLcU/37YUvZ3mHT7WSWJTxfdcu4FWgpyu3U1N9WIIs13PVX8JkbR2npkyj+CT60QnXaaMF+OLiH+7GmYN3ibadPGoMiWWXYKvIY/1k6rUQ+8PGBvSruf7ePS8EfKHFqCfAePnCI2+xGF+d7mkXhSe36hvfDH+HHIdTMlXJiVls6vH5dJBWrKITvlK5IZ+3/C4Caj+L0uzv6CYmrBv3aI1Y4SnV6aKCZQKWCfIRNaCP0/H91cS1YF4BmhtqWUVe/X45JP8/2tEjwDflA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195275; c=relaxed/relaxed;
	bh=CH6lracKvhmTt+RT18YGJq1Z4+02QzpUCkT41iO/P0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ef8PMMAPXsMyJiVt8JBvDfEZUmZgXijxIbdJ0NAuE/86YBzUknj4aXwDPcwV2lkaAwnqaIOKwVXDu4QaSO5YMlH1VkyYXLZ1aHIDtue7dIiFDJIdp0N+MgKm7+qomynVmO8BVa7ZlvebkuhM45aysLE7mBjsM9RYGeFFfcbuqrk3PpgV+gBWHe1sUXv1zmzI9yqUjkc/O6gGzJhxz9gg8xR6GkUK77ZT2GySXTpPpkGu/fftgNgJ8JP9OZTzyVYcJ2sjG1sIr0rvbwlAdk9wg4n0YyVv1skimWetwfWx0y4dGeqzucQgs5a6B/tPe8wdDavkfhio2qojFMR8g9NGmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=COE+sd+Y; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=COE+sd+Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvT702xXz3cBP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:34 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHtVRa509351;
	Wed, 11 Mar 2026 02:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CH6lra
	cKvhmTt+RT18YGJq1Z4+02QzpUCkT41iO/P0k=; b=COE+sd+YTH5bC0fFD9bqmU
	HV6FXx8dI8RiDdjKbWZ0k4S3GYVjPFD0ZMMIAQbr8TWnWOPrqzY8xIhbk/xuwKcD
	zLWlXVRdUClsXs1bHRraroGhLDOxHmzrWd5MasIYXrRgCQCspXBV3VmE9R3T2XlY
	nDkGEw4bRgafZtRGrmVgwHYj2bNRTwFGrAv6dOEvO4I2wkakIiY+3lmaZh8NeSMJ
	wLNpTZe/yX9tsVQvvsaW0xQ8jlvAOnulYM6UZDtXmeB1pavubz0t/rnmLGTMz203
	DtIzTqytmH4PjYh2DodLm8Do0nc8nriRGdX5NCACiLdQyt8cWmHG3yNttrYhV51w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywdset-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B0WLAU029360;
	Wed, 11 Mar 2026 02:14:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6ur8xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2EJpB14352658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB12C2006A;
	Wed, 11 Mar 2026 02:14:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55BAB20067;
	Wed, 11 Mar 2026 02:14:16 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:16 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5] dt-bindings: powerpc: Add Freescale/NXP MPC83xx SoCs
Date: Wed, 11 Mar 2026 07:44:15 +0530
Message-ID: <177319508346.269267.3469218082268296638.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-ppcyaml-soc-v5-1-2982d5a857bc@posteo.net>
References: <20260303-ppcyaml-soc-v5-1-2982d5a857bc@posteo.net>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX2+IBv5Iv9g1Z
 R1rsclMDRglSpdlDZ4JUvUMjZxgbFBo8zMPRFOsYkouyGArFFhMzyUJYlbTcYdXH9DPn5liITQD
 QQPhHQQVvjVobBsjWPgpuDUuqqwcG8OiYGBV3q+xxKcv4FcUFTKj4iEMECQMt+YgCPyja+E3ZTQ
 9fCn0atIV5wafIt4PY1St907a8zhFfmfyQ7lec+NyilgwCbzzy25R5wrGg7gYFBTifAOM4dQc9p
 5Sv8evQTPCZr7KKsVc4UdceCKBfpoEPzPr0ucEGKiOEeySD5Nj/w1qrG8FBuSj4j9NYI4jqAVPe
 EY5wfLLEo1yvaSUZMBYzZ9lpPYMZpiEXxbSewGa45SkR1Oa4qSVZZgdeoFAHF0VVKfryEr/85nP
 q1tFYTVgCbELo4rxSqXieBU90cOubBc5rPEZRvc+teMJWHXK+vX53u46biqt8LdLvUWW5bisbkm
 F5Ek6XAlvnunwG6g+Ig==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b0cfff cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=kHYQ0qvyJFGcrkIvl-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OKTa63j9SxiP9KF0erjZHAccUi-WN_zr
X-Proofpoint-ORIG-GUID: 0dcg_uyFAPGwH5lZ_cvOzpk1ErWCxK82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Tue, 03 Mar 2026 17:04:08 +0100, J. Neuschäfer wrote:
> Add a new binding for MPC83xx platforms, describing the board compatible
> strings used in currently existing device trees.
> 
> Note that the SoC bus is called immr@... in many existing devicetrees,
> but this contradicts the simple-bus binding.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] dt-bindings: powerpc: Add Freescale/NXP MPC83xx SoCs
      https://git.kernel.org/powerpc/c/202d23eeccd4b12047869538d6fb91d1e42c4ddd

cheers

