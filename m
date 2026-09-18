Return-Path: <linuxppc-dev+bounces-27690-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127FAC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 09:27:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmS2321wGz2y7r;
	Fri, 18 Sep 2026 19:27:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789723627;
	cv=none; b=J+q0HvVSChqdd1igWW6q9EfliWsUGos2uir7APBh4nKrH/XFecNjqMrkz7eNVkLo0OtZQYYFqebQWsOxIlspS18557CeddbnKFpKWLhHXKLe1XmbznzQCkrfb4ujnOF0YeXn2Mx1HJ19liacUIRe0NlzlsQSNVgLnvlvHx/T+avWQqYsh8J5DxN3Qqm8uqP4/gm6YLi+pXj11fUCDeYYHipDkBoh7qLsY6n0NylYGB6zvNZ/ah4J1zQaho/iNJjNffO9tz7Qoe61issKdQY81zUPJ+oOCtCDkJFwvIXjknwTH+sRnUtn2QZ+mK049go7F/HuE7grCG/Jp4KvmBhhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789723627; c=relaxed/relaxed;
	bh=uQ40/RfkC11RYfYXRL8vnQFf8hI17lg+wSka0zlW6V8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hzr9DpXxQQwrMIU59xxnisilT4g6antEksECIrrN7JTGu88hs28A8c/JZYmP6ZczUsHJ0ZlsSHAOa9syawoiSeX9OInxpbo9KdlhlskArKj2mizIbqvV9Tm4MUrUrjueV40rl5GEh97lJSCRhs7o7awfRl9ccKqXsCNDxIJnGiw2iiUPjUWCQqVwcpfhBbzLr2HPM9zGdyojuM3bFAwlIojM1kIc3hS1sbTS5AmY0fg0IZoLXwtuonoZL2FVjtHX1dTmu2dcv/Snvz2RWPJFNg+h2wapF1kvVMrVjqa5xeVXxGCdWq66b+EiUy2H2SwhzdVJIFhuwECDuF8RelNLXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s/iOzj6D; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s/iOzj6D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmS222vnjz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 19:27:05 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61gBU457436;
	Fri, 18 Sep 2026 09:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uQ40/R
	fkC11RYfYXRL8vnQFf8hI17lg+wSka0zlW6V8=; b=s/iOzj6D9A1uqMqZLQ2+jD
	Av/WiKnfj7esblVpcsMKRlKEIzybZ+J1CCWkUwBLt3+4WYR7V0HmrH2LW4ALIkch
	PDt5mXtX6t5m1d8NKTlT6Cx/W1PE/iwvk52esle7JzJ9/ulUB8NNMtkq1hxBolLB
	D3CjogKdtK5C+rmyhix7wjSjD7CedvPZugrTW36nmGJOPS3nA5GMVYZC3swzpaQA
	WS0vqxFQtdHD6b/yJ/OAeP3Z1gHPN2NG+AZc8iawOZRZxg+30LHRAw74Y6VD65Ib
	z7VJv5PBDv/0nWNRsGx4eQfq/qdbiU0qWKscgRDsuUaCpsRXYy6Hc6GcKp3PipLA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx8479b9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 09:26:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I6542q1154899;
	Fri, 18 Sep 2026 09:26:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gep92t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 09:26:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I9Qj4M54526442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 09:26:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C0D020043;
	Fri, 18 Sep 2026 09:26:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D6B320040;
	Fri, 18 Sep 2026 09:26:41 +0000 (GMT)
Received: from [9.39.16.52] (unknown [9.39.16.52])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 09:26:41 +0000 (GMT)
Message-ID: <ed82620e-ecb1-4b7f-a84b-a0f3a773dd36@linux.ibm.com>
Date: Fri, 18 Sep 2026 14:56:40 +0530
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
From: Shrikanth Hegde <sshegde@linux.ibm.com>
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
 <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyNCBTYWx0ZWRfX0t4hGh39sJ6d
 MScUVqjHsv0kFqYJbhUBxcCBoMDDLce82UThZqsls5q7A6xHG+KW6faiPm6YlHIG+CjnVO7H+yc
 ELkj6iU89bbAGFelnyEY2xiOjqvLW6VAhKCQekrTSLwwHTv7DYfPfMlWWO/lOo9DZXBlc2fH9Br
 vW7PbK2PldWSOoKx15Y4p/GgPBmIo1g8Nq358rl+yUxM1MVw0ZS9QGGn5xwjBeYEaWRvIobZemV
 sx+JEEJmZZ753AB8uee+HAv62sTNsJdumwp7zp2WxRBqD10PwDA4I5xcMIeZKPFsk9wsCAP4rvV
 oU8CNHx2hpgC5RQXwGTj74jVtA/YZTdu1kXufAQYescaWak2h2tEm+6XcVyHn+Pyh99b65YoW1j
 LettZ65is72SzCKwaMQDz1INslUCKgAZKgNZP63hZibJ4ePsvLSr53to2JRg4tnu6Q8Ov33BvmR
 L3Uo+oOsHjrVqCB2yCg==
X-Proofpoint-ORIG-GUID: Pei-JNYQBWJ00x4VWb2AJiHecPLALoGx
X-Proofpoint-GUID: W1GdYp7On5Sui71efCYMew7BYD4hEvgu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyNCBTYWx0ZWRfX35a3iCW0fzeW
 hmjMfQb1juEJk+/xfvKTtyTQxgXLWtS5JtFEYru5p70iNMDa+a7w9/Sb9ngoWJDf3tnCYPKzsGd
 rm62/RquOthSXMCVULDP8On7SrsC7ro=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aad03da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c6Psy_y7xmvc5y5bdP4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180124

Hi Michal.

On 9/17/26 7:45 PM, Shrikanth Hegde wrote:
> 
> Hi Michal,
> 
>>>
>>> Give it a try.
>>>
>>> I am suspecting both lockup, stack corruptions are secondary symptoms here.
>>> While recreate, I have different type of traces.
>>
>> Yes, it does work for the crash I see.
> 
> Thanks. Give me sometime to see further on that. Didn't get any time today.
> 
This is going to be the fix IMO. It passes all the recreates i have as of now.
(Please ignore the whitespace mangling if any)

Let me write changelog and send it across.
---

diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 6599fe3c6234..54c8727b48cd 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -220,7 +220,9 @@
  
  	/* Restore gprs */
  	.if \allregs == 1
-	REST_GPRS(2, 31, r1)
+	REST_GPRS(2, 12, r1)
+	/* Do not restore a stale PACA pointer if the task migrated */
+	REST_GPRS(14, 31, r1)
  	.else
  	REST_GPRS(3, 10, r1)
  #if defined(CONFIG_LIVEPATCH_64) || defined(CONFIG_PPC_FTRACE_OUT_OF_LINE)

