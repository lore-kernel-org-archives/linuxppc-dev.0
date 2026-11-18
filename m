Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213F606A334
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OVH+PPLq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTktw6v2mz2y32;
	Wed, 18 Nov 2026 12:45:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794966312;
	cv=none; b=LOb4fsVmYHQ93wEeIkQfZYYnkFhTssq1g62M/As9vbVg3OCQsBjOs7P0DC+ShbPQYTPwk72hxFS+ycful/XLtfTXaxL2YdZo05Q/VR/RLXLZzS43IhZCLoQNF/RPYe2J2+rYt51ech65+1FlWf4pDLCBpWYWXn0dHvQ8wmiTcUBzVCi757DHy0SWtYUqthVmJj2FfHTiwGbPrUPrNeF2n6+4M31519lKVQ8PnpNTgCBh6/83MdhUk5UJQ13LZeEFUkELhfXyB/QvO5d+r3zTWcJL1iEe3NxdrTTgT9HUWBNEA5+buKGQcUdwJmGLm780NQiKlJ+lOPguk2QcJSyDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794966312; c=relaxed/relaxed;
	bh=w++WoOqvUgF7NwuXxPtgBet20OmoMipzkODW3UtZXdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdfmRBbDcwccZXsEZzKvAKbjB8xsfTvt3G1/SNnvJ2dS1Ol+EAqUl77HWpbZRKlE0i2LXkw7sCETJygAbDMOS9CKRtm32LJSfrd7C9wLsbUEwmY6iogkMJuD/9L1KfR6IwqcIX702YuFSJEC96qOOiFKlAePWcCeZYmwm928wN9XtHdJzk9SV0FoiKLkKHcW0N9XRkRQsr7DrWCthw2KKmZNPXwzbwZEBxwfQI6YsKaB671Xbrbep9uc9GbWG+zf1+zkLV5BOWSr1T1whClDj/5RW7cTJ4GDQNC/CeKwVCyuAGjx6vCtGGpfjbZJarzWYXZVcsqIfcAWAW1BgoU76Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OVH+PPLq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OVH+PPLq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTktw15yfz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 12:45:11 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMv4953803880;
	Wed, 18 Nov 2026 01:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w++WoO
	qvUgF7NwuXxPtgBet20OmoMipzkODW3UtZXdA=; b=OVH+PPLqUtqZl+rlJZkUvx
	MW4mNjRVESMDh7aHREnwBH19riBrUKnumGftf4YI/9pM0SGiTQmOny4SM32szHq4
	ban8SMtpa4aMuZaFBoZjght6CWTV08lsTwAVdCrqoSLSYyzleJnnsKWYuK5fZnJ/
	XnDUu8VVAZTkaCNFFCtmcgGeVg/nInpcmiqgWEj9XK6g8nz7acvvECcXisR3lcPS
	ktaP9XOD7KWgwdGSbN7wm7pIWHr7DDtBI+8bV3A1cNBvxp4cNgsqITPQn5otndM7
	2Rw0hWDkRenwsa1nD9JAHaeVx0CJBJsFYXcC1hCi9RdwNhfhpopNYFIHuvkrx+kw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n8d5d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMo0E42234496;
	Wed, 18 Nov 2026 01:45:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02juedgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1ivNk45023682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:44:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B89720040;
	Wed, 18 Nov 2026 01:44:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF32A20043;
	Wed, 18 Nov 2026 01:44:53 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:44:53 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v5] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
Date: Wed, 18 Nov 2026 07:14:52 +0530
Message-ID: <179496619898.633156.157194038888710996.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261102091700.253381-1-gautam@linux.ibm.com>
References: <20261102091700.253381-1-gautam@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfXzNTkvvMsS0Za
 ZtEdJHpdo5g6zEcY3bMXFdE+zzZBO9LDr0qnF1jhxE9l8Zb3i1GdFiC6Pzo301/ZBnHBrVZD+ZO
 luoz4aYpESjigZDb7DgFNHiRTXqbIBpuEfxyYAAODaKavm/oO5vZasAWwJJE5JJHkKjK3FZGe0h
 YcqDnN5Jx1xjdAh2H+P97cBPiRBGxGogVq8A7PPkPnPERDLHU6zo10NyonfC77CMYQnLBK7Z4h1
 MflSVvVG6P/wUAe4qY/pP/UVIqco4kuNtMvP6OXs8jDOBsSyuEnvRSHoLCmSWxkMlwS9SizjV+A
 6B1C4o3Tf7d7+3WYbGeFcYWalxX6nkS2hioD7tuyDlHI/VPLbnV5PgwyOG8F4dd2FeXDbnCmEMR
 CRPXd4O2HkkKdazhvo8A+jTzBX1sidgdS2GOc9bIyOl9EEMdkLgV0ni4cjpRRgUCUcs0vUXH6FJ
 pVYS7IuMxtqZGTsusXQ==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd031e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=R5pTh2J6EbdJFU7_rC4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PL1qid-a0E9Pq0B86x8Ks14BUjwSLyrH
X-Proofpoint-ORIG-GUID: n5B5z_QM2xBLLRJVJfooGjoct0zZFpKv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX7eAFA/UFb+Um
 sI5dtlk/5yTq+fUG9WPfnJ+6KNZX6B1TSld69e7nByJ80gYAlc38vAYsp5g2Pbmj46RNK6bjuAq
 rIHcQV6v2geEJ2gk57+43+9dfxXqWDo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180005
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 14:46:59 +0530, Gautam Menghani wrote:
> A huge number of spurious interrupts can be seen immediately after a KVM
> on PowerNV guest boots up in XIVE mode.
> 
> $ cat /proc/interrupts  | grep SPU
> SPU:     223705     192439     273526     147623   Spurious interrupts
> 
> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> Handle pending exceptions on guest entry with MSR_EE"). The root cause
> is that once LPCR_MER bit is set, it is supposed to be reset by
> software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> not exit back to the host until the decrementer expires or there is an
> hcall, etc. This is because KVM on PowerNV guests have support for
> native XIVE, so they are not dependent on host for interrupt emulation.
> Due to this behaviour, a huge number of spurious interrupts are seen
> since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> vCPU exits to the host.
> 
> [...]

Applied to powerpc/fixes.

[1/1] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
      https://git.kernel.org/powerpc/c/9751c361cb234f000261879b1b5015bf08f6a428

cheers

