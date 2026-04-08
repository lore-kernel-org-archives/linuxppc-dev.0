Return-Path: <linuxppc-dev+bounces-19476-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403A7FD5F6F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:30:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97q1vFyz2ynh;
	Wed, 08 Apr 2026 14:29:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622567;
	cv=none; b=ZkbkJd7LdpZ4mtag/TEkY7wgNINmx1bshTmtdbSyKcsaITQ7qmwL1eigeHjKMXgLcFS11cTBbBaRzZWV3ZDdcI6snEcjNlc9B66fQ5Ga07cWoa2yr5xGBpCR0olsHXn+5o8U4ITuFB0KKBmW0hUyEDAAa6sO/mois91GEgpcqMx6hXhXe7Oly30ts14pH+E+VrGRXbkez+e2zYGU4Q7VUx82U352oBK6vedBdzYPnCoi4req11gMVEUrVZIpXRb+cGjpxFMKKeDshqQeV4UpWGAFaBCv7czSQacljOBgRWiA9ot7yOtZFKU07oZNASjbIrEk5l5a+EGJKorU52zAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622567; c=relaxed/relaxed;
	bh=nFJHyoz9CXtW3KpITY9KgxOr/aRJZiT52yeFnJ2Ts8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNR1TwwLqS0ts+by8wnUHOJGskoEk8WCeiWhwN3Jr4m7RVB/g4SXZQWGA6UzI3k4FjgiYUNBcHRyKAPZZnoMlImlo6AVC7vU2cIHJq46q/Dm5qMHd87FM3+/tmWt9EkilBf/QQ48ouk5/7NcawpWmXyB2UAYeygZQzI13X7BSeNjBAQzuTlW27ZVNWeacXk65xzVXNBZ0cZkm2MBNbSlxl/cu/FuUdQvH3FyMjmfyE54yVfgMFSK52m2Ej6ZWCEKi1K3oWBMp6zOfXR+Aup2CUZPw0CkQ/ZeaRz5pin7p46NyUPbxwkFzgPIzBYLo6yRsSb0UjxvJWmhPmb4gHYceA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DiCqsmQl; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DiCqsmQl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97p234kz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:26 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EHr9w2301624;
	Wed, 8 Apr 2026 04:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nFJHyo
	z9CXtW3KpITY9KgxOr/aRJZiT52yeFnJ2Ts8c=; b=DiCqsmQlx9KBQVDVPKQdxf
	TptWFU3KGbbjmurYf/yN+2iu+N8kwjf7w4C2+9X8aRJArWnlIURy6zfH76IG800k
	1HG6l1qATBE7Bxxk1KTaTpD3Z08K+DXbkbdpNTdcD4UA+Ql2Em7KM+CzRKerVZZC
	F0QeKbWHYenNLtdlP4kwe8mR9zNIQ8In2lpB41Gix0T10v+JRCRrrPwq2M9TVgdZ
	WlaKbwVlOn8WmeXJ5t3yTdgV7auuXzXwG7XQDXk3egHF8fH5uzLX8moeahceMgxq
	4IAtjAZcNSn7rnqzsnQb/kEcmHn0bqjVZDKCO+/X5LnpL58WlR92J+NMhsYi5uYg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fe793-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63800NQk018877;
	Wed, 8 Apr 2026 04:29:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9e0ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384TFr146072204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:29:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E35A20043;
	Wed,  8 Apr 2026 04:29:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F07DE20040;
	Wed,  8 Apr 2026 04:29:12 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:29:12 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: chleroy@kernel.org, nysal@linux.ibm.com, mkchauras@linux.ibm.com,
        rafael@kernel.org, daniel.lezcano@kernel.org, christian.loehle@arm.com,
        mkchauras@gmail.com, npiggin@gmail.com, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] cpuidle: powerpc: avoid double clear when breaking snooze
Date: Wed,  8 Apr 2026 09:59:12 +0530
Message-ID: <177562236430.1381144.27958537257316890.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311061709.1230440-1-sshegde@linux.ibm.com>
References: <20260311061709.1230440-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfXwPg28izPWoLf
 bQYnD/oHMPaCXq9W5q/syIjFJKnrAwdh1jdzE0KzsFXLp+3llLN4HAARpeMrw/Fi756loQC0Oaf
 sB2mHHubp/UT9e9JYHpW8yqCJj3kAE7QGK03CQ57+/v/2e9xBnDYLdRQs3YFWrSprWUQYvvKU7V
 vM1RQ0qU/jdMrutyps8zFtdgipaPgDYNyZaqCTtCcn+i1E7LgWrPONS8fDzpud1pLihTYGdcUGf
 0twhdpsY9ii32vS1cf2Rs6nKnIZNOEOivuciEun/a7IdyaK3Y9mV3oTglb29q5fV55q0HhU9uE7
 R+ygwkN1FIJ2vQDWOdA/HbEjObI8vUXvnNmB0St7RxZ2lWQf/Qq96buP4M2bVlWsQ+Ej08va2cx
 sSlGg7dUlkd3i4o80LatV6kBA3ZMw7kuHOMW9lcC0f0PSfm0UHd8rFvZlojP3eTxgaCFKhU3mXy
 rUjLfdrBk/KnmDqOoTg==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d5d9a0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=38kH_jgIqBUk_XIBi1EA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: _8GFPxaJzMLUHB1nkZMtDe-oV4YzIzny
X-Proofpoint-GUID: pAJage6zwfLutYcgN_oN4WMQbrdJhRpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Wed, 11 Mar 2026 11:47:09 +0530, Shrikanth Hegde wrote:
> snooze_loop is done often in any system which has fair bit of
> idle time. So it qualifies for even micro-optimizations.
> 
> When breaking the snooze due to timeout, TIF_POLLING_NRFLAG is cleared
> twice. Clearing the bit invokes atomics. Avoid double clear and thereby
> avoid one atomic write.
> 
> [...]

Applied to powerpc/next.

[1/1] cpuidle: powerpc: avoid double clear when breaking snooze
      https://git.kernel.org/powerpc/c/64ed1e3e728afb57ba9acb59e69de930ead847d9

cheers

