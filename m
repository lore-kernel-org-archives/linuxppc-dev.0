Return-Path: <linuxppc-dev+bounces-20548-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5455BCD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 04:08:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9zHp5YDYz2yrD;
	Thu, 07 May 2026 14:08:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778126886;
	cv=none; b=gEjRYCAkJ6AokQ0Gt4zwAFdKi3hqrk2otwiIWEnTcdNz50Z2hIgA7MdMzZpKyVPHQijyt2+L7yfBSfcJSph4cF8GnOPn+WZjqZkSP810q4kVmkGbGW5iy85AexnS5+hd9gyvknLinanNYq7jMnSZHwgFU0koGTxl63w+5gjACtk2BJKS4PIT07MTCq7FBawZy6MBVykL4y5YjaObg0kTxO3skzVU5a2Jhd14LKmtheNE5zKtIj7MIDBVbQyFGmkkpUVi0Pk4oda75syNthOiAXQn8lZeVe5etEOp62xneiAaGjrPW3hy0cgu4hiRLdI0faJ4ruRO4xsSDj4sxLxpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778126886; c=relaxed/relaxed;
	bh=/VtWyvDOrlAFoS1mn9UFyVXIwWZueSkc6+5pyZTa7/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fx3u0pyeuRjAPIfRiQKxDNSUWnRDwK3oW3T124rkRa6BbDuEIW2LCHeGnV3dEwd0vh2qnwhAnSiVnpHXrUx7v66uRo4qMIb0vhQU+iKtEQG1fsY2x7qAs0bhZ63XuWFHd+LqxASJ75JQ0jCcbev0xMINkvOHRtfQOqhsAN/ifDpH9j0LQt3tYVvfI363LQ6ETXGqfFsFk3/g8L5MZ6a00tjrMga/jAnjPmeiubkKx3HEj6HWysz89ykepkjaaLoY1Jc5X/Dl+MuWEFDenw0pELDKmXj8Zfg5nTtGLcGLNb7V5WDdte3pL/64o7UU1X9ZiCoB8JC75VCFq4attq+fYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ByzwSILK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ByzwSILK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9zHm6t7Kz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 14:08:04 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646MgS7S3638747;
	Thu, 7 May 2026 04:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/VtWyv
	DOrlAFoS1mn9UFyVXIwWZueSkc6+5pyZTa7/g=; b=ByzwSILKbQac7UkFiPDOw4
	LkabSs62zoR8E84PURCKCpEV8HlPRP6JfjeVfiDvaSNicey+FSPrM5a+L2ThuGvS
	ZHmfHJDbInVt9V3aMhn6i/3e4II23XWfWI+3PTP99zVVG0d7jNlccQnqx7KIVZlK
	sPbJCx55PBAQnO2R6/+SpOhvyUP6afJCGjxj/gKNrsitKvBpHnZ5w+4CcBnOW2Ow
	MDIRWleCae2fyTjlM1rhucsNLxxn8xHkceTDRFt2OiPL4jDvLloJmCSShw27q6me
	NQd3DY8Vt5rX2mdzXhAwes85TB0jA5e9F+d2xHfpTKLRpoqa13dYchze8GY0Htog
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxu5t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 04:07:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6473sa7V029750;
	Thu, 7 May 2026 04:07:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw9esh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 04:07:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64747m3j58196338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 04:07:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D290220049;
	Thu,  7 May 2026 04:07:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEF3320040;
	Thu,  7 May 2026 04:07:45 +0000 (GMT)
Received: from [9.39.23.70] (unknown [9.39.23.70])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 04:07:45 +0000 (GMT)
Message-ID: <aade3c40-6d72-46c0-9d52-6f3c3f823a78@linux.ibm.com>
Date: Thu, 7 May 2026 09:37:43 +0530
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
Subject: Re: [PATCH v2] powerpc/fadump: Add timeout to RTAS busy-wait loops
To: Adriano Vero <adri.vero.dev@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260406061542.22354-1-litaliano00.contact@gmail.com>
 <20260419065039.23495-1-adri.vero.dev@gmail.com>
 <7bef2ce2-1fd3-4648-8c78-d3c5e07a1f9f@linux.ibm.com>
 <CAGKWbKuxRCfqZaixqo7L3uT0gtOssDo8-cWWvsVJkKEsaTumcg@mail.gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <CAGKWbKuxRCfqZaixqo7L3uT0gtOssDo8-cWWvsVJkKEsaTumcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAzNyBTYWx0ZWRfX2DEhk7lVTlbD
 XNI24U7eLrXgCUngZJRamFXv8K1cLbQa+ernoop3zW++8pBU8K3ExDVLu27H1DyAOZgAmL+0sUm
 wpipW4h/Mzw8wzB8u621vN0EdeKoU3gNAqPrXYJuC2TGN3bho29lFYWZSMdEd04YkKN9lYXV3nc
 rVtxohC1efG/qqQsFMpfUyl/esSwuWxm3dVemAaYBq1rWcdBjMsGWwZqk2XtAZNZQTzSYhnqQuW
 fRc8RQTLcjmsbgCE7u1gXT/zXB4xQzZrJnldtsVzGtfFHQabLeKzc+TqDVpqHoEsOSss8+1oEMH
 mjRnkYWbfUcvc3s9FHt/eSEmHdpSEf9ljEOsxVOoShwtUZGQFQ0420ohUS1rpNuMImU3tFhTs4g
 a++byBuACOd2tTI4wvOzTBonJPeUA2aRFo7Pii1g5mIrSYkRy3xNGPwkXUgKCsazFqzjNEoIwLW
 5eSYgeOKP4Yv7uV8wqA==
X-Proofpoint-ORIG-GUID: XYcVxa5NZ05RxsUU_MGodLGMIilCFooS
X-Proofpoint-GUID: vHqoC4K_Rln9wutAz7d0bPCD_1QkdvVJ
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fc1018 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=RbH5DiymoCeLN0jEbdAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070037



On 07/05/26 08:22, Adriano Vero wrote:
> Hi Sourabh,
>
> Thank you for the review. v3 with your Reviewed-by tag has been sent.

Thanks, but a new version just to include tags is not really needed.
Maintainers generally take care of including them.

- Sourabh Jain

>
> Adriano
>
>
> On Wed, May 6, 2026 at 9:22 PM Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>>
>>
>> On 19/04/26 12:20, Adriano Vero wrote:
>>> The ibm,configure-kernel-dump RTAS call sites in
>>> rtas_fadump_register(), rtas_fadump_unregister(), and
>>> rtas_fadump_invalidate() polled indefinitely while firmware returned
>>> a busy status. A misbehaving or hung firmware could stall these paths
>>> forever, blocking fadump registration at boot or preventing clean
>>> teardown.
>>>
>>> Introduce rtas_fadump_call(), a helper that wraps the common
>>> busy-wait pattern shared by all three sites. The helper accumulates
>>> the total delay and returns -ETIMEDOUT if firmware keeps returning a
>>> busy status beyond RTAS_FADUMP_MAX_WAIT_MS (60 seconds). A pr_debug()
>>> message is emitted on each busy iteration to aid diagnosis when the
>>> timeout is hit.
>>>
>>> Signed-off-by: Adriano Vero <adri.vero.dev@gmail.com>
>>> ---
>>>    arch/powerpc/platforms/pseries/rtas-fadump.c | 80 ++++++++++++--------
>>>    arch/powerpc/platforms/pseries/rtas-fadump.h |  6 ++
>>>    2 files changed, 53 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
>>> index eceb32893..3bb4ac2ab 100644
>>> --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
>>> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
>>> @@ -179,9 +179,42 @@ static u64 rtas_fadump_get_bootmem_min(void)
>>>        return RTAS_FADUMP_MIN_BOOT_MEM;
>>>    }
>>>
>>> +/*
>>> + * Helper to make an ibm,configure-kernel-dump RTAS call with a bounded
>>> + * busy-wait loop. Returns the RTAS return code on completion, or
>>> + * -ETIMEDOUT if firmware keeps returning a busy status beyond
>>> + * RTAS_FADUMP_MAX_WAIT_MS milliseconds.
>>> + */
>>> +static int rtas_fadump_call(struct fw_dump *fadump_conf, int operation,
>>> +                         void *fdm_ptr, unsigned int fdm_size,
>>> +                         const char *op_name)
>>> +{
>>> +     unsigned int wait_time, total_wait = 0;
>>> +     int rc;
>>> +
>>> +     do {
>>> +             rc = rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
>>> +                            NULL, operation, fdm_ptr, fdm_size);
>>> +             wait_time = rtas_busy_delay_time(rc);
>>> +             if (wait_time) {
>>> +                     pr_debug("Firmware busy during fadump %s, waiting %ums (total %ums)\n",
>>> +                              op_name, wait_time, total_wait);
>>> +                     if (total_wait >= RTAS_FADUMP_MAX_WAIT_MS) {
>>> +                             pr_err("Timed out waiting for firmware to complete fadump %s\n",
>>> +                                    op_name);
>>> +                             return -ETIMEDOUT;
>>> +                     }
>>> +                     total_wait += wait_time;
>>> +                     mdelay(wait_time);
>>> +             }
>>> +     } while (wait_time);
>>> +
>>> +     return rc;
>>> +}
>>> +
>>>    static int rtas_fadump_register(struct fw_dump *fadump_conf)
>>>    {
>>> -     unsigned int wait_time, fdm_size;
>>> +     unsigned int fdm_size;
>>>        int rc, err = -EIO;
>>>
>>>        /*
>>> @@ -192,16 +225,10 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
>>>        fdm_size = sizeof(struct rtas_fadump_section_header);
>>>        fdm_size += be16_to_cpu(fdm.header.dump_num_sections) * sizeof(struct rtas_fadump_section);
>>>
>>> -     /* TODO: Add upper time limit for the delay */
>>> -     do {
>>> -             rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
>>> -                             NULL, FADUMP_REGISTER, &fdm, fdm_size);
>>> -
>>> -             wait_time = rtas_busy_delay_time(rc);
>>> -             if (wait_time)
>>> -                     mdelay(wait_time);
>>> -
>>> -     } while (wait_time);
>>> +     rc = rtas_fadump_call(fadump_conf, FADUMP_REGISTER, &fdm, fdm_size,
>>> +                           "register");
>>> +     if (rc == -ETIMEDOUT)
>>> +             return -ETIMEDOUT;
>>>
>>>        switch (rc) {
>>>        case 0:
>>> @@ -234,19 +261,12 @@ static int rtas_fadump_register(struct fw_dump *fadump_conf)
>>>
>>>    static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
>>>    {
>>> -     unsigned int wait_time;
>>>        int rc;
>>>
>>> -     /* TODO: Add upper time limit for the delay */
>>> -     do {
>>> -             rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
>>> -                             NULL, FADUMP_UNREGISTER, &fdm,
>>> -                             sizeof(struct rtas_fadump_mem_struct));
>>> -
>>> -             wait_time = rtas_busy_delay_time(rc);
>>> -             if (wait_time)
>>> -                     mdelay(wait_time);
>>> -     } while (wait_time);
>>> +     rc = rtas_fadump_call(fadump_conf, FADUMP_UNREGISTER, &fdm,
>>> +                           sizeof(struct rtas_fadump_mem_struct), "unregister");
>>> +     if (rc == -ETIMEDOUT)
>>> +             return -ETIMEDOUT;
>>>
>>>        if (rc) {
>>>                pr_err("Failed to un-register - unexpected error(%d).\n", rc);
>>> @@ -259,19 +279,13 @@ static int rtas_fadump_unregister(struct fw_dump *fadump_conf)
>>>
>>>    static int rtas_fadump_invalidate(struct fw_dump *fadump_conf)
>>>    {
>>> -     unsigned int wait_time;
>>>        int rc;
>>>
>>> -     /* TODO: Add upper time limit for the delay */
>>> -     do {
>>> -             rc =  rtas_call(fadump_conf->ibm_configure_kernel_dump, 3, 1,
>>> -                             NULL, FADUMP_INVALIDATE, fdm_active,
>>> -                             sizeof(struct rtas_fadump_mem_struct));
>>> -
>>> -             wait_time = rtas_busy_delay_time(rc);
>>> -             if (wait_time)
>>> -                     mdelay(wait_time);
>>> -     } while (wait_time);
>>> +     rc = rtas_fadump_call(fadump_conf, FADUMP_INVALIDATE,
>>> +                           (void *)fdm_active,
>>> +                           sizeof(struct rtas_fadump_mem_struct), "invalidate");
>>> +     if (rc == -ETIMEDOUT)
>>> +             return -ETIMEDOUT;
>>>
>>>        if (rc) {
>>>                pr_err("Failed to invalidate - unexpected error (%d).\n", rc);
>>> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.h b/arch/powerpc/platforms/pseries/rtas-fadump.h
>>> index c109abf6b..65fdab7b5 100644
>>> --- a/arch/powerpc/platforms/pseries/rtas-fadump.h
>>> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.h
>>> @@ -41,6 +41,12 @@
>>>    #define MAX_SECTIONS                                10
>>>    #define RTAS_FADUMP_MAX_BOOT_MEM_REGS               7
>>>
>>> +/*
>>> + * Maximum time to wait for firmware to respond to an
>>> + * ibm,configure-kernel-dump RTAS call before giving up.
>>> + */
>>> +#define RTAS_FADUMP_MAX_WAIT_MS                      60000U
>>> +
>>>    /* Kernel Dump section info */
>>>    struct rtas_fadump_section {
>>>        __be32  request_flag;
>> Changes look good to me.
>>
>> Feel free to add:
>> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>
>> While testing this patch I realized that fadump prints below message
>> when registered is successfully
>> <rtas/opal> fadump: Registration is successful
>>
>> But there is no message when fadump is unregistered successfully. I
>> think it is good to
>> log that event.  I will send a separate patch for this.
>>
>> - Sourabh Jain


