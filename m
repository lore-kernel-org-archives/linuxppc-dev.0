Return-Path: <linuxppc-dev+bounces-25389-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18BBC55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 18:26:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF27Y1nysz2yH5;
	Wed, 05 Aug 2026 04:26:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785868009;
	cv=none; b=UPqktHyuU1WOeFDcYLpUBs7W7XbWVJur+kAfhJ8EgunoGSVmhDg5h29VrK0ePQJC/PApO9/UNGShabBTLdG6qnWoJ9Rq+qAutFOTa5SBTx98KEOlQzAU1MXzB3kVM/CpnjA20i657wYtIoCj3FE41/JveEGiPv+nP+c/ZA0dZMQxvC9DLrT9pW2kDuEkMDCpFLOPyOWGiJvi2nVu8zQp2RX8r+U13oWf07vI/vJvlbKG4rAMU0AOQTrLdHX4pOp1pBqHO7yvkGYpRlihBiJ+Zh93js+xlT2dl2KoUSLiM6g6s6jZO13qf/vlIYzFEuseLFFP4D03Ko8yZFnlA9hjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785868009; c=relaxed/relaxed;
	bh=2obzAuFga8FO0qmhRHd5hVY0Y7HR87//ztq9j3ehPUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhJebzJWt/wOddZtSP2tWY74cyPxXwgs6CEmbFDqwFEK14RV+TVkTbpvhy6pVjkZ2bJMi//VEJ/drpaj5w9ElLgits96v5az9O5sa8+krulolTaoi38vv+dEuC3K+hOB9PZEzfu/yI4OKjgpUReKmR2DRIjSp50PLOBvUnt3mK9M/yHxrBvfQUBw1dfe49XU+hal/p1j9SoPkPLct8h81w8XwvmeQiFloIcRSTtKHtFwUjfp1bqg+TnjsXE744KdXSOK8h+CbI/OR9wSiv/5DtM3FnbEKnHLUiHQRydYZF715jfZM86mQEaB4dmMpHGHJJE6MHk8cT/5kLFPN4MKyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PI5l4AvZ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PI5l4AvZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF27X3pSXz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 04:26:48 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FlaZU1254293;
	Tue, 4 Aug 2026 18:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2obzAu
	Fga8FO0qmhRHd5hVY0Y7HR87//ztq9j3ehPUU=; b=PI5l4AvZsR35r27+75BDn1
	AGxBujf1I5GFFaMxdw/lqGWmiijkhTjV9kQY4CMr4BbQYfmigfnFOfrazoFSnr4+
	88HGhvLKM7rsjK+8/GgFY6qaewGdUclEYTXBr8RCyqRM5duOaftzpp0n1/j+3ygT
	uakEryKffX6d/oJ/Si3xpolFO/z/6Yc+r8HrqYga8KNyecwLDHynH4r8VAMYH2sJ
	E61h1i68YZ2Hu/B3/S41qxresfOh7aNACdqceeQDMfEvB0+vjFqfa0vuf0PFBLnj
	XmRvYMhv1728OH7z3MFYG8YK1/aHL06Tozr26KCon4P7kr1N9zHHVeIOcE8p6qvw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3ycft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:26:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674IQNB4029951;
	Tue, 4 Aug 2026 18:26:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhb50d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:26:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674IQS8u37880082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:26:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BB7320043;
	Tue,  4 Aug 2026 18:26:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9269520040;
	Tue,  4 Aug 2026 18:26:23 +0000 (GMT)
Received: from [9.39.27.173] (unknown [9.39.27.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:26:23 +0000 (GMT)
Message-ID: <1f8f70a4-2e5c-4e41-a8f1-9a32f37286d0@linux.ibm.com>
Date: Tue, 4 Aug 2026 23:56:22 +0530
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
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-5-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260721033815.5300-5-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a722edc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NhFz2HU8D7Y_24l5fhYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cKrle13SJEDr_QnALBzFkp842kSz54qh
X-Proofpoint-GUID: 0Mr6QFkjJ7jrG0GMbhGkNTgqn4hmZ6r1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX4Eh/QPzJPW8x
 XsZfZuF5TVKvwwJU9o/crBk5cXUzn7wPECAzoQC0EhCeDsFBvco6cSEAxTbgBVf1vh55rfdeLn1
 lZba6DNWVBh6bOmKk2OoM2yfkHBSv6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX6jFLjZrUEHzg
 1mYNKgRIk1EDmSyXoFwRpU5FkGX1jjbiLd921Vy5c/oeFhw0mP9uUcgDU8JbQrCNfIl0U5osiH5
 saWs8h7gn8EcQfqG9ZstPtS8Blm1qFY4ElU3/bm/Ro7+N+0EIo5oVGHXaahFHiTSQ+o+F7qOmPz
 P/Ajctyvrc8d5CMODzbqH2eqdcQz3BJheD1xcuOtlbq2W1qMNneWD0Ip/gyMIBzyzVJRjLBs6OD
 p4/keCqRTqmD6Ytvx/7lEN5UyeM1jfrLFtqx7euUmxjjwh3xiynUeacTNwNyyKsIj883Zhq2SUu
 zp8IhhfJxmJYz58Ksb7hl+ywsaEJDouEelEfLYojTNpszB4sNWE/yXAp9zL90HiN6CCc0U88R3/
 68HMMaQQZ0xJyd8I1XMVrYACCHO/DMhrAmR3EXkSF9aBfheNC4dZRTGeAiuPNIEIZ4H2Qy2rzmF
 rLMggNNHCjzGC0L14Dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040148



On 21/07/26 09:08, Narayana Murty N wrote:
> Replace legacy MMIO error injection with full PAPR-compliant RTAS error
> injection supporting 14+ error types via
>    - ibm,open-errinjct
>    - ibm,errinjct
>    - ibm,close-errinjct.
>
> Key features:
>    - Complete open-session-inject-close cycle management
>    - Special handling for ibm,open-errinjct output format (token,status)
>    - Comprehensive buffer preparation per PAPR layouts
>    - All pr_* logging uses pr_fmt("EEH: ") prefix
>
> Tested with corresponding QEMU patches:
> https://lore.kernel.org/all/20251029150618.186803-1-nnmlinux@linux.ibm.com/
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/eeh_pseries.c | 121 +++++++++++++++----
>   1 file changed, 95 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index 25aad86c696d..d32a84009fdc 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -1037,40 +1037,109 @@ static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
>   }
>   
>   /**
> - * pseries_eeh_err_inject - Inject specified error to the indicated PE
> - * @pe: the indicated PE
> - * @type: error type
> - * @func: specific error type
> - * @addr: address
> - * @mask: address mask
> - * The routine is called to inject specified error, which is
> - * determined by @type and @func, to the indicated PE
> + * pseries_eeh_err_inject - Inject specified error into the indicated PE
> + * @pe:   the indicated PE
> + * @type: generic EEH error type (EEH_ERR_TYPE_*)
> + * @func: error function selector (EEH_ERR_FUNC_*)
> + * @addr: target address, if applicable
> + * @mask: address mask, if applicable
> + *
> + * Implements the EEH error-injection callback for pseries using the RTAS
> + * ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct firmware services.
> + *
> + * Generic EEH error types are translated to RTAS firmware type codes via
> + * pseries_eeh_type_to_rtas() before the injection session is opened.
> + * Unsupported generic types are rejected with -EINVAL before any RTAS call
> + * is made.  Existing userspace is unaffected.
> + *
> + * Return: 0 on success, negative errno or RTAS error code on failure.
>    */
>   static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
>   				  unsigned long addr, unsigned long mask)
>   {
> -	struct	eeh_dev	*pdev;
> -
> -	/* Check on PCI error type */
> -	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
> -		return -EINVAL;
> +	int open_token, errinjct_token, close_token;
> +	int session_token = 0;
> +	bool session_open = false;
> +	void *buf;
> +	u32 buf_phys;
> +	int rc;
> +	int rtas_type;
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
> +	/* Guard: buffer must fit in 32 bits for RTAS */
> +	if (WARN_ON_ONCE(upper_32_bits(rtas_errinjct_buf)))
>   		return -ERANGE;
> +
> +	/* Map generic EEH ABI to RTAS-internal error type */
> +	rtas_type = pseries_eeh_type_to_rtas(type);
> +	if (rtas_type < 0) {
> +		pr_err("unsupported EEH error type %#x\n", type);
> +		return rtas_type;

How about -EINVAL instead?

>   	}
>   
> -	return 0;
> +	/* Verify all three RTAS tokens are available before touching firmware */
> +	open_token    = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
> +	errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
> +	close_token   = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
> +
> +	if (open_token    == RTAS_UNKNOWN_SERVICE ||
> +	    errinjct_token == RTAS_UNKNOWN_SERVICE ||
> +	    close_token   == RTAS_UNKNOWN_SERVICE) {
> +		pr_err("ibm,open/errinjct/close-errinjct not available\n");
> +		return -ENODEV;
> +	}
> +
> +	buf      = __va(rtas_errinjct_buf);
> +	buf_phys = lower_32_bits(rtas_errinjct_buf);
> +
> +	mutex_lock(&rtas_errinjct_mutex);
> +
> +	/* Step 1: open injection session */
> +	do {
> +		rc = rtas_call(open_token, 0, 2, &session_token);
> +	} while (rtas_busy_delay(rc));
> +
> +	if (rc) {
> +		pr_err("ibm,open-errinjct failed: status=%d\n", rc);
> +		goto out_unlock;
> +	}
> +	session_open = true;
> +
> +	/* Step 2: prepare the work buffer */
> +	rc = prepare_errinjct_buffer(buf, pe, rtas_type, func, addr, mask);
> +	if (rc) {
> +		pr_err("failed to prepare errinjct buffer: rc=%d\n", rc);
> +		goto out_close;
> +	}
> +
> +	/* Step 3: inject the error */
> +	do {
> +		rc = rtas_call(errinjct_token, 3, 1, NULL,
> +			       rtas_type, session_token, buf_phys);
> +	} while (rtas_busy_delay(rc));
> +
> +	if (rc)
> +		pr_err("ibm,errinjct failed: status=%d\n", rc);
> +
> +out_close:
> +	/* Step 4: always close the session */
> +	{
> +		int close_rc;

Why are having separate rc variable for close close token call?

> +
> +		if (session_open) {

is session_open variable really needed?

> +			do {
> +				close_rc = rtas_call(close_token, 1, 1, NULL,
> +						     session_token);
> +			} while (rtas_busy_delay(close_rc));
> +
> +			if (close_rc)
> +				pr_warn("ibm,close-errinjct failed: status=%d\n",
> +					close_rc);
> +		}
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&rtas_errinjct_mutex);
> +	return rc;
>   }
>   
>   static struct eeh_ops pseries_eeh_ops = {


