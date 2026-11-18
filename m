Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA8606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zu4JiESS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTkvG73VFz2yMP;
	Wed, 18 Nov 2026 12:45:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794966330;
	cv=none; b=kWkSWjp3ui55UjyXLuKSHj948IO0rVYThM2gzCXFahCVDRe+moybSC9pd+M6uiorh0QPZKXyAP0wS9UwxNM7IR7jJy9tSrkuWurgxtA5LMvHeZp24ZYLfKJo65NFoyTtKSQuL+2ChJZD88Kuu3aGumqjN+0R2D/yBcl5jiEaJ3BolEWCHcTtMe5N4qr4OwjqeQp/WMSZkN4IWvwINMIgKONFplycPsszrBmxxPLFFlBUcars39FMQzcLSAINYWpm5f/UQssiHXcGtgjb81RRegYttiZdXqxEEkkSRvoGvbC1tPQpEzq9YGjRcPmQtpNS8VfgxHUAUG23ChpwPJatQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794966330; c=relaxed/relaxed;
	bh=gPzGy5OrlM665pisJmXWybF5U89BI8P9Fwv7EwWKvKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXvGXX1KGovx3x/MBK16Z9WhPGJMNuCE3KNYTh7bRlIsGa4MD2csvxZXS1OepjHxVfAoJYGoZtsf079mIfbgtpzFYUtYJn5I0SEVS6RR/Uyf2PjfpNMS9fBdurlV2Tx4oVdSqyuwo2HFgvYxaeaUPP7u4C/4PuJzOXk6bIVATVWTn7Z6PTR/094dd37p+8827UEdGupoerTNKrQbJiSabWRGYBRLCRKkc9p1/HlLP37JlAzJI5i9WZfJCIMmuFtHq4iLbPWLqgVlDtvL3TCJvadOudcxCoj+POyzWkSKy1ZZxWbAh6s8JTG9REUYD1R3IIFOxYEAq9kdNDUAV9hcog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zu4JiESS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zu4JiESS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTkvF6kVwz2yLg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 12:45:29 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMv9d33642029;
	Wed, 18 Nov 2026 01:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gPzGy5
	OrlM665pisJmXWybF5U89BI8P9Fwv7EwWKvKE=; b=Zu4JiESSu9ZhszqONLgY0l
	eRIM7lVdh+3wq4wTv3JGG4p38OOi9ysPN9+CHTYD0H4J0QJOGub3dxDZQw8VoHVt
	UhAS5eSqZuTkIGGSx/7kSSD7h9ahTpsWw/a1WF7FK6RAij3mgOkEYS0/4e9BY9kj
	wI2xODIRNlQ1Igqey3hPLzT+5WGm+vR3jGBCgRbVBjbhI0CbpUEqjE59tZohIa+Z
	hxCgwx481Lgk1qVbYtceu1lZN+IMe1DR+YeeiNzVhb3c9ONHFK32Lv6zYfvhe3ze
	OUKzr6U/BalWceqSH/S5qasicHwdqFREj9ZLR3oygou/QdYwjTpnB33zhRYgJ8Dw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t0d8c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMo1D92234523;
	Wed, 18 Nov 2026 01:45:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02juedjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1jGZM50659760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:45:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2DF720043;
	Wed, 18 Nov 2026 01:45:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC63520040;
	Wed, 18 Nov 2026 01:45:13 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:45:13 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: override EMIT_TESTS instead of the emit_tests rule
Date: Wed, 18 Nov 2026 07:15:12 +0530
Message-ID: <179496619903.633156.4835349727978199526.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261103232307.1924618-3-sashal@kernel.org>
References: <20261103232307.1924618-3-sashal@kernel.org>
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
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afd0330 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=tuqVzCswFf30IZH3a70A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: W4-zoXmF4V0X4aYitghopO3HJ1UYWKkR
X-Proofpoint-GUID: LrjlwOrn32g6fXNVAhra2KfaZ-GEf97P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX0HFZaKchtNik
 Imk8MLkLQGBMTKwuZkPj/FDmeNBVHHKBrdo2qpcHX7TewESlueNsFyGqiACMQJ/X7lix5AjiWdE
 MUKCQMjE0TKCuvzCX+L/FpK/hr9S4rpAfh8I6vU50/5p35jFVhoW4q3ZUxrxhOjIInsIdmlnhlW
 dhqKtGEVpIuHcqGH1o6FtzictfXpWXOyCionFq3bFO0e/ExhJ2L1d/5gKjViuVRobPtukwyIaVe
 IQ2oREtWnkk0vJK3e6h9IAojG6Y3O17xWDmf9y07szd8zqNuzEOVgyhJyUHPljPlv7xFeaxEfVd
 tHsx8KdK1VEnHZD8iLwvc79Z299wFtf80smIomSJdkXdT+wW9ycQayRnn5QjX9fQ0nn4S91hlpS
 XDRlLoSAO4j8OnJTIF016OC84ZHMJ3Nxdb/tuC34CS/QpHwk32RsHvvO2ZAWvnMm0fPyOQnedGr
 Ttyh3wkLphO1h7ToJaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX1n/d0KXW33zW
 e/VUQD/Vf8R3zfdZMoIXLJ+yFonTYj47BK9GIb1/c8Cs+QFmv2Wuvr3tWW+iZyzSY5xIy1/eAND
 4lqJcDryEy5szGQ+5H94AnV8Ue60wVg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180005
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 03 Nov 2026 18:23:07 -0500, Sasha Levin wrote:
> The powerpc Makefiles include lib.mk and then define their own
> emit_tests rule, so every selftests build that includes powerpc warns,
> on any architecture:
> 
>   Makefile:60: warning: overriding recipe for target 'emit_tests'
>   ../lib.mk:183: warning: ignoring old recipe for target 'emit_tests'
> 
> [...]

Applied to powerpc/fixes.

[1/1] selftests/powerpc: override EMIT_TESTS instead of the emit_tests rule
      https://git.kernel.org/powerpc/c/6648db997a0b8223fefbee3b4d5391c0d90d0422

cheers

