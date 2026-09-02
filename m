Return-Path: <linuxppc-dev+bounces-26428-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD17C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 05:16:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZWDZ2DLtz2xyh;
	Wed, 02 Sep 2026 15:16:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788326206;
	cv=none; b=PiY9QBm+akmx2oFw8O4QLk0t+tQSLy93pN1/nYBoCYAEXTEpGjnmFB4sv+7MqPKOfwfen8AD/OLmcj8Jkp3xIDiskSCQZ9sOHz2THGFXBkv7TSrHbUypJGAzeyiZhalh6dslFr2MAtOPFxpMf2ty0IwDA9zSkqYWCxck1yII6Ykm/2V2FdlgN1L8Au38ZPiFDGZulaGWz2p4KfdU1mU6HuPkeIsJdH6jgzTT5H7CGdKN5RCbsOo4O/sgfsecK8YcT7PgKsycIvjQdlwSGKUqD3pWpyQSAcrLKXsHhV/rUcA52FlRAbVxVnkGlOscIFy3rMJ8pB+HpDSkw47twmkkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788326206; c=relaxed/relaxed;
	bh=FSpnYz1Zw4safg6tGbZ97h/13eVfSuDBviaBaBRfYOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4H7V1TJlpaank+AgJsGJzbrrm7xHIB7Et2h/d625IEnbCoqz9FUMcsF2EwNjaF9rhXl6MMQqsmg+NpVCvCQ7w7U3KDszeF1YWbUKgiGKcY84KRhaBOljZJdGMjd2XX3UcO8epDCPL6k3CxwGk4vwSLdhzh+4OJGsxj57dFTiZuZgSToLIBjobDUOZDfL+ySN+CFZXTtSfpN5UGlWux1a+tyDx5odpO+QkGSDF43Wrty6qNohJoBE6zrxFZ2kEFCbXOg1iaMkoRNfvx//D+j29zcnIDnrE2WBwoPRASq+xAj6QM6xR1dURj0xMHJnuuvGznW5x2L5ofreRtcWv9n5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JscPV3nM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JscPV3nM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZWDY1Vx6z2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 15:16:44 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWV4A2236415;
	Wed, 2 Sep 2026 05:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FSpnYz
	1Zw4safg6tGbZ97h/13eVfSuDBviaBaBRfYOw=; b=JscPV3nMDm/l9VU4MXwRoL
	L1gykqc46SO5KFbe+pmJILpJarYwrzFJtBqWTTEoJ4nf7zkUALs2qeHovEioAQ9q
	jiSg6D1qAKZYpJnHISei3FD8kITmjLJGp2hjl4xNd71PtLyiXdZPr0fOB9+m93UB
	j4BTSL5d/axeyMjoMh5GFgRmaiEb2fY/gI4IB2lDVUbKxX7XzTqG5F4JOYnOm1an
	tBg5ChDqYYfRGwgtblU5D8jwVZSwb5EPlbpSy6+DdC9L9xuo3XB1Hp7MPLpSD8f4
	wGzReK51G9uibYzDS12r6yrft/pYAPoeeLcH/vbyiuNp7BkaKYiy6C36q6+Wkcew
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5me2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 05:16:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6825BNYh024602;
	Wed, 2 Sep 2026 05:16:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqg1j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 05:16:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6825GS0T30605756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 05:16:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73EBF20043;
	Wed,  2 Sep 2026 05:16:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8170E20040;
	Wed,  2 Sep 2026 05:16:25 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 05:16:25 +0000 (GMT)
Message-ID: <02c8c3a8-04f4-4664-a4fd-5223f5262508@linux.ibm.com>
Date: Wed, 2 Sep 2026 10:46:24 +0530
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
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        oohall@gmail.com, npiggin@gmail.com, tpearson@raptorengineering.com,
        alex@shazbot.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
References: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
 <20260831065441.48654-5-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260831065441.48654-5-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a97b131 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=shHpiqZUIdK5DwAqfgwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I2xhfhDBhOy8ce-slgqVKLJ79kOmom_n
X-Proofpoint-ORIG-GUID: qZ_0YU2Br7aPuYl6R0pJ5XsAfmN1ps0J
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX0q0aJpmVu1Tq
 mXjTUOy6b+CsKmq28l1YpA/D6kepD+jS133ncjd4uqILTRezmj5owhSpZL7e7AHJ51YLt2bXPpr
 4mpKDqF4q5msAaFKhsJuN8iUHrS5I5g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MyBTYWx0ZWRfX8paWurv+1y40
 EDjOO5BoMLXP6LL9c+Za1aBUQIY5erlttZSIjArE6QAc5c0WX92Xz+QMLqyNKd6qJqoZEu4Oz3W
 EoK/sk6/tNpsEn3xLrO4VE8Dyfu/bcs8IwUWx5f5oTDZKTo1IPqSm9OyxrBvnvNTFFHWnEKfaMt
 mHFbi95Rx5c77E5zk6BCPa9fKeAvA+MigVEwCA1X7XciuIcUhS8L5IxI7lfwwB4z9k/jPoavuaj
 tIhaG8YrFJ4pXcHb78AtbKcsecTac0zYIhgsS+0ZFdFc4rN3+eb1tG6PBEjB2l2Iblt4hikathd
 5CrXS0UJ1nVjPVL6S0O9JwZ51mZGoQ7+1TYodOdql8hzRecMgGP8EdxSLcJL6gsXuLE8GPxTFxR
 yNHE1NBjGdfOqPw/nn+VUC+B2v41CslMfyL0CGkxglB7JsWYr4KhXBjMCf2ofB82cIBGQQsuHCh
 A8gjpqyyeQEEe+l2jSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020043



On 31/08/26 12:24, Narayana Murty N wrote:
> Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
> PAPR-compliant RTAS error injection path using the existing RTAS
> work-area allocator.
>
> The mutex is not a buffer lock;
Sorry but I didn't get this...

> it serializes the firmware session
> open/inject/close sequence as required by PAPR.  No global buffer
> is allocated or used.
Nit:
I think the above para is influenced form old suggestion to not use global
dedicated buffer. Lets drop the global buffer thing from commit message
explain just the current approach.

>
> VFIO EEH error injection exposes a generic userspace ABI.  pSeries maps
> the generic EEH error types to RTAS ibm,errinjct encodings via
> pseries_eeh_type_to_rtas().  EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are
> unchanged; their values are defined in arch/powerpc/include/uapi/asm/eeh.h
> and are not renumbered.
>
> Tested with corresponding QEMU patches:
> https://lore.kernel.org/all/20251029150618.186803-1-nnmlinux@linux.ibm.com/
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/eeh_pseries.c | 123 ++++++++++++++-----
>   1 file changed, 95 insertions(+), 28 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index fafe0004e738..fcb8c560d813 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -25,6 +25,7 @@
>   #include <linux/rbtree.h>
>   #include <linux/sched.h>
>   #include <linux/seq_file.h>
> +#include <linux/mutex.h>
>   #include <linux/spinlock.h>
>   #include <linux/crash_dump.h>
>   
> @@ -34,6 +35,7 @@
>   #include <asm/machdep.h>
>   #include <asm/ppc-pci.h>
>   #include <asm/rtas.h>
> +#include <asm/rtas-work-area.h>
>   
>   /* RTAS tokens */
>   static int ibm_set_eeh_option;
> @@ -958,8 +960,6 @@ static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
>   			return -EINVAL;
>   
>   		if (upper_32_bits(addr) || upper_32_bits(mask)) {
> -			pr_err("32-bit IOA injection cannot encode addr=%#lx mask=%#lx\n",
> -			       addr, mask);

We are returning -EINVAL remove the error message, what is the need?

>   			return -EINVAL;
>   		}
>   
> @@ -992,50 +992,117 @@ static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
>   		break;
>   
>   	default:
> -		pr_err("unsupported RTAS error injection type 0x%x\n", rtas_type);
> +		pr_err("unsupported RTAS error injection type 0x%x\n",
> +		       rtas_type);

Above change is not necessary..

>   		return -EINVAL;
>   	}
>   
> -	pr_debug("errinjct buffer ready: rtas_type=0x%x func=%d addr=0x%lx mask=0x%lx\n",
> -		 rtas_type, func, addr, mask);

What is need to remove this debug message?

>   	return 0;
>   }
>   
> +/* pseries-local mutex serializes the open/inject/close RTAS session */
> +static DEFINE_MUTEX(pseries_errinjct_mutex);
> +
>   /**
>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>    * @pe: the indicated PE
> - * @type: error type
> - * @func: specific error type
> - * @addr: address
> - * @mask: address mask
> - * The routine is called to inject specified error, which is
> - * determined by @type and @func, to the indicated PE
> + * @type: generic EEH error type (EEH_ERR_TYPE_32 or EEH_ERR_TYPE_64)
> + * @func: specific error function
> + * @addr: address argument (type-dependent, may be zero)
> + * @mask: address mask (type-dependent, may be zero)
> + *
> + * Implements PAPR-compliant error injection using:
> + *   ibm,open-errinjct -> ibm,errinjct -> ibm,close-errinjct
> + *
> + * A short-lived RTAS work area is allocated per call; no global buffer
> + * is used.
Mentioning "no global buffer is used" is not adding any value, I think.

> pseries_errinjct_mutex serializes the open/inject/close
> + * session sequence.
> + *
> + * Return: 0 on success, negative errno on failure.
>    */
>   static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
>   				  unsigned long addr, unsigned long mask)
>   {
> -	struct	eeh_dev	*pdev;
> +	struct rtas_work_area *area;
> +	phys_addr_t area_phys;
> +	u32 buf_phys;
> +	void *buf;
> +	int open_token, errinjct_token, close_token;
> +	int session_token;
> +	int rtas_type;
> +	int close_rc;
> +	int rc;
> +
> +	rc = validate_errinjct_args(pe, type, func, addr, mask);
> +	if (rc)
> +		return rc;
>   
> -	/* Check on PCI error type */
> -	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
> +	rtas_type = pseries_eeh_type_to_rtas(type);
> +	if (rtas_type < 0)
>   		return -EINVAL;
>   
> -	switch (func) {
> -	case EEH_ERR_FUNC_LD_MEM_ADDR:
> -	case EEH_ERR_FUNC_LD_MEM_DATA:
> -	case EEH_ERR_FUNC_ST_MEM_ADDR:
> -	case EEH_ERR_FUNC_ST_MEM_DATA:
> -		/* injects a MMIO error for all pdev's belonging to PE */
> -		pci_lock_rescan_remove();
> -		list_for_each_entry(pdev, &pe->edevs, entry)
> -			eeh_pe_inject_mmio_error(pdev->pdev);
> -		pci_unlock_rescan_remove();
> -		break;
> -	default:
> -		return -ERANGE;
> +	open_token    = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
> +	errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
> +	close_token   = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
> +
> +	if (open_token    == RTAS_UNKNOWN_SERVICE ||
> +	    errinjct_token == RTAS_UNKNOWN_SERVICE ||
> +	    close_token   == RTAS_UNKNOWN_SERVICE)
> +		return -ENODEV;
> +
> +	area = rtas_work_area_alloc(RTAS_ERRINJCT_BUF_SIZE);
> +	buf  = rtas_work_area_raw_buf(area);
> +	area_phys = rtas_work_area_phys(area);


I was wondering if there is any need to hold the work area buffer until
we acquire pseries_errinjct_mutex.

Would it make sense to allocate the buffer only after acquiring the
mutex? I suggested an order for the open, errinjct, and close calls
below, which I think could also help address the above comment.

Nit: this file is under pseries platform so pseries_errinjct_mutex can 
renamed to errinct_mutex.
> +
> +	if (WARN_ON_ONCE(upper_32_bits(area_phys))) {
> +		rc = -ERANGE;
> +		goto out_free_area;
>   	}
>   
> -	return 0;
> +	buf_phys = lower_32_bits(area_phys);

I don't understand the above logic. First, we check area_phys and exit
early if the address is above 4G, and then we take the lower 32 bits of
the same address.

I think the RTAS work area allocation API should be responsible for
allocating the work area buffer at the right location. The user
shouldn't have to worry about where exactly the buffer is allocated
unless they have a specific requirement.

Is the work area buffer allocated by the API not meeting your
requirement? If so, could you please explain what the issue is? Let's
see if we can fix it in the work area allocation API. Otherwise, I
would suggest removing the checking and truncation done around
area_phys.

Let me know your opinion.


> +
> +	rc = prepare_errinjct_buffer(buf, pe, rtas_type, func, addr, mask);
> +	if (rc)
> +		goto out_free_area;
> +
> +	mutex_lock(&pseries_errinjct_mutex);
> +
> +	do {
> +		rc = rtas_call(open_token, 0, 2, &session_token);
> +	} while (rtas_busy_delay(rc));
> +
> +	if (rc) {
> +		pr_err("ibm,open-errinjct failed: status=%d\n", rc);
> +		rc = rtas_error_rc(rc);
> +		goto out_unlock;
> +	}

I think we should allocate the work area buffer only after the
open-errinjct call succeeds. My preferred order is:

- Call RTAS open-errinjct
- Allocate the work area buffer
- Populate the work area buffer and make the errinjct RTAS call
- Release the work area buffer
- Call RTAS close-errinjct

This way, the work area buffer is held only for as long as it is needed,
and we also avoid allocating it if open-errinjct fails.

> +
> +	do {
> +		rc = rtas_call(errinjct_token, 3, 1, NULL,
> +			       rtas_type, session_token, buf_phys);
> +	} while (rtas_busy_delay(rc));
> +
> +	if (rc) {
> +		pr_err("ibm,errinjct failed: status=%d\n", rc);
> +		rc = rtas_error_rc(rc);
> +	}
> +
> +	do {
> +		close_rc = rtas_call(close_token, 1, 1, NULL, session_token);
> +	} while (rtas_busy_delay(close_rc));
> +
> +	if (close_rc) {
> +		pr_warn("ibm,close-errinjct failed: status=%d\n", close_rc);
> +		if (!rc)
> +			rc = rtas_error_rc(close_rc);
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&pseries_errinjct_mutex);
> +
> +out_free_area:
> +	rtas_work_area_free(area);
> +	return rc;
>   }
>   
>   static struct eeh_ops pseries_eeh_ops = {


