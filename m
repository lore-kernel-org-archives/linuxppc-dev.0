Return-Path: <linuxppc-dev+bounces-26169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6059C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 11:04:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWbBJ5KKpz2y8F;
	Fri, 28 Aug 2026 21:04:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787915080;
	cv=none; b=XvzK7Q4KmU2syrh5je80IuN+8p6eSgnt+ZgFtKQij6kn6xojVg6cW9wqNj1kLPOsHm3ZhFOHxcgcnDPQTMLE10b47ikDA/RgSrbNZRkvmny99PdY9VA2zbLD9i/NF70BjILDsysY5rjc1iES+YceXv5wWWOP4cUfsEQuLQcKyIJYPO0OqERvp3S/HJgCgNT1M/KQS/K55dPp7/9VL8/lfW3rv09bMH19dSNoC3cLLmQmolkAhB2paJLx5MM9X2swSrkYvfl0Zek9GJ3O9mf2rawrMXoXoCDiJ+biOZfGxN7reXJnQ9ViNYezDLRDodonNOrTwlZuMErzKB9+9DloXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787915080; c=relaxed/relaxed;
	bh=Pd+79KbBPIbvFt+f4MVrjd3FCUo6dIrs4578T8fBa48=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=aD6R1YD8JUqMsF5aKAMM60bYZi2QwTDe8OMa5vo71qY9c/0OsVx/n8pzLsPdOLxOFlmHOSyXUmh+N3IycxS+6t2Pqknj/mxBtSypshbIQQHhSHubMztnclcq7SGKciizd+W2yqkSCvYWQEfdP9eQBdLEcMlHECSTNIhdZlZpExu4AS2aqJEPtfxhQ8wfD/A+eVnL4Tu/KSPl0o20rmg4ujqcMicjKRr8Gbg8LPL/NwQwmkqdi56/ER2f2lbjq12JWmlYnCNl+nnqq1mcW5xcpSzR9Ef0iLtK3CKYTr8MH4hqPTyC4Pf/GzxVSsoqNSxU5waVuDst0qwJIVfI6KSEbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QNrWc+Nf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QNrWc+Nf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWbBG4cyMz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 21:04:37 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAVYeS4048580;
	Fri, 28 Aug 2026 11:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Pd+79KbBPIbvFt+f4MVrjd3FCUo6dI
	rs4578T8fBa48=; b=QNrWc+Nf1Vve9bcaYd8VgCqcoeTe7cBp6oyyQNOx90SqMa
	TrXbsM41qZZU3W1ujs7fjT0Bkce19kPJpT/sqRbsBr122ydB6xL/fGj5WtpajE+F
	pAnO0fTUCThSInPovB6Da6472hsLswRb9/c0mJYv2/2hfGvK+J8DC6wnM5C2goNA
	Xja0jG2rfu9t2jx0NwFBWQ+KlhNvAJb7BMnViPi33LxdRBhoKUz0RQBzOs7aVb7i
	xKH+D4fVEj0XKpsOo+2I6QJdDfTRPiSEgn3ceIm0j4xRLT4h1XFKL48XILTD0WJe
	SLx+r0aY0geZb6K5PwRetjDiKFQP/aEHLBXgmVyg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73erbkgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:04:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SAuSP0003197;
	Fri, 28 Aug 2026 11:04:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3kdqsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:04:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SB4Hnb36372800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:04:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7FDC20043;
	Fri, 28 Aug 2026 11:04:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A528720040;
	Fri, 28 Aug 2026 11:04:10 +0000 (GMT)
Received: from [9.61.249.126] (unknown [9.61.249.126])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Aug 2026 11:04:10 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------CYnNj7x7LOdPK0GMFZH5FtBY"
Message-ID: <94a8cd96-9e49-4f39-8730-e677b113d256@linux.ibm.com>
Date: Fri, 28 Aug 2026 16:34:07 +0530
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
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260827062309.724808-1-ssrish@linux.ibm.com>
 <20260827062309.724808-7-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260827062309.724808-7-ssrish@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LOBLOieNQ4cbdVa3cGrkJB9Gb3WEDlKw
X-Proofpoint-ORIG-GUID: VZPLiJkppqy7fbbuhBvfF05sGoP8Gups
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5NSBTYWx0ZWRfXyKSdzQ3KHYog
 p66qkRA03Qf+cmT07gS3U42SPNIjEakNcbrCVlY8QoEyQK2W3U9QmLu+OmZ4yxlrb02mn1VUUFd
 ZUYL8PTEp6jB44C8gKYKIrkskBPiow2D4iNjU+Y41KGBmJ5Ril3DoaeNvg4pq/Y2geXpjHVlLHF
 zWhVqbZmbaKflvSU3424ngrl2Me0dTmWjJTNWYxWBKalFvUlC6zjHX2G6FVqAEMK6OL2I7CiAh7
 YyzZrQJ/7Mm0PTw5vcsKA6wyfqxP5T61jJ6vDsoCcAQmXt0FmLmh5Tk5uWbX7jzt6b2Wwdcmyoo
 ZLfXQvfc6dJt5QWPJ8c6u7EXV18hhg0k0nDZnyRn8jzeQgn8s4g+TMYLDXGJjIS2oQob0cSUdw5
 cdUkPPIWnlSIa3qFUl0h4z5i3q32vvB1v7YTM9UOVi6glwUT6yZ/BHJtLC8v+UotZZUNdUt3k58
 4f4EmbbghTJB5QpEXkw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a916b37 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=syZUe3wMas8Yd6IghWgA:9 a=2zeZwfwtEwIPCJIq:21 a=QEXdDO2ut3YA:10
 a=lWQKvBrNlG38MY5WF7oA:9 a=YlH5uDmbomUVZx3t:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5NSBTYWx0ZWRfX77ndFCbU0mSV
 pgM0YvbTEfpu12jBEBcYFCpqn4cpzyeETJXxef1dak1u+cExxpw6sRLOKcO3FQXHcnt7Znf0UTo
 kEtA9Yn3HQSxqjOOBlDLWWBjP57F4io=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280095

This is a multi-part message in MIME format.
--------------CYnNj7x7LOdPK0GMFZH5FtBY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27.08.2026 11:53 AM, Srish Srinivasan wrote:
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
> Signed-off-by: Srish Srinivasan<ssrish@linux.ibm.com>
> ---
>   Documentation/arch/powerpc/papr_hcalls.rst |  33 ++
>   arch/powerpc/include/asm/hvcall.h          |   5 +-
>   arch/powerpc/include/asm/plpks.h           |  15 +
>   arch/powerpc/platforms/pseries/plpks.c     | 475 ++++++++++++++++++++-
>   4 files changed, 524 insertions(+), 4 deletions(-)
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
> index b553f7b130b6..48a86497eb2b 100644
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
> @@ -1189,6 +1218,446 @@ int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
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
> +	if (!var->name || !*var->name) {

Can you please add null check for 'var' also.

if (! var || !var->name || !*var->name)

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
> +	if (!var->name || !*var->name) {
same comment as above
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
> +	if (!var->name || !*var->name) {
same comment as above
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
> +	if (!var->name || !*var->name) {
same comment as above
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

--------------CYnNj7x7LOdPK0GMFZH5FtBY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 27.08.2026 11:53 AM, Srish
      Srinivasan wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260827062309.724808-7-ssrish@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">The PKWM trusted source uses a single wrapping key per LPAR, created only
once during trust source initialization. All the wrap and unwrap requests
are bound to this default wrapping key.

Implement H_PKS_REVOKE_OBJECT, H_PKS_UNREVOKE_OBJECT, and
H_PKS_GET_OBJECTLABELS HCALLs to enable support for revoking and unrevoking
PKWM wrapping keys, and for retrieving wrapping key labels. The label
retrieval operation (H_PKS_GET_OBJECTLABELS) applies to all wrapping keys
including the default one, while the life cycle operations
(H_PKS_REVOKE_OBJECT/H_PKS_UNREVOKE_OBJECT) apply only to user-created
wrapping keys.

Signed-off-by: Srish Srinivasan <a class="moz-txt-link-rfc2396E" href="mailto:ssrish@linux.ibm.com">&lt;ssrish@linux.ibm.com&gt;</a>
---
 Documentation/arch/powerpc/papr_hcalls.rst |  33 ++
 arch/powerpc/include/asm/hvcall.h          |   5 +-
 arch/powerpc/include/asm/plpks.h           |  15 +
 arch/powerpc/platforms/pseries/plpks.c     | 475 ++++++++++++++++++++-
 4 files changed, 524 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/powerpc/papr_hcalls.rst b/Documentation/arch/powerpc/papr_hcalls.rst
index 44c9c8b32ae3..3455b403a048 100644
--- a/Documentation/arch/powerpc/papr_hcalls.rst
+++ b/Documentation/arch/powerpc/papr_hcalls.rst
@@ -343,6 +343,39 @@ is returned to the caller.
 H_PKS_UNWRAP_OBJECT is used to unwrap an object that was previously wrapped with
 H_PKS_WRAP_OBJECT.
 
+**H_PKS_REVOKE_OBJECT**
+
+| Input: authorization, objectlabel, objectlabellen, flags
+| Out: *object policy*
+| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3, H_P4,
+                H_Authority, H_Not_Found, H_Busy, H_Aborted*
+
+H_PKS_REVOKE_OBJECT is used to revoke an object in Platform Keystore.
+
+
+**H_PKS_UNREVOKE_OBJECT**
+
+| Input: authorization, objectlabel, objectlabellen, flags
+| Out: *object policy*
+| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3, H_P4,
+                H_Authority, H_Not_Found, H_Busy, H_Aborted*
+
+H_PKS_UNREVOKE_OBJECT is used to unrevoke an object that was previously revoked
+with H_PKS_REVOKE_OBJECT in Platform Keystore.
+
+
+**H_PKS_GET_OBJECTLABELS**
+
+| Input: authorization, continueToken, out, outlen
+| Out: *continue-token, number of object labels in the returned list, object
+        label list*
+| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3, H_P4,
+                H_Authority, H_Busy, H_Aborted, H_Continue*
+
+H_PKS_GET_OBJECTLABELS is used to retrieve a list of object labels owned by the
+specified consumer.
+
+
 References
 ==========
 .. [1] "Power Architecture Platform Reference"
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index dff90a7d7f70..4d4c2ce1dd87 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -340,6 +340,7 @@
 #define H_PKS_GET_CONFIG	0x41C
 #define H_PKS_SET_PASSWORD	0x420
 #define H_PKS_GEN_PASSWORD	0x424
+#define H_PKS_GET_OBJECTLABELS	0x428
 #define H_PKS_WRITE_OBJECT	0x42C
 #define H_PKS_GEN_KEY		0x430
 #define H_PKS_READ_OBJECT	0x434
@@ -362,7 +363,9 @@
 #define H_GUEST_DELETE		0x488
 #define H_PKS_WRAP_OBJECT	0x490
 #define H_PKS_UNWRAP_OBJECT	0x494
-#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
+#define H_PKS_REVOKE_OBJECT	0x4AC
+#define H_PKS_UNREVOKE_OBJECT	0x4B0
+#define MAX_HCALL_OPCODE	H_PKS_UNREVOKE_OBJECT
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index 8b2ffb27db5a..c39d1f07017e 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -25,6 +25,7 @@
 #define PLPKS_SIGNEDUPDATE	PPC_BIT32(7) // Object can only be modified by signed updates
 #define PLPKS_WRAPPINGKEY	PPC_BIT32(8) // Object contains a wrapping key
 #define PLPKS_HVPROVISIONED	PPC_BIT32(28) // Hypervisor has provisioned this object
+#define PLPKS_REVOKED		PPC_BIT32(30) // Object is revoked
 
 // Signature algorithm flags from signed_update_algorithms
 #define PLPKS_ALG_RSA2048	PPC_BIT(0)
@@ -123,6 +124,20 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 
 int plpks_unwrap_object(u8 **input_buf, u64 input_len,
 			u8 **output_buf, u64 *output_len);
+
+int plpks_revoke_wrapping_key(struct plpks_var *var);
+
+int plpks_unrevoke_wrapping_key(struct plpks_var *var);
+
+int plpks_del_wrapping_key(struct plpks_var *var);
+
+int plpks_is_wrapping_key_revoked(struct plpks_var *var);
+
+int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
+			    char *comp_prefix);
+
+bool plpks_revoke_is_supported(void);
+
 #else // CONFIG_PSERIES_PLPKS
 static inline bool plpks_is_available(void) { return false; }
 static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index b553f7b130b6..48a86497eb2b 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -23,8 +23,17 @@
  */
 #define PLPKS_WRAPPING_BUF_DIFF	1024
 
+/*
+ * Maximum length for the buffer to store the retrieved object labels
+ */
+#define PLPKS_OBJLABEL_BUF_MAX	2550
+
+#define PLPKS_OBJLABEL_LEN_FIELD_SIZE	2
+#define PLPKS_OBJLABEL_PREFIX_LEN	8
+
 #define PLPKS_WRAP_INTERFACE_BIT	3
 #define PLPKS_WRAPPING_KEY_LENGTH	32
+#define PLPKS_REVOKE_INTERFACE_BIT	4
 
 #define WRAPFLAG_BE_BIT_SET(be_bit) \
 	BIT_ULL(63 - (be_bit))
@@ -46,6 +55,7 @@
 #include &lt;linux/libfdt.h&gt;
 #include &lt;linux/memblock.h&gt;
 #include &lt;linux/bitfield.h&gt;
+#include &lt;linux/unaligned.h&gt;
 #include &lt;asm/hvcall.h&gt;
 #include &lt;asm/machdep.h&gt;
 #include &lt;asm/plpks.h&gt;
@@ -67,6 +77,7 @@ static u32 maxlargeobjectsize;
 static u64 signedupdatealgorithms;
 static u64 wrappingfeatures;
 static bool wrapsupport;
+static bool revokesupport;
 
 struct plpks_auth {
 	u8 version;
@@ -146,6 +157,9 @@ static int pseries_status_to_err(int rc)
 	case H_ABORTED:
 		err = -EIO;
 		break;
+	case H_CONTINUE:
+		err = -EAGAIN;
+		break;
 	default:
 		err = -EINVAL;
 	}
@@ -312,6 +326,7 @@ static int _plpks_get_config(void)
 	signedupdatealgorithms = be64_to_cpu(config-&gt;signedupdatealgorithms);
 	wrappingfeatures = be64_to_cpu(config-&gt;wrappingfeatures);
 	wrapsupport = config-&gt;flags &amp; PPC_BIT8(PLPKS_WRAP_INTERFACE_BIT);
+	revokesupport = config-&gt;flags &amp; PPC_BIT8(PLPKS_REVOKE_INTERFACE_BIT);
 
 	// Validate that the numbers we get back match the requirements of the spec
 	if (maxpwsize &lt; 32) {
@@ -831,9 +846,6 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	if (var-&gt;namelen &gt; PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
-	if (var-&gt;policy &amp; PLPKS_WRAPPINGKEY)
-		return -EPERM;
-
 	auth = construct_auth(consumer);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
@@ -903,6 +915,23 @@ bool plpks_wrapping_is_supported(void)
 }
 EXPORT_SYMBOL_GPL(plpks_wrapping_is_supported);
 
+/**
+ * plpks_revoke_is_supported() - Get the H_PKS_REVOKE_OBJECT and
+ * H_PKS_UNREVOKE_OBJECT interfaces availability status for the LPAR.
+ *
+ * Successful execution of the H_PKS_GET_CONFIG HCALL during initialization
+ * sets bit 4 of the flags variable in the PLPKS config structure if the
+ * H_PKS_REVOKE_OBJECT and H_PKS_UNREVOKE_OBJECT interfaces are supported.
+ *
+ * Returns: true if the H_PKS_REVOKE_OBJECT and H_PKS_UNREVOKE_OBJECT interfaces
+ * are supported, false if not.
+ */
+bool plpks_revoke_is_supported(void)
+{
+	return revokesupport;
+}
+EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
+
 /**
  * plpks_gen_wrapping_key() - Generate a new random key with the 'wrapping key'
  * policy set.
@@ -1189,6 +1218,446 @@ int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
 }
 EXPORT_SYMBOL_GPL(plpks_unwrap_object);
 
+/**
+ * plpks_revoke_wrapping_key() - Revoke a wrapping key stored in the PLPKS.
+ * @var: variable representing the wrapping key to be revoked
+ *
+ * The H_PKS_REVOKE_OBJECT HCALL revokes an object stored in the PLPKS.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if PLPKS modification is blocked due to the LPAR's state
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid wrapping key label parameter
+ *		if invalid wrapping key label length parameter
+ *		if invalid or unsupported wrapping key revoking flags
+ * -EPERM	if access is denied
+ * -ENOENT	if the requested wrapping key was not found
+ * -EBUSY	if unable to handle the request or long running operation
+ *		initiated, retry later.
+ *
+ * Returns: On success 0 is returned, a negative errno if not.
+ */
+int plpks_revoke_wrapping_key(struct plpks_var *var)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
+	struct plpks_auth *auth = NULL;
+	struct label *label;
+	u64 objrevokeflags = 0;
+	int rc = 0, pseries_status = 0;
+
+	if (!var-&gt;name || !*var-&gt;name) {</pre>
    </blockquote>
    <p>Can you please add null check for 'var' also.</p>
    <p>if (! var || <span style="white-space: pre-wrap">!var-&gt;name || !*var-&gt;name)</span></p>
    <blockquote type="cite"
      cite="mid:20260827062309.724808-7-ssrish@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
+		pr_err("key label cannot be NULL/empty\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (!strcmp((char *)var-&gt;name, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
+		pr_warn("the default wrapping key must not be revoked!\n");
+		rc = -EPERM;
+		goto out;
+	}
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth)) {
+		rc = PTR_ERR(auth);
+		goto out;
+	}
+
+	label = construct_label(var-&gt;component, var-&gt;os, var-&gt;name,
+				var-&gt;namelen);
+	if (IS_ERR(label)) {
+		rc = PTR_ERR(label);
+		goto out;
+	}
+
+	rc = plpar_hcall(H_PKS_REVOKE_OBJECT, retbuf, virt_to_phys(auth),
+			 virt_to_phys(label), label-&gt;size, objrevokeflags);
+
+	pseries_status = rc;
+	rc = pseries_status_to_err(rc);
+
+	if (rc) {
+		pr_err("H_PKS_REVOKE_OBJECT failed. pseries_status=%d, rc=%d\n",
+		       pseries_status, rc);
+	}
+
+	if (!rc || (rc == -EPERM &amp;&amp; retbuf[0]))
+		var-&gt;policy = (u32)retbuf[0];
+
+	kfree(label);
+out:
+	kfree(auth);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_revoke_wrapping_key);
+
+/**
+ * plpks_unrevoke_wrapping_key() - Unrevoke a revoked wrapping key in the PLPKS.
+ * @var: variable representing the revoked wrapping key to be unrevoked
+ *
+ * The H_PKS_UNREVOKE_OBJECT HCALL unrevokes a revoked object stored in the
+ * PLPKS.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if PLPKS modification is blocked due to the LPAR's state
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid object label parameter
+ *		if invalid object label length parameter
+ *		if invalid or unsupported object revoking flags
+ * -EPERM	if access is denied
+ * -ENOENT	if the requested object was not found
+ * -EBUSY	if unable to handle the request or long running operation
+ *		initiated, retry later.
+ *
+ * Returns: On success 0 is returned, a negative errno if not.
+ */
+int plpks_unrevoke_wrapping_key(struct plpks_var *var)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
+	struct plpks_auth *auth = NULL;
+	struct label *label;
+	u64 objrevokeflags = 0;
+	int rc = 0, pseries_status = 0;
+
+	if (!var-&gt;name || !*var-&gt;name) {</pre>
    </blockquote>
    same comment as above
    <blockquote type="cite"
      cite="mid:20260827062309.724808-7-ssrish@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
+		pr_err("key label cannot be NULL/empty\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (!strcmp((char *)var-&gt;name, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
+		pr_warn("unrevoke on the default wrapping key is invalid\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth)) {
+		rc = PTR_ERR(auth);
+		goto out;
+	}
+
+	label = construct_label(var-&gt;component, var-&gt;os, var-&gt;name,
+				var-&gt;namelen);
+	if (IS_ERR(label)) {
+		rc = PTR_ERR(label);
+		goto out;
+	}
+
+	rc = plpar_hcall(H_PKS_UNREVOKE_OBJECT, retbuf,
+			 virt_to_phys(auth), virt_to_phys(label),
+			 label-&gt;size, objrevokeflags);
+
+	pseries_status = rc;
+	rc = pseries_status_to_err(rc);
+
+	if (rc)
+		pr_err("H_PKS_UNREVOKE_OBJECT failed. pseries_status=%d, rc=%d\n",
+		       pseries_status, rc);
+
+	if (!rc || (rc == -EPERM &amp;&amp; retbuf[0]))
+		var-&gt;policy = (u32)retbuf[0];
+
+	kfree(label);
+out:
+	kfree(auth);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_unrevoke_wrapping_key);
+
+/**
+ * plpks_is_wrapping_key_revoked() - Check if a given wrapping key has been
+ * revoked.
+ * @var: variable representing the wrapping key to be checked
+ *
+ * When the H_PKS_READ_OBJECT HCALL tries reads an object that exists but when
+ * the policy is not met, it returns H_AUTHORITY along with the 4-byte object
+ * policy. This policy is inspected to determine if the object has been revoked.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid object label parameter
+ *		if invalid object label len parameter
+ *		if invalid output data parameter
+ *		if invalid output data len parameter
+ * -EPERM	if access is denied
+ * -ENOENT	if the requested object was not found
+ * -EFBIG	if the requested object couldn't be
+ *		stored in the buffer provided
+ * -EBUSY	if unable to handle the request
+ *
+ * Returns: 1 is returned if the wrapping key has been revoked. 0 is returned if
+ *	    the wrapping key has not been revoked. Otherwise, a negative errno
+ *	    is returned.
+ */
+int plpks_is_wrapping_key_revoked(struct plpks_var *var)
+{
+	int rc;
+
+	if (!var-&gt;name || !*var-&gt;name) {</pre>
    </blockquote>
    same comment as above
    <blockquote type="cite"
      cite="mid:20260827062309.724808-7-ssrish@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
+		pr_err("key label cannot be NULL/empty\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	rc = plpks_read_var(PLPKS_OS_OWNER, var);
+	if (!rc) {
+		pr_err("unexpected successful read of wrapping key\n");
+		rc = -EIO;
+	} else if (rc == -EPERM) {
+		if (var-&gt;policy &amp; PLPKS_WRAPPINGKEY) {
+			if (var-&gt;policy &amp; PLPKS_REVOKED)
+				rc = 1;
+			else
+				rc = 0;
+		}
+	}
+
+out:
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_is_wrapping_key_revoked);
+
+/**
+ * plpks_del_wrapping_key() - Delete a wrapping key from the PLPKS.
+ * @var: variable representing the revoked wrapping key to be deleted
+ *
+ * The plpks_remove_var function removes the specified variable and its data
+ * from the PLPKS by invoking the H_PKS_REMOVE_OBJECT HCALL.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if PLPKS modification is blocked due to the LPAR's state
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid object label parameter
+ *		if invalid object label len parameter
+ * -EPERM	if access is denied
+ * -ENOENT	if the requested object was not found
+ * -EBUSY	if unable to handle the request
+ *
+ * Returns: On success 0 is returned, a negative errno if not.
+ */
+int plpks_del_wrapping_key(struct plpks_var *var)
+{
+	int rc;
+	struct plpks_var_name vname;
+
+	if (!var-&gt;name || !*var-&gt;name) {</pre>
    </blockquote>
    same comment as above
    <blockquote type="cite"
      cite="mid:20260827062309.724808-7-ssrish@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
+		pr_err("key label cannot be NULL/empty\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (!strcmp((char *)var-&gt;name, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
+		pr_warn("the default wrapping key must not be deleted!\n");
+		rc = -EPERM;
+		goto out;
+	}
+
+	rc = plpks_is_wrapping_key_revoked(var);
+	if (rc == 1) {
+		vname = (struct plpks_var_name) {
+			.name = var-&gt;name,
+			.namelen = var-&gt;namelen
+		};
+
+		rc = plpks_remove_var(PLPKS_WRAPKEY_COMPONENT, var-&gt;os,
+				      vname);
+		if (rc)
+			pr_err("deletion of &lt;%s&gt; failed. rc=%d\n",
+			       (char *)var-&gt;name, rc);
+		goto out;
+	} else if (!rc) {
+		pr_err("revoke &lt;%s&gt; before deletion\n", (char *)var-&gt;name);
+		rc = -EPERM;
+		goto out;
+	} else {
+		pr_err("revocation status check failed for &lt;%s&gt;. rc = %d\n",
+		       (char *)var-&gt;name, rc);
+	}
+
+out:
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_del_wrapping_key);
+
+/**
+ * plpks_get_object_labels() - retrieve a list of object labels for the objects
+ * stored in the PLPKS
+ * @output_buf: buffer to store the retrieved object labels
+ * @output_len: number of object labels retrieved
+ * @comp_prefix: component prefix string
+ *
+ * The H_PKS_GET_OBJECTLABELS HCALL retrieves a list of object labels for the
+ * objects with the given component prefix stored in the PLPKS.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if PLPKS modification is blocked due to the LPAR's state
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid output buffer parameter
+ *		if invalid output buffer length parameter
+ *		if invalid continue token parameter
+ *		if the provided component prefix is NULL
+ * -EPERM	if access is denied
+ * -EBUSY	if unable to handle the request or long running operation
+ *		initiated, retry later.
+ *
+ * Returns: On success 0 is returned, a negative errno if not.
+ */
+int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
+			    char *comp_prefix)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
+	u8 *labels_buf = NULL;
+	u8 *tmp_buf = NULL;
+	struct plpks_auth *auth = NULL;
+	struct label_attr *metadata = NULL;
+	u16 label_len;
+	u64 labels_count;
+	u64 continuetoken = 0, output_buf_len = 0;
+	int rc = 0, pseries_status = 0;
+	size_t labels_buf_offset = 0, output_buf_offset = 0;
+	size_t obj_label_entry_size, i;
+
+	*output_buf = NULL;
+	*output_len = 0;
+
+	if (!comp_prefix) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth)) {
+		rc = PTR_ERR(auth);
+		goto out;
+	}
+
+	do {
+		labels_buf =
+			kzalloc(roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX),
+				GFP_KERNEL);
+
+		if (!labels_buf) {
+			pr_err("labels_buf buffer allocation failed\n");
+			rc = -ENOMEM;
+			goto out_free_output_buf;
+		}
+
+		rc = plpar_hcall(H_PKS_GET_OBJECTLABELS, retbuf,
+				 virt_to_phys(auth), continuetoken,
+				 virt_to_phys(labels_buf),
+				 roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX));
+
+		pseries_status = rc;
+		rc = pseries_status_to_err(rc);
+
+		if (rc &amp;&amp; rc != -EAGAIN) {
+			pr_err("H_PKS_GET_OBJECTLABELS failed. pseries_status=%d rc=%d\n",
+			       pseries_status, rc);
+			goto out_free_labels_buf;
+		} else {
+			/*
+			 * Setting an incorrect countinuetoken upon
+			 * receiving H_CONTINUE would result in H_P2. Since
+			 * the continuetoken is being set to the expected
+			 * value from the previous call, H_P2 must not be
+			 * returned.
+			 */
+			continuetoken = retbuf[1];
+
+			labels_count = retbuf[0];
+			if (!labels_count) {
+				kfree(labels_buf);
+				labels_buf = NULL;
+				goto out;
+			}
+
+			/*
+			 * Filter out object labels that don't have the provided
+			 * component prefix.
+			 */
+
+			output_buf_len +=
+				roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX);
+
+			tmp_buf = krealloc(*output_buf, output_buf_len,
+					   GFP_KERNEL);
+
+			if (!tmp_buf) {
+				pr_err("output buffer re-allocation failed\n");
+				rc = -ENOMEM;
+				goto out_free_labels_buf;
+			}
+
+			*output_buf = tmp_buf;
+
+			for (i = 0; i &lt; labels_count; ++i) {
+				label_len =
+					get_unaligned_be16(labels_buf +
+							   labels_buf_offset);
+
+				obj_label_entry_size =
+					PLPKS_OBJLABEL_LEN_FIELD_SIZE +
+					label_len;
+
+				metadata =
+					(struct label_attr *)(labels_buf +
+					labels_buf_offset +
+					PLPKS_OBJLABEL_LEN_FIELD_SIZE);
+
+				if (!memcmp(metadata-&gt;prefix, comp_prefix,
+					    PLPKS_OBJLABEL_PREFIX_LEN)) {
+					memcpy(*output_buf + output_buf_offset,
+					       labels_buf + labels_buf_offset,
+					       obj_label_entry_size);
+
+					output_buf_offset +=
+						obj_label_entry_size;
+					(*output_len) += 1;
+				}
+				labels_buf_offset += obj_label_entry_size;
+			}
+			kfree(labels_buf);
+			labels_buf = NULL;
+			labels_buf_offset = 0;
+		}
+	} while (rc == -EAGAIN);
+
+	goto out;
+
+out_free_labels_buf:
+	kfree(labels_buf);
+	labels_buf = NULL;
+out_free_output_buf:
+	kfree(*output_buf);
+	*output_buf = NULL;
+	*output_len = 0;
+out:
+	kfree(auth);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_get_object_labels);
+
 /**
  * plpks_read_os_var() - Fetch the data for the specified variable that is owned
  * by the OS consumer.
</pre>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Thanks and Regards
R.Nageswara Sastry</pre>
  </body>
</html>

--------------CYnNj7x7LOdPK0GMFZH5FtBY--


