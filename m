Return-Path: <linuxppc-dev+bounces-20543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE16BCD3436
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 02:28:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9x4q2jd8z2xm1;
	Thu, 07 May 2026 12:28:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778120907;
	cv=none; b=a/ZYwjJZYJIwgaX9qnF7pOzpKE6d2wiXiUo0o0vlFwZwM90eMc05wM8A3w/YyfoF9PC4HBv/qbqSpzTj7BwZyt8kBnmMvK1AZeau1Azn9+MbGmpv82kV0m+f8UwWSW+RDXGZLFGSvo4O69opCFrwFk1Z4GqU5+tZZrdT5PU+FMESOPsGCnvpKZzWeGkXeLkBIGgXtup/cDPEKyMQzTSj4w+7tit7TqhH3vKsmn3gVXcXbuHOgLNLeTj9hns/RB89jpqk0u3FPU841x+uUNDRkkTPdX2zO9Y93JJ81uEh3xhyajP5SKBzQR7a74ByU7rX6MLolKAvZNnauNAPYjp2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778120907; c=relaxed/relaxed;
	bh=JMxEAyBneJQnhXbO1ZAyvbjk83KsMS3iIN9Uw7iWO7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxKw+P5z1qr1o7j5ER8/WFceJEF+i+ZK1CqSnrN8OeL74B60UdRKSUWtorWRvLoDDbwXq4pH6fUZyiWFpSH76f6zZBHLZrEOoUzvNlkEZOYoWw9REOm+ovkOBH50qskxGdbZDpml2XUoNet8SgP1JpqHhrFCj2IqWoscT95+7sCx0BsjYAxV7cjrTKffcVM7DuRj3YMVEq3cowQOFMzoGc3CzhnzcJSz4uvVcRgB6kOVhh0spBeZ0kNWn9b0zjGg5H9j2yct/ZtS+6o0gmLDAxQCnMHo72mxcJVnghSlyndPGSqJKHMhUV8Ow2BHisvYHrEUxZ6aw4LdEe9LvsDHDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SX/ZJuDE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SX/ZJuDE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9x4p1T5cz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 12:28:25 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646Ik7w31531488;
	Thu, 7 May 2026 02:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JMxEAy
	BneJQnhXbO1ZAyvbjk83KsMS3iIN9Uw7iWO7c=; b=SX/ZJuDER/f3sV8RX7jnik
	56t0OqKXr67e7oU8YDXnYAQBXXLIYb94SiIrzaPbG0gnMlsc8Mmy0TUEs1dKehcI
	5VsuZErsd2fYfye941TAxZyZCPbit9CGuxba1psx3pdJIYccIbTsVCG8HRkpjcBk
	pqgI4254lEKK59/QlSr1tegqUGcjFxyUntW24nkm8moYDYM28nW4RUycd4p833CW
	yQGHCwCOnhykM8HSAudRsEEzHAIMZn5s7YQSpZE2k5zRu7BsThCV/7iyke4/SOpE
	56ZdRneZH+GKH2q+6M85cOjG0Izs4xJNtBqgXvN91P7SsQ1CXTDhTAHgXeie4NRw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4urx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 02:28:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6472OVSD006661;
	Thu, 7 May 2026 02:28:13 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw96ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 02:28:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6472SDsC41288056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 02:28:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3187A5805E;
	Thu,  7 May 2026 02:28:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 207055805A;
	Thu,  7 May 2026 02:28:09 +0000 (GMT)
Received: from [9.43.90.101] (unknown [9.43.90.101])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 02:28:08 +0000 (GMT)
Message-ID: <5a8613f0-1f26-4aac-8897-68295610e547@linux.ibm.com>
Date: Thu, 7 May 2026 07:58:06 +0530
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
Subject: Re: [PATCH v3] powerpc/g5: Enable all windfarms by default
To: Michael Ellerman <mpe@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
 <5a28c484-5500-4b68-b837-28d30648e592@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <5a28c484-5500-4b68-b837-28d30648e592@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAxOSBTYWx0ZWRfXw3w0MiMkNbK5
 fBm5TKOeF2K34XehOGugu/RzQUOkabeqVN9kpni0oHDOJ34mfffNQnhlOo5Ole+PaKCbRq4uger
 FRGsm0RA5FeNZsR3di6bFl+Y+deuuFSa+sQZ5lMtE3G2kFtZkA60DsMGUnuAPBZodV1x8qVhX+R
 AShhw/yLRxJsHYfY0nAxkxh0WOKn6JAjTGptBw2vVJu0tIl/AFspNh3C9Lxt5ciT6+2B1SzzCS1
 MoNsvAgGMA7jSMYKgn579gZZqc2ObSJ5Ufb/gKmsjzoLtGX41sFtMlddDWx4lnzUoO9xZzt+C6c
 FggoMzapf+18z9730Z9WA6QF+2PC9kY2yPtwkesSy96uHLWw8c5yaPlCn5dPjFAKSnuFIqu7v0I
 RmSrNxipjIkH9wfHsUNlz2oXX4jg0I2W/KFrC7pnGD7gGtxpeWxVw8zCbiibI7Uex+tLyOOlqgt
 G5XmbVv8hsOyxh6RUhg==
X-Proofpoint-ORIG-GUID: SJUsv1U9TO3O4n9Vhm4PQTyf763YqAfH
X-Proofpoint-GUID: hsy4ikYAxm_7m0sZYHZ_WzUkWZSnWa64
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fbf8bf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=f2FukGz-UFaU7qqNYBoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070019


On 5/6/26 5:11 PM, Michael Ellerman wrote:
> On 6/5/2026 04:47, Linus Walleij wrote:
>> The G5 defconfig is clearly intended for the G5 Powermac
>> series, and that should enable all the available
>> windfarm drivers, or the machine will overheat a short
>> while after booting and shut itself down, which is
>> annoying.
>>
>> Signed-off-by: Linus Walleij <linusw@kernel.org>
>> ---
>> I wonder why this never gets applied. Am I doing something wrong?
>> Is the patch stupid? No-one cares?
>
> Sorry it didn't get picked up.
>
> I don't have any G5s anymore, but the ones I did have used the other 
> windfarm drivers so I never hit this.
>
> You might be the last person on earth booting Linux on those :)
>
>> ---
>> Changes in v3:
>> - Rebased on v7.1-rc1
>> - Link to v2: 
>> https://lore.kernel.org/r/20260120-powermac-g5-config-v2-1-cd8f1c8bfbae@kernel.org
>>
>> Changes in v2:
>> - Rebased on v6.19-rc1
>> - Link to v1: 
>> https://lore.kernel.org/r/20251205-powermac-g5-config-v1-1-8609aa97c1c0@kernel.org
>>
>> To: Madhavan Srinivasan <maddy@linux.ibm.com>
>> To: Michael Ellerman <mpe@ellerman.id.au>
>> To: Nicholas Piggin <npiggin@gmail.com>
>> To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   arch/powerpc/configs/g5_defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/configs/g5_defconfig 
>> b/arch/powerpc/configs/g5_defconfig
>> index 04bbb37f5978..f74ccc06f4c1 100644
>> --- a/arch/powerpc/configs/g5_defconfig
>> +++ b/arch/powerpc/configs/g5_defconfig
>> @@ -85,6 +85,8 @@ CONFIG_PMAC_SMU=y
>>   CONFIG_MAC_EMUMOUSEBTN=y
>>   CONFIG_WINDFARM=y
>>   CONFIG_WINDFARM_PM81=y
>> +CONFIG_WINDFARM_PM72=y
>> +CONFIG_WINDFARM_RM31=y
>>   CONFIG_WINDFARM_PM91=y
>>   CONFIG_WINDFARM_PM112=y
>>   CONFIG_WINDFARM_PM121=y
>>
>
> Ack, LGTM.
>
> Maddy can you pick this one up for next?

Sure will do.
Thanks.


>
> cheers
>

