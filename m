Return-Path: <SRS0=xMs2=JT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1237FC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 06:11:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1989B61453
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 06:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1989B61453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQn9X3BhBz30CT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 16:11:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s85lS4vv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ganeshgr@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=s85lS4vv; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQn8y1SDSz2xYZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2021 16:10:41 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13M62sLY050592; Thu, 22 Apr 2021 02:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OIOy8R+6jwGwjJH+DVhvn8AU3P30mmVQuhJyCIZujvM=;
 b=s85lS4vvShBFFvqXtzMIvZt/t5vIsXIxSfdfS7k+CovT3dhprFZ6TSjmZZ6DPzdGzmBe
 udMCEwB8iDCV2b0E5Un+V0Tm0Fvb0RU1LHK4PKl0KUYtVyGNRqpoUla6y3ndZBw0VbgJ
 D95Ywv9z/x4mLxVTpfqWM6jyPGepNJU+otJ5qZfDygJxpSihKcUhlRqHnVfxl2vvm+b5
 TnSr1SlIxTK381fkccGoqbFBT5y6fQFceHbky1BJfKysCqjudocTZ0Pr5NjeiKCFP1d4
 gIrzDKX2zSktAgSpnRuPbbqzFWuLi8l+bbT8DZca5nkqpBXmkL7gn7uFlb/0o4MW61lT 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38318kkd5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Apr 2021 02:10:37 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13M62uNH050752;
 Thu, 22 Apr 2021 02:10:37 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38318kkd4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Apr 2021 02:10:36 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13M67a8R012790;
 Thu, 22 Apr 2021 06:10:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04ams.nl.ibm.com with ESMTP id 37yqa8jpdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Apr 2021 06:10:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13M6AWG042402232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Apr 2021 06:10:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A761A406A;
 Thu, 22 Apr 2021 06:10:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 786ADA4066;
 Thu, 22 Apr 2021 06:10:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.84.22])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 22 Apr 2021 06:10:30 +0000 (GMT)
Subject: Re: [PATCH] powerpc/mce: save ignore_event flag unconditionally for UE
From: Ganesh <ganeshgr@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <20210407045816.352276-1-ganeshgr@linux.ibm.com>
 <cdc59fb2-b389-99ee-24bd-10f3f09c2b42@linux.ibm.com>
Message-ID: <302b3ae6-7952-48ea-5573-6c2d07f0777b@linux.ibm.com>
Date: Thu, 22 Apr 2021 11:40:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cdc59fb2-b389-99ee-24bd-10f3f09c2b42@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v_Rwu0jlatvFNBUaBwOWQ6fb1KOrD2OJ
X-Proofpoint-ORIG-GUID: qZ45gxV5nNRwBOu2JfFKo1E1yGof97di
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-22_01:2021-04-21,
 2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220051
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mahesh@linux.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 4/22/21 11:31 AM, Ganesh wrote:
> On 4/7/21 10:28 AM, Ganesh Goudar wrote:
>
>> When we hit an UE while using machine check safe copy routines,
>> ignore_event flag is set and the event is ignored by mce handler,
>> And the flag is also saved for defered handling and printing of
>> mce event information, But as of now saving of this flag is done
>> on checking if the effective address is provided or physical address
>> is calculated, which is not right.
>>
>> Save ignore_event flag regardless of whether the effective address is
>> provided or physical address is calculated.
>>
>> Without this change following log is seen, when the event is to be
>> ignored.
>>
>> [  512.971365] MCE: CPU1: machine check (Severe)  UE Load/Store 
>> [Recovered]
>> [  512.971509] MCE: CPU1: NIP: [c0000000000b67c0] memcpy+0x40/0x90
>> [  512.971655] MCE: CPU1: Initiator CPU
>> [  512.971739] MCE: CPU1: Unknown
>> [  512.972209] MCE: CPU1: machine check (Severe)  UE Load/Store 
>> [Recovered]
>> [  512.972334] MCE: CPU1: NIP: [c0000000000b6808] memcpy+0x88/0x90
>> [  512.972456] MCE: CPU1: Initiator CPU
>> [  512.972534] MCE: CPU1: Unknown
>>
>> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/mce.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
> Hi mpe, Any comments on this patch?
Please ignore, I see its applied.
