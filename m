Return-Path: <linuxppc-dev+bounces-18584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC640D58CDD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 06:12:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffN9m4FHYz2yYq;
	Mon, 23 Mar 2026 17:12:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774246332;
	cv=none; b=oHRuZWowljyZObp5sCOj3HxQhmkIcLH6VbvJEFnB/mY8KQFbUwnhio4cHdMEyfDSxKPT11PObk1nb5qhhFeb3OPv6vLBZSyWFqYs1awkkKkrpyHokumDZxn2CvXhSs/XUJnMt2mpSSyFPiYA6ep83GAgifv0RmWTtwfMPb8aIgW/aX1MGBbVzrk3JxguLCS+lbHa3ZWegCKk68rwxmTMphA84oUQHEaMxupcFZOacoGHZCHu1nmlJii4QlboRqwtbwSnP2aFBhP2uHZuTYKxMmisEDqcnflLQaRQh/E68ZzrH0G5dgaGFc+gf9y3CjDdAAyUPsAucXi8NThTjynbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774246332; c=relaxed/relaxed;
	bh=kSf+1FW7POK259mGvIfdCJA0DSomJSBcsPEGwaT/AFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNiQyqDgtVteNK6ktbXKi0kgu/8IwYHG6WxXFfuebeBpFHJr0WE83fZDKaujZKW2QQIyaFyMvAp2Jbbe2JosjHNdqhRKDBZJyVtTZXENbcK6Qa26qnN0BeVygVURdZlifrmbsXylCHJk7zrs3mCa9PSpB2+AwW7Lc5BN8vSgAvxhhgelUiznLGCrlo38I6RgsVcPQXejp0bFIuya5NI1r8xj7Lt5My3P6jb/HWBuNZCxbB4zsN+1LfNWteXWLR9fPpyQm5OILyBJDS6/7NlFwA214xffWtAUVTPRjzSWSjzAU541hZmvrcwUfL0zddAr1KcP/6B0Kn0fnIoBdQ7Hug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FP270o9T; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FP270o9T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffN9l2qQ4z2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 17:12:10 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MMKp8V510743;
	Mon, 23 Mar 2026 06:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=kSf+1FW7POK259mGvIfdCJA0DSomJSBcsPEGwaT/AFU=; b=FP270o9TLtiz
	cK7wDXPjeuExGS1dzDQgzQUdmSyGKzFefi0aPnR5sohEb0z2rE5mSRvQ0SNkJSzL
	l+3FAs2QyhX7LFo1lALvLojMzZVrhLSyxPQc7SWtFXH8fTS5l+Eb4L5npjI0cw4F
	DMRzJw5+eW/88hC3ucKZ3EJNdFG8qDI75QrEnHx2uQk3KERjMQgwUCAmiCAInbFs
	Afm0dcMzaZxU7FxQCNmStDAeYM5sX9zWjiM3+QelB73RGprgR7YS146PYycaJE0D
	lFWRR06ACxJ4IvdozzYBSgJm1SKUwAXDfOCUXjQdkY8xC0XzSgNqIuIPh2TwOrlY
	C1Tn4RHa+g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9nkrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 06:11:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N2p9xx004392;
	Mon, 23 Mar 2026 06:11:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1uy0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 06:11:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N6Bqbr50659662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 06:11:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B250C20043;
	Mon, 23 Mar 2026 06:11:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 922BF20040;
	Mon, 23 Mar 2026 06:11:50 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.123.6.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 06:11:50 +0000 (GMT)
Date: Mon, 23 Mar 2026 11:41:48 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/kdump: fix KASAN sanitization flag for
 core_$(BITS).o
Message-ID: <acDZNdku8sR_O9Ba@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260321053121.614022-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: d_2zDFsAgxbVhK3fEFGOluwKH8KpQApJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA0MiBTYWx0ZWRfX11Peyy0rm0my
 a+ll6mpPJhs8ruWI2zZTfYUtR3lHZdA+NQWlMXyOrKIUcFAkodwwvE6pc+HTin4nw94IxSq15sJ
 WfRsym/YqQM9KfXIdwJlK0KzwuWLDQGW4DSVXbnnpjVzr4vcMI3Y3ThQCO4tD55+E6Gw/gd9hZD
 XSl2I1/Sfla8rWi8c3afIpW59VbxAnpiZgYrQC1r9ip+Bvu0hBqRxpmc0mSrVQ4rtV+2fL5PCOH
 rjYHt9QIBDKZ64Svr+keWSesJz9dlIoa7eIx8wi3fi4+QjOkhHquNw7z2qNL7YL/hnRycOSoZrg
 rUEoPrxJhW3WHQkVad5QhhuWf3xesNrQaPGxsfyZCJ1oQgN6ByrFZ2a3zfk/GOM+NhzVtpZ6+XF
 mEqRTZT64W4TPEQZrdKH9Dnjw6Z8EtoOgojeZjbeEI6jVjZeyCwNPs0wRlmF3WZfFg6tRp+HXrU
 I7eOk3FJQ1ZO3uZrImw==
X-Proofpoint-GUID: NSnrn3J8MyaMh5Z2zCc5wgiCh_Z5eS0K
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c0d9ad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=ZSZbnnKFPOSW3gtc0DAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230042

On 2026-03-21 11:01:17 Sat, Sourabh Jain wrote:
> KASAN instrumentation is intended to be disabled for the kexec core
> code, but the existing Makefile entry misses the object suffix. As a
> result, the flag is not applied correctly to core_$(BITS).o.
> 
> So when KASAN is enabled, kexec_copy_flush and copy_segments in
> kexec/core_64.c are instrumented, which can result in accesses to
> shadow memory via normal address translation paths. Since these run
> with the MMU disabled, such accesses may trigger page faults
> (bad_page_fault) that cannot be handled in the kdump path, ultimately
> causing a hang and preventing the kdump kernel from booting. The same
> is true for kexec as well, since the same functions are used there.
> 
> Update the entry to include the “.o” suffix so that KASAN
> instrumentation is properly disabled for this object file.
> 
> Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/
> Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/kexec/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> index 470eb0453e17..ec7a0eed75dc 100644
> --- a/arch/powerpc/kexec/Makefile
> +++ b/arch/powerpc/kexec/Makefile
> @@ -16,4 +16,4 @@ GCOV_PROFILE_core_$(BITS).o := n
>  KCOV_INSTRUMENT_core_$(BITS).o := n
>  UBSAN_SANITIZE_core_$(BITS).o := n
>  KASAN_SANITIZE_core.o := n
> -KASAN_SANITIZE_core_$(BITS) := n
> +KASAN_SANITIZE_core_$(BITS).o := n

Nice catch. Thakns for fixing.

Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks,
-Mahesh.

-- 
Mahesh J Salgaonkar

