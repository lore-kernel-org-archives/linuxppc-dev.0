Return-Path: <linuxppc-dev+bounces-22841-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63227CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:01:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs3f2JHyz3c8Y;
	Sat, 20 Jun 2026 08:00:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906446;
	cv=none; b=f6L14FIyblJJT0ZPHziGnlTvS0kLh3VqRLdQFepNBQO0iXAWL6XPhefhf09aH2XXWFY2UB8kvYmClF06MCSYZ4ezpGMQE2+8IgeiAXl5corZrcf5S7kHs2AIYQJvI3waLnka5VPqXf9k+Jkq72KwpnEdKgMN4YFUiJvfh9rM0XrEXJ0kAPcfzGRwSYRHZUcbWkprwUw33kHXO4rKOn6nslJ6Jf0GLfi4tKG4TmG6htQAFd2IAwwxOaX0hYxr5yF8b0qP5OryMfOV2o9VeaIdp3I3URUd0AYbhYYKy56iDMFE9Z7n04uE6EDai9xav4l660AV8SnK4GCLO1ddQe0z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906446; c=relaxed/relaxed;
	bh=6JvhwxNEfZ6gCtsUvw57xzECc2YIuK8sv9ViE4Xq4nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL1ctVaUczUUeVXs6UyD1QOD+SnKRC6qkWnZunDQH9DT0rfYuOpsbRV6viaDDNOQxXC7EXUTsD0iAqyID4eVdtEhXWAldIiGmiu41Xp4gEa6QPjV0lF54RrrV54V0AmF1vtVTX+YzZSfHX9N50p3ff50l5JoubAjnJ/TaekewhqXoQ6oGGOEKwAeVKqgaf0rWp+XPkdmLXOpFPpENEX+ufgFAC+vGMTmY8dRONBPPip58K1vdHuKpTTKrYq+ccaReiIyTbR23+jYH2YGW2Iz5T8LXj3RT/LwfyUs6go8gwhIjN3xnrmzFF5EQoGu5/gNCp44BB6+0EhG1gRUaA15Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jSBnQ46l; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jSBnQ46l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs3d2Vv2z3c7j
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:45 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmukd3392975;
	Fri, 19 Jun 2026 22:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Jvhwx
	NEfZ6gCtsUvw57xzECc2YIuK8sv9ViE4Xq4nM=; b=jSBnQ46l/lo3yUAJSb63kV
	kySmryxAZhlBZgbBAP7qQKc+ZuHvztDdY4BumyAR+H5YHTTyBgFziuf/RWpPPue8
	N/5ZVATtDdPW0j2p6uJeeiEQt7mPLHxhiXzq64Ku16OWCSjSUeG2fbs68BLFx3U2
	Peu+hhJAAvhBAvOJd00gKifNJQsa8oWhrZjP4l+jh0Ihgb7h9mSLZCdA2gUAsJYX
	/IzvJcstTEfmxg+69yVGLsRA7KD0eMq2VKJpldsn1wSbjyOPISckoNZtySDi91q5
	Sat8BHjQWhfWAxr02kz+m5gqi5gY7L9JiXfucm4QD2IpZYyixrTCkqkP/uFOYjIA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxqeud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLngnW007540;
	Fri, 19 Jun 2026 22:00:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM0TIk23331176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E25472004B;
	Fri, 19 Jun 2026 22:00:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D618D20040;
	Fri, 19 Jun 2026 22:00:27 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:27 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix indentation and replace typedef with struct name
Date: Sat, 20 Jun 2026 03:30:09 +0530
Message-ID: <178190618801.653308.14450344238070105745.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20250517125834.421088-2-thorsten.blum@linux.dev>
References: <20250517125834.421088-2-thorsten.blum@linux.dev>
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
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a35bc01 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=D_91MgoWmL2N8UOGbAwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfXy5yc4h6sQ06f
 eowuHlACK7aLRcLFlwuqhOJj3WgTR39pYJgGH+6gzYVHciQwsEu96hxvCq/XCTsjvAOI/i058On
 g8TWAW6HXB620UftJpPzakT2KcogW9PRnMrP+1E+7rxP/RTxsYdxZLJ2asqSyRG0vHwJZeSZ0sR
 kmcCaQRPXYOrbmH1l1tHDuszAOQHYVrpkPMYNeZM+TrHYLk4Bs1ycmb5zFPB5lKHaQgkbG+HDLT
 PrHGXcuZIZoYcR7mmuo6Ooa/RlVjihts13wKygx+eef2+tP1IWgt5vOhB1c+3YWotrIqis+/zhs
 M4pJ4ZblGcqo0AoHD7U2ppQXcSlp/ESs2jteMqls/LYcn/sAknYHwk/lxvvMdYiZTSqXaELqwK/
 JYXQlXn2GZUH8Hf1OXkKNqHh1cMCPumFvfpi3EWFtPMkwrQPDWh2XM1Pd4xDbEU/OwjvIdLpQeP
 dCXIOgXJ10pSHxlSrwA==
X-Proofpoint-GUID: tLiRYjfaL66DHext7jC2_bYR-pvi5OZf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX/o6TdK3rV6uk
 JIMAKPqwhvGZ4yWnVJ1BsDSASmgGp+znaxA7Uic6AwY47Q5XujZpfvYeFFB/rOv5st21ds/sSNz
 ot3RKUEoafYG2/wwzdzKgDvJYm9T5jc=
X-Proofpoint-ORIG-GUID: ON0lEj6Em-AACV_sbrszWlfe2uJS0Tvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Sat, 17 May 2025 14:58:31 +0200, Thorsten Blum wrote:
> Indent several struct members using tabs instead of spaces.
> 
> Replace the typedef alias AOUTHDR with an explicit struct name to
> silence a checkpatch warning.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Fix indentation and replace typedef with struct name
      https://git.kernel.org/powerpc/c/457cf3d00dab71b7e74603b6ee96e13c51a8fd3d

cheers

