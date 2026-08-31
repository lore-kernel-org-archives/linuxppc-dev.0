Return-Path: <linuxppc-dev+bounces-26275-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0E1C61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:15:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRHL1jNbz2y2f;
	Mon, 31 Aug 2026 21:15:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788174926;
	cv=none; b=CxpPXT1BnPQGkqitFYULr22Oj4PFoTQ/RuX1EFYAtPp9F1uZeSmHeKXs1mToj/05N7xxGP7mJbKU6AP8GvXfZpRoQj0/fPZOugOKfcLBxqCuP8iR4l+cVJVKuSgslK/+5P83lVY8L+w1+S6ffaOE50NlhgMW23OF0M5wUirXQtM6pzs7IUFqnjDTL0MwSIkTkDX+bkFagm9oiJPpkaFWOIsxZEpF9LstI4EK4t72+3D2f/z0h+rLi17dFFJQZ1mI+wbWV8e1XSCGxR+8u3Q1YU07+7f7HqbPP0dylGaTAYfdjDpYlpE5T4gOZ+8wB9Tdc/sJevPd2iweaCR97wGhww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788174926; c=relaxed/relaxed;
	bh=jIW2RvVTw5HNfWo6mB5oI20TffZc9A6hR2YM47QV8zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXKALUUDtMCt80lsqXgB56/DqOCbqNrnpEnV+zkbByMokh8DpM2r3huNMei9nVhiR75KLTRP5hXthSVx9fUEHSpJKUC26fz1pK7DOjwiLuEIuJHlGcQTDq3M+jXP8a+Zj0DZo/v9HdvaX/TR7beJfJEcF2Z7nz6lE9cztICyG5lbd6+5UWlfqM06iZ7H3Fjum3G/PLlUhLbaanQAVI1HKqySZALrHRcj1LHCJaAaO0cpUgVV9gjZCNozcP6Ytwcm4y2Y96X1LqjwcAoN5reobriCZu/O5zaQcfsa6zUU1nJO42Y/HEwfGqMp0Jn5bcEVbdTl+4KIWqaUjTMjN2ue2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MmKIztMY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MmKIztMY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRHJ6DNxz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:15:24 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82U3Z1640552;
	Mon, 31 Aug 2026 11:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jIW2Rv
	VTw5HNfWo6mB5oI20TffZc9A6hR2YM47QV8zU=; b=MmKIztMYA0LPADfn7B83Va
	v79UyF8DVvplDUSMprKj2O2Udc5K/4wA+8tqufC8y+zKeHHgWCBKHU60VIPRs/S9
	XU1ps4QtwX5AdLJc9dF9czGRLtN1zwDiYIztpl1zUoSmouA1w8I6ljpmuQS8kVwq
	ENjM6fmpZ147wNoa4cs1TTIa7URRTnq+Xn2Tb3DYo/qKwA3SbSR4LF593TAJXOWE
	HtdRfMAdth5zk20VP80LGcV6eshqVQKAwaE7xTtvmO4Qq58DJWDBK2oZ76VN5LvS
	4M1cr2RxnptAsHQoQroURqK0QPd4d/l5VryEAjCplTANfJojxa27DvAES9vvu7vg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx58va9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:15:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDHvl007580;
	Mon, 31 Aug 2026 11:15:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq5pbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:15:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBF7s913697556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:15:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E61715805A;
	Mon, 31 Aug 2026 11:15:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E38C58051;
	Mon, 31 Aug 2026 11:15:02 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:15:01 +0000 (GMT)
Message-ID: <fc844444-e684-460c-8c99-cf24367831c9@linux.ibm.com>
Date: Mon, 31 Aug 2026 16:45:00 +0530
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
Subject: Re: [PATCH 6/8] pseries/plpks: add HCALLs for PKWM wrapping key life
 cycle management
To: R Nageswara Sastry <rnsastry@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260827062309.724808-1-ssrish@linux.ibm.com>
 <20260827062309.724808-7-ssrish@linux.ibm.com>
 <94a8cd96-9e49-4f39-8730-e677b113d256@linux.ibm.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <94a8cd96-9e49-4f39-8730-e677b113d256@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a95623d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=RpNjiQI2AAAA:8
 a=VnNF1IyMAAAA:8 a=Tt0fwigvkZjGoAu4qJwA:9 a=2zeZwfwtEwIPCJIq:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uVl8VZP9vN56kkfl79RckAMQ0wO0TqA6
X-Proofpoint-ORIG-GUID: f3_Ldzvy_Gzmjt3D1h-_beXXg7E0cspI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX/bfaxBOsLZDN
 732QvUx6jaGpCqDBnOGlCX0JQsccHnSlK1prEJK9GSGRJ2j3hmK2lMJ3VaSlLu7VNwpTVVCVR2o
 jww39sAMKdC3voDPzQ2+tGNIKmvj99w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX+5RsEmiL83qG
 6bVMMBvxG53qyA6aZppqO9iWi8R81+6V2m4h4jIS274YMJ1QRkzvJtB+SiXnzNPil5vNG0A/ah4
 DAqc3tVhm+UGqRGSXvx00YY2u2pqNg5AaEJtbQ0OKYVtXCpd+X2F0iscqkaI8MGCCkXFkeUPHd/
 o0gp7ZreJbgBCbg0/JkytfJFtZQAagTbYQMh9fjjxQF3T1jVe7y0kjaoFGf/En2bVS4NuclHHoG
 xMlI0OhC9/rbv2a8EaOAqMEUsD0cJ9YHrhNNAyKDc0Q/B+274MDtoOObsMfSjIaOBFBVO0VVNL1
 qI5TkI4lyc2a+5rPkRgU2YR1c1ZFIfjwkOUsO5fgjKKilgq4+nJMla3sKuVRxff3H+gzZ4p0dDx
 lw+npU4qZiSMmBbzjtU7MH/fLHdBH7EfMGqOm/oDghMdmEkHll4nw6nk/bMUb7prq74V1d42H8o
 h5CvTWFDt9HZIOG1Y4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310095

Hi Nageswara,
Thanks for taking a look.

On 8/28/26 4:34 PM, R Nageswara Sastry wrote:
> On 27.=E2=80=8A08.=E2=80=8A2026 11:=E2=80=8A53 AM, Srish Srinivasan wrote=
: The PKWM trusted=20
> source uses a single wrapping key per LPAR, created only once during=20
> trust source initialization. All the wrap and unwrap requests are=20
> bound to this default wrapping key. Implement
>=20
>
>
> On 27.08.2026 11:53 AM, Srish Srinivasan wrote:
>> The PKWM trusted source uses a single wrapping key per LPAR, created only
>> once during trust source initialization. All the wrap and unwrap requests
>> are bound to this default wrapping key.
>>
>> Implement H_PKS_REVOKE_OBJECT, H_PKS_UNREVOKE_OBJECT, and
>> H_PKS_GET_OBJECTLABELS HCALLs to enable support for revoking and unrevok=
ing
>> PKWM wrapping keys, and for retrieving wrapping key labels. The label
>> retrieval operation (H_PKS_GET_OBJECTLABELS) applies to all wrapping keys
>> including the default one, while the life cycle operations
>> (H_PKS_REVOKE_OBJECT/H_PKS_UNREVOKE_OBJECT) apply only to user-created
>> wrapping keys.
>>
>> Signed-off-by: Srish Srinivasan<ssrish@linux.ibm.com>
>> ---
>>   Documentation/arch/powerpc/papr_hcalls.rst |  33 ++
>>   arch/powerpc/include/asm/hvcall.h          |   5 +-
>>   arch/powerpc/include/asm/plpks.h           |  15 +
>>   arch/powerpc/platforms/pseries/plpks.c     | 475 ++++++++++++++++++++-
>>   4 files changed, 524 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/arch/powerpc/papr_hcalls.rst b/Documentation/=
arch/powerpc/papr_hcalls.rst
>> index 44c9c8b32ae3..3455b403a048 100644
>> --- a/Documentation/arch/powerpc/papr_hcalls.rst
>> +++ b/Documentation/arch/powerpc/papr_hcalls.rst
>> @@ -343,6 +343,39 @@ is returned to the caller.
>>   H_PKS_UNWRAP_OBJECT is used to unwrap an object that was previously wr=
apped with
>>   H_PKS_WRAP_OBJECT.
>>  =20
>> +**H_PKS_REVOKE_OBJECT**
>> +
>> +| Input: authorization, objectlabel, objectlabellen, flags
>> +| Out: *object policy*
>> +| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P=
3, H_P4,
>> +                H_Authority, H_Not_Found, H_Busy, H_Aborted*
>> +
>> +H_PKS_REVOKE_OBJECT is used to revoke an object in Platform Keystore.
>> +
>> +
>> +**H_PKS_UNREVOKE_OBJECT**
>> +
>> +| Input: authorization, objectlabel, objectlabellen, flags
>> +| Out: *object policy*
>> +| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P=
3, H_P4,
>> +                H_Authority, H_Not_Found, H_Busy, H_Aborted*
>> +
>> +H_PKS_UNREVOKE_OBJECT is used to unrevoke an object that was previously=
 revoked
>> +with H_PKS_REVOKE_OBJECT in Platform Keystore.
>> +
>> +
>> +**H_PKS_GET_OBJECTLABELS**
>> +
>> +| Input: authorization, continueToken, out, outlen
>> +| Out: *continue-token, number of object labels in the returned list, o=
bject
>> +        label list*
>> +| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P=
3, H_P4,
>> +                H_Authority, H_Busy, H_Aborted, H_Continue*
>> +
>> +H_PKS_GET_OBJECTLABELS is used to retrieve a list of object labels owne=
d by the
>> +specified consumer.
>> +
>> +
>>   References
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   .. [1] "Power Architecture Platform Reference"
>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/as=
m/hvcall.h
>> index dff90a7d7f70..4d4c2ce1dd87 100644
>> --- a/arch/powerpc/include/asm/hvcall.h
>> +++ b/arch/powerpc/include/asm/hvcall.h
>> @@ -340,6 +340,7 @@
>>   #define H_PKS_GET_CONFIG	0x41C
>>   #define H_PKS_SET_PASSWORD	0x420
>>   #define H_PKS_GEN_PASSWORD	0x424
>> +#define H_PKS_GET_OBJECTLABELS	0x428
>>   #define H_PKS_WRITE_OBJECT	0x42C
>>   #define H_PKS_GEN_KEY		0x430
>>   #define H_PKS_READ_OBJECT	0x434
>> @@ -362,7 +363,9 @@
>>   #define H_GUEST_DELETE		0x488
>>   #define H_PKS_WRAP_OBJECT	0x490
>>   #define H_PKS_UNWRAP_OBJECT	0x494
>> -#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
>> +#define H_PKS_REVOKE_OBJECT	0x4AC
>> +#define H_PKS_UNREVOKE_OBJECT	0x4B0
>> +#define MAX_HCALL_OPCODE	H_PKS_UNREVOKE_OBJECT
>>  =20
>>   /* Scope args for H_SCM_UNBIND_ALL */
>>   #define H_UNBIND_SCOPE_ALL (0x1)
>> diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm=
/plpks.h
>> index 8b2ffb27db5a..c39d1f07017e 100644
>> --- a/arch/powerpc/include/asm/plpks.h
>> +++ b/arch/powerpc/include/asm/plpks.h
>> @@ -25,6 +25,7 @@
>>   #define PLPKS_SIGNEDUPDATE	PPC_BIT32(7) // Object can only be modified=
 by signed updates
>>   #define PLPKS_WRAPPINGKEY	PPC_BIT32(8) // Object contains a wrapping k=
ey
>>   #define PLPKS_HVPROVISIONED	PPC_BIT32(28) // Hypervisor has provisione=
d this object
>> +#define PLPKS_REVOKED		PPC_BIT32(30) // Object is revoked
>>  =20
>>   // Signature algorithm flags from signed_update_algorithms
>>   #define PLPKS_ALG_RSA2048	PPC_BIT(0)
>> @@ -123,6 +124,20 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len=
, u16 wrap_flags,
>>  =20
>>   int plpks_unwrap_object(u8 **input_buf, u64 input_len,
>>   			u8 **output_buf, u64 *output_len);
>> +
>> +int plpks_revoke_wrapping_key(struct plpks_var *var);
>> +
>> +int plpks_unrevoke_wrapping_key(struct plpks_var *var);
>> +
>> +int plpks_del_wrapping_key(struct plpks_var *var);
>> +
>> +int plpks_is_wrapping_key_revoked(struct plpks_var *var);
>> +
>> +int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
>> +			    char *comp_prefix);
>> +
>> +bool plpks_revoke_is_supported(void);
>> +
>>   #else // CONFIG_PSERIES_PLPKS
>>   static inline bool plpks_is_available(void) { return false; }
>>   static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
>> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platf=
orms/pseries/plpks.c
>> index b553f7b130b6..48a86497eb2b 100644
>> --- a/arch/powerpc/platforms/pseries/plpks.c
>> +++ b/arch/powerpc/platforms/pseries/plpks.c
>> @@ -23,8 +23,17 @@
>>    */
>>   #define PLPKS_WRAPPING_BUF_DIFF	1024
>>  =20
>> +/*
>> + * Maximum length for the buffer to store the retrieved object labels
>> + */
>> +#define PLPKS_OBJLABEL_BUF_MAX	2550
>> +
>> +#define PLPKS_OBJLABEL_LEN_FIELD_SIZE	2
>> +#define PLPKS_OBJLABEL_PREFIX_LEN	8
>> +
>>   #define PLPKS_WRAP_INTERFACE_BIT	3
>>   #define PLPKS_WRAPPING_KEY_LENGTH	32
>> +#define PLPKS_REVOKE_INTERFACE_BIT	4
>>  =20
>>   #define WRAPFLAG_BE_BIT_SET(be_bit) \
>>   	BIT_ULL(63 - (be_bit))
>> @@ -46,6 +55,7 @@
>>   #include <linux/libfdt.h>
>>   #include <linux/memblock.h>
>>   #include <linux/bitfield.h>
>> +#include <linux/unaligned.h>
>>   #include <asm/hvcall.h>
>>   #include <asm/machdep.h>
>>   #include <asm/plpks.h>
>> @@ -67,6 +77,7 @@ static u32 maxlargeobjectsize;
>>   static u64 signedupdatealgorithms;
>>   static u64 wrappingfeatures;
>>   static bool wrapsupport;
>> +static bool revokesupport;
>>  =20
>>   struct plpks_auth {
>>   	u8 version;
>> @@ -146,6 +157,9 @@ static int pseries_status_to_err(int rc)
>>   	case H_ABORTED:
>>   		err =3D -EIO;
>>   		break;
>> +	case H_CONTINUE:
>> +		err =3D -EAGAIN;
>> +		break;
>>   	default:
>>   		err =3D -EINVAL;
>>   	}
>> @@ -312,6 +326,7 @@ static int _plpks_get_config(void)
>>   	signedupdatealgorithms =3D be64_to_cpu(config->signedupdatealgorithms=
);
>>   	wrappingfeatures =3D be64_to_cpu(config->wrappingfeatures);
>>   	wrapsupport =3D config->flags & PPC_BIT8(PLPKS_WRAP_INTERFACE_BIT);
>> +	revokesupport =3D config->flags & PPC_BIT8(PLPKS_REVOKE_INTERFACE_BIT);
>>  =20
>>   	// Validate that the numbers we get back match the requirements of th=
e spec
>>   	if (maxpwsize < 32) {
>> @@ -831,9 +846,6 @@ static int plpks_read_var(u8 consumer, struct plpks_=
var *var)
>>   	if (var->namelen > PLPKS_MAX_NAME_SIZE)
>>   		return -EINVAL;
>>  =20
>> -	if (var->policy & PLPKS_WRAPPINGKEY)
>> -		return -EPERM;
>> -
>>   	auth =3D construct_auth(consumer);
>>   	if (IS_ERR(auth))
>>   		return PTR_ERR(auth);
>> @@ -903,6 +915,23 @@ bool plpks_wrapping_is_supported(void)
>>   }
>>   EXPORT_SYMBOL_GPL(plpks_wrapping_is_supported);
>>  =20
>> +/**
>> + * plpks_revoke_is_supported() - Get the H_PKS_REVOKE_OBJECT and
>> + * H_PKS_UNREVOKE_OBJECT interfaces availability status for the LPAR.
>> + *
>> + * Successful execution of the H_PKS_GET_CONFIG HCALL during initializa=
tion
>> + * sets bit 4 of the flags variable in the PLPKS config structure if the
>> + * H_PKS_REVOKE_OBJECT and H_PKS_UNREVOKE_OBJECT interfaces are support=
ed.
>> + *
>> + * Returns: true if the H_PKS_REVOKE_OBJECT and H_PKS_UNREVOKE_OBJECT i=
nterfaces
>> + * are supported, false if not.
>> + */
>> +bool plpks_revoke_is_supported(void)
>> +{
>> +	return revokesupport;
>> +}
>> +EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
>> +
>>   /**
>>    * plpks_gen_wrapping_key() - Generate a new random key with the 'wrap=
ping key'
>>    * policy set.
>> @@ -1189,6 +1218,446 @@ int plpks_unwrap_object(u8 **input_buf, u64 inpu=
t_len, u8 **output_buf,
>>   }
>>   EXPORT_SYMBOL_GPL(plpks_unwrap_object);
>>  =20
>> +/**
>> + * plpks_revoke_wrapping_key() - Revoke a wrapping key stored in the PL=
PKS.
>> + * @var: variable representing the wrapping key to be revoked
>> + *
>> + * The H_PKS_REVOKE_OBJECT HCALL revokes an object stored in the PLPKS.
>> + *
>> + * Possible reasons for the returned errno values:
>> + *
>> + * -ENXIO	if PLPKS is not supported
>> + * -EIO		if PLPKS access is blocked due to the LPAR's state
>> + *		if PLPKS modification is blocked due to the LPAR's state
>> + *		if an error occurred while processing the request
>> + * -EINVAL	if invalid authorization parameter
>> + *		if invalid wrapping key label parameter
>> + *		if invalid wrapping key label length parameter
>> + *		if invalid or unsupported wrapping key revoking flags
>> + * -EPERM	if access is denied
>> + * -ENOENT	if the requested wrapping key was not found
>> + * -EBUSY	if unable to handle the request or long running operation
>> + *		initiated, retry later.
>> + *
>> + * Returns: On success 0 is returned, a negative errno if not.
>> + */
>> +int plpks_revoke_wrapping_key(struct plpks_var *var)
>> +{
>> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] =3D { 0 };
>> +	struct plpks_auth *auth =3D NULL;
>> +	struct label *label;
>> +	u64 objrevokeflags =3D 0;
>> +	int rc =3D 0, pseries_status =3D 0;
>> +
>> +	if (!var->name || !*var->name) {
>
> Can you please add null check for 'var' also.
>
> if (! var || !var->name || !*var->name)
>

Noted.
I will fix this.


>> +		pr_err("key label cannot be NULL/empty\n");
>> +		rc =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (!strcmp((char *)var->name, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
>> +		pr_warn("the default wrapping key must not be revoked!\n");
>> +		rc =3D -EPERM;
>> +		goto out;
>> +	}
>> +
>> +	auth =3D construct_auth(PLPKS_OS_OWNER);
>> +	if (IS_ERR(auth)) {
>> +		rc =3D PTR_ERR(auth);
>> +		goto out;
>> +	}
>> +
>> +	label =3D construct_label(var->component, var->os, var->name,
>> +				var->namelen);
>> +	if (IS_ERR(label)) {
>> +		rc =3D PTR_ERR(label);
>> +		goto out;
>> +	}
>> +
>> +	rc =3D plpar_hcall(H_PKS_REVOKE_OBJECT, retbuf, virt_to_phys(auth),
>> +			 virt_to_phys(label), label->size, objrevokeflags);
>> +
>> +	pseries_status =3D rc;
>> +	rc =3D pseries_status_to_err(rc);
>> +
>> +	if (rc) {
>> +		pr_err("H_PKS_REVOKE_OBJECT failed. pseries_status=3D%d, rc=3D%d\n",
>> +		       pseries_status, rc);
>> +	}
>> +
>> +	if (!rc || (rc =3D=3D -EPERM && retbuf[0]))
>> +		var->policy =3D (u32)retbuf[0];
>> +
>> +	kfree(label);
>> +out:
>> +	kfree(auth);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(plpks_revoke_wrapping_key);
>> +
>> +/**
>> + * plpks_unrevoke_wrapping_key() - Unrevoke a revoked wrapping key in t=
he PLPKS.
>> + * @var: variable representing the revoked wrapping key to be unrevoked
>> + *
>> + * The H_PKS_UNREVOKE_OBJECT HCALL unrevokes a revoked object stored in=
 the
>> + * PLPKS.
>> + *
>> + * Possible reasons for the returned errno values:
>> + *
>> + * -ENXIO	if PLPKS is not supported
>> + * -EIO		if PLPKS access is blocked due to the LPAR's state
>> + *		if PLPKS modification is blocked due to the LPAR's state
>> + *		if an error occurred while processing the request
>> + * -EINVAL	if invalid authorization parameter
>> + *		if invalid object label parameter
>> + *		if invalid object label length parameter
>> + *		if invalid or unsupported object revoking flags
>> + * -EPERM	if access is denied
>> + * -ENOENT	if the requested object was not found
>> + * -EBUSY	if unable to handle the request or long running operation
>> + *		initiated, retry later.
>> + *
>> + * Returns: On success 0 is returned, a negative errno if not.
>> + */
>> +int plpks_unrevoke_wrapping_key(struct plpks_var *var)
>> +{
>> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] =3D { 0 };
>> +	struct plpks_auth *auth =3D NULL;
>> +	struct label *label;
>> +	u64 objrevokeflags =3D 0;
>> +	int rc =3D 0, pseries_status =3D 0;
>> +
>> +	if (!var->name || !*var->name) {
> same comment as above


Yup.=C2=A0I will fix this.


>> +		pr_err("key label cannot be NULL/empty\n");
>> +		rc =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (!strcmp((char *)var->name, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
>> +		pr_warn("unrevoke on the default wrapping key is invalid\n");
>> +		rc =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	auth =3D construct_auth(PLPKS_OS_OWNER);
>> +	if (IS_ERR(auth)) {
>> +		rc =3D PTR_ERR(auth);
>> +		goto out;
>> +	}
>> +
>> +	label =3D construct_label(var->component, var->os, var->name,
>> +				var->namelen);
>> +	if (IS_ERR(label)) {
>> +		rc =3D PTR_ERR(label);
>> +		goto out;
>> +	}
>> +
>> +	rc =3D plpar_hcall(H_PKS_UNREVOKE_OBJECT, retbuf,
>> +			 virt_to_phys(auth), virt_to_phys(label),
>> +			 label->size, objrevokeflags);
>> +
>> +	pseries_status =3D rc;
>> +	rc =3D pseries_status_to_err(rc);
>> +
>> +	if (rc)
>> +		pr_err("H_PKS_UNREVOKE_OBJECT failed. pseries_status=3D%d, rc=3D%d\n",
>> +		       pseries_status, rc);
>> +
>> +	if (!rc || (rc =3D=3D -EPERM && retbuf[0]))
>> +		var->policy =3D (u32)retbuf[0];
>> +
>> +	kfree(label);
>> +out:
>> +	kfree(auth);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(plpks_unrevoke_wrapping_key);
>> +
>> +/**
>> + * plpks_is_wrapping_key_revoked() - Check if a given wrapping key has =
been
>> + * revoked.
>> + * @var: variable representing the wrapping key to be checked
>> + *
>> + * When the H_PKS_READ_OBJECT HCALL tries reads an object that exists b=
ut when
>> + * the policy is not met, it returns H_AUTHORITY along with the 4-byte =
object
>> + * policy. This policy is inspected to determine if the object has been=
 revoked.
>> + *
>> + * Possible reasons for the returned errno values:
>> + *
>> + * -ENXIO	if PLPKS is not supported
>> + * -EIO		if PLPKS access is blocked due to the LPAR's state
>> + *		if an error occurred while processing the request
>> + * -EINVAL	if invalid authorization parameter
>> + *		if invalid object label parameter
>> + *		if invalid object label len parameter
>> + *		if invalid output data parameter
>> + *		if invalid output data len parameter
>> + * -EPERM	if access is denied
>> + * -ENOENT	if the requested object was not found
>> + * -EFBIG	if the requested object couldn't be
>> + *		stored in the buffer provided
>> + * -EBUSY	if unable to handle the request
>> + *
>> + * Returns: 1 is returned if the wrapping key has been revoked. 0 is re=
turned if
>> + *	    the wrapping key has not been revoked. Otherwise, a negative err=
no
>> + *	    is returned.
>> + */
>> +int plpks_is_wrapping_key_revoked(struct plpks_var *var)
>> +{
>> +	int rc;
>> +
>> +	if (!var->name || !*var->name) {
> same comment as above


Yup.=C2=A0I will fix this.


>> +		pr_err("key label cannot be NULL/empty\n");
>> +		rc =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	rc =3D plpks_read_var(PLPKS_OS_OWNER, var);
>> +	if (!rc) {
>> +		pr_err("unexpected successful read of wrapping key\n");
>> +		rc =3D -EIO;
>> +	} else if (rc =3D=3D -EPERM) {
>> +		if (var->policy & PLPKS_WRAPPINGKEY) {
>> +			if (var->policy & PLPKS_REVOKED)
>> +				rc =3D 1;
>> +			else
>> +				rc =3D 0;
>> +		}
>> +	}
>> +
>> +out:
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(plpks_is_wrapping_key_revoked);
>> +
>> +/**
>> + * plpks_del_wrapping_key() - Delete a wrapping key from the PLPKS.
>> + * @var: variable representing the revoked wrapping key to be deleted
>> + *
>> + * The plpks_remove_var function removes the specified variable and its=
 data
>> + * from the PLPKS by invoking the H_PKS_REMOVE_OBJECT HCALL.
>> + *
>> + * Possible reasons for the returned errno values:
>> + *
>> + * -ENXIO	if PLPKS is not supported
>> + * -EIO		if PLPKS access is blocked due to the LPAR's state
>> + *		if PLPKS modification is blocked due to the LPAR's state
>> + *		if an error occurred while processing the request
>> + * -EINVAL	if invalid authorization parameter
>> + *		if invalid object label parameter
>> + *		if invalid object label len parameter
>> + * -EPERM	if access is denied
>> + * -ENOENT	if the requested object was not found
>> + * -EBUSY	if unable to handle the request
>> + *
>> + * Returns: On success 0 is returned, a negative errno if not.
>> + */
>> +int plpks_del_wrapping_key(struct plpks_var *var)
>> +{
>> +	int rc;
>> +	struct plpks_var_name vname;
>> +
>> +	if (!var->name || !*var->name) {
> same comment as above


Yup.=C2=A0I will fix this.


Thanks,
Srish.


>> +		pr_err("key label cannot be NULL/empty\n");
>> +		rc =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (!strcmp((char *)var->name, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
>> +		pr_warn("the default wrapping key must not be deleted!\n");
>> +		rc =3D -EPERM;
>> +		goto out;
>> +	}
>> +
>> +	rc =3D plpks_is_wrapping_key_revoked(var);
>> +	if (rc =3D=3D 1) {
>> +		vname =3D (struct plpks_var_name) {
>> +			.name =3D var->name,
>> +			.namelen =3D var->namelen
>> +		};
>> +
>> +		rc =3D plpks_remove_var(PLPKS_WRAPKEY_COMPONENT, var->os,
>> +				      vname);
>> +		if (rc)
>> +			pr_err("deletion of <%s> failed. rc=3D%d\n",
>> +			       (char *)var->name, rc);
>> +		goto out;
>> +	} else if (!rc) {
>> +		pr_err("revoke <%s> before deletion\n", (char *)var->name);
>> +		rc =3D -EPERM;
>> +		goto out;
>> +	} else {
>> +		pr_err("revocation status check failed for <%s>. rc =3D %d\n",
>> +		       (char *)var->name, rc);
>> +	}
>> +
>> +out:
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(plpks_del_wrapping_key);
>> +
>> +/**
>> + * plpks_get_object_labels() - retrieve a list of object labels for the=
 objects
>> + * stored in the PLPKS
>> + * @output_buf: buffer to store the retrieved object labels
>> + * @output_len: number of object labels retrieved
>> + * @comp_prefix: component prefix string
>> + *
>> + * The H_PKS_GET_OBJECTLABELS HCALL retrieves a list of object labels f=
or the
>> + * objects with the given component prefix stored in the PLPKS.
>> + *
>> + * Possible reasons for the returned errno values:
>> + *
>> + * -ENXIO	if PLPKS is not supported
>> + * -EIO		if PLPKS access is blocked due to the LPAR's state
>> + *		if PLPKS modification is blocked due to the LPAR's state
>> + *		if an error occurred while processing the request
>> + * -EINVAL	if invalid authorization parameter
>> + *		if invalid output buffer parameter
>> + *		if invalid output buffer length parameter
>> + *		if invalid continue token parameter
>> + *		if the provided component prefix is NULL
>> + * -EPERM	if access is denied
>> + * -EBUSY	if unable to handle the request or long running operation
>> + *		initiated, retry later.
>> + *
>> + * Returns: On success 0 is returned, a negative errno if not.
>> + */
>> +int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
>> +			    char *comp_prefix)
>> +{
>> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] =3D { 0 };
>> +	u8 *labels_buf =3D NULL;
>> +	u8 *tmp_buf =3D NULL;
>> +	struct plpks_auth *auth =3D NULL;
>> +	struct label_attr *metadata =3D NULL;
>> +	u16 label_len;
>> +	u64 labels_count;
>> +	u64 continuetoken =3D 0, output_buf_len =3D 0;
>> +	int rc =3D 0, pseries_status =3D 0;
>> +	size_t labels_buf_offset =3D 0, output_buf_offset =3D 0;
>> +	size_t obj_label_entry_size, i;
>> +
>> +	*output_buf =3D NULL;
>> +	*output_len =3D 0;
>> +
>> +	if (!comp_prefix) {
>> +		rc =3D -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	auth =3D construct_auth(PLPKS_OS_OWNER);
>> +	if (IS_ERR(auth)) {
>> +		rc =3D PTR_ERR(auth);
>> +		goto out;
>> +	}
>> +
>> +	do {
>> +		labels_buf =3D
>> +			kzalloc(roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX),
>> +				GFP_KERNEL);
>> +
>> +		if (!labels_buf) {
>> +			pr_err("labels_buf buffer allocation failed\n");
>> +			rc =3D -ENOMEM;
>> +			goto out_free_output_buf;
>> +		}
>> +
>> +		rc =3D plpar_hcall(H_PKS_GET_OBJECTLABELS, retbuf,
>> +				 virt_to_phys(auth), continuetoken,
>> +				 virt_to_phys(labels_buf),
>> +				 roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX));
>> +
>> +		pseries_status =3D rc;
>> +		rc =3D pseries_status_to_err(rc);
>> +
>> +		if (rc && rc !=3D -EAGAIN) {
>> +			pr_err("H_PKS_GET_OBJECTLABELS failed. pseries_status=3D%d rc=3D%d\n=
",
>> +			       pseries_status, rc);
>> +			goto out_free_labels_buf;
>> +		} else {
>> +			/*
>> +			 * Setting an incorrect countinuetoken upon
>> +			 * receiving H_CONTINUE would result in H_P2. Since
>> +			 * the continuetoken is being set to the expected
>> +			 * value from the previous call, H_P2 must not be
>> +			 * returned.
>> +			 */
>> +			continuetoken =3D retbuf[1];
>> +
>> +			labels_count =3D retbuf[0];
>> +			if (!labels_count) {
>> +				kfree(labels_buf);
>> +				labels_buf =3D NULL;
>> +				goto out;
>> +			}
>> +
>> +			/*
>> +			 * Filter out object labels that don't have the provided
>> +			 * component prefix.
>> +			 */
>> +
>> +			output_buf_len +=3D
>> +				roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX);
>> +
>> +			tmp_buf =3D krealloc(*output_buf, output_buf_len,
>> +					   GFP_KERNEL);
>> +
>> +			if (!tmp_buf) {
>> +				pr_err("output buffer re-allocation failed\n");
>> +				rc =3D -ENOMEM;
>> +				goto out_free_labels_buf;
>> +			}
>> +
>> +			*output_buf =3D tmp_buf;
>> +
>> +			for (i =3D 0; i < labels_count; ++i) {
>> +				label_len =3D
>> +					get_unaligned_be16(labels_buf +
>> +							   labels_buf_offset);
>> +
>> +				obj_label_entry_size =3D
>> +					PLPKS_OBJLABEL_LEN_FIELD_SIZE +
>> +					label_len;
>> +
>> +				metadata =3D
>> +					(struct label_attr *)(labels_buf +
>> +					labels_buf_offset +
>> +					PLPKS_OBJLABEL_LEN_FIELD_SIZE);
>> +
>> +				if (!memcmp(metadata->prefix, comp_prefix,
>> +					    PLPKS_OBJLABEL_PREFIX_LEN)) {
>> +					memcpy(*output_buf + output_buf_offset,
>> +					       labels_buf + labels_buf_offset,
>> +					       obj_label_entry_size);
>> +
>> +					output_buf_offset +=3D
>> +						obj_label_entry_size;
>> +					(*output_len) +=3D 1;
>> +				}
>> +				labels_buf_offset +=3D obj_label_entry_size;
>> +			}
>> +			kfree(labels_buf);
>> +			labels_buf =3D NULL;
>> +			labels_buf_offset =3D 0;
>> +		}
>> +	} while (rc =3D=3D -EAGAIN);
>> +
>> +	goto out;
>> +
>> +out_free_labels_buf:
>> +	kfree(labels_buf);
>> +	labels_buf =3D NULL;
>> +out_free_output_buf:
>> +	kfree(*output_buf);
>> +	*output_buf =3D NULL;
>> +	*output_len =3D 0;
>> +out:
>> +	kfree(auth);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(plpks_get_object_labels);
>> +
>>   /**
>>    * plpks_read_os_var() - Fetch the data for the specified variable tha=
t is owned
>>    * by the OS consumer.
> --=20
> Thanks and Regards
> R.Nageswara Sastry

