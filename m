Return-Path: <linuxppc-dev+bounces-26871-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF1EC79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:07:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfr256SlZz2y2J;
	Wed, 09 Sep 2026 16:07:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934061;
	cv=none; b=PkAMkP/+3au3R3a0GTTjiBGXDiv65iHdQ/XR0C2jsIi+dj1shh8dWqUmclpHGLjZydN0PjL6GBItoKxvBhhAeHzWtfsffta3rZkybYpqgNxrMEXF55FdZkd5ANWHsRX2U+UWX6Hr7c6YFV6wXZZinpWEXtrMvmQlav6BUxtK34snVD95OvgBVYGvdRrqV/MugMzX3qXHP56Vq4L4c1CjPw34AmHX56tdkImNzSdcyJ0xQ58uaVAknDNr/oBjaSgBI2FksQASq7HsTNqsGwVI63JTEkJSKoz7xO3uX5JiPgGqHNub9Kn5ZDaTCYOjc5nJfNZ86IqUYbrcwrL3PyWhOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934061; c=relaxed/relaxed;
	bh=uk0u9FhT8YAH7rD+2Bj1nJLC1XnYAKmxfuVYeYYnnkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUitbTTC/NjOOXWop1/KC4znlTR911V3qk1EqlRA/iYWM7S89KsFEBaGeLY99waNkjyfZN8amT8G7D0qj71XAKRAEH9H/jn2ldyYPxJh5NhSJMFc0tbEoEjOpjG13oDmbkxjSCPwpehMqykMdbiv8RSwICbMCNGyayqOMQ1mFT2OO0TmvFZBj8OAjqkJsLboG+OlKyH9IOkUdC8YMSaIpd1TAY0d9bUf55iYkRMNCw9xDf9xRin8CIv4oHTUFnCd5qiIjKDCI6kETxnOlD0W7D+3NJZYeqjRPSQyKfvfCpQcJYOmEr2x54S7bWjdqr7z5XKnYcYF42zGr+w9ptF3cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SGqNqT7N; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SGqNqT7N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfr2464hcz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:07:40 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1xrx2300030;
	Wed, 9 Sep 2026 06:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uk0u9F
	hT8YAH7rD+2Bj1nJLC1XnYAKmxfuVYeYYnnkQ=; b=SGqNqT7NhyV7eelVSmXiuG
	0aj0OV/uXABjiZ+IOBfb9w9woaFsRv64UfPiA8aG/MSRmHcGMkrBpfKehCfvfgpM
	jhTB6Ni4AQO6BALVjl9lgcxJilB9jrVeRfXWUij+KuoMjhlqSLU3+BPsno51v+pR
	vv5bB9eK6NBeauOB20bpo681uEYYs00hgY2zeRCVJKVI9YWN59zjDjrr4o1IX7J2
	bLNs9Ob0RALTKYHfu2u7e2GUigbLyfVPHg1rr8gry8uhkqmkwbv5hldgN0smgPUS
	IGQoJsknba7cACmk0s9RrNTQ3R/nS8wknCV/+QgNqjnuGRqvQ0bPPnzQ1CzIM1zg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf3nh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:07:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6895uGhM021023;
	Wed, 9 Sep 2026 06:07:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgge7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:07:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68967Ni850135338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:07:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67DD020040;
	Wed,  9 Sep 2026 06:07:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A541620043;
	Wed,  9 Sep 2026 06:07:20 +0000 (GMT)
Received: from [9.123.3.199] (unknown [9.123.3.199])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:07:20 +0000 (GMT)
Message-ID: <385c38cc-fb9a-446c-9e19-2e4fa0631f19@linux.ibm.com>
Date: Wed, 9 Sep 2026 11:37:19 +0530
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
Subject: Re: [PATCH v4 4/5] powerpc/pseries/eeh: Implement RTAS-based EEH
 error injection
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        oohall@gmail.com, npiggin@gmail.com, tpearson@raptorengineering.com,
        alex@shazbot.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
References: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
 <20260831065441.48654-5-nnmlinux@linux.ibm.com>
 <02c8c3a8-04f4-4664-a4fd-5223f5262508@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <02c8c3a8-04f4-4664-a4fd-5223f5262508@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: mYuO9aD32imxhIklcFwbp62gmjUb7VNu
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa0f7a0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=0oMT2e0EhHCWqyLYaj0A:9 a=dMb2Ee1TWpK55KY-:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX4tFqblkBdvbo
 6+3oNOlFrq4hQNeGKRr9tlvRGKE3rBDAqIOdKxD7TESrd84ov9sdXiyGnVEq5fXriQ41P5wzs2U
 1Z7yF8vbJJj7+Pt0ZjHxDxHn4KXOJu4=
X-Proofpoint-ORIG-GUID: 9eqMUFyMvjAfEwXkjFkTZYLlG5JxWgst
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX1el77rZ9xIoa
 GAfXqQ5svvrsHCwaGSvrvnh6LSTMBSbShIlP7YfbuB82kJq1DrPsLNAwzSiEiFbr+vEhANUQe1i
 i98LP4bThHwRUGMFpvCaTtRedqdgZEq9IfS98MbAEgVyJb8LPREr1MiMsremu1UwEAgZ7zDHttG
 bGy/5zTmaF2yb78I3QS/DJR7VkVSKjUByWTdbFNj1XNd96CX/1IzHz9C5jUTGI1AZTQ33dneMWK
 meuUO38kJ8vOK+hNSUBXY8MTZgdA4YPQcDMwJusVzqO1Qq3OfbaEAlOY+i5wnXsEimLDmDHYovp
 0nj0fQ2cL0G/HCwg/OISgtc5luz1nGuuumBoZQl8bJBdTDAgy4xSqZMrEqlDjjEkVJUVl1ZrfRL
 5RIo/1vp3dlB0DgA0Q/86qHHMafR5SOVeLuGTSTLh4fXdWuc3B3vRILbFDuPoUZ5fvKeAl0wabz
 qt3nnm6MXyYa+yFft/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066



On 02/09/26 10:46 AM, Sourabh Jain wrote:
> 
> 
> On 31/08/26 12:24, Narayana Murty N wrote:
>> Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
>> PAPR-compliant RTAS error injection path using the existing RTAS
>> work-area allocator.
>>
>> The mutex is not a buffer lock;
> Sorry but I didn't get this...
> 
>> it serializes the firmware session
>> open/inject/close sequence as required by PAPR.  No global buffer
>> is allocated or used.
> Nit:
> I think the above para is influenced form old suggestion to not use global
> dedicated buffer. Lets drop the global buffer thing from commit message
> explain just the current approach.
> 
Agreed. I will clean up the commit message and describe only the current
implementation. I will drop the "mutex is not a buffer lock" and "no 
global buffer is used" wording.
>>
>> VFIO EEH error injection exposes a generic userspace ABI.  pSeries maps
>> the generic EEH error types to RTAS ibm,errinjct encodings via
>> pseries_eeh_type_to_rtas().  EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are
>> unchanged; their values are defined in arch/powerpc/include/uapi/asm/ 
>> eeh.h
>> and are not renumbered.
>>
>> Tested with corresponding QEMU patches:
>> https://lore.kernel.org/all/20251029150618.186803-1- 
>> nnmlinux@linux.ibm.com/
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 123 ++++++++++++++-----
>>   1 file changed, 95 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/ 
>> powerpc/platforms/pseries/eeh_pseries.c
>> index fafe0004e738..fcb8c560d813 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/rbtree.h>
>>   #include <linux/sched.h>
>>   #include <linux/seq_file.h>
>> +#include <linux/mutex.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/crash_dump.h>
>> @@ -34,6 +35,7 @@
>>   #include <asm/machdep.h>
>>   #include <asm/ppc-pci.h>
>>   #include <asm/rtas.h>
>> +#include <asm/rtas-work-area.h>
>>   /* RTAS tokens */
>>   static int ibm_set_eeh_option;
>> @@ -958,8 +960,6 @@ static int prepare_errinjct_buffer(void *buf, 
>> struct eeh_pe *pe,
>>               return -EINVAL;
>>           if (upper_32_bits(addr) || upper_32_bits(mask)) {
>> -            pr_err("32-bit IOA injection cannot encode addr=%#lx 
>> mask=%#lx\n",
>> -                   addr, mask);
> 
> We are returning -EINVAL remove the error message, what is the need?
> 
Agreed. I will remove this unnecessary error message and just return
-EINVAL.

>>               return -EINVAL;
>>           }
>> @@ -992,50 +992,117 @@ static int prepare_errinjct_buffer(void *buf, 
>> struct eeh_pe *pe,
>>           break;
>>       default:
>> -        pr_err("unsupported RTAS error injection type 0x%x\n", 
>> rtas_type);
>> +        pr_err("unsupported RTAS error injection type 0x%x\n",
>> +               rtas_type);
> 
> Above change is not necessary..
> 
Agreed. I will drop this unrelated formatting-only change.
>>           return -EINVAL;
>>       }
>> -    pr_debug("errinjct buffer ready: rtas_type=0x%x func=%d 
>> addr=0x%lx mask=0x%lx\n",
>> -         rtas_type, func, addr, mask);
> 
> What is need to remove this debug message?
There is no strong reason to remove it. I will keep the existing debug 
message.
> 
>>       return 0;
>>   }
>> +/* pseries-local mutex serializes the open/inject/close RTAS session */
>> +static DEFINE_MUTEX(pseries_errinjct_mutex);
>> +
>>   /**
>>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>>    * @pe: the indicated PE
>> - * @type: error type
>> - * @func: specific error type
>> - * @addr: address
>> - * @mask: address mask
>> - * The routine is called to inject specified error, which is
>> - * determined by @type and @func, to the indicated PE
>> + * @type: generic EEH error type (EEH_ERR_TYPE_32 or EEH_ERR_TYPE_64)
>> + * @func: specific error function
>> + * @addr: address argument (type-dependent, may be zero)
>> + * @mask: address mask (type-dependent, may be zero)
>> + *
>> + * Implements PAPR-compliant error injection using:
>> + *   ibm,open-errinjct -> ibm,errinjct -> ibm,close-errinjct
>> + *
>> + * A short-lived RTAS work area is allocated per call; no global buffer
>> + * is used.
> Mentioning "no global buffer is used" is not adding any value, I think.
> 
Agreed.
>> pseries_errinjct_mutex serializes the open/inject/close
>> + * session sequence.
>> + *
>> + * Return: 0 on success, negative errno on failure.
>>    */
>>   static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int 
>> func,
>>                     unsigned long addr, unsigned long mask)
>>   {
>> -    struct    eeh_dev    *pdev;
>> +    struct rtas_work_area *area;
>> +    phys_addr_t area_phys;
>> +    u32 buf_phys;
>> +    void *buf;
>> +    int open_token, errinjct_token, close_token;
>> +    int session_token;
>> +    int rtas_type;
>> +    int close_rc;
>> +    int rc;
>> +
>> +    rc = validate_errinjct_args(pe, type, func, addr, mask);
>> +    if (rc)
>> +        return rc;
>> -    /* Check on PCI error type */
>> -    if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>> +    rtas_type = pseries_eeh_type_to_rtas(type);
>> +    if (rtas_type < 0)
>>           return -EINVAL;
>> -    switch (func) {
>> -    case EEH_ERR_FUNC_LD_MEM_ADDR:
>> -    case EEH_ERR_FUNC_LD_MEM_DATA:
>> -    case EEH_ERR_FUNC_ST_MEM_ADDR:
>> -    case EEH_ERR_FUNC_ST_MEM_DATA:
>> -        /* injects a MMIO error for all pdev's belonging to PE */
>> -        pci_lock_rescan_remove();
>> -        list_for_each_entry(pdev, &pe->edevs, entry)
>> -            eeh_pe_inject_mmio_error(pdev->pdev);
>> -        pci_unlock_rescan_remove();
>> -        break;
>> -    default:
>> -        return -ERANGE;
>> +    open_token    = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
>> +    errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>> +    close_token   = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
>> +
>> +    if (open_token    == RTAS_UNKNOWN_SERVICE ||
>> +        errinjct_token == RTAS_UNKNOWN_SERVICE ||
>> +        close_token   == RTAS_UNKNOWN_SERVICE)
>> +        return -ENODEV;
>> +
>> +    area = rtas_work_area_alloc(RTAS_ERRINJCT_BUF_SIZE);
>> +    buf  = rtas_work_area_raw_buf(area);
>> +    area_phys = rtas_work_area_phys(area);
> 
> 
> I was wondering if there is any need to hold the work area buffer until
> we acquire pseries_errinjct_mutex.
> 
> Would it make sense to allocate the buffer only after acquiring the
> mutex? I suggested an order for the open, errinjct, and close calls
> below, which I think could also help address the above comment.
> 
Agreed. I will reorder the flow as suggested:

1. acquire the mutex
2. call ibm,open-errinjct
3. allocate the RTAS work area
4. populate the work buffer
5. call ibm,errinjct
6. free the RTAS work area
7. call ibm,close-errinjct
8. release the mutex

This avoids allocating the work area if ibm,open-errinjct fails and 
keeps the
work area held only while it is needed.
> Nit: this file is under pseries platform so pseries_errinjct_mutex can 
> renamed to errinct_mutex.
Agreed. I will rename it to errinjct_mutex.
>> +
>> +    if (WARN_ON_ONCE(upper_32_bits(area_phys))) {
>> +        rc = -ERANGE;
>> +        goto out_free_area;
>>       }
>> -    return 0;
>> +    buf_phys = lower_32_bits(area_phys);
> 
> I don't understand the above logic. First, we check area_phys and exit
> early if the address is above 4G, and then we take the lower 32 bits of
> the same address.
> 
> I think the RTAS work area allocation API should be responsible for
> allocating the work area buffer at the right location. The user
> shouldn't have to worry about where exactly the buffer is allocated
> unless they have a specific requirement.
> 
> Is the work area buffer allocated by the API not meeting your
> requirement? If so, could you please explain what the issue is? Let's
> see if we can fix it in the work area allocation API. Otherwise, I
> would suggest removing the checking and truncation done around
> area_phys.
> 
> Let me know your opinion.
> 
Agreed. Since this path uses the RTAS work area allocator, I will remove 
the explicit upper_32_bits(area_phys) check and the local address 
truncation logic. If the allocator does not provide an RTAS-suitable 
address, that should be handled in the allocator rather than in this EEH 
path.
> 
>> +
>> +    rc = prepare_errinjct_buffer(buf, pe, rtas_type, func, addr, mask);
>> +    if (rc)
>> +        goto out_free_area;
>> +
>> +    mutex_lock(&pseries_errinjct_mutex);
>> +
>> +    do {
>> +        rc = rtas_call(open_token, 0, 2, &session_token);
>> +    } while (rtas_busy_delay(rc));
>> +
>> +    if (rc) {
>> +        pr_err("ibm,open-errinjct failed: status=%d\n", rc);
>> +        rc = rtas_error_rc(rc);
>> +        goto out_unlock;
>> +    }
> 
> I think we should allocate the work area buffer only after the
> open-errinjct call succeeds. My preferred order is:
> 
> - Call RTAS open-errinjct
> - Allocate the work area buffer
> - Populate the work area buffer and make the errinjct RTAS call
> - Release the work area buffer
> - Call RTAS close-errinjct
> 
As stated above, will address in next version.
> This way, the work area buffer is held only for as long as it is needed,
> and we also avoid allocating it if open-errinjct fails.
Agreed.
> 
>> +
>> +    do {
>> +        rc = rtas_call(errinjct_token, 3, 1, NULL,
>> +                   rtas_type, session_token, buf_phys);
>> +    } while (rtas_busy_delay(rc));
>> +
>> +    if (rc) {
>> +        pr_err("ibm,errinjct failed: status=%d\n", rc);
>> +        rc = rtas_error_rc(rc);
>> +    }
>> +
>> +    do {
>> +        close_rc = rtas_call(close_token, 1, 1, NULL, session_token);
>> +    } while (rtas_busy_delay(close_rc));
>> +
>> +    if (close_rc) {
>> +        pr_warn("ibm,close-errinjct failed: status=%d\n", close_rc);
>> +        if (!rc)
>> +            rc = rtas_error_rc(close_rc);
>> +    }
>> +
>> +out_unlock:
>> +    mutex_unlock(&pseries_errinjct_mutex);
>> +
>> +out_free_area:
>> +    rtas_work_area_free(area);
>> +    return rc;
>>   }
>>   static struct eeh_ops pseries_eeh_ops = {
> 


