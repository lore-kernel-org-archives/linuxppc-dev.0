Return-Path: <linuxppc-dev+bounces-25057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE97C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:42:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dPV6zbMz2xwH;
	Thu, 30 Jul 2026 15:42:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390126;
	cv=none; b=W28yr9Toa2szF3EJsgAAP0YG4zaHr+VwSrrPPInVa/mozJnYAYmV3+gJniV1TPVvBIAcn8OPK0bprRLSYUEkvM86eGFkeXaHyHO4R4hCinOzOaCcIKFIAC2mC6/vH4fg/YhyZuD1UzFEEk41mmPvRLQexaFjxxWvHvUIyWiHKyXnzdLcMIREzWqaFINzm81OkiKndb0eLUb/Owm9QV9B1jGy3X2zpoQRoK/Rj/aYRZexppZlaPxefVA7Zv1H/8DXW5lTodIW8qRXf+d7JM3sw4XO1yN26R6sJKWClLizI+lSjqBAf//7H6J7zo5xB5S3EeMhv1vgE0nchxZufQvK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390126; c=relaxed/relaxed;
	bh=xn62JlP95pG83+cOFOdzXlHAatYXdJAD/8UPlPm7O2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1r8iczNWfGZYqOI58gH6X1hMiZ4lYusT/qtnXLVD3dtLsaLQe5iBzCpnuMnWYHlWJNyEl7iSl+B66tUBr8eNsPB1RAgR6Sapkt2aIcV3EjDJ6peT5lqZ/PYkRgtMGWqwYDvCDafBUVUasIf8Q4192XpzYK/r8gNGBO/bGhC5xO4l5CgOFdvxyzAVM9XobRiMU4HkDKVzmHTmCAwcT7E9kDkuqATYuEOi4sZUYbHw09fzkOOH/2pO5SewZDSbG6FPv2zvBgheaIA293ggifKhegRucmAYG5fWyBiABKIYdmWph1lbUxZy8wY/9EO5dWcZWLqz3wMqGGZ6QRagN7Dng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EZA1MpZ9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EZA1MpZ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dPV2xHfz2yvX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:42:06 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3leSB037583;
	Thu, 30 Jul 2026 05:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xn62Jl
	P95pG83+cOFOdzXlHAatYXdJAD/8UPlPm7O2A=; b=EZA1MpZ9dPVx/3BVFmrVR+
	lByQ6iA9WkR8hB+iH8V04SCmUD1AL+K01xin/htTUCVcyfaigsKp7eqLSBgqRZIj
	73xvCLANJFcuswoxe5O3cq0rj7jxUh38pWfXsgTuq6gAg2guJHAwVAhEzjotHV7C
	BphYyGfn+GdENzzaCciWnWjY5/V864dUOZIev9BF1SbADnLBT2idUrXhNUPQ73ym
	U4nAODsgyiju1PE+y3j3F6MOvwjAQb9DsmOgZ9H4LTl/FSqNOGXzNiKRi0ChnGYA
	Bq4v1dqF8TEHB1mnBHWn7yODuQDZM6KK26xE9gFeamOMqJIP+FBaFwvPXVXRXqMA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycp49x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fKta012972;
	Thu, 30 Jul 2026 05:41:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk9xgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5fuNm52691382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 153FD20043;
	Thu, 30 Jul 2026 05:41:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 539EF20040;
	Thu, 30 Jul 2026 05:41:54 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:54 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/pseries: Skip vpa_init() for boot cpu in smp_setup_cpu()
Date: Thu, 30 Jul 2026 11:11:53 +0530
Message-ID: <178538948384.1278583.1321591910444981709.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708015842.274690-1-vaibhav@linux.ibm.com>
References: <20260708015842.274690-1-vaibhav@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GWGd_aQe0XF8Z-P15LmwqBLRLP2bPXmE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX2AuvdhrXdOji
 lfyJeraA3BUOaLrPbmGWmvY58wS+KeIgwZsaZ5+XP+v3LNKzz6kg8RUMS0BTqgC678WzbHYfMWJ
 VjTO+B82yNo4nE7gtSk6GlZJiaPeBn2FaunOHt1fqJ7chN/YLzWkndxhb4s2HjdX7dysGWl4+Qg
 gfhkJ5/KG0DWzRcAucX32Rgpwdmu1IuuFfjT7fJltftSkxDSQVe8hxQO8nXIrGO+xtyfsEnLm+D
 T/a0ka5CAwkrYSEE8FOFQWiL691NVFt/SRnGy5bOZa8BaccLlfrIDF++JSp7ltoWruBLsjzUPms
 AnHZqcyWaYjTOEvs8LRyKJ2Tv2VtlC3Shj5H5RACebYiIOzJdWrGDW3FdEB5SyyUWQHt81sQ5A0
 OuEiYXuI7yX6tczMac8BSgHVeen9HxiJC5xlBtCVLaKGFX/6a2G0VVJP5ixT3NJpCNArx5FzQSb
 QZQYOA6RVIcI2Tsbl/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfXywsyzZjREOf5
 2EoMgmIBZeIq9yOa+Z/6xClO85VRR28qilE4Zty7+1YM95R0TMT0iMYD4oqLFyqyuU7UWjM/bfU
 NWhs6ixotRLgpgAwq4ryPsEKHcR1gK4=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6ae427 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=LOVXTl4FZXIr5lB-pgUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GWGd_aQe0XF8Z-P15LmwqBLRLP2bPXmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Wed, 08 Jul 2026 07:28:40 +0530, Vaibhav Jain wrote:
> During pSeries_setup_arch(), VPA for boot-cpu is first to be
> initialized. However later in the boot, smp_setup_cpu() is called for
> setting up VPA on boot and secondary cpus that were brought online. This
> results in vpa_init() being called twice for boot-cpu and three redundant
> H_REGISTER_VPA hcalls being made to the hypervisor.
> 
> Fix this by adding an extra condition in smp_set_cpu() to call vpa_init()
> only on non boot-cpus.
> 
> [...]

Applied to powerpc/fixes.

[2/2] powerpc/pseries: Skip vpa_init() for boot cpu in smp_setup_cpu()
      https://git.kernel.org/powerpc/c/8f45abd50aaa4155a72ec539f371dafb039786df

cheers

