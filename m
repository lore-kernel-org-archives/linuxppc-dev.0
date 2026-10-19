Return-Path: <linuxppc-dev+bounces-29692-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E38CCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:56:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7WD958mmz2xjN;
	Mon, 19 Oct 2026 20:56:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792403817;
	cv=none; b=MwIDC50kfQW+EDd+KZIUUZNRsx9DUjMq3avRj1lfeAvEdImg6rcKpV12EcqAKBgeUEhbUa8HRsyUjP5ON9gyCBMDDgJmOtgGB2qrKdbKFxzJBlN0jt1yHaDPNosd2i2Hyd/XTQaD1qavAoZR1vryrwPy5Af7Nkfb/XyHJf9cMkkchEymOuN73kd9TRKtxGoKKfem0Z2TSJOLYJxOcHn0kfda0I0bT1vX7x/NLV43VsmUyuFJeo+19vQLloNX5RpRV2Z/k3QeeSTKqzuGWrwPUqHPFeiJAXKHneDudbsCYlbue/XZDFSEfDkNUBblTxb6e8mpAqiwAcFWe4wTrviwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792403817; c=relaxed/relaxed;
	bh=CuWa+SkgGgXLoxRtbTofBCsCmxGYvW2B7XqjsBrIafs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joXjgsT+XcpkmVZCnnou6oOYtS6ZS/v3vAVVhXMyUDWpGeNL+RdhRrjdPfMzNsx5gr43nsGXhlNMKifOm79HHafjUj+N5XMN4k2unjAPjVQrwQFIDxv1/8n7P0ZYPzvRri9Ms5cQ5R0hndUPezQ48a2kTwE0d21gYIvCzkbg9+ywqMTy+L/GeifVuEyRAdHGiONIvQ5Ps1+3Z5YWN4szfAPVoDGYEsLur9mP4n7SaLV1oiqUOKv1dVXx00WiveyIL0rJBRX5yerHb2PPN8cxp9dlJoPsexqutBAya2rv7IY5V/8JuTQl57R5Kj0enTwVjL7RJT/ITUFJz37zbAVkWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D3ZDWYmX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D3ZDWYmX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7WD46GL2z2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 20:56:52 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iJWF3250657;
	Mon, 19 Oct 2026 09:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CuWa+S
	kgGgXLoxRtbTofBCsCmxGYvW2B7XqjsBrIafs=; b=D3ZDWYmXf6ohN7xnzDN4Xl
	KL3/RpQeOq5ViOT0nnz0pgsZrv4hUY6yXgHAXaqDv4QpNTqJ+PiF+ndYwKv0fwbe
	dT5PI32a1dGEHL/88ezGyIxkSH1Ox3ypez4LXYwZ4dLkDfsx8z6BEO7yXE3bezRx
	lrJ7IWPwHErEZw3qM2OjkTEtaSyJkBeo3xbaXB3Q1wzfl/D27qlXNXbD5L6+Bt1L
	OXdU9wYjeUVFV1YmjIdKBVWq01Trg6+wzSuLDhvBRqrYngQNKkjLtFulZpIXAHRx
	CMcFRn8NxX1RcMxCgPD8RjKx1A1GRhlPhE4b3mPWJ5w9LYkG3zdtlnDysZJuMAvA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxeht1dj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 09:56:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8noPh3845750;
	Mon, 19 Oct 2026 09:56:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvd8c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 09:56:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69J9uVap54985214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 09:56:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D46612004D;
	Mon, 19 Oct 2026 09:56:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB4CF20040;
	Mon, 19 Oct 2026 09:56:28 +0000 (GMT)
Received: from [9.124.217.62] (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 09:56:28 +0000 (GMT)
Message-ID: <620b6ea4-bb68-4e1f-b345-d8055df86538@linux.ibm.com>
Date: Mon, 19 Oct 2026 15:26:27 +0530
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
 <23c0e185-c56b-4025-8136-326dae53ef4e@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <23c0e185-c56b-4025-8136-326dae53ef4e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX44Zmhu0qU6uk
 tnK9xJiqrm6rWG0CxVpohnxqCNS4GWmu0EcW9sMPVzuOrCsh0Fo3ywN3hphp8UnKr5YLtQ4l3uA
 5yZeEecH2IYNBd4UxLW5GpzYCOpgsKeUHH+ojPgX+p5iCS2wmpT29K+9X+lo/fI8ewjZm7N+DTj
 piq+cAwwS5TcVin2xAxsqi6GzlQSF62zCdUQRlGqgf4ZqX4UqK2t9ulTo8vEKR/6JGxXgNmNFb/
 fMCx779i+0YXfgfkcZ3Npmv0s0LkEkKs5LCbe7R36ieWDswYDh0Ysu2uul0ud40rrCDjc3c2uiP
 aTAkkW7EmobdoJzVDZMefo/TioB0Co3H8ktpIGFbQ3w7vIq1stf85w/jvb9XLn53K+GiS9N01U9
 +KgfXUYuEwbT2Mj3OzibTcGda5S/dIzWRhPDt+Rda5RQXrKaQr+YarWQi+JVH9gzhnKUaT9O03g
 8u4LvmEPug5WoMkkOyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX3cVxBcCMkmbW
 Z1L/p13KvMkhedft/YvcUdbrAj0VPD/oNNxQN7f6+ucAxu5GuVJ8hysgqaV3nezOcstERWoA0VR
 7Tb6kBU5aUVeYDQZ8EI395b+p8fCwMU=
X-Proofpoint-GUID: Hb2uSgDWyumJ65ziIJSRgfOgZu8JbFwc
X-Proofpoint-ORIG-GUID: qERKp8eKe-TQKESximFoASxCoIcEnvuM
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad5e955 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=B0ODx0f1l_MszaswaQUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190038

Hi Sourabh,

On 23/09/26 3:52 PM, Sourabh Jain wrote:
> 
> 
> On 31/08/26 12:24, Narayana Murty N wrote:
>> Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
>> PAPR-compliant RTAS error injection path using the existing RTAS
>> work-area allocator.
>>
>> The mutex is not a buffer lock; it serializes the firmware session
>> open/inject/close sequence as required by PAPR.  No global buffer
>> is allocated or used.
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
>>           return -EINVAL;
>>       }
>> -    pr_debug("errinjct buffer ready: rtas_type=0x%x func=%d 
>> addr=0x%lx mask=0x%lx\n",
>> -         rtas_type, func, addr, mask);
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
>> + * is used.  pseries_errinjct_mutex serializes the open/inject/close
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
> 
> Only caller of eeh_pe_inject_mmio_erro() is getting removed here. Should 
> we remove the eeh_pe_inject_mmio_error() from the source?
Yes, this removes the last caller of eeh_pe_inject_mmio_error().

I have removed eeh_pe_inject_mmio_error() and its declaration in v5.

Thanks,
Narayana

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
>> +
>> +    if (WARN_ON_ONCE(upper_32_bits(area_phys))) {
>> +        rc = -ERANGE;
>> +        goto out_free_area;
>>       }
>> -    return 0;
>> +    buf_phys = lower_32_bits(area_phys);
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


