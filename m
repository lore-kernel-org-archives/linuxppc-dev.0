Return-Path: <linuxppc-dev+bounces-28007-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3CDC982FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 10:22:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqY1l1SVdz2yqq;
	Wed, 23 Sep 2026 20:22:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790158955;
	cv=none; b=G0JOjZEVxxoOJ0iF9ax2D/gbTo5qyMFf8tEkpS6Th2OPgMeFFdB9cvv4nMgEAuxZAxFwMVUI5yLbaUNn0G3EsSQTZiseHIiz4b3t/gJAFZeXm3BxhnNphDFIqPG2z1f1bdACDF6ICYdkFFb3DvZQSLZMIMNLxsod53k+Xt4brtswVbwAqDO+so0ycC7aUgS8X456x25QnshFfbrUyM3x/hZFHvUVmL3vEiJCAXjw70jmwQpwBP+OPzQ8F6kixur9kjJlx3w0lCLkqVqRHu3c28eABKOfdJon61Kt//hPJIvgIP/MdaCm8VnQPB7coOniPLJpy9ebxzKdwDd94oUF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790158955; c=relaxed/relaxed;
	bh=UJSxSKDkUkpvf8mfl9N8qfOQL0311c7JKC2qECOIKk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV2eZyQ9aj5ZimZNRL6WA5T++DuRmk2UjrXfKefsTeUwYLhaTmR7GegPLAfveDus+O7HLP4x28NdlnEb95pdXfyGfl4SwG8I6f5I8qSg+/CDbk4YX1m2knV18w9/99uUTTLZwObdL27aQkcgmRM6Oq+SOvfu4yG742zF6ssi+DO/3ggxN+Ac63otStV45SwclmKqYOipfAf0NRz6cEAamkT/oL978V9ZAwLy/42v+Tza3DOm0Zgl1aRIe36cH0DkTDnryUeXnIK2kZm/BxTAqSGW5KbBblYRVPfzdiuojHR/rvYJ6O0K9S4fUyy/Po0acL4Pbf0jb9OaUPhTYdqwEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ao65L2wB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ao65L2wB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqY1j5ZZVz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 20:22:33 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ad2N1732116;
	Wed, 23 Sep 2026 10:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UJSxSK
	DkUkpvf8mfl9N8qfOQL0311c7JKC2qECOIKk0=; b=Ao65L2wBUIitsZvGGAJG/o
	Y2tsv4EeQcLb5UzhY0oYt4pEbRkNg5GLlY2TPKlurQ4zkotWbxknOD8cYaSJZosN
	z3zXRnK8HfmlQv4tBTb3g/OIBUd0B3aCVRkD9lRa+lh2DH0IcQb62/NZHLVFw6ZB
	CENE9tmnjMWb1FD9RLNjWGfDvfvuvYMjKatIuhWxh/K0FV2lalU0ythyrOF+mcFg
	gZnGjT8IqdGxBW+Jl0+W6J4zXGiW+XOkMRHm/TTXZGN5IMP3gGiOMgohmvoCLh7x
	47ahVkjIbiwHZ7o1vznRiSPn+4NtwD0gNmqNJf2ZklkQpgkO4Qja61l36e5ZpyEg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqj2ar-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 10:22:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8LwdM008054;
	Wed, 23 Sep 2026 10:22:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qgdg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 10:22:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NAMGbO56361380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 10:22:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 500DE20043;
	Wed, 23 Sep 2026 10:22:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1FB520040;
	Wed, 23 Sep 2026 10:22:13 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 10:22:13 +0000 (GMT)
Message-ID: <23c0e185-c56b-4025-8136-326dae53ef4e@linux.ibm.com>
Date: Wed, 23 Sep 2026 15:52:12 +0530
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
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab3a85d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nKMCb-GtO1_C_x72D5QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfX887MkZ5rxaY8
 ZRevR9qVNjOO2jc/5G72rSmRSLaJ64Aqb/BoFTFJK2IPLQ953G6k10G7DYxSlJ35uSsxg2frjAd
 4GFrl7M1N8LAovWqMvul81WJdJzTXblmEmUsc5X255L51E51GjD1zLSHe22f6ntdcY2vFZwN0tD
 nvri6RxaPw1VDixW9QiZZKfJDOfdarlO3AvKV7zIjCtqQtk70jni6GCPzIjpgRJ1k3xEaFvUvsL
 OKqMxFKiATSFMHHsNIjXr2bziTKsaZ2ms1I9kAQT4d5YkT46Nwa3RR2IWxVnplhOL5Y9LsZ2JC0
 16XCPQApQCwwEyWahq+i9W/PZ8Oy8cDV8Ah9Eb3H5c8vMmsDRQNfTbsF3GO55vqVtK/raZUkkS1
 vxjoA19TE+pAn3+v/QT67kQBHsqfw+9icCad7ernV5HSGOG3wkyetQTMXcrqNcsoQlrtlu7ZqfG
 IDntXTWSmTIHvfc4bpw==
X-Proofpoint-ORIG-GUID: GJSceuQl689lwc1HM24mvtd05fH_DZ17
X-Proofpoint-GUID: 0-OWOJwmgeSb8ge42PUi4WE9ioduVk3b
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfX9XxmUJjb3W6b
 /BnCW94cZw/AnHaUIUFyqFo0qi8tqhf660xXJZkJ2PfM6APIXBQn3Lq4bDZPNY/4jm3Fw77MeQk
 KPpEI92b/yVsXMEJe454b3y1+ptY8TU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230040



On 31/08/26 12:24, Narayana Murty N wrote:
> Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
> PAPR-compliant RTAS error injection path using the existing RTAS
> work-area allocator.
>
> The mutex is not a buffer lock; it serializes the firmware session
> open/inject/close sequence as required by PAPR.  No global buffer
> is allocated or used.
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
>   		return -EINVAL;
>   	}
>   
> -	pr_debug("errinjct buffer ready: rtas_type=0x%x func=%d addr=0x%lx mask=0x%lx\n",
> -		 rtas_type, func, addr, mask);
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
> + * is used.  pseries_errinjct_mutex serializes the open/inject/close
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

Only caller of eeh_pe_inject_mmio_erro() is getting removed here. Should 
we remove the eeh_pe_inject_mmio_error() from the source?
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
> +
> +	if (WARN_ON_ONCE(upper_32_bits(area_phys))) {
> +		rc = -ERANGE;
> +		goto out_free_area;
>   	}
>   
> -	return 0;
> +	buf_phys = lower_32_bits(area_phys);
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


