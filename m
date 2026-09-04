Return-Path: <linuxppc-dev+bounces-26523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B151C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:12:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmMh63J6z2y2b;
	Fri, 04 Sep 2026 16:12:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788502336;
	cv=none; b=a6gGEXJ8OCnoiGwGuBczYC8kPBr2TDVLUVPKKBdoc9/DWLd90LQGfxAemM8JmTcujjUMtFaNWkOfwIIl6TK2PozCRa5spwI7OtmgSsfID7SKloNdA3AFshRwhojL56oUq2TMFNKt8PY+aAyCRPE9DQTpR1XvnvZy55MYoekQziSw71emCSigLi2Imldy12h/0kdSFgcCR9384deUCZEZcZTYxx3/eJi4k19nmQEqNPGaAk8LQWw8vQ66ncZtyydzhJMCPP3wo9l3p5Zww3JlFBBu76/NWn6h2/PAogNbR7WfuqgWrHwqVBeil+D8CvI0wNBsPi/2p5nYVUV2HgeQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788502336; c=relaxed/relaxed;
	bh=xyM65XNog/H7fiEDfUT9RhpDHIsu4bagLP0oXnVKw90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M71SJ+RBQmxMMOpSW22uL/r5ZxbTaKkrg5iFI57yy2uIxuTTwA7yZK3Gf/Hk0QvPCgbdwiYwgoTJUf+FDOHnTpTr8gw4G9qfXH+Cz5WjPODJTLf555hKaiyfBsOw6WcIh8Efa19SzCVsGXUUeTGRloeKNkcI2cNM0opeGYGc9uLLBkUaxoBHr3SHI15z/ZrmnDTuus/g8Ys27nOVGP55i87nhfow1vl3nZPuD/DPvqd0N2tXLXJCSCF4FsnqlvNCQUQyELUx0e/0s4G6FtqVO0t5Tpgk6Xpw6NP6ygQclO2vfPbWZM2+uZzZLhn/cLwZCrn4poyYAqxQ9zyQU71R5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RG5GmDgs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RG5GmDgs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmMh0rf6z2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:12:15 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464EJX936677;
	Fri, 4 Sep 2026 06:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xyM65X
	Nog/H7fiEDfUT9RhpDHIsu4bagLP0oXnVKw90=; b=RG5GmDgsO9SGrXY2cjvSrd
	sG5X2Z3xCq/PLmAe+0P/o630NDL/B0jUepbQGmL3Hd0Abu2AFqbRivVSuupQdOXw
	zg4gGu4nDzQo+af/9sErSgICwt/EIX5apKmgG28VETs2LkY9qt04pKw9WHb/ucd4
	6tCb+7hA2rUYhQV8rZrP+u2aAdFmypG1/DSY1lWlSTISMic0hcfsh97Uhnb+XHxE
	9a7+hFD1LMUrtbyQ+tvQi7ANuK7GkzDsA6mq7SXKlRT5h2Eb5lS6gefmz5XyrRAf
	qEDYM01yg0bh3uUV5SLttUvaOPzRHRV5ONf9L96rKZzEC/tGZGLZEo5fTYe42X0A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx611md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:12:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6846BhtK026541;
	Fri, 4 Sep 2026 06:12:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyka8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:12:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846BwbS31654524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:11:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB6E720043;
	Fri,  4 Sep 2026 06:11:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C81FF20040;
	Fri,  4 Sep 2026 06:11:51 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:11:51 +0000 (GMT)
Message-ID: <e98b01dc-6347-438b-9894-4f18335f2c9e@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:41:48 +0530
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
Subject: Re: [PATCH v2 03/10] pseries/plpks: improve type consistency and
 parameter validation
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-4-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-4-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9a6133 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=k4SqsDxa1PK0FLuH3CsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VyLghFNv6_HeOB_OwrN7o2q3VOfAuv-F
X-Proofpoint-ORIG-GUID: b3Q4BCg3lHUzaH2KwXGu1DO3sPJbWtVB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXx6Wx5Ou8ZPLY
 5LxZDxI34fon2j1moOrtBJxnSYHYDIKUfKxmXQmlgFvX52DUvUnjQHCWDOCHZjvzsOIZCVmxtXu
 Gd02RWD42Dtb9D6FgrNbqouQSZacZv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX97vEHlOQ9dpj
 7Dyi2afMmAg8sv7cDl2ks0mjbGu8EzHuyXcMpH8y3LzwroTGJ6Zxs/xQONt+rXNIA1D5AfH87jq
 1yfRi8XX4/kwqYYuAByQMhaQoKd+r6IHKMLCTkCih2BIiRrAbiPy+eouVLNd9VPAWHGMgvwcnAN
 zzM+f3b3pWTwysZ8yQleR31+wM+nPJyoj/2zkJvKR9hopiu0QxerW+2vNe5knxN2c4wJMQHGxnF
 6CI6T2NQywb3F/AmtpKuFcTUYTs56FOgBh6pTELQEEEVq+oHiLjxEKVjtMlScDTMUds4rkxoYCr
 tMGkAeWjtBIyJllpMfW8tRpeEXSQGOl6u9BPNHu9q16ql+X/IGaRv+aojEEZE4Ked3VhQ34zHCu
 UqnWvxBY0Gj/iUN54e5V3TyZso4PHBp2+Z/9XeRHQZUwy4gChXDd6D6bZIB09bsazDXTeush1vB
 MC65IDKoTsnIkhBpS1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> Update plpks_wrap_object() and plpks_unwrap_object() to use u64 length
> parameters, matching the underlying hcall data types for consistency.
> Update the PKWM consumer, where these interfaces are used, accordingly.
>
> Add explicit casts when copying values from hcall return buffers into
> narrower data types. This makes the intended conversion clear and avoids
> implicit truncation in PLPKS hcall result handling.
>
> Also validate input pointers in plpks_signed_update_var() and
> plpks_read_var() before dereferencing them, addressing missing validation
> when reading and updating PLPKS objects.
>
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
> Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
> Fixes: 899d9b8fee66 ("powerpc/pseries: Implement signed update for PLPKS objects")
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested on ppc64le PowerVM LPARs on firmware with wrap/unwrap support,
with and without Secure Boot enabled.

Verified trusted key creation and the seal/unseal round-trip for key sizes
in the range [32-128] bytes. Confirmed that NULL pointer validation in
plpks_signed_update_var() and plpks_read_var() does not break normal
operation.
> ---
>   arch/powerpc/include/asm/plpks.h          |  8 ++++----
>   arch/powerpc/platforms/pseries/plpks.c    | 22 ++++++++++++++--------
>   security/keys/trusted-keys/trusted_pkwm.c |  4 ++--
>   3 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
> index e87f90e40d4e..8b2ffb27db5a 100644
> --- a/arch/powerpc/include/asm/plpks.h
> +++ b/arch/powerpc/include/asm/plpks.h
> @@ -118,11 +118,11 @@ bool plpks_wrapping_is_supported(void);
>   
>   int plpks_gen_wrapping_key(void);
>   
> -int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
> -		      u8 **output_buf, u32 *output_len);
> +int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
> +		      u8 **output_buf, u64 *output_len);
>   
> -int plpks_unwrap_object(u8 **input_buf, u32 input_len,
> -			u8 **output_buf, u32 *output_len);
> +int plpks_unwrap_object(u8 **input_buf, u64 input_len,
> +			u8 **output_buf, u64 *output_len);
>   #else // CONFIG_PSERIES_PLPKS
>   static inline bool plpks_is_available(void) { return false; }
>   static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index 7bd5c149dd09..45278c5a45c1 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -576,7 +576,7 @@ static int plpks_confirm_object_flushed(struct label *label,
>   				 virt_to_phys(auth), virt_to_phys(label),
>   				 label->size);
>   
> -		status = retbuf[0];
> +		status = (u8)retbuf[0];
>   		if (rc) {
>   			timed_out = false;
>   			if (rc == H_NOT_FOUND && status == 1)
> @@ -637,6 +637,9 @@ int plpks_signed_update_var(struct plpks_var *var, u64 flags)
>   	u64 continuetoken = 0;
>   	u64 timeout = 0;
>   
> +	if (!var)
> +		return -EINVAL;
> +
>   	if (!var->data || var->datalen <= 0 || var->namelen > PLPKS_MAX_NAME_SIZE)
>   		return -EINVAL;
>   
> @@ -822,6 +825,9 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
>   	u8 *output;
>   	int rc;
>   
> +	if (!var)
> +		return -EINVAL;
> +
>   	if (var->namelen > PLPKS_MAX_NAME_SIZE)
>   		return -EINVAL;
>   
> @@ -863,14 +869,14 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
>   		goto out_copy_policy;
>   	}
>   
> -	if (!var->data || var->datalen > retbuf[0])
> -		var->datalen = retbuf[0];
> +	if (!var->data || var->datalen > (u16)retbuf[0])
> +		var->datalen = (u16)retbuf[0];
>   
>   	if (var->data)
>   		memcpy(var->data, output, var->datalen);
>   
>   out_copy_policy:
> -	var->policy = retbuf[1];
> +	var->policy = (u32)retbuf[1];
>   out_free_output:
>   	kfree(output);
>   out_free_label:
> @@ -1015,8 +1021,8 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
>    *
>    * Returns: On success 0 is returned, a negative errno if not.
>    */
> -int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
> -		      u8 **output_buf, u32 *output_len)
> +int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
> +		      u8 **output_buf, u64 *output_len)
>   {
>   	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
>   	struct plpks_auth *auth;
> @@ -1134,8 +1140,8 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
>    *
>    * Returns: On success 0 is returned, a negative errno if not.
>    */
> -int plpks_unwrap_object(u8 **input_buf, u32 input_len, u8 **output_buf,
> -			u32 *output_len)
> +int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
> +			u64 *output_len)
>   {
>   	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
>   	struct plpks_auth *auth;
> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
> index bf42c6679245..b6b5697426a8 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c
> @@ -83,7 +83,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>   	struct trusted_key_options *options = NULL;
>   	struct trusted_pkwm_options *pkwm = NULL;
>   	u8 *input_buf, *output_buf;
> -	u32 output_len, input_len;
> +	u64 output_len, input_len;
>   	int rc;
>   
>   	options = trusted_options_alloc();
> @@ -130,7 +130,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>   static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
>   {
>   	u8 *input_buf, *output_buf;
> -	u32 input_len, output_len;
> +	u64 input_len, output_len;
>   	int rc;
>   
>   	input_len = p->blob_len;

-- 
Thanks and Regards
R.Nageswara Sastry


