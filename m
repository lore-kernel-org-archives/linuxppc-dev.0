Return-Path: <linuxppc-dev+bounces-22378-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38BFCD8CB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 03:46:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZsC81gh5z2xjN;
	Wed, 10 Jun 2026 13:46:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781063188;
	cv=none; b=Njabr0o+hfDRusQ8kdCF2r5mxiMVgmSevpp1XnmIbDtV/Y3BwJolz/0h4ZC+gw5Z3J3GL0+OmFm3JLvztriRdJ9Bve9hRydaJMUTBaRC168KXiorkBFZ7Lu8zZ2iJSQAUOX7tW9BQDRPgoQM+RdjrfWqcHnpCwVB0RtQqVwnb99L2zfsZkFBlKyUv5HKA9ckTI1Q12TQnU2ptoiDK42w6hAxR7SMZ/CCO8UUBDnI03UcrqOY8PU6kTIeSJj3WXEp4+9b6x9Pn2TOVgkodM4NdRQdSiDLGQnIbuSOjbk5eulbTmoGTnibpWoLJun5yiNjg0/7oZsWUXFFoIBvOY++ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781063188; c=relaxed/relaxed;
	bh=DBnqgZ6sRObDt9c9SyyXz02abtIY96sL/cQSo6BFj4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cScZWuZ72KRHwqY9y7BMBXIRuBXILEPzpoiO/oSe+FXGXcHHf8eh0fntYIUfnIthFGxa2mMcT4Zv+009zyWmh5/sBN1SLTEuFvgpfdleP/XcU8lcFYFtNei+OmLBGx79tWMV2EZW+Bi4YVp/6niMu0G0pk0ucsll8MxUeFp7F//icJ1WJdAwyA20KgU6WKcY5lJz0/JgcYBMctuZhhTyAnHBVANXnywTTtYWcn7eS8oaWHvQ6Yk2MrODTIz5WCYM8fUXnzywJfIlOtymjEdcIgGzLZk9LviT8DSXS4MFfh8TW7vhMb4YZ9ut2Y9hRFwGnrUP26PXo4oEaV5kGpcJkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mIvheDZZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mIvheDZZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZsC70c7Gz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 13:46:26 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659Dwkm43408398;
	Wed, 10 Jun 2026 03:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DBnqgZ
	6sRObDt9c9SyyXz02abtIY96sL/cQSo6BFj4E=; b=mIvheDZZ+yZk3rUn35lvqD
	aKH7CQFALyV/AmWu8lGpi9j/RvXR6oR/GfeC6X16ga4KbAffIibGHAgmAndyJMJP
	pUJkjrps+bGU110t6AzpvOpq8Bmzl2IwfHJLbSwUOREJI+mJ88lPMi9Qa/l/3w7Q
	1Bc0/cDkBn4ladMyKLI6KVdu6nWTf207Ng1e1qWHGBslqnkSd/rweL8L95B6Bqn4
	n2L0StORipn7yUbIa8vusbPRvlxCx94xGpnuGJm90R8qID8ZORA34zTT+6T1M5EJ
	VPcEFw/mjqZoRIftIxpjMVUM69vmjIMUV2vniqH3WjvenFnSqOgWxIU5vBEJoyqA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhy5su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 03:46:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A3Yh6m026351;
	Wed, 10 Jun 2026 03:46:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjvx98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 03:46:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A3kAXX52625788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 03:46:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0B3E20040;
	Wed, 10 Jun 2026 03:46:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD2AE2004B;
	Wed, 10 Jun 2026 03:46:06 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 03:46:06 +0000 (GMT)
Message-ID: <f5701f0e-5e91-449e-aaf8-0d0ff4400f33@linux.ibm.com>
Date: Wed, 10 Jun 2026 09:15:57 +0530
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
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-5-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260527072433.94510-5-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDAzMCBTYWx0ZWRfX/Vwv3qUrEvSj
 Ro40ZBWQiLO00SkGqK2NKeK/DgNOE8+a+j5w9hNajqn4ZTBOBi3ZDhAR08/1jyRcGjCdkKcBH7F
 Pl7pmrns2VnW9Qgx61/xkhuObbUI+Oo4LzLPOWU3+YZB5GtCUjDs/mSQTsBSbBW9aTSq0zJfanu
 kWXzp0y9B+JWGsfYQZQRwR8PUI8aOpQcEloJF/T1QACMWKBwDLu0YTiv6uUKsEvM9vNUtDSlhEy
 u7lBaTD7rR3DlZYxg+Y2BwRhmmIc1qdobAaiqCy2flynfoNwRpBaZO9gpW/MpQP2k921sgMt/gC
 p+6/E1oQ33kdAwn3R3MiezVJYIQWVRp4hHZwk2ea4iPlEzp/2iBm0j9neaaiOGfjnAI0+626L5Q
 pY/qx5NZwVMbfrgz+AYx32pl2xjlQ/idSxMO7UdKDIly+4XjB37jB/yLhnAOVHSn8/8vkb4TOqT
 OZH7XPdNA5FKwdJlh3Q==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a28de07 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Pw3nJj3FJHTPHJfKu94A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zjI6z2PXRXc8d9xiWOZ-b7_CtvoJKPcT
X-Proofpoint-GUID: RNw8yLDhZsAg3vBF9GjmD91OLQ354llk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100030



On 27/05/26 12:54, Narayana Murty N wrote:
> Replace legacy MMIO error injection with full PAPR-compliant RTAS error
> injection supporting 14+ error types via
>   - ibm,open-errinjct
>   - ibm,errinjct
>   - ibm,close-errinjct.
>
> Key features:
> - Complete open-session-inject-close cycle management
> - Special handling for ibm,open-errinjct output format (token,status)
> - Comprehensive buffer preparation per PAPR layouts
> - All pr_* logging uses pr_fmt("EEH: ") prefix
>
> Tested with corresponding QEMU patches:
> https://lore.kernel.org/all/20251029150618.186803-1-nnmlinux@linux.ibm.com/
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/eeh_pseries.c | 168 ++++++++++++++++---
>   1 file changed, 147 insertions(+), 21 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index d6f2e0d43b89..6af2a153ec25 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -902,8 +902,7 @@ static int validate_special_event(unsigned long addr, unsigned long mask)
>    * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
>    */
>   
> -static int validate_corrupted_page(struct eeh_pe *pe __maybe_unused,
> -				   unsigned long addr, unsigned long mask)
> +static int validate_corrupted_page(unsigned long addr, unsigned long mask)
>   {
>   	if (!addr) {
>   		pr_err("corrupted-page requires non-zero addr\n");
> @@ -978,7 +977,7 @@ static int prepare_errinjct_buffer(struct eeh_pe *pe, int type, int func,
>   		if (addr == 0)
>   			return RTAS_INVALID_PARAMETER;
>   
> -		if (validate_corrupted_page(pe, addr, mask))
> +		if (validate_corrupted_page(addr, mask))
>   			return RTAS_INVALID_PARAMETER;
>   
>   		buf32[0] = cpu_to_be32(upper_32_bits(addr));
> @@ -1047,6 +1046,97 @@ static int prepare_errinjct_buffer(struct eeh_pe *pe, int type, int func,
>   	return 0;
>   }
>   
> +/**
> + * rtas_open_errinjct_session - Open an RTAS error injection session
> + *
> + * Opens a session with the RTAS ibm,open-errinjct service.
> + *
> + * Return: Positive session token on success, negative error code on failure.
> + */
> +static int rtas_open_errinjct_session(void)
> +{
> +	int open_token, args[2] = {0};
> +	int rc, status, session_token = -1;
> +
> +	open_token = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
> +	if (open_token == RTAS_UNKNOWN_SERVICE) {
> +		pr_err("RTAS: ibm,open-errinjct not available\n");
> +		return RTAS_UNKNOWN_SERVICE;
> +	}
> +
> +	/* Call open; original code treated rtas_call return as session token */
> +	rc = rtas_call(open_token, 0, 2, args);
> +	status = args[1];
> +	if (status != 0) {
> +		pr_err("RTAS: open-errinjct failed: status=%d args[1]=%d rc=%d\n",
> +		       status, args[1], rc);
> +		return status ? status : -EIO;
> +	}
> +
> +	session_token = args[0];
> +	pr_info("Opened injection session: token=%d\n", session_token);
> +	return session_token;
> +}
> +
> +/**
> + * rtas_close_errinjct_session - Close an RTAS error injection session
> + * @session_token: Session token returned from open
> + *
> + * Attempts to close a previously opened error injection session. Best-effort;
> + * logs warnings if close fails or if service is unavailable.
> + */
> +
> +static void rtas_close_errinjct_session(int session_token)
> +{
> +	int close_token, args[2] = {0};
> +
> +	if (session_token <= 0)
> +		return;
> +
> +	close_token = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
> +	if (close_token == RTAS_UNKNOWN_SERVICE) {
> +		pr_warn("close-errinjct not available\n");
> +		return;
> +	}
> +
> +	args[0] = session_token;
> +	rtas_call(close_token, 1, 1, args);
> +	if (args[0])
> +		pr_warn("close-errinjct  args[0]=%d\n", args[0]);
> +}
> +
> +/**
> + * do_errinjct_call - Invoke the RTAS error injection service
> + * @errinjct_token: RTAS token for ibm,errinjct
> + * @type:           RTAS error type
> + * @session_token:  RTAS error injection session token
> + *
> + * Issues the RTAS ibm,errinjct call with the prepared work buffer. Logs errors
> + * on failure.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +
> +static int do_errinjct_call(int errinjct_token, int type, int session_token)
> +{
> +	int rc, status;
> +
> +	if (errinjct_token == RTAS_UNKNOWN_SERVICE)
> +		return -ENODEV;
> +
> +	/* errinjct takes: type, session_token, workbuf pointer (3 in), returns status */
> +	rc = rtas_call(errinjct_token, 3, 1, &status, type, session_token,
> +		       rtas_errinjct_buf);

Why are we passing virtual address of rtas_errinjct_buf (working buffer 
address) to rtas call?

> +
> +	if (rc || status != 0) {
> +		pr_err("RTAS: errinjct failed: rc=%d, status=%d\n", rc, status);
> +		return status ? status : -EIO;
> +	}
> +
> +	pr_info("RTAS: errinjct ok: rc=%d, status=%d\n", rc, status);
> +	return 0;
> +}
> +
>   /**
>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>    * @pe: the indicated PE
> @@ -1060,30 +1150,66 @@ static int prepare_errinjct_buffer(struct eeh_pe *pe, int type, int func,
>   static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
>   				  unsigned long addr, unsigned long mask)
>   {
> -	struct	eeh_dev	*pdev;
> +	int rc = 0;
> +	int session_token = -1;
> +	int errinjct_token;
>   
> -	/* Check on PCI error type */
> -	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
> -		return -EINVAL;
> +	/* Validate type */
> +	if (!validate_err_type(type)) {
> +		pr_err("RTAS: invalid error type 0x%x\n", type);
> +		return RTAS_INVALID_PARAMETER;
> +	}
> +	pr_debug("RTAS: error type 0x%x\n", type);
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
> +	/* For IOA bus errors we must validate err_func and addr/mask in PE.
> +	 * For other types: if addr/mask present we'll still validate BAR range;
> +	 * otherwise skip function checks.
> +	 */
> +	if (type == RTAS_ERR_TYPE_IOA_BUS_ERROR ||
> +	    type == RTAS_ERR_TYPE_IOA_BUS_ERROR_64) {
> +		/* Validate that addr/mask fall in the PE's BAR ranges */
> +		rc = validate_addr_mask_in_pe(pe, addr, mask);
> +		if (rc)
> +			return rc;
> +	} else if (addr || mask) {
> +		/* If caller provided addr/mask for a non-IOA type, do a BAR check too */
> +		rc = validate_addr_mask_in_pe(pe, addr, mask);
> +		if (rc)
> +			return rc;
>   	}
>   
> -	return 0;
> +	/* Open RTAS session */
> +	session_token = rtas_open_errinjct_session();
> +	if (session_token < 0)
> +		return session_token;
> +
> +	/* get errinjct token */
> +	errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
> +	if (errinjct_token == RTAS_UNKNOWN_SERVICE) {
> +		pr_err("RTAS: ibm,errinjct not available\n");
> +		rc = -ENODEV;
> +		goto out_close;
> +	}
> +
> +	/* prepare shared buffer while holding lock */
> +	spin_lock(&rtas_errinjct_buf_lock);
> +	rc = prepare_errinjct_buffer(pe, type, func, addr, mask);
> +	if (rc) {
> +		spin_unlock(&rtas_errinjct_buf_lock);
> +		goto out_close;
> +	}
> +
> +	/* perform the errinjct RTAS call */
> +	rc = do_errinjct_call(errinjct_token, type, session_token);
> +	spin_unlock(&rtas_errinjct_buf_lock);
> +
> +out_close:
> +	/* always attempt close if we opened a session */
> +	rtas_close_errinjct_session(session_token);
> +	return rc;
>   }
>   
> +
>   static struct eeh_ops pseries_eeh_ops = {
>   	.name			= "pseries",
>   	.probe			= pseries_eeh_probe,


