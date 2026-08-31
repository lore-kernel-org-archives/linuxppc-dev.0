Return-Path: <linuxppc-dev+bounces-26315-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F0CC624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:10:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXV11vVhz2yCv;
	Tue, 01 Sep 2026 01:10:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788189001;
	cv=none; b=D9juJBcBoxIe0/Yw4Ny8xCpFBnXifvAUB5XOWJb1SOisL7y8/38A3jneSleGZuyX61sQ/JtyYMs1cul/x1ZMDJwHOt98aybwR1xS38O2tPuKbGxt19nykyDpnKoju3srlNUSwdEfSr2Jfrls0JkD0pSnDya67QUeVAqtaDXNFT7KI6k8ACKtKG1AAijU0c7zrBQTL3iEw+la8SbvPpQkJH3hULhXadON8gWpq7PUu4daZcsOluAkvWH3veWecG1UJf5nYJtlK1kadDWRbBxHFtuLEtPQvQ/if+zTpXCopikWIQPMzBuu+UKBtiFbd+7rBqM6WNmvl4M8ED4k3hMgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788189001; c=relaxed/relaxed;
	bh=nqvvjocRJPuBAbBXC+gYZnypv5W8yQhGpHk8UKs+KXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVCaHhHpCTuFwD9LKphLcv5hOiHiN14VvqbT750WyW1Ih/hr55ucgn7t/u5ffGMNFNMYbyZbE/9Ons96mxFGyXLm8nJGTD+QUDZbsYQn/1VCKNETgam2HPeWmppZbGMc+reeUB0bEb7O12mvuKt66Oy4ydPbwMyBWvNFYLuNM/KfBW4qJTVptehDhHaHBYK1SCebLtaPQyhmeuHFhXJfrB+Eeh9OAfWq5DTEfyixkzSrn3Duq06TFVSth7XoBqZyulE5A1FRVckKnTY/I1G/wBTRdjJZfujnAwmXWD4q8dlQ5dTSZCWXvo3p5DpSgFJGKu1B2CnMNWHKCsk429FvVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OHiS9OG+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OHiS9OG+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXV01QCsz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:10:00 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ3nX2530191;
	Mon, 31 Aug 2026 15:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nqvvjo
	cRJPuBAbBXC+gYZnypv5W8yQhGpHk8UKs+KXk=; b=OHiS9OG+EGsT5N0RUyCKo3
	BuURiJcZDFngnsOaquGVEAxGJkdc5dBGlIZPNl7FynopaNU097P22GctIaCXocUg
	1kvjBZXU8cWbOYLR73A/TXmpPPhzZv7anYVgc2vJtunIc9jSh0HHX2kAqa+PQ6SK
	E2XFoIwY4HwoVXAd5BmrRt8EoUtXhL1HwmYZ/iUiRx84RNn/7UnRklYONrq6koPV
	5w2J1iJEbleHmOCZQA0YhuR53ynlxzfJlXfkVA50ROzi1p4cb0nnyeCeCzI1keYn
	w2+6b8tOMAHHFXAMeujs0Q1CLhDJzxgToG/ftnCc7kYvnYN8gVwzqLvv1XmgejKA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5a4y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEubqh024915;
	Mon, 31 Aug 2026 15:09:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjxk6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:09:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF9e9n51904878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:09:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 732B02004E;
	Mon, 31 Aug 2026 15:09:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C24902004D;
	Mon, 31 Aug 2026 15:09:36 +0000 (GMT)
Received: from [9.124.217.83] (unknown [9.124.217.83])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:09:36 +0000 (GMT)
Message-ID: <d7031bd9-9485-4cc5-a06e-082f91cad91a@linux.ibm.com>
Date: Mon, 31 Aug 2026 20:39:35 +0530
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
Subject: Re: [PATCH v3 4/5] powerpc/pseries/eeh: Implement RTAS-based EEH
 error injection
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-5-nnmlinux@linux.ibm.com>
 <1f8f70a4-2e5c-4e41-a8f1-9a32f37286d0@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <1f8f70a4-2e5c-4e41-a8f1-9a32f37286d0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a95993c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vIEh78ILgNviK4F0Fn4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: L7CN_AlEYjPbasFBPyqlV6Wz608COKa3
X-Proofpoint-ORIG-GUID: 7NAaSYsUr21Hi2mBBMamfimicZzkrs8b
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXx0+Z2sB7lclt
 DipgknIzDYO3yuqM35grwo+ta5uhRiQ32vAMS0ofXitvt8/y15EU9hLXV4ArGmWFstizELNM2bW
 Ed6+Joztb6NvCpF0z/py/6RmQN0mMQA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX20QSbVdRjrH6
 3FRVadgvXmipuPounmuxXcarphH+7sjUF9T/5q0XwDr4GQPeTPpaiGzLflyw2Bn0qcvkQaOQVw4
 Zc0nB6kgV0z0+4EeF8TjkeJszc7wvY92xZM17PWngePBdura+CY+ErhiMatAwuWTNPmBDs6nnZJ
 er7qbml9zdkfjLAdn7/SWAefRedDRueP5un3y9pjdNMP8AXW5vW8LGL414Qoy/6FGLqyrUvJmjI
 DzO8EzqX3vm9OhSzuiR2+fukUHmFwWmyisH7uBPFUEW4uHYqn+2hS9MIpTPZVkrikTPI0y3mxue
 RWNda4WT4w9zYdFJ9Pc1bm4/ZE81NoAkJPNx3XNoeeBPxggu5/DjOGWvM7UJ7GFPDcSmqlWrtF0
 yXKAR6icR3GugpNvonEzC+AfQrEvemjKI4Oe89RZYUWSp276ODU1Gs3npjwz2IrI9K8cpinL6PC
 Yx19M8bbeAqwdMXB/RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310130

Hi Sourabh,
Thanks for the review.

On 04/08/26 11:56 PM, Sourabh Jain wrote:
> 
> 
> On 21/07/26 09:08, Narayana Murty N wrote:
>> Replace legacy MMIO error injection with full PAPR-compliant RTAS error
>> injection supporting 14+ error types via
>>    - ibm,open-errinjct
>>    - ibm,errinjct
>>    - ibm,close-errinjct.
>>
>> Key features:
>>    - Complete open-session-inject-close cycle management
>>    - Special handling for ibm,open-errinjct output format (token,status)
>>    - Comprehensive buffer preparation per PAPR layouts
>>    - All pr_* logging uses pr_fmt("EEH: ") prefix
>>
>> Tested with corresponding QEMU patches:
>> https://lore.kernel.org/all/20251029150618.186803-1- 
>> nnmlinux@linux.ibm.com/
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 121 +++++++++++++++----
>>   1 file changed, 95 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/ 
>> powerpc/platforms/pseries/eeh_pseries.c
>> index 25aad86c696d..d32a84009fdc 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -1037,40 +1037,109 @@ static int prepare_errinjct_buffer(void *buf, 
>> struct eeh_pe *pe,
>>   }
>>   /**
>> - * pseries_eeh_err_inject - Inject specified error to the indicated PE
>> - * @pe: the indicated PE
>> - * @type: error type
>> - * @func: specific error type
>> - * @addr: address
>> - * @mask: address mask
>> - * The routine is called to inject specified error, which is
>> - * determined by @type and @func, to the indicated PE
>> + * pseries_eeh_err_inject - Inject specified error into the indicated PE
>> + * @pe:   the indicated PE
>> + * @type: generic EEH error type (EEH_ERR_TYPE_*)
>> + * @func: error function selector (EEH_ERR_FUNC_*)
>> + * @addr: target address, if applicable
>> + * @mask: address mask, if applicable
>> + *
>> + * Implements the EEH error-injection callback for pseries using the 
>> RTAS
>> + * ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct firmware 
>> services.
>> + *
>> + * Generic EEH error types are translated to RTAS firmware type codes 
>> via
>> + * pseries_eeh_type_to_rtas() before the injection session is opened.
>> + * Unsupported generic types are rejected with -EINVAL before any 
>> RTAS call
>> + * is made.  Existing userspace is unaffected.
>> + *
>> + * Return: 0 on success, negative errno or RTAS error code on failure.
>>    */
>>   static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int 
>> func,
>>                     unsigned long addr, unsigned long mask)
>>   {
>> -    struct    eeh_dev    *pdev;
>> -
>> -    /* Check on PCI error type */
>> -    if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>> -        return -EINVAL;
>> +    int open_token, errinjct_token, close_token;
>> +    int session_token = 0;
>> +    bool session_open = false;
>> +    void *buf;
>> +    u32 buf_phys;
>> +    int rc;
>> +    int rtas_type;
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
>> +    /* Guard: buffer must fit in 32 bits for RTAS */
>> +    if (WARN_ON_ONCE(upper_32_bits(rtas_errinjct_buf)))
>>           return -ERANGE;
>> +
>> +    /* Map generic EEH ABI to RTAS-internal error type */
>> +    rtas_type = pseries_eeh_type_to_rtas(type);
>> +    if (rtas_type < 0) {
>> +        pr_err("unsupported EEH error type %#x\n", type);
>> +        return rtas_type;
> 
> How about -EINVAL instead?
Agreed.
> 
>>       }
>> -    return 0;
>> +    /* Verify all three RTAS tokens are available before touching 
>> firmware */
>> +    open_token    = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
>> +    errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>> +    close_token   = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
>> +
>> +    if (open_token    == RTAS_UNKNOWN_SERVICE ||
>> +        errinjct_token == RTAS_UNKNOWN_SERVICE ||
>> +        close_token   == RTAS_UNKNOWN_SERVICE) {
>> +        pr_err("ibm,open/errinjct/close-errinjct not available\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    buf      = __va(rtas_errinjct_buf);
>> +    buf_phys = lower_32_bits(rtas_errinjct_buf);
>> +
>> +    mutex_lock(&rtas_errinjct_mutex);
>> +
>> +    /* Step 1: open injection session */
>> +    do {
>> +        rc = rtas_call(open_token, 0, 2, &session_token);
>> +    } while (rtas_busy_delay(rc));
>> +
>> +    if (rc) {
>> +        pr_err("ibm,open-errinjct failed: status=%d\n", rc);
>> +        goto out_unlock;
>> +    }
>> +    session_open = true;
>> +
>> +    /* Step 2: prepare the work buffer */
>> +    rc = prepare_errinjct_buffer(buf, pe, rtas_type, func, addr, mask);
>> +    if (rc) {
>> +        pr_err("failed to prepare errinjct buffer: rc=%d\n", rc);
>> +        goto out_close;
>> +    }
>> +
>> +    /* Step 3: inject the error */
>> +    do {
>> +        rc = rtas_call(errinjct_token, 3, 1, NULL,
>> +                   rtas_type, session_token, buf_phys);
>> +    } while (rtas_busy_delay(rc));
>> +
>> +    if (rc)
>> +        pr_err("ibm,errinjct failed: status=%d\n", rc);
>> +
>> +out_close:
>> +    /* Step 4: always close the session */
>> +    {
>> +        int close_rc;
> 
> Why are having separate rc variable for close close token call?
> 
The intent was to preserve the original inject failure status while 
still attempting to close the error-injection session. If ibm,errinjct 
fails and ibm,close-errinjct also fails, returning the close status 
would hide the original injection failure.

So close_rc is used only to report close failure with pr_warn(), while 
the function returns the status from the open/prepare/inject path.
>> +
>> +        if (session_open) {
> 
> is session_open variable really needed?

It is mostly defensive. It avoids calling ibm,close-errinjct if 
ibm,open-errinjct failed before a valid session was established.

In v4, I simplified the flow so the close path is only used after a 
successful open. That makes the control flow clearer and avoids carrying 
unnecessary state.

Regards,
Narayana.
> 
>> +            do {
>> +                close_rc = rtas_call(close_token, 1, 1, NULL,
>> +                             session_token);
>> +            } while (rtas_busy_delay(close_rc));
>> +
>> +            if (close_rc)
>> +                pr_warn("ibm,close-errinjct failed: status=%d\n",
>> +                    close_rc);
>> +        }
>> +    }
>> +
>> +out_unlock:
>> +    mutex_unlock(&rtas_errinjct_mutex);
>> +    return rc;
>>   }
>>   static struct eeh_ops pseries_eeh_ops = {
> 


