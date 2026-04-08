Return-Path: <linuxppc-dev+bounces-19468-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67296FD5F6D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:29:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97H29n0z2ygp;
	Wed, 08 Apr 2026 14:28:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622539;
	cv=none; b=d/hYJdTr0EMAViVPLvu0bcYizDl49MBxdo61K47C/P7cWERFIlg/W5xRauNrthaNS7ZXR+BKd8ROgtmcmoFuiZcAkDrVanVx+ik3hsiKi4O+w77OKsApAwnNsuMv++b+QpZizN2QAXFdhAgjJEVLg47t0f+4Z7uSrn4K+QaCuTAoE9JzPWaNVKDDlFwHJU1uU4NSEJ6kWH6k2Y2F4SoIv8Er2YuaSkNGrhs/6weUZWVbRGPAe74vXUNoWcp6+DS/etX5DklWFb2Gd6e1RU3N2SP197XlzTjDBL3augutTUk7bCa99ylzupVsEnhHzfrkDpzT2ux2gIrIoh8+Z9Q/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622539; c=relaxed/relaxed;
	bh=KHkgA5rnezyfdvWUSpptQbGO1pU1LUddvMA3ATcHhUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGFGjNtoBGuIBmsUMzxVh3MXCyEpg1MPpdysFsmdIKw8szDU78iXKSChn7zw56VifPbiIbsTMb1UJzqvj8jT2A8g33HqoVTucFztr6fI2bw3WDxOcsPwbwCM4SbdSzUI3wKduZh45Kb5Piu/JEr4BNDnOxxz4pvT6udGVmGSAcnwd4+zOip/w7WJvUrd2jCPkdWkl9FRiyTcStFNx4qg/iuzSljsPf/ZLtUhjIflYK6zNLwnHiGYR4hf8SUFTgrh7ZulfFVve8W+xVGj1f1MUGE0Nh3Y7aDkwkFekYof4mrhcP/X0lUBHxRW8Uv2W75twtyFRe2+T9vRJZZM38hMdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cA7AHPUS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cA7AHPUS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97G4JJwz30Gm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:58 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EX9bc2302449;
	Wed, 8 Apr 2026 04:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KHkgA5
	rnezyfdvWUSpptQbGO1pU1LUddvMA3ATcHhUg=; b=cA7AHPUSrBV+ZWmwPGv3GF
	rmVRMemyaL2uqlhRj0ZNnydTQq6jeSMIF6OxD9i0X1EQsGYYzpj3T3KpvwC4l5G9
	5DYCmJVocFXiaCckyl6k2RCKdT8KdlgrECCDyw+nWVLQAfs+PLmkuYhumHZUzxcO
	xIS12uIzH60FeXIiNgpos1gLKbR4otAllAMJ+uEgeMbHpAo3bOJzV//IShlnbJ70
	dm6o9gE6LYgDRUni1ISMhlkmt9BleQLvwOc0SeSdI1DEafb1mGIshvgTRbefe4H6
	T9ImOYl8uigZ9E7xzxU0DtwfNmS4cb6IQSN8AFRBNC8A5zkk0QtUt0cxNfH1vWHQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fe77r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380PVto026707;
	Wed, 8 Apr 2026 04:28:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7wy0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384Sbsd44761402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 673CF20043;
	Wed,  8 Apr 2026 04:28:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 144C520040;
	Wed,  8 Apr 2026 04:28:35 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:34 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        audit@vger.kernel.org,
        Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
Date: Wed,  8 Apr 2026 09:58:34 +0530
Message-ID: <177562236431.1381144.17164983023348957945.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX0mcPefc49ttG
 HRnPg6uzlYarwby+oKuaE9JQOAmpzhrJnjokUQoK7bCsxq5BdcMjbo6jwn74OIbiEtYULUZwjjw
 dhSJjXOguNkBArM07GccMmIkD1RFLaQmdLdbA4Q0VgBU8LBLsjac+MPsyt4G4AaPTj42xz+EuGS
 VAY6LxFb7c3341jgPgDFwQg3dncxMA35l3QfzpmaTEdbiRtfPRQrVdwAPk0OJEbyLPAwVpeDAyM
 NRFkPQmIn/+uVevx/oEZr9fdrteKGJN4CnrGUKrMvuePerWjfs2xnX/SBrt4J6IFwqEID68AeUI
 /b6lBN9tg9snylC0W5VDuwq23hdqul7t4slgov4n4ae0tjJu7xQYBdnDsCpfk5lG/7Ge2RSa+8T
 IdAITNoNXh3puhDt9ibszXuN/zsRtAP4q1x4oRGx9mNz1sVxfq8ML0RAPaXxW9xCvpnb5SZoqND
 05qPTXFBv9stUslxuTw==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d5d978 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=vyRKV1McS8jDwafK7MYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZaLGr1CHOsYgM18nDSkMZNdrVDWoeUha
X-Proofpoint-GUID: 5bLdbNo0hfmNVG8pOW9EFv3CaADoIicD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 10 Mar 2026 16:08:07 +0100, Christophe Leroy (CS GROUP) wrote:
> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> targets") added generic support for AUDIT but that didn't include
> support for bi-arch like powerpc.
> 
> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> added generic support for bi-arch.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
      https://git.kernel.org/powerpc/c/f26ad12356a275ab303d5d3af4790ad94acc20d7

cheers

