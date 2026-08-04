Return-Path: <linuxppc-dev+bounces-25332-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DD3C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:37:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDkPJ2cmxz2yYs;
	Tue, 04 Aug 2026 16:37:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785825460;
	cv=none; b=Yf2URvVGNpowcttbrbakzfMu2iPN4UZDH6byAqCSznTMoTUK7a6CGSHcyIzA+2O2sKBB7IKQ4z54EXhzmYNebVg4qIx8QpleCQ8hi5Ht/rt3kUx+1VM09dTszsa8MUMa0KSAYW7rTXlEXEfqy1xw8XdzwMideS1WWBJ3Q/6KKYkyy6X1vJujTJfK2dB40xRvLm6GDNJOZGi6vOdVKz6adDlcVDtO9GHP0/QpV6TfLrYSFRz/hzTtZwG53/LRWFFTaTEQ3Zp+dYsP08IkyOhST0lDW5BtYj6qyri9305Ljcd6yudq3NwoDANvtmy2wc6MTf/RaOzpe75V+o6ANVmo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785825460; c=relaxed/relaxed;
	bh=ixcwCpKyKh1v5fLxx1LvJAh/miSvd+xzBbIw0UaNQZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=az/2/0qNA3LmS7stzXDXDJsVkEeWpaWAega0sM7uMYjTTp6kZ+akKRu1WsVFMVhML++SNtQuchnzmI+MHELs5gd12QduXwxJ/4TyZ3hPytCWY87XlDhCrEmqT07JlZF+fOsBQzJe2S74fBYTCjt7byNowTPIXoHqayykmV3H5N7K0RS53OK/r1xOVbhS6PJy+d2vrn1piHeTx/m6iI1rbT2/0Bzd1oj3duzWnMC78YMknBQREc0sXp44rmoMxv+u/GFv8TEyLaaHVBirAV7j+fiREEkWOcoL4MiV9yEsOjfZl2G/S81gbIXc8TmQ2SCmaI5T0K5OCSS1CaqYnP+rog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BA7shSzV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BA7shSzV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDkPH3wf8z2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:37:39 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741HiXF3656281;
	Tue, 4 Aug 2026 06:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ixcwCp
	KyKh1v5fLxx1LvJAh/miSvd+xzBbIw0UaNQZ4=; b=BA7shSzVZKVm8HQRlGftq5
	VPothERnRh4YRvUvA9jjSyEq99/F4kQ6qI09NlMzBttA4mUoOQCMy2x10n4E1Dy0
	faZkjqKLDiBwHZlqYWdsqmSZBoM/L/bI4elZBP9TbllDBJuPWuxd9vcq/CmfqZSp
	8Mp0rFu42FrDwDiR6AYx5CJNp0F0QXBeVsGxZvvGObXngkGz/znVqg3W4fe+ikoO
	3y2T1w9TmYS68lpVqoQzCi+k+wfGGMBFdX+D9hUAF6Uw8plTD2g0w3aWpn+N6/km
	hSnhofSkr4DBj3ucZPwnyIjWwYB2WPCbdy5hsYNe/5BridIn/vUmL8LAcZ4cSU/A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4vg4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:37:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746QQp4011389;
	Tue, 4 Aug 2026 06:37:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw0vba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:37:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6746bJh251904982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:37:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4039B2004D;
	Tue,  4 Aug 2026 06:37:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD2F120040;
	Tue,  4 Aug 2026 06:37:14 +0000 (GMT)
Received: from [9.123.6.250] (unknown [9.123.6.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 06:37:14 +0000 (GMT)
Message-ID: <3ba77c24-2b62-4b24-98f6-c4f7ce0a9309@linux.ibm.com>
Date: Tue, 4 Aug 2026 12:07:13 +0530
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
Subject: Re: [PATCH v2 4/5] powerpc/pseries: Implement RTAS error injection
 via pseries_eeh_err_inject
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-5-nnmlinux@linux.ibm.com>
 <f5701f0e-5e91-449e-aaf8-0d0ff4400f33@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <f5701f0e-5e91-449e-aaf8-0d0ff4400f33@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX9WDuIjQpoxWt
 oHFyPLRyo/uyfLJRMJF3qgQlqAozJIT7gCeBdVS49r3tgFHxWEiWpAiaQTKJVkGcVvDvXt9tqN7
 58fIHLH/QDd9fEeb2+nIYUmT/c9rH+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX71fKYW+nFBeO
 Hv2Ha5SHF73/FAfx0U7HydxtQF0LMn+QkxeIEYwzBAaSMHhVLKACo+f03xZXvdBvcyMIQHvAbMr
 G/7uLt9P/2JJ1yqXjd1xtIhrWGE2Zk2RdbOzgLvbG07uwnIMorCMYh9Mwc0Rg4aWAQUHqqzcdDl
 hLjdsup1GlDglRPPbVnzXigM9WhRjXUOAqdEZe6YpmIy3UnYW8ROPYmQPOyUtl7WhTVooeqhp0R
 XS8tmlRcudYftINxtmwZIDMkXkClz+Gy4cGo//DaFhSa+02yzfhAp5EPjXFXlT5vOt3Q5AGL+Ia
 cIHPRcbIjyowgdIdSWIJpghf+rYTmzyV0u1dyqtB7mSyDPdnyiHM1ttClaw+0OEa6MLaeHtciU3
 LEbRE9U2drhJN6EA/gDPzQOqF9r+l9Fazf/r4ZRF4YKMmNOTd2AS2bySlMuMlEkKxof2gf//7LE
 YqNieOuN19JNFXEzXig==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7188a8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=l9DjJgc0GmXvglxNSFsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DPWLbPBjQ-eUinCA1lkUE0r--Wls3K-T
X-Proofpoint-GUID: Exy9QtWvNsCE_i7ZK2ojzTXeG4qkbuQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040048

Hi Sourabh,
On 10/06/26 9:15 AM, Sourabh Jain wrote:
>
>
> On 27/05/26 12:54, Narayana Murty N wrote:
>> Replace legacy MMIO error injection with full PAPR-compliant RTAS error
>> injection supporting 14+ error types via
>>   - ibm,open-errinjct
>>   - ibm,errinjct
>>   - ibm,close-errinjct.
>>
>> Key features:
>> - Complete open-session-inject-close cycle management
>> - Special handling for ibm,open-errinjct output format (token,status)
>> - Comprehensive buffer preparation per PAPR layouts
>> - All pr_* logging uses pr_fmt("EEH: ") prefix
>>
>> Tested with corresponding QEMU patches:
>> https://lore.kernel.org/all/20251029150618.186803-1-nnmlinux@linux.ibm.com/ 
>>
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 168 ++++++++++++++++---
>>   1 file changed, 147 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c 
>> b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> index d6f2e0d43b89..6af2a153ec25 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -902,8 +902,7 @@ static int validate_special_event(unsigned long 
>> addr, unsigned long mask)
>>    * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
>>    */
>>   -static int validate_corrupted_page(struct eeh_pe *pe __maybe_unused,
>> -                   unsigned long addr, unsigned long mask)
>> +static int validate_corrupted_page(unsigned long addr, unsigned long 
>> mask)
>>   {
>>       if (!addr) {
>>           pr_err("corrupted-page requires non-zero addr\n");
>> @@ -978,7 +977,7 @@ static int prepare_errinjct_buffer(struct eeh_pe 
>> *pe, int type, int func,
>>           if (addr == 0)
>>               return RTAS_INVALID_PARAMETER;
>>   -        if (validate_corrupted_page(pe, addr, mask))
>> +        if (validate_corrupted_page(addr, mask))
>>               return RTAS_INVALID_PARAMETER;
>>             buf32[0] = cpu_to_be32(upper_32_bits(addr));
>> @@ -1047,6 +1046,97 @@ static int prepare_errinjct_buffer(struct 
>> eeh_pe *pe, int type, int func,
>>       return 0;
>>   }
>>   +/**
>> + * rtas_open_errinjct_session - Open an RTAS error injection session
>> + *
>> + * Opens a session with the RTAS ibm,open-errinjct service.
>> + *
>> + * Return: Positive session token on success, negative error code on 
>> failure.
>> + */
>> +static int rtas_open_errinjct_session(void)
>> +{
>> +    int open_token, args[2] = {0};
>> +    int rc, status, session_token = -1;
>> +
>> +    open_token = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
>> +    if (open_token == RTAS_UNKNOWN_SERVICE) {
>> +        pr_err("RTAS: ibm,open-errinjct not available\n");
>> +        return RTAS_UNKNOWN_SERVICE;
>> +    }
>> +
>> +    /* Call open; original code treated rtas_call return as session 
>> token */
>> +    rc = rtas_call(open_token, 0, 2, args);
>> +    status = args[1];
>> +    if (status != 0) {
>> +        pr_err("RTAS: open-errinjct failed: status=%d args[1]=%d 
>> rc=%d\n",
>> +               status, args[1], rc);
>> +        return status ? status : -EIO;
>> +    }
>> +
>> +    session_token = args[0];
>> +    pr_info("Opened injection session: token=%d\n", session_token);
>> +    return session_token;
>> +}
>> +
>> +/**
>> + * rtas_close_errinjct_session - Close an RTAS error injection session
>> + * @session_token: Session token returned from open
>> + *
>> + * Attempts to close a previously opened error injection session. 
>> Best-effort;
>> + * logs warnings if close fails or if service is unavailable.
>> + */
>> +
>> +static void rtas_close_errinjct_session(int session_token)
>> +{
>> +    int close_token, args[2] = {0};
>> +
>> +    if (session_token <= 0)
>> +        return;
>> +
>> +    close_token = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
>> +    if (close_token == RTAS_UNKNOWN_SERVICE) {
>> +        pr_warn("close-errinjct not available\n");
>> +        return;
>> +    }
>> +
>> +    args[0] = session_token;
>> +    rtas_call(close_token, 1, 1, args);
>> +    if (args[0])
>> +        pr_warn("close-errinjct  args[0]=%d\n", args[0]);
>> +}
>> +
>> +/**
>> + * do_errinjct_call - Invoke the RTAS error injection service
>> + * @errinjct_token: RTAS token for ibm,errinjct
>> + * @type:           RTAS error type
>> + * @session_token:  RTAS error injection session token
>> + *
>> + * Issues the RTAS ibm,errinjct call with the prepared work buffer. 
>> Logs errors
>> + * on failure.
>> + *
>> + * Return: 0 on success, negative error code otherwise.
>> + */
>> +
>> +static int do_errinjct_call(int errinjct_token, int type, int 
>> session_token)
>> +{
>> +    int rc, status;
>> +
>> +    if (errinjct_token == RTAS_UNKNOWN_SERVICE)
>> +        return -ENODEV;
>> +
>> +    /* errinjct takes: type, session_token, workbuf pointer (3 in), 
>> returns status */
>> +    rc = rtas_call(errinjct_token, 3, 1, &status, type, session_token,
>> +               rtas_errinjct_buf);
>
> Why are we passing virtual address of rtas_errinjct_buf (working 
> buffer address) to rtas call?

You are right. |ibm,errinjct|expects the physical address of the RTAS 
work buffer.
Passing the kernel virtual address of |rtas_errinjct_buf|here was incorrect.
This has been fixed in v3. The error-injection buffer is allocated in an
RTAS-accessible RMO region, and the physical address of the buffer is passed
to |ibm,errinjct|. The virtual address is used only by the kernel while 
preparing the buffer contents.


Thanks,
Narayana
>
>> +
>> +    if (rc || status != 0) {
>> +        pr_err("RTAS: errinjct failed: rc=%d, status=%d\n", rc, 
>> status);
>> +        return status ? status : -EIO;
>> +    }
>> +
>> +    pr_info("RTAS: errinjct ok: rc=%d, status=%d\n", rc, status);
>> +    return 0;
>> +}
>> +
>>   /**
>>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>>    * @pe: the indicated PE
>> @@ -1060,30 +1150,66 @@ static int prepare_errinjct_buffer(struct 
>> eeh_pe *pe, int type, int func,
>>   static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int 
>> func,
>>                     unsigned long addr, unsigned long mask)
>>   {
>> -    struct    eeh_dev    *pdev;
>> +    int rc = 0;
>> +    int session_token = -1;
>> +    int errinjct_token;
>>   -    /* Check on PCI error type */
>> -    if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>> -        return -EINVAL;
>> +    /* Validate type */
>> +    if (!validate_err_type(type)) {
>> +        pr_err("RTAS: invalid error type 0x%x\n", type);
>> +        return RTAS_INVALID_PARAMETER;
>> +    }
>> +    pr_debug("RTAS: error type 0x%x\n", type);
>>   -    switch (func) {
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
>> +    /* For IOA bus errors we must validate err_func and addr/mask in 
>> PE.
>> +     * For other types: if addr/mask present we'll still validate 
>> BAR range;
>> +     * otherwise skip function checks.
>> +     */
>> +    if (type == RTAS_ERR_TYPE_IOA_BUS_ERROR ||
>> +        type == RTAS_ERR_TYPE_IOA_BUS_ERROR_64) {
>> +        /* Validate that addr/mask fall in the PE's BAR ranges */
>> +        rc = validate_addr_mask_in_pe(pe, addr, mask);
>> +        if (rc)
>> +            return rc;
>> +    } else if (addr || mask) {
>> +        /* If caller provided addr/mask for a non-IOA type, do a BAR 
>> check too */
>> +        rc = validate_addr_mask_in_pe(pe, addr, mask);
>> +        if (rc)
>> +            return rc;
>>       }
>>   -    return 0;
>> +    /* Open RTAS session */
>> +    session_token = rtas_open_errinjct_session();
>> +    if (session_token < 0)
>> +        return session_token;
>> +
>> +    /* get errinjct token */
>> +    errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
>> +    if (errinjct_token == RTAS_UNKNOWN_SERVICE) {
>> +        pr_err("RTAS: ibm,errinjct not available\n");
>> +        rc = -ENODEV;
>> +        goto out_close;
>> +    }
>> +
>> +    /* prepare shared buffer while holding lock */
>> +    spin_lock(&rtas_errinjct_buf_lock);
>> +    rc = prepare_errinjct_buffer(pe, type, func, addr, mask);
>> +    if (rc) {
>> +        spin_unlock(&rtas_errinjct_buf_lock);
>> +        goto out_close;
>> +    }
>> +
>> +    /* perform the errinjct RTAS call */
>> +    rc = do_errinjct_call(errinjct_token, type, session_token);
>> +    spin_unlock(&rtas_errinjct_buf_lock);
>> +
>> +out_close:
>> +    /* always attempt close if we opened a session */
>> +    rtas_close_errinjct_session(session_token);
>> +    return rc;
>>   }
>>   +
>>   static struct eeh_ops pseries_eeh_ops = {
>>       .name            = "pseries",
>>       .probe            = pseries_eeh_probe,
>


