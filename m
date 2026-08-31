Return-Path: <linuxppc-dev+bounces-26276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954F5C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:17:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRLD3Td1z2y2f;
	Mon, 31 Aug 2026 21:17:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788175076;
	cv=none; b=MO2PEtRw7WMMfX8EB/DWslSuGveZdPzpq0IJ31JeLRi5Yg429iND/PFjGEKxConi0vkHPERMhbZ3SYDXvUJN62ltGwErSTPTXI8zhEeXNT64AIyvZxy/zvUhpXGpgxjz0J2SoIPS+sGjW2PPmbUWtdMmrqimvjhWIUyGqaUPvvemciUQp/qIFJ8JTGmHllHMf3QwYFu6gJemclkiPFnHLL8YFOyZwu0D3rbfSZZHA/1O58f1FfULPQcz6e2R0ohmsdLhYTDP/hLl1QSI8rl03bJVHDffVVxuZl/w9kFXpMzJKWHr5XgSa/kGDHNr59ePGcMhzmAsNcQs7++qYB4kDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788175076; c=relaxed/relaxed;
	bh=G9mDYgItyOkSuZg9u5J3SdEPeCqDGWcTNHF4yfy6l5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKu9aZ6O1Ez7ISTnbd7raLY3P8HA+hJXfbonBQy9OSDYacV2do3iNaVZThG1oJc3YIzDOk9qvuR/M1F5nIHI/9HxcxarGAVkXSjzanxFrwOsg91TsK3vp2LgDnI5jhL0+wrcGc+y86yRQDR39F/kOz4/0ksDFNed5nLkGjM/a6MMoz96QvaTaZyvYl5LS5/K2PmI6uc57T96WieJDJIiDWdY/dfUalBhkwGWAH6AnGyoVtaL6O3kcHo+isNe+MB3SPXGtrjD2JBbgBjrkqaSzBsS4eiHqa+FlVwetpO/eD66d8wcgR+jtssnInFcEDJjGAv1uYUTF984iK/rDBb5JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UztgbIy5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UztgbIy5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRLC4BvFz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:17:55 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82GT41530799;
	Mon, 31 Aug 2026 11:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G9mDYgItyOkSuZg9u
	5J3SdEPeCqDGWcTNHF4yfy6l5I=; b=UztgbIy5gKEtgx/8Z4+CrQTVy+fR4M3Xp
	um2bTK+b4EI/F8nHV8hE+GxNmAsqxyR7AgPzMA5tH/3Azgeig6P/a8131OaloCuc
	HekrYy2VAfDiK/FlmHrfIW+oihxxYJk2gAaen4TY7wVi1V158RIBG8Cwg57OuQWZ
	yW1Q1IQ2QixAu6lKmcHCj6IpRhoOgLaQGvppHNhQhYy2nXvU1YePDuLg3TvSCBlK
	QYMuI+jmATJjYw0E0f0rVs5kP5UX2V5Qh/O5IVln+bNpeXy2bxZL0DAFdyqyAjoI
	SsS01aH0OIM++7g2PdDhYOi/FIs54aiAnwJB/BcPTvd5aW8NsBPow==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhh1nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:17:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDIc8008524;
	Mon, 31 Aug 2026 11:17:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h5f4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:17:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBHo1p30671120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:17:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E27812004D;
	Mon, 31 Aug 2026 11:17:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 908C62004F;
	Mon, 31 Aug 2026 11:17:46 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:17:46 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 02/10] pseries/plpks: fix error handling in plpks_read_var()
Date: Mon, 31 Aug 2026 16:47:30 +0530
Message-ID: <20260831111738.334857-3-ssrish@linux.ibm.com>
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
X-Proofpoint-GUID: iWnzLJvtMWUuzQvMJx5ZXthGDssAZPSG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX194yWTpBRn7b
 ylaR7fA5ZbK8kesJojyVEZtSbLD76Idxh9jvARLKrT6ZBVMKU21qMCTbS39hZxj429tmYhh+NQG
 veiqGIKZ0vH/UTAAlRduqVP+HRqFP3hFdqtqFsuIu7+68Gz5jqMBxfLMhE/WJAvuieetSZ2Gq2k
 FxZe4h1uebllRZJxX2CmWCiStVrsl67XrZ4qidw1eBQmPTQsFbxfQuBH5avCQSm1qcVMKqCiXMF
 Jip+uZALsU5u5MR85izNOesvGi+PWMMsjzmrIQZoKVNmClbOkGoMprie5hRJJ/gBB/4KK8M6ewS
 VVNLTHjNzV5rUCg0vwtcftaNJEQc45WbwnYL+G315MJLQ7Ani66hTFIIVKs0dGGyt8kTM4wvlh4
 KLf8wdnfXVnq+mCR2GUOI4Z2gCdYrgghtSP5OY21CIHRP4K4PHWXYa9Qz5+HCyP3QAT+MDkhjE0
 ChQk+OoS1r9oVFk0ZPw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9562e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=oL9t_hqQ2ej-tATgvj4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX0QQiYlBn8Fjl
 jNnuLU5GgAyaXFpOtfd6+p5rNziv4kl3H47QdNgsq/Z1/E13lZF8r4oTPMJWZXnR3+yJbuyogbp
 Btg0CnsO00MGzi3j+sJzTVX/C6VGvcg=
X-Proofpoint-ORIG-GUID: iWnzLJvtMWUuzQvMJx5ZXthGDssAZPSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310095

When a plpks variable is initialized without a policy and used to read an
object with the 'wrapping key' policy set, the hypervisor returns
H_AUTHORITY along with the object's policy. However, plpks_read_var() at
present treats this the same as any other H_AUTHORITY failure and returns
an error without propagating the policy information to the caller.

Distinguish this case from other H_AUTHORITY failures and only propagate
policy information when it is returned alongside H_AUTHORITY by the
hypervisor. Remove the explicit assignment of rc to zero in the case of
H_SUCCESS as it is redundant.

Also return -EPERM instead of -EINVAL when the 'wrapping key' policy bit is
set by the caller, better reflecting the access restriction being enforced.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 23e4e2a922fc..7bd5c149dd09 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -826,7 +826,7 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 		return -EINVAL;
 
 	if (var->policy & PLPKS_WRAPPINGKEY)
-		return -EINVAL;
+		return -EPERM;
 
 	auth = construct_auth(consumer);
 	if (IS_ERR(auth))
@@ -856,22 +856,21 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 				 virt_to_phys(var->name), var->namelen, virt_to_phys(output),
 				 maxobjsize);
 
-
 	if (rc != H_SUCCESS) {
 		rc = pseries_status_to_err(rc);
-		goto out_free_output;
+		if (rc != -EPERM || !retbuf[1])
+			goto out_free_output;
+		goto out_copy_policy;
 	}
 
 	if (!var->data || var->datalen > retbuf[0])
 		var->datalen = retbuf[0];
 
-	var->policy = retbuf[1];
-
 	if (var->data)
 		memcpy(var->data, output, var->datalen);
 
-	rc = 0;
-
+out_copy_policy:
+	var->policy = retbuf[1];
 out_free_output:
 	kfree(output);
 out_free_label:
-- 
2.52.0


