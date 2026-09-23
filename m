Return-Path: <linuxppc-dev+bounces-28061-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844D1C9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:30:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqlrs2WQNz30RN;
	Thu, 24 Sep 2026 04:30:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790188237;
	cv=none; b=H26a0Geb+qG4PvJd4g7eMk1I1RwYv0QUhMzBj/g9HY0aIO/rF2v65C1WpI1rAGtDDVBohHfhL2cfhklo2AfYfhArJ5xcXVG/Oy9nJn94AAcUmMvZwcIws8toX+V9YXd/em72Irsz8xHL+/LHUPaQh89lcRjuGxzbO1Re6bbUeg0q2zJsYvToPx/hLqo+bMFKIJGAnGqb/MnAeyIx6lMnlywZ3u5UGDjZkE0n6abwvZBR4qDYtzfS4ed4lzRUh3BehP5rarPVEgUxbqgL2N8r5Zgt2LobW1ZJZYXB6YRxrgS2NOlQ/w/LcTOdjuArBVkRaBTcDx+TY9ra0Viojy9wWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790188237; c=relaxed/relaxed;
	bh=w1J1z+N+G321cxNkEZ3g3FhEOqDogrxBFm/mVGaYJgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9NfOl5jvWhwAYxF/xxrClSEX3XoxqBrZyg9wd2e9qZmqVuMaFViaFo5uu/G9oaYxC0D4gl3J+5BRrPrIDWziotnVxRdzAGvbUuY5W+ZTbqrsn8TmVzXvrM9jZVrd1loHFfFb8cXgrrA1GJ/OL9qqSupHzmwQvOE3t6BVFQJ8DlRGxCRBUoHgGFiW3jkcTVD+HHbB+1Sngw0MRHFhdCkFO8bVZvsvC+Qrw2gdyCAvLoQjshwN7XMFtajh1xnA4n410xKB53r1xK2ZZ7Cg2ba0rQUB73dP153cDCQcfgork7QmDudys8jApbJ7pq/zQCsWtydh5eIwRrs38ZTdX7InQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bjRaQ6tE; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bjRaQ6tE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqlrr3jkBz30M6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 04:30:36 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZnsi3765043;
	Wed, 23 Sep 2026 18:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w1J1z+N+G321cxNkE
	Z3g3FhEOqDogrxBFm/mVGaYJgk=; b=bjRaQ6tEgjoIhKQq5nolG/L6IFVJrNfUx
	LYvkP+ZBhHJeID30XIDSMDD5XsuvVe0BTN6Hy1kyv9avp2mNHq/y631YQg00zl8f
	30J1PMdRlRJPN3Fu+N6z/WCrqFNbowkwqOS45E/pt1BZ8vAaqZyTpDxgvQp1lT0h
	FZxSQvCrpsrBcdFQYdSmUo+g5aZZnWyG9CrJHWim7tD5Z+fb0I1ItvVLd7WXl1Lp
	JzuUwVCAZPPTMFt73Fyit7NzafNvFOjmX5qzkwAruZ6gGE90xoMmiAQm0PtBfuhX
	gHydFe5TyEseDiW5f/yiKGHw59xLfhsdl8CKfp0umB1N5ydI9ej7w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1mgs4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:30:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWlHf627135;
	Wed, 23 Sep 2026 18:30:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2t5fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:30:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NIULD111862522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:30:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F3B82004F;
	Wed, 23 Sep 2026 18:30:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A91B2004E;
	Wed, 23 Sep 2026 18:30:16 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:30:15 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com
Subject: [PATCH 12/12] pseries/plpks: update PKS documentation and MAINTAINERS entry
Date: Wed, 23 Sep 2026 23:58:16 +0530
Message-ID: <20260923182816.151451-13-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923182816.151451-1-ssrish@linux.ibm.com>
References: <20260923182816.151451-1-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: vG6r3mDQVpY-Bhhy7IrFQv6ZMeMORD8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX7gqcY44SItNH
 MDTt8QohiQ2W/844g/AGgXryK9ub2jbV01BcIuFTB5nP7Nc0gSsulf4LrVGR8pT7a0IGuKJyXTp
 4KApv/Kq4OeWWOG0L2XtPH0TUlRd7hRLINSmm6VXQUE0SM5zRPxLeEvQ+ZGE6rwG3ZxGVv2FLOS
 ObPcDDkyieGP7nd2Oc+hES+4Ts45Nu/PR8WeINWC0KSvYXl/71a1PRHcC49dlwOzTeL+u4I8aaX
 M423NXBB2DfEm6BYTEP9f0uuSvq0s9b79mocPbS62aApyTYBRZ7t1HMOqxaPhAlY0ZS9Abgr1I0
 vvZ+1KsAz7w4mFNGQsfUXHife7xi6lVfr46c/6TYjBHihUwkRoQUuCly9/9M6t6vJdA+WhA4RTY
 NskpWAN4GXu/e2nXgR0iovKvYoJEb/UZ5XUrzbG+XP3KdCegVdIFJz8eSXgeTYipRoRScYFGdYh
 4lBZc0hrSEYDf+H3J/g==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab41ac2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=2YPxekF_mspUCEnIjzkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX0BM+pQO7V3Ka
 WFrIU061/xte2YBs+/12Vd4AUAEUMWXIn9oqXyD9rFBpyS3tcXdQ32+WyS5QuFQ8aklb2HsV8E3
 lyqvWF46WCMFNcIoOCyIw0a0sM1axbE=
X-Proofpoint-GUID: Ox6s56VtInLl4zrN01vsQYbAmN9UIv84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

Wrap long PKS hcall return-value lines consistently and fix a typo in the
H_PKS_UNWRAP_OBJECT description.

Also update the MAINTAINERS entry from KEYS-TRUSTED-PLPKS to
KEYS-TRUSTED-PKWM to reflect the PowerVM Key Wrapping Module naming.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
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
index cc3cae2e378b..932eb463428c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14485,7 +14485,7 @@ S:	Supported
 F:	include/keys/trusted_dcp.h
 F:	security/keys/trusted-keys/trusted_dcp.c
 
-KEYS-TRUSTED-PLPKS
+KEYS-TRUSTED-PKWM
 M:	Srish Srinivasan <ssrish@linux.ibm.com>
 M:	Nayna Jain <nayna@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
-- 
2.52.0


