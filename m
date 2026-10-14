Return-Path: <linuxppc-dev+bounces-29471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EB0CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:15:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4QXN61Z2z2yLY;
	Wed, 14 Oct 2026 20:15:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791969316;
	cv=none; b=bWAbhY7ZPpcelJRvpYI9p/2qGp41O+7U3Lh6Igr2AiQljufKYTqKuz197D+bQKGNu1lJ1v24w+xfoAU+YGaTk5gXgXDLmhTeJa8EAfRBatf1Q223EN8KaBJ4LXWTtl4iE71SoQV+a3RHwmTi9jTitjFPEl/KNqzy1odQJnFO6RkPGx2gsMa+u5YJoT+RvUrhkFwifWQl8NbdjgA1OixnI+CpY4JzSrcpKepbfoS0qXoQ+rHnZk4rt4lU6Dk8/U/NNoWxTPh8s2THbVJkaTdLh82xuwI4eRmd4Ez3+z4R1eapC71tED5NENwaXOXFHBsQ4260yL8AzcUBAxR+RKlyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791969316; c=relaxed/relaxed;
	bh=qG2pg4CVbY0VZfvfcouD2jYA6Q0xOYzetAscMwwf8TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM+vpTrdpzfCTsYiOg3Jy9W4l7Gl6sef6UT0CjhvfWxKu5/sQK8j0GT62dYbnt723fU0otadLjlPZyGPX6R+6ESObNDqh9f8XI4CJwtF2s5VqkFDE5NKMvsUR4/XT/ibn2du0R6CsdClQfSNjoafisJUGI7hfhyWkbFJ8HQheeLuhPqGlW9KIG6p9NnV5JbIGfiLNQwVvIR2epumf9Cj6NxmeGrk+yQ8CK/FnDUSaOBr/GIO0Cgp/968CJ0+1lWlg8nhLkjraFs4LEc0p/+CXrOsYsB0jZlyZiuTa9Q8dBUp0nKj4V3zWN5OWefGNIG0erL+RZ8Ss4XTDCXBHVXqBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eRG0QJX5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eRG0QJX5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4QXM5xmSz3c1S;
	Wed, 14 Oct 2026 20:15:15 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DMqImX149837;
	Wed, 14 Oct 2026 09:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qG2pg4
	CVbY0VZfvfcouD2jYA6Q0xOYzetAscMwwf8TQ=; b=eRG0QJX5+TesohEGnBUhLa
	Y5djPpItxa+wK2g/s1MaREZeMbQg0Hww9wAyX21jze5kRP+OhFLtjxCaj63j1ZcK
	6ubuHjaR5VF3rlvSGr9cbVrd6Q9Qnkg1luVZtyMJf4Iq4zyE4QKoUf1VZnu5T+ov
	b13y4uLemKaLgxZDEFDfrolJlxk71av72Bti+8cMcBY3Zd/9Jv7nB4vuqzTuwmhE
	iqRU9f7lUiqTMOHMucjgTOh4U7mBZJZ7LrIFRxhG5zKKaMk0TMp7I5O2os4lmGDE
	3OKBKTfezRsDi/rAtDUEIClS6sxRUpGKiy56sSVeeHz31Zl9E9QKqed7uYPa+aqg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhkghb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 09:15:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E70NCR2709289;
	Wed, 14 Oct 2026 09:15:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h6kkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 09:15:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E9F0OO44958092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 09:15:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B42120043;
	Wed, 14 Oct 2026 09:15:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1719720040;
	Wed, 14 Oct 2026 09:14:58 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 09:14:57 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, skiboot@lists.ozlabs.org,
        arbab@linux.ibm.com, mahesh@linux.ibm.com, chleroy@kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 0/3] powerpc/numa: Enable coregroup support on PowerNV
Date: Wed, 14 Oct 2026 14:44:57 +0530
Message-ID: <179196918696.1557523.10826364523042103006.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902123458.340456-5-srikar@linux.ibm.com>
References: <20260902123458.340456-5-srikar@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX3t3dWDd+/Yu8
 bRYiLJQJ6UlYXBRMrmsQVdcG2PcSq/2VScId2ASXMZ1JjthPxc4lsmOlxX6oKCSyl5TmO9kN5A6
 mt3dLM1GRpLHyQVLG+Uyk4DrpKAaiAA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfXzj0aTXyOsZPB
 Dx4zVkLGrMK8yCimPpbiJ6XL1X8GLqw9IWMdLi100yjsySP8kUP6vvbsLGn1ZwDI4Lfrx3D+1xU
 lmKMN7nZqLzT12MoIw4RPdx4nVXTELag96Y0WDxs1bVStwBpDwzjvQ7W+OsKEPncukt7UYhP/p3
 nEfarp6B64WoN7FeWTIfQK0ORkqCW7mqUsPNw4qPM9eX/79nWapVMYavrMykeWbG3mxXUNBQIo7
 Y/qwXTAw1unKQJS726ud1WRGCuGBgDqhpzNO9azEZywbfiR8fWDarhw7PU6Ffi0melBUP/2OCnQ
 25hobpEBMK/Y06/Z+npcu523f8Un1qs3ey9q0C0HM3THQbgw1lc1hvkqfHxGACIEr1LSAxBMHON
 2wuNkMcEWtWAP8yuC6a7lbc5XbbDkN8b7n/dlaYPW2jfBorfl/7Kndu2bTFqU8POHqTHgZpsxag
 nXQSp3zHfwMZOaZWRaw==
X-Proofpoint-GUID: lmZwaDVKf61yfLc2a-ktXgwTGFx7_ttN
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acf481b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=gZoKHcpVvol-cTOXeyUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -oRpEdUXAuHESLSPtvchvxcCjEvgJ9al
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140036

On Wed, 02 Sep 2026 18:04:59 +0530, Srikar Dronamraju wrote:
> This series prepares cpu_to_coregroup_id() for broader use and enables
> coregroup support on PowerNV when firmware exposes the required
> associativity information.
> 
> The first patch cleans up find_primary_domain_index(). The second makes
> cpu_to_coregroup_id() available outside PPC_SPLPAR while preserving the
> existing fallback behavior. The final patch detects coregroup support
> from the associativity hierarchy and uses it on PowerNV systems.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/numa: Simplify find_primary_domain_index
      https://git.kernel.org/powerpc/c/ff9d9df1deb10c657ff00fc7b94f154fb4552721
[2/3] powerpc/numa: Allow cpu_to_coregroup_id without PPC_SPLPAR
      https://git.kernel.org/powerpc/c/e18351513a8e7ba08d9735056864f0c0095676d0
[3/3] powerpc/numa: Support coregroup on PowerNV
      https://git.kernel.org/powerpc/c/129f5d395fd66b6587a5ac156b232cca060d6512

cheers

