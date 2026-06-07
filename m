Return-Path: <linuxppc-dev+bounces-22157-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C0ECD8C8C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2026 13:35:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYGQM2nmGz2xlV;
	Sun, 07 Jun 2026 23:35:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780839339;
	cv=none; b=BW+qOm+4Ziwf3zJqbAtxUr8quWudTDA0lPfg/iMdhaQDnVCPPX68shASwhysBwulSJhJuU//ycHWiuyWmTaOFthCToed6KWM1mertTeVok+S3VttJwcHiwhnG7jANiVT0YR/Akb0gpYkiiKcFFKBT/MSg9ITBpqpetHZ0J87Q7zrkcWWEw7V8f5hQz3c3VdoMpk8KWjjIXuPkmKctFhz6DqR980CsCz9NOLezwXoZvCYdQV3O0a7sOKQnqF85W7ZdCO2lMknczC8RW8G+jRrkMPR4M9tnXZF+5PvLWBnzEoJlI/UQ60icnsOxU4psyv6Zx+KMZ6fcUa6AzgUxSQ5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780839339; c=relaxed/relaxed;
	bh=/nuoDSR6TpbEtmb0PxQIDClChvJdJkhVUI5tCRjsEdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJeIaK/VYaRJXXy4xxa9h0Omff4l6cil66v6KYtdDc+Rgmfaf/y7m2w/tJRKYwO51+coiU+0gYSHK9BrUjx0A4p/XElvmQrXLenE/ZOGZB8kY2eWwixvvbjhSXBTubQOrqxgBU4F/jGVdDQ8uDGMzvQetNc3uAnxlcjAwJVUARmAhfyskFpsePKiiDK5SZL+VUCbBmWr+Q69zbvv0XoyzNwkq1CWaLKZEp5WoQ001se++r442QayDOZkB6tZEeP+HwgZKrCPCcZJMiqL7LMScCR4Aj24mXJGcKH0zSkU6ZymbjZhUQxXpl0wzYfnNcUVE5TSoVuQIccHIexRylWMhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b8N5Q6MQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b8N5Q6MQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYGQL041xz2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jun 2026 23:35:37 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657BeBOO2613994;
	Sun, 7 Jun 2026 13:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/nuoDS
	R6TpbEtmb0PxQIDClChvJdJkhVUI5tCRjsEdI=; b=b8N5Q6MQWwUbFDyPob+0Aa
	fq4jrzCgvVRdIuOyNsG/k9AHTQ+HJWLLeB+KMyJHBYT1YQiCZAy01lmroW+RVQHw
	6ZUmhKeOn6Y6yEH2KvT5a7goSyGqycqlJkZTZrGwMt3Clq9O3x725KktZM+sbiQc
	FRYBDuUGCOuQgkmQEBPFACoS6loyBacLINrZtgV9Q48C1NIWectvpr8OYMmrH5O5
	9vloeEA3KZczarJsgRCigVaZnBjCxNN7QSULYuiwM7LLGgiXEfH21tf6b2Z/JLjn
	oGzWi2WIPBZdAEXkftuOIdH0OuUOmYqAghpwWG6e8vxaHHLo1Nt9SVf07eNH1lcA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6skqx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 13:35:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657DYd5I013164;
	Sun, 7 Jun 2026 13:35:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vsqek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 13:35:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657DZJXq53019022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 13:35:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB13120043;
	Sun,  7 Jun 2026 13:35:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9283820040;
	Sun,  7 Jun 2026 13:35:13 +0000 (GMT)
Received: from [9.39.26.1] (unknown [9.39.26.1])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 13:35:13 +0000 (GMT)
Message-ID: <5388c50b-e43b-4a3a-bd59-28568f5d84cb@linux.ibm.com>
Date: Sun, 7 Jun 2026 19:05:11 +0530
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
X-Proofpoint-ORIG-GUID: njLAteeT_h61iTLp1RmDZTsaW53OFpae
X-Proofpoint-GUID: mTVaDD974mGIq0tN9ijAF6KK3oOVwwrY
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a25739b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FFFY8qpp1dcUkLX4SnkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEzMCBTYWx0ZWRfX4yDOEWqfClE0
 uW3bcJYjgKRWI1kdaEGh2PuPL271TsqQzSfgRCmFSf8t/fANSf9mhXvfvMckW+qAqxC0r5ziS8Y
 wR0nivtLTQEW4/j4VB659XqoPoy4HgMsDQHey8x75Pn5nVqCw0khIo4F6nifIIyfzBcqFiuAqaq
 dMFVKAierncedhdke7WgTHuAjUkp1nhjtll0+/I+uiTnAGl73QRY2gGgfVCGrfmTMeAwZAlMP3e
 v1ChGn+wby6C3Z98sMwg3tvtHXkz0jlSqNusxEGZ3q2lfV5CD9sr2QO65/9kBCRdUPtQBoykE5Y
 6vIsN4Wpw6IKwClj6CembPLIRTF7g9rMrGfieS94QbrWeLaOjeqInZK8Rql0v3xnvInS3ZZZaKR
 sSiNPKaJx3xV6eQl73bVEyj8TDIQDEdDjaoPD4nN90GOImkLq8nknZs+vCnR0WWSFXlKDhyvVCf
 nCloDkgO5s3WF1KUycw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070130



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

session token can't be 0, is it?

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
rc and status is same, isn't it? That makes the status variable redundant.

> +	if (status != 0) {
> +		pr_err("RTAS: open-errinjct failed: status=%d args[1]=%d rc=%d\n",
> +		       status, args[1], rc);
> +		return status ? status : -EIO;
> +	}

Not planning to handle extend delay by RTAS, return code 9900...9905?

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

I didn't find a section in the PAPR which says token can't be 0.

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

IIUC rtas_call do not copy status to output buffer. Let's consider 
return value
from rtas_call function as status.

Since status is not copied, int arg is enough.

I think we must handle rtas busy delay for errinjct close rtas call?

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

The above if and else if case has identical code. Why don't we merge them?

>   
> -	return 0;
> +	/* Open RTAS session */
> +	session_token = rtas_open_errinjct_session();
> +	if (session_token < 0)

session_token 0 is considered valid here. Where as it was considered 
invalid in other
function above.

> +		return session_token;
> +
> +	/* get errinjct token */
> +	errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
> +	if (errinjct_token == RTAS_UNKNOWN_SERVICE) {
How about checking this before getting the session token?

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

This new line seems unnecessary.


>   static struct eeh_ops pseries_eeh_ops = {
>   	.name			= "pseries",
>   	.probe			= pseries_eeh_probe,


