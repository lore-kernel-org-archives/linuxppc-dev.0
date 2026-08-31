Return-Path: <linuxppc-dev+bounces-26278-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14C0C61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:18:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRLP22Tqz2yCt;
	Mon, 31 Aug 2026 21:18:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788175085;
	cv=none; b=GLUEJu30f0iAwNI9BUGL9ZzLZXEBHCDxBCk6ydf38uGwOELhHIgzfHMGSTmmttf7bfyFdgsdT9NksxMKwj7Ok0fOzD4DBUscucM3TS5M71kwTDMOPSoW3uJRDHNKFMMu5sD6UKiCjNtAHjzGnmQDrxO5Owh5zJ93Jy3tZqcHGDpkdXCtQDjeQQk9B+Jr3tC/i8aYiPXSI+Wc3jiXp0zm77MRJeMKmgboMu+sPpU5Ori/BpSgkzj4ZpM6BaoM48kGmR5wpHOfW8Juxo2yYMZMiUY4oT41xX2q1ff93o7b1WJ9WJsT+z4t+TNmj/94D8QRhFLHB7UmNcEavovdntMIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788175085; c=relaxed/relaxed;
	bh=6Aby6J8S9My1jTaZOXyTHNwF1Hj/DrlTLzWePf5+yBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUIH0qrDs5UCcNzAekkkgzeK4/OTRlJqQK9EnoQA/VnTILDEqAjh8IJln8hn2xb+rjpQzL455ARUxWaYax32cEgdnwWgCzd0NztrgMZhjCdY66POSgo4CSboj2A7t9ugG1MnX8zLs2/pyafyr3I2B5iTVwh5iq+ykf6nMpIl3dNXlZsBFU0PwTxpI3UmX82OKm1ZF/OYa6oP4EHXo3gWe4chCsFCakaAffo4sBhA1a+mqAFapxKtB2erOeS/0FwJDzw45JpollLjyv3mDCMfbAmLgdycHkzu/UMkBnM4c8WEYvgy3M1XbatJQ755Avrk5NADwjJrTSC3DvYnsPaYcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CKZfbqK3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CKZfbqK3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRLN2MZCz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:18:03 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82M5u1698181;
	Mon, 31 Aug 2026 11:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6Aby6J8S9My1jTaZO
	XyTHNwF1Hj/DrlTLzWePf5+yBU=; b=CKZfbqK3G9aUnUrAANpkflpFHLVgvUEpT
	CZWA/GnbbsOf+9+tIaDeA/s3lPK48QaYND8IYfDpl+rYkZOKnO5q/PJS3l9BWzgt
	zsMaWTeIg4IUM1SSUvZOdWiWUWIeimGJr8QTMLYd1uPU8V16Ji8wx5HQIgwpN+OX
	UKPpLemt3zQLqpg3o8qd+Y4CjS2aq3IiDR/EJaM5IuXJpkAiY3KUo4Ds7L675MYx
	3VIv+iV7KQxhR6nSkgMuNwFqIxRcTDj4Tgcqfx7iHba9TlaRF5Znq4VX90WErHDB
	KXGtITOuvnTVQ7zAMs1kR2rjkT+ZUaq1QMpR457I5bYb9HzZsMtoA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t0pp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:17:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDZnW009110;
	Mon, 31 Aug 2026 11:17:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h5f4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:17:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBHkhX29557494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:17:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DDA52004D;
	Mon, 31 Aug 2026 11:17:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C49D82004F;
	Mon, 31 Aug 2026 11:17:42 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:17:42 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 01/10] pseries/plpks: update PKS documentation and maintainer entry
Date: Mon, 31 Aug 2026 16:47:29 +0530
Message-ID: <20260831111738.334857-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831111738.334857-1-ssrish@linux.ibm.com>
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9562df cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=2YPxekF_mspUCEnIjzkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX7j0D6lMbPhkN
 daVz5sYetziO6bYqjFmymuJ/gD40UEez+W1AiPvXxdO6hm+l6F+flftioc/PXRLCg7ZlEB9pejc
 W8M+bKTvYJebFEpHCSpU3wNBTesMpJE=
X-Proofpoint-ORIG-GUID: tmobB0sGCWLACNXgzdUEVWFabphGn9F4
X-Proofpoint-GUID: 9aq1HGKIMH2YEp745oE65NGUcPHtsEJX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX+AtIAKyCMEPk
 tGOgA4+CCAgPwKoKwMM5Gv9iz1NyrvdnWFzKWDvfSCr1JGB9U3z4xXtkfUwGpBt2/qgLDyrxRaE
 qP7U8U9Z5ZmuT9SWQRjgRzOF4hFtk7SxMWgAePBVcioZRKHs4S+8NXH23TdocO6l1gjxAcN33WI
 dQQk4/xhrrD+hXpQBRq8YOWG+jk5jejtFnUONkNmr+q1c95VJ7MQlsCUSINT5iCaGKd4SwqCnPb
 t0PRrF3UltVbDHaR/T36xBfWzR37eVqTtKYcqcnvuZ+r+lP9r9AXgJ1DHGKD7UGzFJ/Q4Qc5nF2
 WkvPEaP+ffx9BgGGWF+mPuv3AUN9yhtHEaZAQQlnhYdArXAP7+h45zgYyOsuDT5Rup8bgLjsd2U
 yKwC6EtAz/AZq9H+nKLt+eEu3gi5W/v+4c5535SNaxiqGOnyFxecgC1rOnzvjrxqauPOxg0MoLY
 arZEfssnesoao17ualA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310095

Wrap long PKS hcall return-value lines consistently and fix a typo in the
H_PKS_UNWRAP_OBJECT description.

Also update the MAINTAINERS entry from KEYS-TRUSTED-PLPKS to
KEYS-TRUSTED-PKWM to reflect the PowerVM Key Wrapping Module naming.

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
index 3a19da74d00c..6b91d7f081c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14491,7 +14491,7 @@ S:	Supported
 F:	include/keys/trusted_dcp.h
 F:	security/keys/trusted-keys/trusted_dcp.c
 
-KEYS-TRUSTED-PLPKS
+KEYS-TRUSTED-PKWM
 M:	Srish Srinivasan <ssrish@linux.ibm.com>
 M:	Nayna Jain <nayna@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
-- 
2.52.0


