Return-Path: <linuxppc-dev+bounces-22834-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9822CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:00:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs2t45l5z2yF7;
	Sat, 20 Jun 2026 08:00:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906406;
	cv=none; b=YV3kAzV0OZ4JimOZUML3pHGHa+PJHo/ET0y8dd3WcfRfmdYGvyiRs9DoOzLcJRVdGl8IjuyHFvPZ//iPO5b8NiCKD2a98w6odHirkPLTWblA5Os309oyT9CrsFbTIID0lcFkByqQLzo9HN6+fyalmJBV5DWlZeDiSMbRzjiG+1BYDYb0Obha/F7yHRjs+YV4/yzndPCRtTCGxyVPAsKoIoCMRnUg6blBJ77h1fLiqnLKD9WXBi5F3PTh+DjT/d4IvuCyUn7CCSv84MDaR4yo5BqpzhYjUcvF1d+/hus4qgCTZ+e+hraYkwPkYksb2d3dh1naA49jeh/VhSHxyRQJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906406; c=relaxed/relaxed;
	bh=1P6ALL33Rdvx7OHFEo8qsaz3m4CsS4iDLaS8DwZULJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5vPNxLgxePrDMsIq40duYbug1bytze56xGjYXn1Vg/e8axlUw3iWuXb0btqepuO14dPVaLcXV6cPUMaPG79z/oHKaxaIn7JKZIhZ0lD0YHe6itj6jZvx3uwpz0QC35SlmceZSEWZrqm26TxU2RPWg21LAci2fGX7eYoJfQ4eVnNv9EUTXlWOvJSzM/fa31yVcoWMXRSPprpi0kWs4xUiou8ywmfvC0ATa1jPHW6GkxVGU0rU5s0UCdtzUUYn1fcyAZ/J7IZH/eDZ1OtiE/GHfeFIRgjUAHofzIxDWhLQA6dYuiJtJUtr1TFYKTQw1C7puQ5TTzq6Q9DRmKfTqL0BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LCIXw9Pz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LCIXw9Pz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs2s1bZzz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:04 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmgph3358207;
	Fri, 19 Jun 2026 21:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1P6ALL
	33Rdvx7OHFEo8qsaz3m4CsS4iDLaS8DwZULJg=; b=LCIXw9PzW/CeER7t/ldOnH
	xVuG//UWP4HNpcwKGuL0qWGa3Th4f1D3Ljd97sAXSTTjv51FE+1KolWHy6DO5M/7
	VK6lJMiiRrPBp1jSmh2AWKKYgPBa5AYrfas1Zk/NiQ6WG9n9j/BenKKmia1ZF29Q
	mX+6eBrf0ZK34ctVopk90tiuJqTW3Xbj+VqSWAIc8Jz7D+ncFquag3Ep4pn1pr3P
	YTl8LGwb+wkNV4Z5vRbTl0JrwkleHH0VI0tEsNLjrrw2EBSlQrN0/j2FVe13efil
	RNWC0YD6ICT/QhdMqbhNbGrkZAlROPkdBI+pinNFeHp3KIjHhUsrcO2c7LLPqxdg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxfg3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnepn016860;
	Fri, 19 Jun 2026 21:59:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JLxn0h57016764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 21:59:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59D4B20043;
	Fri, 19 Jun 2026 21:59:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDBB920040;
	Fri, 19 Jun 2026 21:59:46 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 21:59:46 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4] powerpc: dts: Build devicetrees of enabled platforms
Date: Sat, 20 Jun 2026 03:29:28 +0530
Message-ID: <178190618780.653308.14086216574686034625.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260315-mpc83xx-dtb-v4-1-243849be4280@posteo.net>
References: <20260315-mpc83xx-dtb-v4-1-243849be4280@posteo.net>
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
X-Proofpoint-GUID: YED3CuEAm-Iwmx3_kVZNhhUJMVoIvU8r
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a35bbd8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=N9c1d4F_mCcFyk3_0iEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfXwvvZa1+hNZzo
 Eoo9UwEZWJ7W1HT/ezuRWnoL1H2YJbtwcwo+5o877LeS+/waS0zDXgeageku4ZeokHtwRC+cIP2
 U79ocY4qP/j/AP2/7LZHZgx9FGCMblI=
X-Proofpoint-ORIG-GUID: T4i0-4syPXiQV7MOYC63z3Ig47lXUosu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX4ggJ5TCBzX3L
 iM+fARe44PuhUrVIyvFs42eB/P7TJxlNB/sIeZBSj7Vzzu+z4/dEX7Vuz74UnBBWg1lQStc1eOn
 yhn9MdPlsT2LMj5b/O0Yl72uKiDBSnc/AztQ6hN6IF0UwMtvHUxYUsMAL5Zua6XzhlIuP0TrI9K
 rJ9lGBznD1DRVIiVOiz3D6Rcx2JxdGlt147XbwZdZ7ncr9OVu4oFAuSh/DxS49D9fQPPtCTTRlN
 6k+a71AH8jAw0ChrpGASNxfIelS0XwUmgJ5KBqhXBtLJ5LUkWUQtymAbF4ANf8xqssBMjB+x9Zi
 +6kQDy51YUA2jPy7bODTNewez2LnOa4O48MpBv3JC2LP9Pg82+lew9JNqa4FLSFrV+gzUzqMGPi
 1lgKfLvg51SrqqqqTWWC39FChZJJPKglmlksl7eblgOfjO9ejl4aqVZT7KdEdy+xn6SimotRVd0
 ULEmbjZlcsQmPmo+FeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Sun, 15 Mar 2026 22:45:13 +0100, J. Neuschäfer wrote:
> Follow the same approach as other architectures such as Arm or RISC-V,
> and build devicetrees based on platforms selected in Kconfig. This makes
> it unnecessary to use CONFIG_OF_ALL_DTBS on PowerPC in order to build
> DTB files.
> 
> This makes it easier to use other build and test infrastructure such as
> `make dtbs_check`, and is a first step towards generating FIT images
> that include all the relevant DTBs with `make image.fit`.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: dts: Build devicetrees of enabled platforms
      https://git.kernel.org/powerpc/c/2442f10c6eae63392452ab84a813dbc1f87c724d

cheers

