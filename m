Return-Path: <linuxppc-dev+bounces-27575-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCC0C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:16:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlyV56QW8z2y2W;
	Fri, 18 Sep 2026 00:16:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789654573;
	cv=none; b=Vq3NhD/DsPVx8ZpvvDTCeS6FypiZ8sOpLMz9mH3r797XkqvvnnTUUhtp35nlHS0bvLzoQU0JVb9+4GwcT0+QjBi+EHM9J0G41GOHnSfYB0KEFFf/9MZ4iSBS/RpHszmvdnhB2+I12c9dN7N3T+I2Q8tqHC7Y568eZB1O5K5CfiYhz0yXyjYFObHtCkr/EJk9/NdUbU3xk+FCvqHawrHa+LFc7fZPTCxZl1XqAh34skf9vgNjAPjt6wPMi2u1b7lIril+5ChFAP3oACiQt46b+RNIPfl+HIu1sCz+xb78rbvfOpeAz+yHijfoHA7jhmqlrjG5WY64vN/RaiJvWZW/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789654573; c=relaxed/relaxed;
	bh=nvXvw1sn5/MK5qx7033f3UKfDxY8JnFlReecMRLv28Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iC4TwB2XSSpyoHMtA4JB8nOcH1/NoRMiKciOxzAQErS3eRESooYSkR/T7p5kRdq92RyHPqWzLoJTifhaba1hAta3JJcPDT4KBScwyOR8GQP5QbauBz5JdCbPuR9k74jcybC6kYjH7NMVBi7b7fU0RxdHd0tJhN+iIZINBzMmOjEt2C6ag2m9306dN4HAhoAoK9CNzBeRc7IhL5WjZq4ErBxUWjSqY86jaH1sX/hWbIqXBSFmzdMewkhuVyTM8BxdnAugLelQ/e+ckcsYDq1RJD8RXHaRMHECuu4a41/R1rizt+89bG4iNEjTyA4EZ10nE2AAQqRfNri/Tv4l1o2ARA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AquGVwUa; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AquGVwUa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlyV446SYz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 00:16:12 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HE1OxI2697557;
	Thu, 17 Sep 2026 14:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nvXvw1
	sn5/MK5qx7033f3UKfDxY8JnFlReecMRLv28Q=; b=AquGVwUaegfJF8Rw9mCuiv
	f9HhhJYBs2SsFQEJrMgApJTufRrgSxq8D2JLCxj1P9nyBZrmQBIctn6O6KA4f7Yy
	9gRTGQw82yiFUPXzs5gOLQUexpOoSrDWRVf9XH7tUERrvFxDWMheV1huZM9hXvwX
	7zCZzOlqwqXJULrkDD+BUYPkhBnmcRmbwrubiBaOY/SSRH8z9AmtGoDxqBCmShmv
	IjT+/cbhJnpKWbQINtwITM1R/JusLP7Y+MqvMsrJgl6qHuCEtOnWoMQPgy99pFGL
	CDuMNdW/cmvs3uKDbDA9CGrTst6Lz/4tInWCbMygEaPj1zuX5EgKZkS/jzfs3Nvg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx842vxj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 14:15:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDaINA3208314;
	Thu, 17 Sep 2026 14:15:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa2nxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 14:15:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HEFpvH43319582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 14:15:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCB8220040;
	Thu, 17 Sep 2026 14:15:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B218D20043;
	Thu, 17 Sep 2026 14:15:47 +0000 (GMT)
Received: from [9.124.214.19] (unknown [9.124.214.19])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 14:15:47 +0000 (GMT)
Message-ID: <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
Date: Thu, 17 Sep 2026 19:45:46 +0530
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
Subject: Re: [Linux PPC] Disable PREEMPT
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, harshpb@linux.ibm.com,
        Gautam Menghani <gautam@linux.ibm.com>, amachhiw@linux.ibm.com,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>, Samir M <samir@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Narayana Murty N <nnmlinux@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
References: <aqKUhHb9UTfVq4As@kunlun.suse.cz>
 <aqKfsVArHHaIK6M9@kunlun.suse.cz>
 <baeb1ae4-7c0f-4e4e-8fc5-09367cb7c4e9@linux.ibm.com>
 <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
 <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
 <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
 <aqvnOg9JfkM2k0TX@kunlun.suse.cz>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aqvnOg9JfkM2k0TX@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE5OCBTYWx0ZWRfXwo+iY3QMaaMZ
 /cA6r++0zlugN7pDSAVgtk8JA7Z8EV2B/zDcwnEgCywDUcY4yahe0WyTtPAWGlK4t0/B5uoylbd
 0qeLHoeeH0pz1/eu1rQkQTB9rku4VgsvsjYDjkBqcpSdrUUvo/TEEIrw1wOUnEgKB9FnUk/W7G+
 OWZyNJHtDC0SedsYNPriW+7QABGGVv9HiIp+Tzu8/i429eFl7QDgtkCPV3GC1RjaE/IUt5f8am8
 g2Clchrg4irRuJOS/iPyTmMR0rEQMDb0oEvYNtCp97TYPHDZjbeBkmQ9oI1KqXI/yqnXQpdj1gV
 PWJWI8c/Zi5zIAIAcDh2BJgpVw7e1RAcFg3FLv8At+dx54fbHTgEnXYtKwIeUx8qiP8nnxKKQeu
 WOvLHCPgtl0nF2qVTfxQx2pO9sYmvSbdEGo5nPXmHQkz3YaUp/0FNE1f5+q4rZVPDthl3AiKgUl
 NN3cSob2M+ByuKS/z1w==
X-Proofpoint-ORIG-GUID: uXY5TngbQYPVhB8AVfmmfNH6_-RqAWtY
X-Proofpoint-GUID: nGgQJq3Lsvg4UE6uwWvpugSUqTOCVuPH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE5OCBTYWx0ZWRfX+Q+GTYSwxIk4
 ApSDXKluezj1GZZtVUHdyZDCGykYmf82+jgBrbg53qMkMCIfjuwVLkjrSgRPwmwiTR4QQ4zBTkM
 CFP79gcVG5annISWQ4+Ih4JHH1gLKlM=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aabf61d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=FoA3EJH4Tt_-IYsel3sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170198


Hi Michal,

>>
>> Give it a try.
>>
>> I am suspecting both lockup, stack corruptions are secondary symptoms here.
>> While recreate, I have different type of traces.
> 
> Yes, it does work for the crash I see.

Thanks. Give me sometime to see further on that. Didn't get any time today.

> However, we hijacked the report
> of KVM locking up on FSL Cyrus+, and that is likely a different problem
> still not addressed.
> 

Ah, that's what you meant. Yes, i still don't know where FSL Cyrus+ is stuck.

I would need help from FSL Cyrus+ to get some logs or is there a way we can spin of
a QEMU guest of it? We should have the log to start somewhere.



