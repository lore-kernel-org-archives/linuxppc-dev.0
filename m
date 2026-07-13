Return-Path: <linuxppc-dev+bounces-24093-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CB1C44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 04:45:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz8xl1Gknz2xWY;
	Mon, 13 Jul 2026 14:45:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783917915;
	cv=none; b=jvn9+a0bS3SAl6N0se9JYh8nO3/tyLaNzm5bIAxiYZNmTcXPXYW9lZUfkZwGZvtiq8u9+Nnfc4L+ubn+C2CgaEcb+5NotJl0n1B+rP4HJVJn3RwnVszEkeqbMUsNbH4nER722bN8CQ9XdW6cbXaZFg7KlNMQhhn7Yp7sobBbqbV9QUUDWiy4oF14ObSn6hrf0szcOnNglrkCvnZJL/Verv3lRxEto46VcbMzhEAl1mug+XVlzg9lgvEmrL1XeqmungC8I863y6/Hqit3CQ0ZbCoobkUxwyi/na3LC0jd1y2wAou4UXt8MNP0Ni2vVZBF1BLBya/u6JBnXTNgK6Hdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783917915; c=relaxed/relaxed;
	bh=t1bPnrPdFm3GOj+MnumA5XkkXc8/jDiS9e168VY2wsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMgZ5YGldjHKiG1sqZb+BEjLNjyYuCCaDR/L3ow14BptAdp4D/zYVfr6PA04k4OGZo25f8l9Z2gca765v/gzUZi6C190Aa+Rh2C027iA0+aOmepaRJOESAHzWtcT9DyLizf6tIBLLJSfeFp8faV0oL3nLB04iKy0ulN9tar+iXhViS5h8G4B4FCvJxAj80YL9YS1fEaPjPxdpoouUEejC9q0IFkODXRW2XNb7MqsevGM/WY3wZ0cMGjc3Yqv5JCN3pj5Oy4EixQcLpSaTPSeQOJJyndzOFrMsOSyLBFwJYhYOd7lQTby3vAp5XVmHahySmfk7HzClwT9eaae1T+Ynw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mypC5aUr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mypC5aUr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz8xk1Pl5z2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:45:13 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3COks1243380;
	Mon, 13 Jul 2026 04:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t1bPnr
	PdFm3GOj+MnumA5XkkXc8/jDiS9e168VY2wsw=; b=mypC5aUrGIn40SXl6+2jJa
	ph9pGsJ3g9pH2hc98Cdlnk7AvvYbycJIGJB1D+Z380cTbmbuSq1qa7quCe5I3NMk
	xNd9XKtsh9wFGf3MGn4SM6KNn4iYrJwAF3AXt9qEDgpjj8LVyzHvKM01d8JQ5F/o
	HY9oZPpkX6vg2/HbFB2LpN2G0JQWeAlf8Mk/UrmPUwF0vvWcZvJ7q/th7yx1zl6Q
	ESTq3svA2+h8bO3cT7yydFBqCROJLU3KULHC3dUOwAoApD3FspTbbOXy5ChRZtWP
	1s7YJ0NgyR8zO+YfgzFgw2rG/ZecVNNjOEEIdGP46y5+w0qUTYCvczvJ8ZrwlJbw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexweec3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:45:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D4YaTd009975;
	Mon, 13 Jul 2026 04:45:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pv8cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:45:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D4iwa316777682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:44:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C79C620049;
	Mon, 13 Jul 2026 04:44:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37DE420040;
	Mon, 13 Jul 2026 04:44:56 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:44:55 +0000 (GMT)
Message-ID: <6b75342a-73e3-424f-9c03-de1695877287@linux.ibm.com>
Date: Mon, 13 Jul 2026 10:14:54 +0530
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
Subject: Re: [PATCH v2 2/3] powerpc/pseries: Handle and log pseries-wdt
 registration failures
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
 <20260713035954.1559605-3-sourabhjain@linux.ibm.com>
 <qzl7v7eh.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <qzl7v7eh.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: IES4AFfdGA1cxWH9i-ZZDrYEMVIRfhXC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA0NSBTYWx0ZWRfXxo4kpDUj/mq7
 5nj40/abLlW+nhSFvB5Y7X5beUwJjq2mvXK2n022hFr9m0FB/KxngtYAYVFIjOgFaUM/zqRTPRx
 6N/IUr3osuO6XdnemNrwZJxPz2u4pRgEZ3U/LBF5iHzizFA0iIjrL+l/X0labw/6Y1ew5Nv0zJN
 yfBZ9B1TfjpnRb0LOWWibsc3ho5K1cKFfIyoYGksJEsLNLO0UvV4z6PaeNYnt9US6Do+GhgHGuT
 SrKpcLkIGQN3QFAbv6HFNIHDwS+hTuR/XsTXFquNUed3csmKQsdP3GAUeU+e6u++163hHL6uzUn
 4BDG4jXhmcbF7Z1YUxuda8t6/8yk5zqCB7E60QU2c6+PpkVZSFbWW7GMwAmqbtKmuEx5IxXRXnO
 uyRKUd03DmU9yys0warKUnVcInMiMt0vGxXEIgYrDa6Kv7T7spbBXfX6lAKffbzP5lKTavVJvFJ
 9f2jYrvC3AdnzI5Si1A==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a546d50 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=yc9vGXn6jqAjeDJYmugA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xOouCz80I5fO431FTomxxNZ_PEcIWeke
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA0NSBTYWx0ZWRfX1i9UhOLJOg8t
 eR+oVU4jGfLlOl6N7/lnXCCS9slA/ANkg1jN8XgYga+vVUfK198SmlMH263MecaEUv37ssAvWdD
 MIrZCetuOOvd4co5AQavouIz7Ajsg7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130045



On 13/07/26 09:59, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> The pseries watchdog initialization registers the pseries-wdt platform
>> device using platform_device_register_simple(), but currently ignores
>> its return value.
>>
>> Check the returned pointer for errors, log a descriptive error message
>> when registration fails, and propagate the failure code to the caller.
>> This avoids silently ignoring platform device registration failures.
>>
> Fair enough.
>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/setup.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 1223dc961242..bbb2813f8ede 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -191,8 +191,18 @@ static void __init fwnmi_init(void)
>>    */
>>   static __init int pseries_wdt_init(void)
>>   {
>> -	if (firmware_has_feature(FW_FEATURE_WATCHDOG))
>> -		platform_device_register_simple("pseries-wdt", 0, NULL, 0);
>> +	struct platform_device *pseries_wdt_dev;
> minor nit: we should rename this to pdev, since it is already under
> pseries_wdt_init(). That is generally how all platform drivers use it
> unless it requires more than one platform device.
>
> But either ways the patch looks good to me:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for the review. I will rename the variable in next version.

- Sourabh Jain

>
>> +
>> +	if (!firmware_has_feature(FW_FEATURE_WATCHDOG))
>> +		return 0;
>> +
>> +	pseries_wdt_dev = platform_device_register_simple("pseries-wdt", 0, NULL, 0);
>> +
>> +	if (IS_ERR(pseries_wdt_dev)) {
>> +		pr_err("Failed to register pseries-wdt platform device\n");
>> +		return PTR_ERR(pseries_wdt_dev);
>> +	}
>> +
>>   	return 0;
>>   }
>>   machine_subsys_initcall(pseries, pseries_wdt_init);
>> -- 
>> 2.52.0


