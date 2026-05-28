Return-Path: <linuxppc-dev+bounces-21628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44F3CD6E44
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 10:26:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR2j46tFNz2xM6;
	Thu, 28 May 2026 20:26:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779964008;
	cv=none; b=kyDdXYCy1WsKMz3nRsJVjogijfUSovSmvqxorqXelHXiCH7R+wmH2yffInkO40t6BdN72FrZW517cHOoc89bIjORyoxkgqIm2eWJ2KtQhrV604xI9EHgCnQeeWJB/KexlQJ78AJV92DIvpwsX28HJKNKeUm1gWhIMXxrMl9EWhncBc3f/4QhyMWpjKlZ7WcrDRmZn/9OBBgP85f5sf4ss20ySe4IdY/Dljhjlm/icfHkrRgFrYiL5NtNWq5fRWidvN4Vm1+EKpN27LNkFjoG1uqwlkmIJg+I0BXxNwAVPLqUVjMT6YEHcFYv0V7mnCYkgJ1F22DdjwGRkMnrrBHfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779964008; c=relaxed/relaxed;
	bh=+tWpfce2jppdCOF7t/epObAdoCgY9GtXI7jXzUkXwto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awCdlJmtco6CX5reUXfC4I5fgGvdSjNcZED6CnxU8Tws0rWMeyvRqzGen7+pMwK5dosxDyC6nvludkBu2PMQK80azHOWzc8PlPSdhzgaVCfF8DsxJFc36kAf2Q8/1B9ilyNlDVKhdqReSgRoaqRu9optKJJzyJ86j3YSuIn9jMYao6VbI5F2kGjuXkRyVJMzm2slY7gxpSQxWbLLknE5nZOlz+d/738HYU5XiZSP1xSHWi2d4my29Cu6/4oxFf+W36Zr4mc4GpUs8aYxvrZo66UrUzNm+5oLJR0yLbtj05ZQ9me6AeurBFV8QSX2Shzd5gm8ULvd0mffMjSFfr3Cmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BwNQWyhm; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BwNQWyhm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR2j33dBQz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 20:26:46 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL74C52479745;
	Thu, 28 May 2026 10:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+tWpfc
	e2jppdCOF7t/epObAdoCgY9GtXI7jXzUkXwto=; b=BwNQWyhmTJ4epesyh2VjEV
	tLMnIMuMU50mdkvMSECUmx/NIg6bzQn6PZ1x0p4Lvafz+cBg6SkI/l2Jr5l0wFDC
	ZjXgjCNmBodFjphg5qDE6nploGDBBgp+f4VVwiUK+DSJouXZiMEmpb4c89atilJN
	cGM0K2VwFB50bOfvKSN+ndpGqmjH6i2/9DBh4Z5sdwrbJcc39Hip8SGw4yrF4H61
	eYy4S1W4TJO5NzPP0BvCHU8FJWKWylXXXdWTvfI5PDm+AAIASe/Sh5wg+FRnNHxx
	2Ueio2c+pSSo9l6wEqqQaobyEtpqxADiun/wgXb4N7ACmcxBFOI8nDNuLdL3NCMw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886agc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 10:26:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SAO4ac009104;
	Thu, 28 May 2026 10:26:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb7ky2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 10:26:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SAQRTs31916446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 10:26:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 618B82004B;
	Thu, 28 May 2026 10:26:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A8702004E;
	Thu, 28 May 2026 10:26:24 +0000 (GMT)
Received: from [9.39.18.196] (unknown [9.39.18.196])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 10:26:24 +0000 (GMT)
Message-ID: <a4d3703e-45a8-4f83-b854-14dbd0e62d1e@linux.ibm.com>
Date: Thu, 28 May 2026 15:56:23 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: srikar@linux.ibm.com, venkat88@linux.ibm.com, maddy@linux.ibm.com,
        riteshh@linux.ibm.com, chleroy@kernel.org, tim.c.chen@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sched@vger.kernel.org,
        kprateek.nayak@amd.com
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <ahUogeqIq5km7JSr@linux.ibm.com>
 <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
 <20260526140856.139657-1-yu.c.chen@intel.com>
 <d45877d5-86f1-4581-b3e0-59ceb722de3a@linux.ibm.com>
 <912676bc-230e-410f-a5fe-153b0f304aee@intel.com>
 <42a19577-fe56-44b4-b0ed-37cde6d03ff5@linux.ibm.com>
 <508a604b-2d30-47f4-a63c-36778a1d47c7@linux.ibm.com>
 <db443a1e-e6fc-491c-a38a-1cafc8e674cd@intel.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <db443a1e-e6fc-491c-a38a-1cafc8e674cd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N6F-va5WaRm7rOm09yaB4AlgUfaGRU50
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a181858 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=YXovZx4J0gVKFteh5I0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwMiBTYWx0ZWRfX11tSjyO3F1tM
 XsM1wFSmj5bIJL/kYH53WxeSXG49p8p5+NUCodl4Uz3lCWXyWAK2nHa5Iu3TM0j2cwmaIbOUYRs
 DziBcNWL7AXZz2/SOq6bqafQgHjUmgB5BsLEtL9sTHw2x89z4zP3fhtqPkiPdyKlBj1qZ+PSgBw
 trSv/jOBYAAu8hrXIhv32UbZu4oaIx95rIX51H98Wrlj0IW1uClr6cgHExjpqy4/K0TVeS8cSyR
 DHsu4pHGO3ignbVQ8bc/nE94wYgAXjqcHVCyqxl9hIYPqnEdZohSUp7eHJWtK3+BbcYTkPcSVQ4
 /3bZXb8UL1fgVRBGJH86AKG97Z03OA+OftOO4P8DEdeZ3hwSMy4U/qCOLdijh/b/4GEOv4MJdRn
 4T/E07KzLA3oz70YM/svXnYZ6cv7KhvbQErUVYInZLD18m/b/jFF7/8HF0SGiqCso+WFpKCKA3h
 xWsMBya2XjCEku86HQw==
X-Proofpoint-ORIG-GUID: N6F-va5WaRm7rOm09yaB4AlgUfaGRU50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280102

Hi Chenyu.

> Yes this direction look good to me. Regarding the arch_llc_mask(),
> how about the following per Srikar's description
> 
> const struct cpumask *arch_llc_mask(int cpu)
> {
>      /* Power9, CACHE domain is the LLC*/    if (shared_caches)
>          return cpu_l2_cache_mask(cpu);
> 
>      /* P7, P8, P10, P11, SMT domain is the LLC*/    return 
> cpu_smt_mask(cpu);
> }
> 
> thanks,
> Chenyu
> 

Yes. this is what i was thinking too. I have the patch, let me send it 
across shortly. It is fixing the boot panic for me in SPLPAR. Hopefully
it should work for others too.

I will send it as reply to main thread so one doesn't miss it out.

