Return-Path: <linuxppc-dev+bounces-26530-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52184C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:18:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmVM6GzVz2yrS;
	Fri, 04 Sep 2026 16:18:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788502683;
	cv=none; b=hxyi6gNDvWfq3BMFZpPQ9mDHb1RsHQWbVEVWSOCERh050aqMgsZBjEUtAPY5Hym8oUxToU5nMrNVsjSiobepbUnMM1ANhSZn9OMIg7OO9eU9DIFlbtheX6wTUJWZUFaRBB1OvRCW+48Fpwsx4Xpik+Ied4SEzf95X7ZPKKUqW0tWNp8hKYyYO7OUC+dfzcyjYUoMoKiVh7l5+leQ1Ey46LhFCrjK36u6XyAArELZtjEeKiCBNtpRk/eXLbW8rHSCS7J82hKwRz0jIGooKebWvXfJPcRn8TXTaoNr/Zi6HRS07RL1ut3kkz2WD6FHYRDEt6wQJhdWA+akYgD9aIB6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788502683; c=relaxed/relaxed;
	bh=Rp1wAwrOgIJprKRANvfb75dXmSugXFM8bTOFJkyvwOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNdkeIPbqZoq8oWeZ2/4rCDvrI2MDm6ky4vn3vmYhbpyRo+FAd+o0igxEdH5zyuIi5Zh9EjqKV7AlbcAbz4yFD4yGbKxXTLIGWLu2N3xY7MdcOQa5/nC6T0J6USvt2VbZsFWTfWPfIEyrjEx8wLL8tDwF2ke5K0fxx5zSEA5y7TbBAhK6Dh53CHoZ67C4As0JPbcF+/j/hEMrvUNGNdUyEB0i+ds2+WF/p4yhbv6u5aFFW9SilZfIZz58wIb78K/Euh8U/2L06y+ams0rfr3Bk6oTHOhYE7XhMXr7ASu6MHja8HlCEhVdlIszJMf4fqOTQaM4hWT+g76FpI1LZT3QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ragmS657; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ragmS657;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmVL5r98z2yr2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:18:02 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464Xrs3993767;
	Fri, 4 Sep 2026 06:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rp1wAw
	rOgIJprKRANvfb75dXmSugXFM8bTOFJkyvwOo=; b=ragmS657on46yNG1IapKDA
	GOkJrJ8lprgM+ENXnNUEwjPxsK4C0HXk8E77NIomYXXknn1vL3Ez3WKX6MiujIZu
	16URuLAr8np3BVcRCt7JnGcWaxaMTWNeSa2aO0IOlMjxH/5aMUK0XJ3KgmSWrudz
	wV3E01xCMB9TaPpwxkZ1ZBgei6pjTuFn0pmfPxim5jbdsukZYMap00DS4gfwLMAL
	CkmHe08s+QlENVSL34QLbVggcCMTxS1Gd3MyvKt620idpTa6QtkuWRCHDrrExy16
	1S9JGeOYLMKM4IgeMW8eNiZQmVlmyf24DEA0TJq/8AtB52IJFEFfSAK8SVfwwcWw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue8k5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:17:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6846Bnch004654;
	Fri, 4 Sep 2026 06:17:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjauwmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:17:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846Hh6529295062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:17:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66D2E20040;
	Fri,  4 Sep 2026 06:17:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F9020043;
	Fri,  4 Sep 2026 06:17:37 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:17:36 +0000 (GMT)
Message-ID: <805f4e2c-f48e-4ace-ad16-18fd99aa4270@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:47:33 +0530
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
Subject: Re: [PATCH v2 09/10] keys/trusted_keys: enable PKWM wrapping key
 selection by label
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-10-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-10-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Xph4cTEUmq6XdnCpfs73LZbD-4g48egb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX2OL3Kf/QnQ4h
 Ac8gikwI3sgrn2g1oRG/y078UajlZC56b4Gxn+izx7JiwTVZhqw2F7VJXM9eCMSa7oCGoxiCV5O
 GwH3jz8DZu6wEjvYWYGY4tdxGToWhZ3cV4bnGzwTeWSVnMpwOLu/k/RkPZPE++gyBrkUVeCc28O
 EbFClCHv2P4v/qB4o3PrxEeKOATMaa6+xMilBW4CY5QufuBESZq3Y6Bsle5lWvPwHhG6/eZTsNW
 gDTjS3cEd3ZgOEore1BTkRXbH+YjASvWIoa9X2G0uJQaLkptLJPj8YeBHmluVLaO2jIMDOeClmO
 YOj2Cgtj0ZOhLU+hXEi66t3CLVax21sIfZMcJUQuB2rifBXgCRwpfi3d84DngMQcYnc4ssWLSAU
 vdS+3cTniHTi+kOrxAs/2Jq3XWQK/bhNywt84Ovzbm/b4qd78JqgPqMtSrxM5celS4VaQp6KTuN
 u0GCRBbuzrjSSQyWiqA==
X-Proofpoint-ORIG-GUID: Gxe5Q2OabszHMbL5ukaCy2xqv_7HX3sq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX0iq4Gma1QKUy
 1Wo2BOpCNxh7nVMr2GzU/MHeK9g1f15Q8CEScwCk7rVnvRpJT/5/j/j9A+cxfm8jmnUMW58Rsky
 92uCwdBxoDARtcxhWEW94Hl0G2a5eC8=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9a628c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=LoMaVm7doQ0NSrhH3G0A:9 a=HDeLwfcefyR0U2kU:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> The PKWM trusted source currently uses the default wrapping key for all
> seal and unseal operations. However, PKWM supports multiple wrapping keys,
> enabling better isolation between trusted keys.
>
> Allow users to provide an active wrapping key of their choice created
> through sysfs when sealing trusted keys through a new wrapping_key=<label>
> option. If no label is specified, the default wrapping key is used for
> sealing.
>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested on ppc64le PowerVM LPARs on firmware with wrap/unwrap support,
with and without Secure Boot enabled.

Verified that:
   - Trusted key creation without specifying wrapping_key= continues to work
     (default wrapping key used).
   - Trusted key creation with wrapping_key=<label> works correctly.
   - A label longer than 239 characters is rejected.
   - wrap_flags=0x01 and wrap_flags=0x02 behave as expected with the
     wrapping_key= option under each Secure Boot mode.
> ---
>   .../security/keys/trusted-encrypted.rst       |  4 +-
>   arch/powerpc/include/asm/plpks.h              | 10 ++-
>   arch/powerpc/platforms/pseries/plpks.c        | 64 ++++++++++---------
>   include/keys/trusted_pkwm.h                   |  3 +
>   security/keys/trusted-keys/trusted_pkwm.c     | 34 +++++++++-
>   5 files changed, 80 insertions(+), 35 deletions(-)
>
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index ddff7c7c2582..76fda28fddb1 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -83,7 +83,7 @@ safe.
>   
>        (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
>   
> -         Rooted to a unique, per-LPAR key, which is derived from a system-wide,
> +         Rooted to unique, per-LPAR keys, which are derived from a system-wide,
>            randomly generated LPAR root key. Both the per-LPAR keys and the LPAR
>            root key are stored in hypervisor-owned secure memory at runtime,
>            and the LPAR root key is additionally persisted in secure locations
> @@ -366,6 +366,8 @@ Usage::
>                          0x01: require secure boot to be in either audit or
>                                enforced mode
>                          0x02: require secure boot to be in enforced mode
> +       wrapping_key= optional wrapping key label as a string. The default
> +                     wrapping key is used when no label is provided.
>   
>   "keyctl print" returns an ASCII hex copy of the sealed key, which is in format
>   specific to PKWM key-blob implementation.  The key length for new keys is
> diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
> index c39d1f07017e..badb07afe749 100644
> --- a/arch/powerpc/include/asm/plpks.h
> +++ b/arch/powerpc/include/asm/plpks.h
> @@ -50,6 +50,12 @@
>   #define PLPKS_MAX_TIMEOUT		(5 * USEC_PER_SEC)
>   #define PLPKS_FLUSH_SLEEP		10000 // usec
>   
> +// Label for the PKWM default wrapping key
> +#define PLPKS_DEFAULT_WRAPKEY_LABEL	"default-wrapping-key"
> +
> +// Component for a PKWM wrapping key
> +#define PLPKS_WRAPKEY_COMPONENT	"PLPKSWR"
> +
>   struct plpks_var {
>   	char *component;
>   	u8 *name;
> @@ -117,10 +123,10 @@ int plpks_config_create_softlink(struct kobject *from);
>   
>   bool plpks_wrapping_is_supported(void);
>   
> -int plpks_gen_wrapping_key(void);
> +int plpks_gen_wrapping_key(struct plpks_var *var);
>   
>   int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
> -		      u8 **output_buf, u64 *output_len);
> +		      u8 **output_buf, u64 *output_len, struct plpks_var *var);
>   
>   int plpks_unwrap_object(u8 **input_buf, u64 input_len,
>   			u8 **output_buf, u64 *output_len);
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index 3b1e6f00b4ae..5cdaabe9de06 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -9,9 +9,6 @@
>   
>   #define pr_fmt(fmt) "plpks: " fmt
>   
> -#define PLPKS_WRAPKEY_COMPONENT	"PLPKSWR"
> -#define PLPKS_DEFAULT_WRAPKEY_LABEL	"default-wrapping-key"
> -
>   /*
>    * To 4K align the {input, output} buffers to the {UN}WRAP H_CALLs
>    */
> @@ -935,6 +932,7 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
>   /**
>    * plpks_gen_wrapping_key() - Generate a new random key with the 'wrapping key'
>    * policy set.
> + * @var: variable representing the wrapping key to be created
>    *
>    * The H_PKS_GEN_KEY HCALL makes the hypervisor generate a new random key and
>    * store the key in a PLPKS object with the provided object label. With the
> @@ -960,25 +958,27 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
>    *
>    * Returns: On success 0 is returned, a negative errno if not.
>    */
> -int plpks_gen_wrapping_key(void)
> +int plpks_gen_wrapping_key(struct plpks_var *var)
>   {
>   	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
>   	struct plpks_auth *auth;
>   	struct label *label;
>   	int rc = 0, pseries_status = 0;
> -	struct plpks_var var = {
> -		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
> -		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
> -		.policy = PLPKS_WRAPPINGKEY,
> -		.os = PLPKS_VAR_LINUX,
> -		.component = PLPKS_WRAPKEY_COMPONENT
> -	};
> +
> +	if (!var)
> +		return -EINVAL;
> +
> +	if (!var->name || !*var->name) {
> +		pr_err("key label cannot be NULL/empty\n");
> +		return -EINVAL;
> +	}
>   
>   	auth = construct_auth(PLPKS_OS_OWNER);
>   	if (IS_ERR(auth))
>   		return PTR_ERR(auth);
>   
> -	label = construct_label(var.component, var.os, var.name, var.namelen);
> +	label = construct_label(var->component, var->os, var->name,
> +				var->namelen);
>   	if (IS_ERR(label)) {
>   		rc = PTR_ERR(label);
>   		goto out;
> @@ -986,7 +986,7 @@ int plpks_gen_wrapping_key(void)
>   
>   	rc = plpar_hcall(H_PKS_GEN_KEY, retbuf,
>   			 virt_to_phys(auth), virt_to_phys(label),
> -			 label->size, var.policy,
> +			 label->size, var->policy,
>   			 NULL, PLPKS_WRAPPING_KEY_LENGTH);
>   
>   	if (!rc)
> @@ -995,11 +995,13 @@ int plpks_gen_wrapping_key(void)
>   	pseries_status = rc;
>   	rc = pseries_status_to_err(rc);
>   
> -	if (rc && rc != -EEXIST) {
> -		pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d",
> -		       pseries_status, rc);
> -	} else {
> -		rc = 0;
> +	if (rc) {
> +		if (rc == -EEXIST)
> +			pr_info("wrapping key <%s> already exists\n",
> +				(char *)var->name);
> +		else
> +			pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d\n",
> +			       pseries_status, rc);
>   	}
>   
>   	kfree(label);
> @@ -1010,13 +1012,14 @@ int plpks_gen_wrapping_key(void)
>   EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
>   
>   /**
> - * plpks_wrap_object() - Wrap an object using the default wrapping key stored in
> - * the PLPKS.
> + * plpks_wrap_object() - Wrap an object using the specified wrapping key stored
> + * in the PLPKS.
>    * @input_buf: buffer containing the data to be wrapped
>    * @input_len: length of the input buffer
>    * @wrap_flags: object wrapping flags
>    * @output_buf: buffer to store the wrapped data
>    * @output_len: length of the output buffer
> + * @var: variable representing the wrapping key to be used
>    *
>    * The H_PKS_WRAP_OBJECT HCALL wraps an object using a wrapping key stored in
>    * the PLPKS and returns the wrapped object to the caller. The caller provides a
> @@ -1051,7 +1054,7 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
>    * Returns: On success 0 is returned, a negative errno if not.
>    */
>   int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
> -		      u8 **output_buf, u64 *output_len)
> +		      u8 **output_buf, u64 *output_len, struct plpks_var *var)
>   {
>   	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
>   	struct plpks_auth *auth;
> @@ -1061,18 +1064,21 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
>   	int rc = 0, pseries_status = 0;
>   	bool sb_audit_or_enforce_bit = wrap_flags & BIT(0);
>   	bool sb_enforce_bit = wrap_flags & BIT(1);
> -	struct plpks_var var = {
> -		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
> -		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
> -		.os = PLPKS_VAR_LINUX,
> -		.component = PLPKS_WRAPKEY_COMPONENT
> -	};
> +
> +	if (!var)
> +		return -EINVAL;
> +
> +	if (!var->name || !*var->name) {
> +		pr_err("key label cannot be NULL/empty\n");
> +		return -EINVAL;
> +	}
>   
>   	auth = construct_auth(PLPKS_OS_OWNER);
>   	if (IS_ERR(auth))
>   		return PTR_ERR(auth);
>   
> -	label = construct_label(var.component, var.os, var.name, var.namelen);
> +	label = construct_label(var->component, var->os, var->name,
> +				var->namelen);
>   	if (IS_ERR(label)) {
>   		rc = PTR_ERR(label);
>   		goto out;
> @@ -1135,7 +1141,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
>   EXPORT_SYMBOL_GPL(plpks_wrap_object);
>   
>   /**
> - * plpks_unwrap_object() - Unwrap an object using the default wrapping key
> + * plpks_unwrap_object() - Unwrap an object using its associated wrapping key
>    * stored in the PLPKS.
>    * @input_buf: buffer containing the data to be unwrapped
>    * @input_len: length of the input buffer
> diff --git a/include/keys/trusted_pkwm.h b/include/keys/trusted_pkwm.h
> index 4035b9776394..53a5f780edd2 100644
> --- a/include/keys/trusted_pkwm.h
> +++ b/include/keys/trusted_pkwm.h
> @@ -6,10 +6,13 @@
>   #include <linux/bitops.h>
>   #include <linux/printk.h>
>   
> +#define WRAPPING_KEY_LABEL_LEN_MAX	239
> +
>   extern struct trusted_key_ops pkwm_trusted_key_ops;
>   
>   struct trusted_pkwm_options {
>   	u16 wrap_flags;
> +	unsigned char wrapping_key_label[WRAPPING_KEY_LABEL_LEN_MAX + 1];
>   };
>   
>   static inline void dump_options(struct trusted_key_options *o)
> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
> index 633a7674d065..7bfe98d79cd7 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c
> @@ -13,10 +13,12 @@
>   enum {
>   	Opt_err,
>   	Opt_wrap_flags,
> +	Opt_wrapping_key_label,
>   };
>   
>   static const match_table_t key_tokens = {
>   	{Opt_wrap_flags, "wrap_flags=%s"},
> +	{Opt_wrapping_key_label, "wrapping_key=%s"},
>   	{Opt_err, NULL}
>   };
>   
> @@ -50,6 +52,12 @@ static int getoptions(char *datablob, struct trusted_key_options *opt)
>   				return -EINVAL;
>   			pkwm->wrap_flags = wrap_flags;
>   			break;
> +		case Opt_wrapping_key_label:
> +			if (strlen(args[0].from) > WRAPPING_KEY_LABEL_LEN_MAX)
> +				return -EINVAL;
> +			strscpy(pkwm->wrapping_key_label, args[0].from,
> +				sizeof(pkwm->wrapping_key_label));
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -82,6 +90,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>   {
>   	struct trusted_key_options *options = NULL;
>   	struct trusted_pkwm_options *pkwm = NULL;
> +	struct plpks_var var;
>   	u8 *input_buf, *output_buf;
>   	u64 output_len, input_len;
>   	int rc;
> @@ -108,8 +117,18 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>   
>   	pkwm = options->private;
>   
> +	if (pkwm->wrapping_key_label[0]) {
> +		var.name = (u8 *)pkwm->wrapping_key_label;
> +		var.namelen = strlen(pkwm->wrapping_key_label);
> +	} else {
> +		var.name = (u8 *)PLPKS_DEFAULT_WRAPKEY_LABEL;
> +		var.namelen = strlen(PLPKS_DEFAULT_WRAPKEY_LABEL);
> +	}
> +	var.os = PLPKS_VAR_LINUX;
> +	var.component = PLPKS_WRAPKEY_COMPONENT;
> +
>   	rc = plpks_wrap_object(&input_buf, input_len, pkwm->wrap_flags,
> -			       &output_buf, &output_len);
> +			       &output_buf, &output_len, &var);
>   	if (!rc) {
>   		memcpy(p->blob, output_buf, output_len);
>   		p->blob_len = output_len;
> @@ -161,14 +180,23 @@ static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
>   static int trusted_pkwm_init(void)
>   {
>   	int ret;
> +	struct plpks_var var;
>   
>   	if (!plpks_wrapping_is_supported()) {
>   		pr_err("H_PKS_WRAP_OBJECT interface not supported\n");
>   		return -ENODEV;
>   	}
>   
> -	ret = plpks_gen_wrapping_key();
> -	if (ret) {
> +	var = (struct plpks_var) {
> +		.name = (u8 *)PLPKS_DEFAULT_WRAPKEY_LABEL,
> +		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
> +		.policy = PLPKS_WRAPPINGKEY,
> +		.os = PLPKS_VAR_LINUX,
> +		.component = PLPKS_WRAPKEY_COMPONENT
> +	};
> +
> +	ret = plpks_gen_wrapping_key(&var);
> +	if (ret && ret != -EEXIST) {
>   		pr_err("Failed to generate default wrapping key\n");
>   		return ret;
>   	}

-- 
Thanks and Regards
R.Nageswara Sastry


