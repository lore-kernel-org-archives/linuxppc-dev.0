Return-Path: <linuxppc-dev+bounces-25465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906EDC55ABA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 04:17:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFvBJ2TpLz30F0;
	Thu, 06 Aug 2026 14:17:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785989832;
	cv=none; b=Zwl1U7ykWc4cGdl8kUEy/b0yQqG9LU3fSAEmomM1nhF5eClmPZDTv4RbXwkPU4H9wkMVDZkMgiytKPuzgonVSUsXjS6YtRAgg7TQXKCKbdqRPfZxO/KJKwnXAOvXY0Bl2IEuSuZ8R7zyyP12xwuoIQV8H9/D/t9iAUbbGo3S6x/5enRTGL3jyIKEvfpv9DM6ufmDbgw0l7IppniTAsnUKZfAxSKN9OGUzuL6yYxETDtyFKrlwZ7scPKkUpbS4pMzBzB+C8EzfqqVwV7+hcnXWroS1L4U8Zrvkjr/HhH4mjdDO1w3l3DJObCis4n/OMoKBp71sR4BbRJZ55z2T6yL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785989832; c=relaxed/relaxed;
	bh=ndWYDqgSBxPtSEjY0/Fxf6ZBjJRq7/C+1SRxMaqYaec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2Hn8S3IOOxmK8JNxXtBfLH44mI9RjN+qPSxdnIWLygHV4fcxwNb/mWTsYI4tVG+Pw0REc891+0DSxlBw2BQsv89NRh1KOu6UHHPJrjKdQ1jii+npxuU/97DVsfeQYmtlCRovl8F6wlXnh8G4LrZWfWrbyCvtIC6QLQjSCkgQgwKtfeYSzglmrepR3vq5WuElv13V70icP9vUF6octxbfxMWiueUZfS0JbKfrhhVdRQL+f7K47XNGvD4rDeN2Hvr9NK08NTjHQitorVGf2xkiKYy8LH599dzgMSXPmdiGQKjR45c0nShZZhwG5noKltwMboOhJRtL16Clkqc5eTsTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W0AqqJ4+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W0AqqJ4+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFvBH4YDwz30DY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 14:17:11 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NllDv1092821;
	Thu, 6 Aug 2026 04:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ndWYDq
	gSBxPtSEjY0/Fxf6ZBjJRq7/C+1SRxMaqYaec=; b=W0AqqJ4+R/u71bhzpBvhIs
	24z2Wl+o40oB2LLMeZHPKI2bSA2mctyCWGOA64tPtwX4rpkWoUBMPk881HiB3rcB
	bQuPad2kuA7lOPVMDuFK0+TOI879SilYpJ8+3lfCK80Hs/6MBI6pFtBRrVy+zeLk
	od1GvocW/+Lt/bf8CJnNOTBHRBqKJbLZEBy1ohqeFmfqRkAlkE9zuwr5lDtuBBHK
	n7UpxZXoHc8whELfXqGSx1BLB774XT4FFl1I7RKfzGQM5Clx33jhJoh8Gk40nukj
	N7QZ/ETV8wQwf3Wy74ZnmOXN6guHQyLB35zWu7PnKeKxsNN0Ye3izdIXLDioJIMA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h56abm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6764BLb0019114;
	Thu, 6 Aug 2026 04:16:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw9pm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6764GcYx49348938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 04:16:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB80920043;
	Thu,  6 Aug 2026 04:16:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E7DB20040;
	Thu,  6 Aug 2026 04:16:36 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 04:16:36 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        segher@kernel.crashing.org, hbathini@linux.ibm.com,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
Subject: Re: [PATCH v3] powerpc/irq: Fix missing r2 clobber in PCREL inline assembly
Date: Thu,  6 Aug 2026 09:46:35 +0530
Message-ID: <178598971878.942627.14667171310466300671.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <10fc2cda485cd22e209a31d786bed1984bdf3982.1785732393.git.skb99@linux.ibm.com>
References: <10fc2cda485cd22e209a31d786bed1984bdf3982.1785732393.git.skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX81qxN1Bu/nSL
 s5E6LeFyqdd4oj24MHmiBhC7HhwHGDz7KF9yH/pCJgrTS1Uo7LLu6rOmvfpqNE2jbt+kWnYGxNK
 bhoPy0yPpon03HSqJ37Fm7Ka9F5WztY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX1qkCmmwqVGi/
 5GmeRwzMIpsuRsbA96AYy5N6RDBo0GMJcHTC1psU7SDtR4Q5fmI4UVIV9HWazo53LiNJiE4R10A
 GwbBl7PEEHUZhtlE2ffa3N+hBTBRzssnhAEgRayXwfnHp1CSD9G2ROvWB1Bitw/5aAHLz6ivQqI
 qlE4nRbennFD4wJ11YbbChZY7mFD91zwCBI9ASUYr+vLDKvJf3z0v4L8pl2vL7fy1m8/26yG878
 4DNFCqmowvR4FRWAosvHmjEx3o+ACisyK1m941CLK+keVbsv5Tv97Q3J/DM2551tAMIs7voPTqT
 3CzM0H4vVwxVfISpDh9Xw0NE7JbDNDGfCHTc+c/aAz03A2ADMZ4wKDJCwrLoCjiNDWAirJO3m4U
 GCitav9cW6bINVa/28LtVjB94zAni1MGMDeBjPcZyKypTs/ANgyxuCHInXSmlWTTIBjp/yVz04L
 L5e0fNqKfRb1zSO4HCA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a740aac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=b4EOssonIuH-pqZP4nMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JARLyblwg71vWLhm-7SI89P61A2PYrQM
X-Proofpoint-GUID: rA8pSXEAlXYGLmdG6yx5toSNBs1ajAlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060025

On Mon, 03 Aug 2026 10:58:43 +0530, Saket Kumar Bhaskar wrote:
> In CONFIG_PPC_KERNEL_PCREL mode, r2 is no longer reserved for the TOC
> pointer and is available as a caller-saved register [0].
> 
> Both call_do_irq() and call_do_softirq() use inline assembly to call
> functions with stack switching, but fail to list r2 in their clobber
> lists. This causes the compiler to assume r2 is preserved across these
> calls, leading to register corruption when the called functions
> (__do_irq and __do_softirq) clobber r2.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/irq: Fix missing r2 clobber in PCREL inline assembly
      https://git.kernel.org/powerpc/c/00be69070d91d2be978e752bb117a0a4db0e1281

cheers

