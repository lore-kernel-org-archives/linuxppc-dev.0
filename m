Return-Path: <linuxppc-dev+bounces-26131-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC559C5DF9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 06:23:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVs0t2jCwz2y2b;
	Thu, 27 Aug 2026 16:23:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787811838;
	cv=none; b=JwOrlUqqu8vzWkH+Q0VAsHWlno1QyaUze8eblruQMUivqL+Y216Gy7i630EyY/CvLiJlZwxHW1S9LtX9M8djmMQ5gWZkIJAdZOrxrUvzqbQquGlWw4y6m5ILztMfLs6dNUBQiLidODeOtGRAaGX2DixQBnpPu2rFv2WfRlK1VsMfZD6uToiHOoPZ7ltfE2yDoWjjZMzcgo7+5ZUnLLmR2jyYu4PBFuMTAb2OZt80SynH/FZ0QDZg5UXzjCb9iepVd4sJ423oxQB8YF91WbctJIZK+FH3InK9hO/Ov3IpFQ0FAtdz4Ig6RhcXmgtznF/sfCRmggqviNf4MnnymP/JLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787811838; c=relaxed/relaxed;
	bh=IL05qI0zF9+6tMvjpCrbdI1qk258KXsyIPDjSVuxBpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKjLyJcnaRNKjiWQWyHS7jdrvidEq2k13KBt0m0WTkDb3ia3IzkhfIfjOJZFuiZrtY6PbYVeb85ixNwax58YyCs+Q9IANx21QLxZq3VFIZScbMMvvcWxbG7ftGzbXmYK1p21gmj0fWv+70Xq7dgIkz91ZxEtBt4mzLYEswWAHyxb5FWWzcQtoRv+xadd+9E9O7hBF25/eEaX+pIBqZoCRqBAF86mFKVGL1gDBw/I3lQbtu9n5Hfd0aF2g9Fnn3t85bSePqGapLrHt94LexNb2UmtsrSJ+3HiyaIhacHPJTwcMtyHa7nQAtDZ2T8awbmvPitU9PL+pKYKgur9S0at0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ntK5gGGn; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ntK5gGGn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVs0s4G5Sz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 16:23:57 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3VarM4139815;
	Thu, 27 Aug 2026 06:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IL05qI0zF9+6tMvjp
	CrbdI1qk258KXsyIPDjSVuxBpk=; b=ntK5gGGnGsMaW9Rtw4TorTMaIyKWp1eBF
	33tTmRUUt1AorET1z9WDZak8QtpsQzGgHS1xlXAMzd4WmoAYM7HCT6/YgVYFoWBN
	0DIZo7v7VLuehPeIzOj2vEQqX2umztMKx0hzOGl9521iCQ6DjWCkAYMsOyJMrlKb
	WkoMp36DblIAsIJwQFtjh7w64lz0LvgzTOT6cwQ5DtGgCiK2BeytMTjNnQxWCk1A
	8da5DvifreY9OJ+CL//KaXAj5SRlFVaXP0ffmP3thNpqpDuMAE8kcPjsv4rxIYzb
	xoVPxs1kuocyoz2gDYrPfDciTTkGMLQavVWPwp5xmLdy4fV9gSQEQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er3h60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:23:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6BF10013824;
	Thu, 27 Aug 2026 06:23:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragpawx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:23:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6Nb4D51053026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:23:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FD342004B;
	Thu, 27 Aug 2026 06:23:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B75220040;
	Thu, 27 Aug 2026 06:23:26 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.76.202.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:23:25 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH 1/8] pseries/plpks: update PKS documentation and maintainer entry
Date: Thu, 27 Aug 2026 11:53:01 +0530
Message-ID: <20260827062309.724808-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827062309.724808-1-ssrish@linux.ibm.com>
References: <20260827062309.724808-1-ssrish@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: E5KGnUswwFo-46pFTKTVWSc5UDgwDV5r
X-Proofpoint-ORIG-GUID: LbGZbk5F3iG2KsUicI5Szx52pvJNnEQC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfX+34rS6nAkAzr
 Hf1ppNN+ai/wFyCtqtPi/y01A/sK5QlJFbx2Di+6AjGZEKdB8XlCAtoWj7iYJ35Zk5o+Lji1TDD
 QsBMZc3ojSv5htLXww1y57LxW4nrgbF+JxCc+OFCdbmnqG8V2w5xOISS2XUTYtGWPPWC7SCZB47
 mQDv37+z4l53QaVIm49oUWkLT5i5D6Wp7VLmbASF2tn1d54AxECy4P8aZmi7B/3Y7rOYeSMgSnJ
 LXyY7XiQ1LCh4ZEqBDsTwVNMo4Nm8EAFZEadeL1ABEUAGXgKE5GbUNx2QqhcM6tu7CMb6Q/o9Ij
 uUULtUpXnaca7uaNEQRgsPQCQMt2dKj8aiTUijqkV+vjuGjXDDCHv5ceHeeKkTUTh7ThoOiw3gk
 FRWpiGjc+TMJofzwrRD5HWQ8FvgJ7S4h+/Xu6zQYJgiqyXmim7fjRxzMULzbMnKs4QtcyDexyib
 Z02fPy8hzW69HB1aEhw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8fd7ee cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=2YPxekF_mspUCEnIjzkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfXzHaFJMhQwOuD
 Ao6BC1eI62J6ywaz4uT4m/rOmKZ6Ur6TUjuWtc7U13Y8McX6cCzOiBp6ekKna6/ylFJZcygSr4o
 itck6hLb/ZgN/saX3dRIIGY9vx8Wxic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270048

Wrap long PKS hcall return-value lines consistently and fix a typo in the
H_PKS_UNWRAP_OBJECT description.

Also update the MAINTAINERS entry from KEYS-TRUSTED-PLPKS to
KEYS-TRUSTED-PKWM to reflect the PowerVM Key Wrapping Module naming.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 Documentation/arch/powerpc/papr_hcalls.rst | 16 ++++++++--------
 MAINTAINERS                                |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/arch/powerpc/papr_hcalls.rst b/Documentation/arch/powerpc/papr_hcalls.rst
index 14e39f095a1c..44c9c8b32ae3 100644
--- a/Documentation/arch/powerpc/papr_hcalls.rst
+++ b/Documentation/arch/powerpc/papr_hcalls.rst
@@ -305,8 +305,8 @@ like core instruction, core LLAT and nest.
 | Input: authorization, objectlabel, objectlabellen, policy, out, outlen
 | Out: *Hypervisor Generated Key, or None when the wrapping key policy is set*
 | Return Value: *H_SUCCESS, H_Function, H_State, H_R_State, H_Parameter, H_P2,
-                H_P3, H_P4, H_P5, H_P6, H_Authority, H_Nomem, H_Busy, H_Resource,
-                H_Aborted*
+                H_P3, H_P4, H_P5, H_P6, H_Authority, H_Nomem, H_Busy,
+                H_Resource, H_Aborted*
 
 H_PKS_GEN_KEY is used to have the hypervisor generate a new random key.
 This key is stored as an object in the Power LPAR Platform KeyStore with
@@ -321,8 +321,8 @@ the user. Generation of wrapping keys is supported only for a key size of
 |        inlen, out, outlen, continue-token
 | Out: *continue-token, byte size of wrapped object, wrapped object*
 | Return Value: *H_SUCCESS, H_Function, H_State, H_R_State, H_Parameter, H_P2,
-                H_P3, H_P4, H_P5, H_P6, H_P7, H_P8, H_P9, H_Authority, H_Invalid_Key,
-                H_NOT_FOUND, H_Busy, H_LongBusy, H_Aborted*
+                H_P3, H_P4, H_P5, H_P6, H_P7, H_P8, H_P9, H_Authority,
+                H_Invalid_Key, H_NOT_FOUND, H_Busy, H_LongBusy, H_Aborted*
 
 H_PKS_WRAP_OBJECT is used to wrap an object using a wrapping key stored in the
 Power LPAR Platform KeyStore and return the wrapped object to the caller. The
@@ -331,16 +331,16 @@ which must have been previously created with H_PKS_GEN_KEY. The provided object
 is then encrypted with the wrapping key and additional metadata and the result
 is returned to the caller.
 
-
 **H_PKS_UNWRAP_OBJECT**
 
 | Input: authorization, objectwrapflags, in, inlen, out, outlen, continue-token
 | Out: *continue-token, byte size of unwrapped object, unwrapped object*
 | Return Value: *H_SUCCESS, H_Function, H_State, H_R_State, H_Parameter, H_P2,
-                H_P3, H_P4, H_P5, H_P6, H_P7, H_Authority, H_Unsupported, H_Bad_Data,
-                H_NOT_FOUND, H_Invalid_Key, H_Busy, H_LongBusy, H_Aborted*
+                H_P3, H_P4, H_P5, H_P6, H_P7, H_Authority, H_Unsupported,
+                H_Bad_Data, H_NOT_FOUND, H_Invalid_Key, H_Busy, H_LongBusy,
+                H_Aborted*
 
-H_PKS_UNWRAP_OBJECT is used to unwrap an object that was previously warapped with
+H_PKS_UNWRAP_OBJECT is used to unwrap an object that was previously wrapped with
 H_PKS_WRAP_OBJECT.
 
 References
diff --git a/MAINTAINERS b/MAINTAINERS
index 24ca91ce5d86..7d92526fbf64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14479,7 +14479,7 @@ S:	Supported
 F:	include/keys/trusted_dcp.h
 F:	security/keys/trusted-keys/trusted_dcp.c
 
-KEYS-TRUSTED-PLPKS
+KEYS-TRUSTED-PKWM
 M:	Srish Srinivasan <ssrish@linux.ibm.com>
 M:	Nayna Jain <nayna@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
-- 
2.52.0


