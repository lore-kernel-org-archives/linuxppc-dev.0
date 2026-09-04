Return-Path: <linuxppc-dev+bounces-26529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB16DC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:17:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmTX2qGKz2yr2;
	Fri, 04 Sep 2026 16:17:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788502640;
	cv=none; b=VW2C8m/UwJD3x28lqERqTFOxc9/dU5VToT62rtq3/0OKTMTsFi8+7B1D9aq1c9aewDIGnOBWpVpGwr3SLTwwoRRItl9IhL+JTh48BLf5fwIkxtpx5yd6FA2PBxsXr91F/GlKowHVPSUCltkAOwurJeD1TUwn3NEawHPBTNZ671mhNDOzh0EwEIhjZMIMOUbnmuyUG+tQDvSk/VOJWxeKASQQ7Yu54fzLbk2J+Xfo/CPcXTF/vZWR3Q8oomuWct4+XsUTHhMq/MvEycE4yZSXV1gI8/VMNR+Q92TwupqY9KyrIrHV+Lly25XgMiO0AYeHMXkXTFXiK9FpuRw0EZ8otA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788502640; c=relaxed/relaxed;
	bh=yJhuxqoYPtdMzKObTGTsg9uIi2PnH5L2611IaZ4h+Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4Bd3K75jMGUrAsNXSBqdRrEhD8aML2Nq2d46z0amxQhiVJQ7T24BdeWTOUVrbFrOY1EE3JGdO/uLrU5qGgk/oNYvAZJ/fDGTUxeufzlDjN4RlVkWp79VysvMpYOFrEAfWwNMVWBooHVfP6fcn2SZ/U2Zva+bGQeJT3Lt+lZnL/TOQy5ARV/+UV0yq1ZAJntdNWQuClY5wt4ykkz+4WuCRZbn945fQHwIvpFLIxFGLKdZdgTgRtm/SlXTwVR9VIHJtGPTOEH1CzVJZMVxwbPwa5f1mhjJeYJh+ifBiUopF3VJI1qRGs6kSVZEvV17tzFLG45ahq9B+YNvUbxkD1qMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HrniCXDb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HrniCXDb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmTW23N6z2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:17:19 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464LZ63254183;
	Fri, 4 Sep 2026 06:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yJhuxq
	oYPtdMzKObTGTsg9uIi2PnH5L2611IaZ4h+Vw=; b=HrniCXDbBvEHu894vIbDRH
	7X22fdzEyhb6P+SKF+7xKm0p6A++ZoeyHWsjcsFMNzB8lF2o+GbdrRUW97bbK4Wn
	7Z8LnUXeVrs76KQaBifBebVzE5/HrbVNZzYJlAHqoLbl0wsZCMxjoiDFZuLZdj6F
	gUUOBMcNyykNniQ9oyFTRf+Y79ge9+sfLf83cLC7vomDoXZbJz/EYt9mcVCMMwM4
	/mSQveKILl6ysCXXcux+ZaVo8vzNw+/XjOOixGs615PQ42a8x5/7b6KOgyuz5bJm
	3ITPvOIl4cTDGfDLXlzcPkxsNpp2wgwARbiXa9B9iwHAZn5A/ehGtBovsa3STY7w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rs1yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:17:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6846BiNd026553;
	Fri, 4 Sep 2026 06:17:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceykatk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:17:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846H1c247514096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:17:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5339C2004B;
	Fri,  4 Sep 2026 06:17:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 836F920040;
	Fri,  4 Sep 2026 06:16:54 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:16:54 +0000 (GMT)
Message-ID: <fcc52798-c82e-449d-95a4-ce65822f8f7f@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:46:50 +0530
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
Subject: Re: [PATCH v2 08/10] pseries/plpks: add HCALLs for PKWM wrapping key
 life cycle management
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-9-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-9-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a6262 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=v5Pn0cnHyjeqJrbvQRgA:9 a=tPo2q3NkLt2s72eS:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX+TwgkhS5gr74
 4ivSUFmpXVIQqrz15VBq0fSDU4/C0bvQc/6m8+AzP3JiDv2o9FQ69bqt0diSih10x/ao6BGjU8J
 DbT4ehow3YslnEUiI7bPmzUshEUUgAhsqKIvkUhNIjkmuWOCNpbetsIkM/HHG4csZVD/FMBNriV
 OB5zcMD3hADebN7mK2D7/oah+PzyC5frTkE/FUL81IVyqpqPgLwOzOCQ7901PdGIzD7FniQ3/r7
 3b3+PZ/+liFoFlHuYeatK+faDiNEwFHXggeNp4ovi0jbQmKBJ7N0mTr0fbPR2TS4mdj0yzNw3nD
 XmFpI29TH/i/vMApAvHaZ1184cQy39QfkLmeIRpn8OJpL+t533DyhcAdq3r9u293qRlZpn7eqyl
 r1yqaMMFwwMUDqYK00c7uNjr8eYRqPgpcYIT1NFoqTQDtlT/MUUtJCCsj21XKvLkCbpbcudDTUC
 93BYcu5eZI8Ux9jjzFw==
X-Proofpoint-GUID: 5BfGus7pcrQqrVBcqS6LHaqSe0VaA61g
X-Proofpoint-ORIG-GUID: zpc8HLzBbpMgCztdRG4__OWXPa_Qowih
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX1wppkZlqKHzz
 Y6KYjuyOtRfqGlim9o1fMhgqd2x5wn8aeM33tNqV1Op4bO7lZNBdo4StDc2f/o6BFvJ4VxxZyI5
 erIm5NpxpjT1nG0WMRsVsJWPF9NbczY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> The PKWM trusted source uses a single wrapping key per LPAR, created only
> once during trust source initialization. All the wrap and unwrap requests
> are bound to this default wrapping key.
>
> Implement H_PKS_REVOKE_OBJECT, H_PKS_UNREVOKE_OBJECT, and
> H_PKS_GET_OBJECTLABELS HCALLs to enable support for revoking and unrevoking
> PKWM wrapping keys, and for retrieving wrapping key labels. The label
> retrieval operation (H_PKS_GET_OBJECTLABELS) applies to all wrapping keys
> including the default one, while the life cycle operations
> (H_PKS_REVOKE_OBJECT/H_PKS_UNREVOKE_OBJECT) apply only to user-created
> wrapping keys.
>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested on ppc64le PowerVM LPARs:

On firmware without revoke/unrevoke support:
   - The kernel correctly detects that H_PKS_REVOKE_OBJECT and
     H_PKS_UNREVOKE_OBJECT are not available and the revoke/unrevoke
     interfaces are not exposed. Existing wrap/unwrap functionality is
     unaffected.

On firmware with revoke/unrevoke support:
   - H_PKS_REVOKE_OBJECT, H_PKS_UNREVOKE_OBJECT and H_PKS_GET_OBJECTLABELS
     are all reachable (exercised via the sysfs interface added in patch 
10).
   - The H_CONTINUE path in plpks_get_object_labels() was exercised with a
     large number of wrapping key objects.
   - Revoke and unrevoke operations return the expected object policy in the
     return buffer.
> ---
>   Documentation/arch/powerpc/papr_hcalls.rst |  33 ++
>   arch/powerpc/include/asm/hvcall.h          |   5 +-
>   arch/powerpc/include/asm/plpks.h           |  15 +
>   arch/powerpc/platforms/pseries/plpks.c     | 487 ++++++++++++++++++++-
>   4 files changed, 536 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/arch/powerpc/papr_hcalls.rst b/Documentation/arch/powerpc/papr_hcalls.rst
> index 44c9c8b32ae3..3455b403a048 100644
> --- a/Documentation/arch/powerpc/papr_hcalls.rst
> +++ b/Documentation/arch/powerpc/papr_hcalls.rst
> @@ -343,6 +343,39 @@ is returned to the caller.
>   H_PKS_UNWRAP_OBJECT is used to unwrap an object that was previously wrapped with
>   H_PKS_WRAP_OBJECT.
>   
> +**H_PKS_REVOKE_OBJECT**
> +
> +| Input: authorization, objectlabel, objectlabellen, flags
> +| Out: *object policy*
> +| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3, H_P4,
> +                H_Authority, H_Not_Found, H_Busy, H_Aborted*
> +
> +H_PKS_REVOKE_OBJECT is used to revoke an object in Platform Keystore.
> +
> +
> +**H_PKS_UNREVOKE_OBJECT**
> +
> +| Input: authorization, objectlabel, objectlabellen, flags
> +| Out: *object policy*
> +| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3, H_P4,
> +                H_Authority, H_Not_Found, H_Busy, H_Aborted*
> +
> +H_PKS_UNREVOKE_OBJECT is used to unrevoke an object that was previously revoked
> +with H_PKS_REVOKE_OBJECT in Platform Keystore.
> +
> +
> +**H_PKS_GET_OBJECTLABELS**
> +
> +| Input: authorization, continueToken, out, outlen
> +| Out: *continue-token, number of object labels in the returned list, object
> +        label list*
> +| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3, H_P4,
> +                H_Authority, H_Busy, H_Aborted, H_Continue*
> +
> +H_PKS_GET_OBJECTLABELS is used to retrieve a list of object labels owned by the
> +specified consumer.
> +
> +
>   References
>   ==========
>   .. [1] "Power Architecture Platform Reference"
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index dff90a7d7f70..4d4c2ce1dd87 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -340,6 +340,7 @@
>   #define H_PKS_GET_CONFIG	0x41C
>   #define H_PKS_SET_PASSWORD	0x420
>   #define H_PKS_GEN_PASSWORD	0x424
> +#define H_PKS_GET_OBJECTLABELS	0x428
>   #define H_PKS_WRITE_OBJECT	0x42C
>   #define H_PKS_GEN_KEY		0x430
>   #define H_PKS_READ_OBJECT	0x434
> @@ -362,7 +363,9 @@
>   #define H_GUEST_DELETE		0x488
>   #define H_PKS_WRAP_OBJECT	0x490
>   #define H_PKS_UNWRAP_OBJECT	0x494
> -#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
> +#define H_PKS_REVOKE_OBJECT	0x4AC
> +#define H_PKS_UNREVOKE_OBJECT	0x4B0
> +#define MAX_HCALL_OPCODE	H_PKS_UNREVOKE_OBJECT
>   
>   /* Scope args for H_SCM_UNBIND_ALL */
>   #define H_UNBIND_SCOPE_ALL (0x1)
> diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
> index 8b2ffb27db5a..c39d1f07017e 100644
> --- a/arch/powerpc/include/asm/plpks.h
> +++ b/arch/powerpc/include/asm/plpks.h
> @@ -25,6 +25,7 @@
>   #define PLPKS_SIGNEDUPDATE	PPC_BIT32(7) // Object can only be modified by signed updates
>   #define PLPKS_WRAPPINGKEY	PPC_BIT32(8) // Object contains a wrapping key
>   #define PLPKS_HVPROVISIONED	PPC_BIT32(28) // Hypervisor has provisioned this object
> +#define PLPKS_REVOKED		PPC_BIT32(30) // Object is revoked
>   
>   // Signature algorithm flags from signed_update_algorithms
>   #define PLPKS_ALG_RSA2048	PPC_BIT(0)
> @@ -123,6 +124,20 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
>   
>   int plpks_unwrap_object(u8 **input_buf, u64 input_len,
>   			u8 **output_buf, u64 *output_len);
> +
> +int plpks_revoke_wrapping_key(struct plpks_var *var);
> +
> +int plpks_unrevoke_wrapping_key(struct plpks_var *var);
> +
> +int plpks_del_wrapping_key(struct plpks_var *var);
> +
> +int plpks_is_wrapping_key_revoked(struct plpks_var *var);
> +
> +int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
> +			    char *comp_prefix);
> +
> +bool plpks_revoke_is_supported(void);
> +
>   #else // CONFIG_PSERIES_PLPKS
>   static inline bool plpks_is_available(void) { return false; }
>   static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index d582c786ccad..3b1e6f00b4ae 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -23,8 +23,17 @@
>    */
>   #define PLPKS_WRAPPING_BUF_DIFF	1024
>   
> +/*
> + * Maximum length for the buffer to store the retrieved object labels
> + */
> +#define PLPKS_OBJLABEL_BUF_MAX	2550
> +
> +#define PLPKS_OBJLABEL_LEN_FIELD_SIZE	2
> +#define PLPKS_OBJLABEL_PREFIX_LEN	8
> +
>   #define PLPKS_WRAP_INTERFACE_BIT	3
>   #define PLPKS_WRAPPING_KEY_LENGTH	32
> +#define PLPKS_REVOKE_INTERFACE_BIT	4
>   
>   #define WRAPFLAG_BE_BIT_SET(be_bit) \
>   	BIT_ULL(63 - (be_bit))
> @@ -46,6 +55,7 @@
>   #include <linux/libfdt.h>
>   #include <linux/memblock.h>
>   #include <linux/bitfield.h>
> +#include <linux/unaligned.h>
>   #include <asm/hvcall.h>
>   #include <asm/machdep.h>
>   #include <asm/plpks.h>
> @@ -67,6 +77,7 @@ static u32 maxlargeobjectsize;
>   static u64 signedupdatealgorithms;
>   static u64 wrappingfeatures;
>   static bool wrapsupport;
> +static bool revokesupport;
>   
>   struct plpks_auth {
>   	u8 version;
> @@ -146,6 +157,9 @@ static int pseries_status_to_err(int rc)
>   	case H_ABORTED:
>   		err = -EIO;
>   		break;
> +	case H_CONTINUE:
> +		err = -EAGAIN;
> +		break;
>   	default:
>   		err = -EINVAL;
>   	}
> @@ -312,6 +326,7 @@ static int _plpks_get_config(void)
>   	signedupdatealgorithms = be64_to_cpu(config->signedupdatealgorithms);
>   	wrappingfeatures = be64_to_cpu(config->wrappingfeatures);
>   	wrapsupport = config->flags & PPC_BIT8(PLPKS_WRAP_INTERFACE_BIT);
> +	revokesupport = config->flags & PPC_BIT8(PLPKS_REVOKE_INTERFACE_BIT);
>   
>   	// Validate that the numbers we get back match the requirements of the spec
>   	if (maxpwsize < 32) {
> @@ -831,9 +846,6 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
>   	if (var->namelen > PLPKS_MAX_NAME_SIZE)
>   		return -EINVAL;
>   
> -	if (var->policy & PLPKS_WRAPPINGKEY)
> -		return -EPERM;
> -
>   	auth = construct_auth(consumer);
>   	if (IS_ERR(auth))
>   		return PTR_ERR(auth);
> @@ -903,6 +915,23 @@ bool plpks_wrapping_is_supported(void)
>   }
>   EXPORT_SYMBOL_GPL(plpks_wrapping_is_supported);
>   
> +/**
> + * plpks_revoke_is_supported() - Get the H_PKS_REVOKE_OBJECT and
> + * H_PKS_UNREVOKE_OBJECT interfaces availability status for the LPAR.
> + *
> + * Successful execution of the H_PKS_GET_CONFIG HCALL during initialization
> + * sets bit 4 of the flags variable in the PLPKS config structure if the
> + * H_PKS_REVOKE_OBJECT and H_PKS_UNREVOKE_OBJECT interfaces are supported.
> + *
> + * Returns: true if the H_PKS_REVOKE_OBJECT and H_PKS_UNREVOKE_OBJECT interfaces
> + * are supported, false if not.
> + */
> +bool plpks_revoke_is_supported(void)
> +{
> +	return revokesupport;
> +}
> +EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
> +
>   /**
>    * plpks_gen_wrapping_key() - Generate a new random key with the 'wrapping key'
>    * policy set.
> @@ -1189,6 +1218,458 @@ int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
>   }
>   EXPORT_SYMBOL_GPL(plpks_unwrap_object);
>   
> +/**
> + * plpks_revoke_wrapping_key() - Revoke a wrapping key stored in the PLPKS.
> + * @var: variable representing the wrapping key to be revoked
> + *
> + * The H_PKS_REVOKE_OBJECT HCALL revokes an object stored in the PLPKS.
> + *
> + * Possible reasons for the returned errno values:
> + *
> + * -ENXIO	if PLPKS is not supported
> + * -EIO		if PLPKS access is blocked due to the LPAR's state
> + *		if PLPKS modification is blocked due to the LPAR's state
> + *		if an error occurred while processing the request
> + * -EINVAL	if invalid authorization parameter
> + *		if invalid wrapping key label parameter
> + *		if invalid wrapping key label length parameter
> + *		if invalid or unsupported wrapping key revoking flags
> + * -EPERM	if access is denied
> + * -ENOENT	if the requested wrapping key was not found
> + * -EBUSY	if unable to handle the request or long running operation
> + *		initiated, retry later.
> + *
> + * Returns: On success 0 is returned, a negative errno if not.
> + */
> +int plpks_revoke_wrapping_key(struct plpks_var *var)
> +{
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
> +	struct plpks_auth *auth = NULL;
> +	struct label *label;
> +	u64 objrevokeflags = 0;
> +	int rc = 0, pseries_status = 0;
> +
> +	if (!var)
> +		return -EINVAL;
> +
> +	if (!var->name || !*var->name) {
> +		pr_err("key label cannot be NULL/empty\n");
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!strcmp((char *)var->name, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
> +		pr_warn("the default wrapping key must not be revoked!\n");
> +		rc = -EPERM;
> +		goto out;
> +	}
> +
> +	auth = construct_auth(PLPKS_OS_OWNER);
> +	if (IS_ERR(auth)) {
> +		rc = PTR_ERR(auth);
> +		goto out;
> +	}
> +
> +	label = construct_label(var->component, var->os, var->name,
> +				var->namelen);
> +	if (IS_ERR(label)) {
> +		rc = PTR_ERR(label);
> +		goto out;
> +	}
> +
> +	rc = plpar_hcall(H_PKS_REVOKE_OBJECT, retbuf, virt_to_phys(auth),
> +			 virt_to_phys(label), label->size, objrevokeflags);
> +
> +	pseries_status = rc;
> +	rc = pseries_status_to_err(rc);
> +
> +	if (rc) {
> +		pr_err("H_PKS_REVOKE_OBJECT failed. pseries_status=%d, rc=%d\n",
> +		       pseries_status, rc);
> +	}
> +
> +	if (!rc || (rc == -EPERM && retbuf[0]))
> +		var->policy = (u32)retbuf[0];
> +
> +	kfree(label);
> +out:
> +	kfree(auth);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(plpks_revoke_wrapping_key);
> +
> +/**
> + * plpks_unrevoke_wrapping_key() - Unrevoke a revoked wrapping key in the PLPKS.
> + * @var: variable representing the revoked wrapping key to be unrevoked
> + *
> + * The H_PKS_UNREVOKE_OBJECT HCALL unrevokes a revoked object stored in the
> + * PLPKS.
> + *
> + * Possible reasons for the returned errno values:
> + *
> + * -ENXIO	if PLPKS is not supported
> + * -EIO		if PLPKS access is blocked due to the LPAR's state
> + *		if PLPKS modification is blocked due to the LPAR's state
> + *		if an error occurred while processing the request
> + * -EINVAL	if invalid authorization parameter
> + *		if invalid object label parameter
> + *		if invalid object label length parameter
> + *		if invalid or unsupported object revoking flags
> + * -EPERM	if access is denied
> + * -ENOENT	if the requested object was not found
> + * -EBUSY	if unable to handle the request or long running operation
> + *		initiated, retry later.
> + *
> + * Returns: On success 0 is returned, a negative errno if not.
> + */
> +int plpks_unrevoke_wrapping_key(struct plpks_var *var)
> +{
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
> +	struct plpks_auth *auth = NULL;
> +	struct label *label;
> +	u64 objrevokeflags = 0;
> +	int rc = 0, pseries_status = 0;
> +
> +	if (!var)
> +		return -EINVAL;
> +
> +	if (!var->name || !*var->name) {
> +		pr_err("key label cannot be NULL/empty\n");
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!strcmp((char *)var->name, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
> +		pr_warn("unrevoke on the default wrapping key is invalid\n");
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	auth = construct_auth(PLPKS_OS_OWNER);
> +	if (IS_ERR(auth)) {
> +		rc = PTR_ERR(auth);
> +		goto out;
> +	}
> +
> +	label = construct_label(var->component, var->os, var->name,
> +				var->namelen);
> +	if (IS_ERR(label)) {
> +		rc = PTR_ERR(label);
> +		goto out;
> +	}
> +
> +	rc = plpar_hcall(H_PKS_UNREVOKE_OBJECT, retbuf,
> +			 virt_to_phys(auth), virt_to_phys(label),
> +			 label->size, objrevokeflags);
> +
> +	pseries_status = rc;
> +	rc = pseries_status_to_err(rc);
> +
> +	if (rc)
> +		pr_err("H_PKS_UNREVOKE_OBJECT failed. pseries_status=%d, rc=%d\n",
> +		       pseries_status, rc);
> +
> +	if (!rc || (rc == -EPERM && retbuf[0]))
> +		var->policy = (u32)retbuf[0];
> +
> +	kfree(label);
> +out:
> +	kfree(auth);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(plpks_unrevoke_wrapping_key);
> +
> +/**
> + * plpks_is_wrapping_key_revoked() - Check if a given wrapping key has been
> + * revoked.
> + * @var: variable representing the wrapping key to be checked
> + *
> + * When the H_PKS_READ_OBJECT HCALL tries reads an object that exists but when
> + * the policy is not met, it returns H_AUTHORITY along with the 4-byte object
> + * policy. This policy is inspected to determine if the object has been revoked.
> + *
> + * Possible reasons for the returned errno values:
> + *
> + * -ENXIO	if PLPKS is not supported
> + * -EIO		if PLPKS access is blocked due to the LPAR's state
> + *		if an error occurred while processing the request
> + * -EINVAL	if invalid authorization parameter
> + *		if invalid object label parameter
> + *		if invalid object label len parameter
> + *		if invalid output data parameter
> + *		if invalid output data len parameter
> + * -EPERM	if access is denied
> + * -ENOENT	if the requested object was not found
> + * -EFBIG	if the requested object couldn't be
> + *		stored in the buffer provided
> + * -EBUSY	if unable to handle the request
> + *
> + * Returns: 1 is returned if the wrapping key has been revoked. 0 is returned if
> + *	    the wrapping key has not been revoked. Otherwise, a negative errno
> + *	    is returned.
> + */
> +int plpks_is_wrapping_key_revoked(struct plpks_var *var)
> +{
> +	int rc;
> +
> +	if (!var)
> +		return -EINVAL;
> +
> +	if (!var->name || !*var->name) {
> +		pr_err("key label cannot be NULL/empty\n");
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	rc = plpks_read_var(PLPKS_OS_OWNER, var);
> +	if (!rc) {
> +		pr_err("unexpected successful read of wrapping key\n");
> +		rc = -EIO;
> +	} else if (rc == -EPERM) {
> +		if (var->policy & PLPKS_WRAPPINGKEY) {
> +			if (var->policy & PLPKS_REVOKED)
> +				rc = 1;
> +			else
> +				rc = 0;
> +		}
> +	}
> +
> +out:
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(plpks_is_wrapping_key_revoked);
> +
> +/**
> + * plpks_del_wrapping_key() - Delete a wrapping key from the PLPKS.
> + * @var: variable representing the revoked wrapping key to be deleted
> + *
> + * The plpks_remove_var function removes the specified variable and its data
> + * from the PLPKS by invoking the H_PKS_REMOVE_OBJECT HCALL.
> + *
> + * Possible reasons for the returned errno values:
> + *
> + * -ENXIO	if PLPKS is not supported
> + * -EIO		if PLPKS access is blocked due to the LPAR's state
> + *		if PLPKS modification is blocked due to the LPAR's state
> + *		if an error occurred while processing the request
> + * -EINVAL	if invalid authorization parameter
> + *		if invalid object label parameter
> + *		if invalid object label len parameter
> + * -EPERM	if access is denied
> + * -ENOENT	if the requested object was not found
> + * -EBUSY	if unable to handle the request
> + *
> + * Returns: On success 0 is returned, a negative errno if not.
> + */
> +int plpks_del_wrapping_key(struct plpks_var *var)
> +{
> +	int rc;
> +	struct plpks_var_name vname;
> +
> +	if (!var)
> +		return -EINVAL;
> +
> +	if (!var->name || !*var->name) {
> +		pr_err("key label cannot be NULL/empty\n");
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!strcmp((char *)var->name, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
> +		pr_warn("the default wrapping key must not be deleted!\n");
> +		rc = -EPERM;
> +		goto out;
> +	}
> +
> +	rc = plpks_is_wrapping_key_revoked(var);
> +	if (rc == 1) {
> +		vname = (struct plpks_var_name) {
> +			.name = var->name,
> +			.namelen = var->namelen
> +		};
> +
> +		rc = plpks_remove_var(PLPKS_WRAPKEY_COMPONENT, var->os,
> +				      vname);
> +		if (rc)
> +			pr_err("deletion of <%s> failed. rc=%d\n",
> +			       (char *)var->name, rc);
> +		goto out;
> +	} else if (!rc) {
> +		pr_err("revoke <%s> before deletion\n", (char *)var->name);
> +		rc = -EPERM;
> +		goto out;
> +	} else {
> +		pr_err("revocation status check failed for <%s>. rc = %d\n",
> +		       (char *)var->name, rc);
> +	}
> +
> +out:
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(plpks_del_wrapping_key);
> +
> +/**
> + * plpks_get_object_labels() - retrieve a list of object labels for the objects
> + * stored in the PLPKS
> + * @output_buf: buffer to store the retrieved object labels
> + * @output_len: number of object labels retrieved
> + * @comp_prefix: component prefix string
> + *
> + * The H_PKS_GET_OBJECTLABELS HCALL retrieves a list of object labels for the
> + * objects with the given component prefix stored in the PLPKS.
> + *
> + * Possible reasons for the returned errno values:
> + *
> + * -ENXIO	if PLPKS is not supported
> + * -EIO		if PLPKS access is blocked due to the LPAR's state
> + *		if PLPKS modification is blocked due to the LPAR's state
> + *		if an error occurred while processing the request
> + * -EINVAL	if invalid authorization parameter
> + *		if invalid output buffer parameter
> + *		if invalid output buffer length parameter
> + *		if invalid continue token parameter
> + *		if the provided component prefix is NULL
> + * -EPERM	if access is denied
> + * -EBUSY	if unable to handle the request or long running operation
> + *		initiated, retry later.
> + *
> + * Returns: On success 0 is returned, a negative errno if not.
> + */
> +int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
> +			    char *comp_prefix)
> +{
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
> +	u8 *labels_buf = NULL;
> +	u8 *tmp_buf = NULL;
> +	struct plpks_auth *auth = NULL;
> +	struct label_attr *metadata = NULL;
> +	u16 label_len;
> +	u64 labels_count;
> +	u64 continuetoken = 0, output_buf_len = 0;
> +	int rc = 0, pseries_status = 0;
> +	size_t labels_buf_offset = 0, output_buf_offset = 0;
> +	size_t obj_label_entry_size, i;
> +
> +	*output_buf = NULL;
> +	*output_len = 0;
> +
> +	if (!comp_prefix) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	auth = construct_auth(PLPKS_OS_OWNER);
> +	if (IS_ERR(auth)) {
> +		rc = PTR_ERR(auth);
> +		goto out;
> +	}
> +
> +	do {
> +		labels_buf =
> +			kzalloc(roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX),
> +				GFP_KERNEL);
> +
> +		if (!labels_buf) {
> +			pr_err("labels_buf buffer allocation failed\n");
> +			rc = -ENOMEM;
> +			goto out_free_output_buf;
> +		}
> +
> +		rc = plpar_hcall(H_PKS_GET_OBJECTLABELS, retbuf,
> +				 virt_to_phys(auth), continuetoken,
> +				 virt_to_phys(labels_buf),
> +				 roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX));
> +
> +		pseries_status = rc;
> +		rc = pseries_status_to_err(rc);
> +
> +		if (rc && rc != -EAGAIN) {
> +			pr_err("H_PKS_GET_OBJECTLABELS failed. pseries_status=%d rc=%d\n",
> +			       pseries_status, rc);
> +			goto out_free_labels_buf;
> +		} else {
> +			/*
> +			 * Setting an incorrect countinuetoken upon
> +			 * receiving H_CONTINUE would result in H_P2. Since
> +			 * the continuetoken is being set to the expected
> +			 * value from the previous call, H_P2 must not be
> +			 * returned.
> +			 */
> +			continuetoken = retbuf[1];
> +
> +			labels_count = retbuf[0];
> +			if (!labels_count) {
> +				kfree(labels_buf);
> +				labels_buf = NULL;
> +				goto out;
> +			}
> +
> +			/*
> +			 * Filter out object labels that don't have the provided
> +			 * component prefix.
> +			 */
> +
> +			output_buf_len +=
> +				roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX);
> +
> +			tmp_buf = krealloc(*output_buf, output_buf_len,
> +					   GFP_KERNEL);
> +
> +			if (!tmp_buf) {
> +				pr_err("output buffer re-allocation failed\n");
> +				rc = -ENOMEM;
> +				goto out_free_labels_buf;
> +			}
> +
> +			*output_buf = tmp_buf;
> +
> +			for (i = 0; i < labels_count; ++i) {
> +				label_len =
> +					get_unaligned_be16(labels_buf +
> +							   labels_buf_offset);
> +
> +				obj_label_entry_size =
> +					PLPKS_OBJLABEL_LEN_FIELD_SIZE +
> +					label_len;
> +
> +				metadata =
> +					(struct label_attr *)(labels_buf +
> +					labels_buf_offset +
> +					PLPKS_OBJLABEL_LEN_FIELD_SIZE);
> +
> +				if (!memcmp(metadata->prefix, comp_prefix,
> +					    PLPKS_OBJLABEL_PREFIX_LEN)) {
> +					memcpy(*output_buf + output_buf_offset,
> +					       labels_buf + labels_buf_offset,
> +					       obj_label_entry_size);
> +
> +					output_buf_offset +=
> +						obj_label_entry_size;
> +					(*output_len) += 1;
> +				}
> +				labels_buf_offset += obj_label_entry_size;
> +			}
> +			kfree(labels_buf);
> +			labels_buf = NULL;
> +			labels_buf_offset = 0;
> +		}
> +	} while (rc == -EAGAIN);
> +
> +	goto out;
> +
> +out_free_labels_buf:
> +	kfree(labels_buf);
> +	labels_buf = NULL;
> +out_free_output_buf:
> +	kfree(*output_buf);
> +	*output_buf = NULL;
> +	*output_len = 0;
> +out:
> +	kfree(auth);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(plpks_get_object_labels);
> +
>   /**
>    * plpks_read_os_var() - Fetch the data for the specified variable that is owned
>    * by the OS consumer.

-- 
Thanks and Regards
R.Nageswara Sastry


