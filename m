Return-Path: <linuxppc-dev+bounces-28479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B8BCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:47:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvBdC3f9lz2yvy;
	Tue, 29 Sep 2026 18:47:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790671647;
	cv=none; b=RrnZOhaKgtaRf8a613Xp1CNzupB8MbAhkLH5SOYi+LrQvqvPi6hXRWUirHXPf0cv7KIN2dXw/xLum+B1MaOVtRpby2YCE4J1zPTO1Oefc9sdRtmqcpQ6htBN6cRlLOcpDiSdqLfUgIlHjuzsPBhwS3ERFo1et18YUjJsSAcUEWfjUOBh/LgLKYN7uoIoz66K1zxjpQmAhvuV9Hd2b1i13pvrgBCXj06f3YfghurMdxFyXRYfdzR42773xy1eJJGIPz7wRQ/mVP5LMGvb0GlUBkJNYUIBGnNK5kdx9BjBHMSp0IhAC2HpnNacKVUEHg7d8rhpPqANFBNDNsGQfXYjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790671647; c=relaxed/relaxed;
	bh=5lkWUuwevkwC50dei+i/w66I1kJbTdd8b9WkYEPGits=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LHxg2o3I8SIVqRJKoQpITALvrXQ6a4qSYE4mzuATsO9z4ju3WJdOuVZc9rNn0ujyUtsmXC0FXFKeY9Za6qbcene3sRtT+u/LYWRuso7L0oIUh4awOZWkrNGURqg8r7Vaa3Ya4krreVJkp1p1l5IPqxnZ24v5V2h3jdXQoAxNnyUTWjffzDTZlipGqarvn7o5lHixslnIL+W6ctQV+BhOvjW7pLlReT3pQ75fx6j7LeDoOc+pRr9y2tGpiJ6K59R44dUapkm+3LAv4yXwLsX7eTdXy5G3YzegUhZU2z+d37mUnoHGipOMPwmp4yLxxh861jPsdIv7JxgthubwHCGuyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AF/L442g; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AF/L442g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvBdB4gtdz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:47:25 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46SY43038867;
	Tue, 29 Sep 2026 06:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5lkWUu
	wevkwC50dei+i/w66I1kJbTdd8b9WkYEPGits=; b=AF/L442gcakGIBxNRxi/9j
	31ieowDectfXR3esUnXxhr4vbLxco7qmAPedH7UMXH7ikYUzBpgLAmdPuI4ZdfWT
	Ok7QzO1eb1yqiDTkKldIICmBk2qF9irVhupVjxZGelB41zOP7Cl/LMj8Zmw8fzxk
	dJV5SzWp+mTDArsIURxRT/xJWCrHEXZzJMkWmy9UZLDfC9D+1WA7aFds7nOapdS7
	qz1576h3hav+5mO/TDK5J97nBz9uE+OR7VgSaeeLwcqhFH/BGqy1a0HHjMTeYNTO
	PeFiODbtaqDC+z4cMS99Quh7pt92fyqywddS8fB5GqrFlNEf5YpA55914FAKpyrg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt4v5c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 06:36:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4HxX81188809;
	Tue, 29 Sep 2026 06:36:53 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhggmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 06:36:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T6aqrw28377696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 06:36:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28C305805D;
	Tue, 29 Sep 2026 06:36:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CBEA58052;
	Tue, 29 Sep 2026 06:36:51 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 06:36:51 +0000 (GMT)
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
Date: Tue, 29 Sep 2026 12:06:51 +0530
From: jyoti <jyoti@linux.ibm.com>
To: amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH] powerpc/mpic: Fix memory leak of mpic on error paths
In-Reply-To: <20260924145126.cf1c0ae1-37-amachhiw@linux.ibm.com>
References: <20260924063010.188642-1-jyoti@linux.ibm.com>
 <20260924145126.cf1c0ae1-37-amachhiw@linux.ibm.com>
Message-ID: <e3c17fc50f7897b08fbd67a120087467@linux.ibm.com>
X-Sender: jyoti@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: CIq2TmpagxsxTr8j6xP_CZTQ_xyjUbyf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX0C8B/7tNxN2Y
 8z3c5M+RZ3Lxg+NHx69oQaRls4/RbG875Znbvee+3xVR1X2TqvSMooMW4LE9e0k4XH6VQtDs/DD
 5sosVjrb5320h/riOo3ohIdHMCduViWIeHFA0ZIgqm/WGf4ACwO3fJxZwFUxvVzi0FCHQV77Wlk
 q1Ag2u+ZfSxNxGc+hkpLO542Inw/guLk7DobLP/AuPKcykrp95v/UCDA4VP49bOrVJrzMkPwEMj
 zI6s/oHV9hAxSTdK+jAW2/qC0/1YMC9UwkkFGBG+lr0uYDViU4+5nyHKi2VWHed3SroU3DQCwV3
 DYBQekrLWN3nM3JV6p7UoavwURg49QNH38ZIPWaYgJ8ZA6ab1zli8BsMeVtnsKQ3562+FwilBKH
 bPL9dHf4HcPAGDujfGsBI4CNA5kD2P7sT9u6hHDKwr4/t6ZWyY3YQdqyVnNo9/ZE/66w8p+bQp7
 aq1jhdpeq1gwcXFL9Sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXz8id8Lv30faP
 Y0lfb7SksZAW6a4W4C8O20pZV0RWaXwRCPaZMvGwGpL+d+GswhOaJwKyNEb60n1qo0XIzvILIXh
 dtMS2+u/ZxNjfLN6kcEO1p3cDbqzGkI=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abb5c86 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Ji-p0BpiYPWx0LsQ57IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hqQ4pxgolEBg2ac4X9iTFsK9CQ1APZdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

On 2026-09-24 15:05, Amit Machhiwal wrote:
> On 2026/09/24 12:00 PM, Jyoti Gupta wrote:
>> mpic_alloc() allocates struct mpic (and optionally the protected
>> sources bitmap) but does not free them when mpic_setup_error_int() or
>> irq_domain_create_linear() fails, leaking the memory.
>> 
>> Initialise mpic to NULL and free the bitmap and the mpic in the common
>> error path before dropping the device node reference. The register
>> mappings are not released here.
>> 
>> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> 
> I see a couple of problems with this patch:
> 
> 1. The patch does not apply.  Both "git apply" and "git am" fail on 
> this patch.
>    I think the context lines around the irq_domain_create_linear() call 
> have
>    tabs converted to spaces, which causes the context match to fail.
> 
>       ❯ git apply
> ./20260924_jyoti_powerpc_mpic_fix_memory_leak_of_mpic_on_error_paths.mbx
> --check --verbose
>       Checking patch arch/powerpc/sysdev/mpic.c...
>       error: while searching for:
>       						 intvec_top,
>       						 &mpic_host_ops, mpic);
> 
>       	/*
>       	 * FIXME: The code leaks the MPIC object and mappings here; this
>       	 * is very unlikely to fail but it ought to be fixed anyways.
>       	 */
>       	if (mpic->irqhost == NULL)
>       		goto err_of_node_put;
> 
> 
>       error: patch failed: arch/powerpc/sysdev/mpic.c:1488
>       error: arch/powerpc/sysdev/mpic.c: patch does not apply
> 
>    Please regenerate with:
> 
>      git format-patch -1
> 
>    and verify with:
> 
>      git apply --check <patch>
> 
>    before resending.
> 

Noted.I will regenerate with git format-patch -1 and verify with git 
apply --check
before resending as v2.

> 2. The mpic_setup_error_int() leak is not actually fixed.  The commit 
> message
>    says both mpic_setup_error_int() and irq_domain_create_linear() 
> failure paths
>    are fixed, but the former still does a bare return NULL:
> 
>      if (fsl_version >= 0x401) {
>          ret = mpic_setup_error_int(mpic, intvec_top - 13);
>          if (ret)
>              return NULL;   /* <-- still leaks mpic and mpic->protected 
> */
>      }
> 
>    This needs to become:
> 
>          if (ret)
>              goto err_of_node_put;
> 
> Thanks,
> Amit
> 

The mpic_setup_error_int() leak is intentionally left to a separate 
patch already under
  review:
"[PATCH] powerpc: Fix missing of_node_put() calls"
That patch converts the return NULL at line 1392 to goto err_of_node_put 
as part of a
broader of_node_put() fix series. This patch focuses only on the 
irq_domain_create_linear()
failure path.

Thanks,
Jyoti

