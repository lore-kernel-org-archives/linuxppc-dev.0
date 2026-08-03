Return-Path: <linuxppc-dev+bounces-25240-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7ACC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:58:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vB0bXSz3c1C;
	Mon, 03 Aug 2026 16:57:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740278;
	cv=none; b=E5BwNstKZtbYKT/+nsPXyiFd1O5Cy3sLkjmdhlsopjeqTC+v6kuxBNurs9Xr349EKzXRA/vRcdyrB6nmZEoz+07pHqjmaViddopQrcxu3rOVrk2Lfr5GOvX1jzsN0m6Ae/K+rJ/M/nD4viVQ0xp6FOZZaB6/196hLWxa43+qgjSLgW1yXUiv/wZ/8d2Bu5Y/n1mHnu0O+vfAFrg0HZbx4/SQ5ncq9guAUFF89+UXd98hRXuwYXm7yixdi1goRbvE5Iq/2AJ1DsPVP5c4RB82uTl2wxc2F4gdQlc+ryA2tNXL5tUgDOz95LISvtm3SIwsf6IOJ9GQ19MGRLMehiU3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740278; c=relaxed/relaxed;
	bh=z+yrtT3C/PzimWtOw09Fn8IdJCWo4auaJPf5vrhigqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxBJ/COYlkP56abNlM8Vaoe8nDb6gLjak9B8h107DwhUYXAICsusimVpf9DiPZVQSLYBTrjWUL1yhd7fzAzQZmUnN9ZzWiYNuohM7ngJnEoIQdrgfFJ/pg6jGKTINND5WciZDUSyzJBWs+UJr6dUeAjhCvH0IJJTyS9QG+tcpRhPCe4QWqA+vlDFgIosd2zgC6S1WNJ7jR4suh3bO/khDx0OhoSCL9bjo+fe7MhXGHXP8VC9fwFZM3OTOqJmRr/T08KK++1aKNvY+OX88DwPFHv6hLDiwwWiawDTSRjZFlF4Sy+JAnfHHt276fNAp1PcyIz7pjxo6PJB/mJOoCgJFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OztZEHO4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OztZEHO4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6v91RFyz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:57:56 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lm3RA160563;
	Mon, 3 Aug 2026 06:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z+yrtT
	3C/PzimWtOw09Fn8IdJCWo4auaJPf5vrhigqg=; b=OztZEHO46qT6WU2b0BFsGH
	RQTcNk9VcSZmFX5a5e8rUalDfh++BT1CtzydudbSAukG5F442inmUh3w7Aqnu6jG
	TBZhHf9YIi0Cg5nFBOMgAqpeRJL7FcWBph1NmksAd45BepArErx5BYcsnOOJ554+
	/zoHn9GdEV1TBIQY0rWHtrMMJ/rjuLnNUjiiriVMFouQEhZZIKrEjvqfTxmCi8SY
	iOYRd2kc+SpEVPnc50Z5Pbx5liStFhfOuAye8cv9eoRk/9CCm3L2XDZRA8zHHz1C
	rBvNUF57RVKU6N+N26zTDsTuj7rc9VUmSUczv9KxFDVoo2XPVqlMVGK6V3B87Z7g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hf9u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736ubhF001129;
	Mon, 3 Aug 2026 06:57:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh431f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vfR831260966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05CF52004F;
	Mon,  3 Aug 2026 06:57:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FE7D2004B;
	Mon,  3 Aug 2026 06:57:39 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:39 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec_file: use snprintf to simplify setup_kdump_cmdline
Date: Mon,  3 Aug 2026 12:27:38 +0530
Message-ID: <178574013460.29744.10953133203759637745.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260527000105.1081651-3-thorsten.blum@linux.dev>
References: <20260527000105.1081651-3-thorsten.blum@linux.dev>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX2yJem34nO9uI
 Y0I8t5Kw4agMH9JN2vNh+0GZRMgY55VxWWJK5XVdAmVVwu5YKYPb8OwFpzf6/MsPmZH86cROs7n
 eTN/V9M7cecG+3SzQ4+tP+EvH2M+b24=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a703be8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=aLIGoUGwjfsx-NHJVzwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX0+phBrWd099j
 jCeyIAp98txP+yakChkIiSZBmRgiQabDxfCwQUFVXB4zMRUVSE6vxIYLljseAqBjSBBGDMW4sFh
 WkcxNDeZmBak/r1+59BhwFQonaxVOsUOllHRR714ImLnqEKgqtp4y/LV6CR0ef88KEEw4gPdiUA
 fhT2xQLAZYYpSxP9KWD6gYzB7iQSnwM6aLF0Us7J9EYtkb8GOpEy0aDzSGn/fV3yrcEOLTwgGoa
 dHZWrQeC/BxQu1sAefhjPCvIlmnrWxH+DQOtLZMKBy5Q50NQmst0LHWvBtC1BvgNQmpJAtQT00p
 mRG55kQxIhih2zL86i+skcBzLsF6UUoaW60yBi0kzf4Qz0wYTEGpGbiH+oa7/UWW8U4gIB6u4Qd
 HzcjbVM3FYd9ghwgAsxGvUoft0UI5OHF+0HyPcXW5m9ID9gL3gygpT/ScrDNGbDqHnaVllNTv/I
 R0eeodsva/+0UR7Vk3Q==
X-Proofpoint-ORIG-GUID: EQCUo4zFscv4NJ-c_taAqQX3kmXzoKU0
X-Proofpoint-GUID: K4JsBW7Mi3ESOI0l08_Umco8znhBjCFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Wed, 27 May 2026 02:01:06 +0200, Thorsten Blum wrote:
> Replace the manual string length accounting, memcpy(), and NUL
> termination with a single snprintf() call to prepend the elfcorehdr=
> address and to detect string truncation at the same time.
> 
> Use kmalloc() to avoid unnecessarily zeroing the memory. While at it,
> also use "prepending" instead of "appending" in the error message.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kexec_file: use snprintf to simplify setup_kdump_cmdline
      https://git.kernel.org/powerpc/c/dd6c80abf46a966f839fead7659bda05f80e462b

cheers

