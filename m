Return-Path: <linuxppc-dev+bounces-22837-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C9BCD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:00:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs3G4nmjz3brP;
	Sat, 20 Jun 2026 08:00:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906426;
	cv=none; b=RH/jN7ptCFig0n+tD5Zfnt00AZLzTuuS4JleywCLKA/AAFDUa30Ek9Bdfmo0TA8JF4BKpIlPzuPl+s+Gm6x+Xdga7jJ1hw53amlLMZmsimk0xCDJaaipomLQYw1WjZKXdEcI2tvzfc5+hqnaNULoA2GSu8jhnrnlPtYCgyCTRvgAtBIgDGaAUNPzA/pgArVwEsQ2aSh8rfC28nPy9bsBclJIe6ej2ODglS4UdCWq/vJbFpZzyDfotDnosEgQ4Vds4BUHxUv5rMBfEkDiXcw+UJm++kzIjEBpsq/Hz6XUcSs2uQA6r/IEKGJ0pXZnd2eQ3JOPIRC5muojgYcIlSJF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906426; c=relaxed/relaxed;
	bh=GpoSEyqKaD8ZLvB+cVT/5tmo+mNZ2dOyixjwGWVvvA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMJbwTMipT8fWxGPUCnge7WaT0zvQqjdg41XXcpi3guSU2nB9q6zcdHvPr/S6We3IMwlHL8CDUB6FvsZsqkDzdIKkRMzgB0Fg/q6Xzq6toz0HkFoKVwvgwY5D0Oqe+npYHTXE9L2i7e3qkJUDntzqYa8KQBKH9HSAjs6s35NdvPw08whoFoOlkQu8b0nz+fYIi4IcDSAs8/cMUS6BraGpxKO8tyD/5HCy/n0JG7eAgmGVmj7H2jW24T/CMq1R75G1MCDOnDoxzVoP+XDi+3BJLE7EBr7fkEJBKdtCJUgFtStTW9DBLBRBJqYv1VnqDLnxUdgMq0qI7+GhcQ5xiVq7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fpPFDQc0; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fpPFDQc0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs3F62cLz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:25 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmdAb3358195;
	Fri, 19 Jun 2026 22:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GpoSEy
	qKaD8ZLvB+cVT/5tmo+mNZ2dOyixjwGWVvvA0=; b=fpPFDQc0d0fHdTpqKHwg6f
	ipftq/EZ8c4jsAFn6UQ6MevX2IpjTPI1Iy7YK1bnEpxV4KKmfAwWf7yeXfDimYNT
	qOc0ICKHhHOR/DyFPOhQ0MLiG3BbINS2jzs2+jIvUV26JjZhFhipuDuDdu84ptjh
	EpIzSklU8flfDtDO+tc7da47TOT3gMnnEoPDhKM1NjRWuOGu8Z8japy77h07LCf0
	LVyg8B+PUo8iQqptbNVhygjruzwUHmqEWSMCgKXwIGRk2nPeGd73H+uuJEwgX/CR
	4QIISU1Mn+P9KcYOdmLImzj3BvgB15+4Ocle9mg6daQWDR0gIcy5MeXsSZbvoP7g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxfg5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLneP1007534;
	Fri, 19 Jun 2026 22:00:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM0JDY50921798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14CB02004B;
	Fri, 19 Jun 2026 22:00:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 422E220043;
	Fri, 19 Jun 2026 22:00:17 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:17 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: chleroy@kernel.org
Subject: Re: [PATCH v2 0/4] powerpc: A few misc cpumask changes
Date: Sat, 20 Jun 2026 03:29:59 +0530
Message-ID: <178190618790.653308.14148704801994865382.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427044715.559137-1-sshegde@linux.ibm.com>
References: <20260427044715.559137-1-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: BvgyX-gtF5SIhA2K--HR9-AJzhYB6BFp
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a35bbf6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=JoSRhTO8oRKzmoEjhEUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX1n8t/XOz5GKC
 RVZj2XDt9p+zLNWlsnUSOotLCexWGJSAkFQN7Z/Z3Ny3EZfRoRekLbyTyiiq0QsdclOCLODRWzF
 Wox3aEAXZufdIQ+YJPIaHMY0lPZ0dzk=
X-Proofpoint-ORIG-GUID: 4CSPSaMg1JWhFMXDR-GZmw-OnV2dGp34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX2aAP2pmNteQE
 iRR83rqcamSF+BSQD6cm5dut2tEloTw6muXRp8FOyTAh/NWdXhjvuKJOuXbcDfbL9S3Z6cwJud7
 VqhV6N42lMW1fAgdhe8pL09hYy+7/gKTziAYYIHbWRXedhIuBh+uCEeuHIFUl+gPQG9PCDIIwBa
 QSLkVRHEruL3MmSeVyIKwEOW17wqGvGOcu6N+P3g/H/ItcjQVgS9+ObvrQhsI1FfREN5OCQNKop
 /F6fcw/Mu/zJ8bKtAxbuyRWPZutMofmBlhceu00YumDhcSy0pvJFyaSUmE4h1nWE1iEtk2DfN60
 3pGDopF6vzWlUUxkDAj+2xnaJ9RsN7Cl31SkugB34BXw3rPUzZFbRloNYCXoJbj4exo4PQcPUmW
 L9RyDC5GOCWqHZTSokf0Bm0fbB37z5FHbOszxznzmEbozIyfCgSAubuAD8FHWK9T7cEG/KxDWOL
 d6H5/SySGPlAARdVUtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Mon, 27 Apr 2026 10:17:11 +0530, Shrikanth Hegde wrote:
> These are some miscellaneous code refactors around using cpumask
> APIs. They are mainly aimed at code simplification.
> 
> Changes since v1:
> - Dropped the changes done in xive_find_target_in_mask. Those changes are
>   done by Yury Norov already.
> - Collected the tags. Thanks to Yury Norov.
> - Added new patch to use cpumask_intersects instead of using
>   temp_mask to achieve the same goal.
> - Added new patch to print the warning when target CPU not found
>   as discussed in [2]. This patch is kept separate since this adds
>   a new warning in case of failure. So one may perceive it as functional
>   change.
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc: Use cpumask_next_wrap instead
      https://git.kernel.org/powerpc/c/1ca0c82bbc72e8e3de0a41e6dbf92473c00f3d1e
[2/4] powerpc: Simplify cpumask api usage for cpuinfo display
      https://git.kernel.org/powerpc/c/a66eab7a5d7decadad51b4204c6f2f0d8cf665d1
[3/4] powerpc/perf: Use cpumask_intersects api for checking disable path
      https://git.kernel.org/powerpc/c/1f8986fdae91880411a3be907879ba63973da100
[4/4] powerpc/xive: Add warning if target CPU not found
      https://git.kernel.org/powerpc/c/0521dbbc5710aca3b3d189747781761732289623

cheers

