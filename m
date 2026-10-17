Return-Path: <linuxppc-dev+bounces-29635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E04CCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 18:40:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6Vwr18l1z2yDs;
	Sun, 18 Oct 2026 05:40:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792262412;
	cv=none; b=dLSJ3j4QGspgpvqtxK+0NSrAjqjIUSZ7Nl5Vlh8p95HYpXgjym/tNsKsQ+3ZckaHWcAf7NOALSpCmNndUXKeKLV9JkN2q/wFK/iD9MhYy0CFv2XtXAs+85Yw+1qq6u3MSNyMEosbNDuTT29pv3Zchvos1R9msioSp2K8wdAzr8uXzRouY9gaHLwsHbqer4OURfzZfcIdqBWnKYs3V+eqRfKag0wEy+0YO4bhc8S9svkp1DK4AL8f75Lhe1wgmvm6SYjb04GbJAizsktXrfr8FMIQMH8MLjK26vOb2Ufbq6cdhA06ranKG1J8VutGazrUM9FXdSVgRiejCwcMF676cA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792262412; c=relaxed/relaxed;
	bh=AkubgfKKCqmlBjsLOPi74HWrQsSj7O0vEuZUA4HCxyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kl4LTpjATXP3jpCp10Wsck9Sb3Cy+foOhEoIgm9GJ8fOBle2czhOeI5318F89Nx9UheLdS1ix8cQLWEOJemQAJB6sTMni4uz2JMHP1KPV+iAWtUXCtRBRM7LLsJ4qTAayXzSEu5irTap9ldbP8AGuSaD8oVBPfBdznVHyxbGqLEqLLu35RgJsqc8Ox7SB2PIX25kJXTcV3B6kN6K86msdxCg1VDI8ihJoJKgblM54RRT8aUNnoIptS6wM0WpM2bql1BLLlmIzCM+loXKgthTu7bxr5rSrVzCzTQ3zA+arxmTRf6HnPOLve0p1lGZ0PGr61RFr6/l1ppmxB+oUWPA7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hydu6xen; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hydu6xen;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6Vwp6vgFz2y8W
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 05:40:10 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGENc22777495;
	Sat, 17 Oct 2026 18:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AkubgfKKCqmlBjsLO
	Pi74HWrQsSj7O0vEuZUA4HCxyg=; b=Hydu6xen3GfsaT9qJXMiavuXq2PXaVOFw
	ypGLhGDwvwqkNzpfGFQASJ9fRc0HKeAhjodkhXfwiT+nDR7KMkYAT79CJ2C/mQvX
	fNXMkQers+KsAucmq0Mb5JCgNdA8Jkp0ptIMsyG4Q+5tpE210O4s1ZAu533wIJGM
	v69qD1JNbc6Vj9ZzK57TNUvHSoeC2JLf7EpLnzyxw+X3Pgm2yMcnWUr2Rpba1nH0
	eweKGfRdMfzaz3VqbUI/7SKQtVviv9hGGsEiqoK0VG+BaWPQbtU1ykyxc/AVqwUJ
	iXCmO7yCDrgjmecWm5b4ox/ZRxQeNAUAhHDTuyG1Tqm171b0T+lQg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehjwxt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGJxfw078187;
	Sat, 17 Oct 2026 18:39:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hbne4vs2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HIdrP151577308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:39:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 421C120040;
	Sat, 17 Oct 2026 18:39:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5E8920043;
	Sat, 17 Oct 2026 18:39:45 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:39:45 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 5/9] keys/trusted_keys: fix PKWM output buffer cleanup
Date: Sun, 18 Oct 2026 00:08:49 +0530
Message-ID: <20261017183853.596052-6-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183853.596052-1-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX61iDYjDLHlcq
 cdMqp/wHFYvahwj1fL0W5SXoFYsFwbkeXf+JFTTnaqF+j8uH8eQJt0NWr7gkx16KdtcJ16b4y07
 cxOubyIvEM1VjACaBg1jwrUfgw1eVHmEvNdwgqm2w1aZdqy9fhoGAJXwdiMDfeou30IDK/3rEzh
 vxI1f16fdVXb/i1kui/8GIUkAvgAO5iTtYXcQfws4mZ4ab8GUlpfxeNKqv/C3n/KlRDH2ea+h/g
 ScWSiph3oYCTWJcVtm3qRUbA+nwl5VfKXez9dpdKj5Ta1B5UlzHtFPaae6NCslQO0xgIdz6eGYM
 9VCBpegqG5TAUaVBv3582kwktYrWNt0npiIcvEPDWUbp48uXjurzs4VinMFGPkkxrsuR+Lz3rV4
 OCJrd0JYRd20SRnc+d3pcVw60nabxgfuncUUeeswp4PTssXYoDb1fNmIVyaVesbkmx4+UUvl3BQ
 pia7I6prjF7//WiEqpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX/zSG0KqRUjHL
 F/DWqs0i+gHaR1BW9YkEGIFZDyIGt8K1RY0nT9d8bSEPe6JPRCIqtYwKA1JeIupI1SewV1HxYsV
 +OezeVsloJXlcfPy2Xsv/J4rhXDp4cg=
X-Proofpoint-GUID: mMaQZdyKu9qyjaAFXaH87Nu4CJvwcqM_
X-Proofpoint-ORIG-GUID: hnjoV_cU6Z4wMuRCWhYyMo-xgmnMMOVz
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad3c0fe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0K-bQ7w7VnYq07X3RDEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072

The PKWM seal and unseal paths unconditionally free their output buffers,
but the PLPKS helpers can return without initializing those pointers.

Initialize the output buffer pointers to NULL to make cleanup safe on early
failure paths.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index 633a7674d065..7345f233eb74 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -82,7 +82,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct trusted_key_options *options = NULL;
 	struct trusted_pkwm_options *pkwm = NULL;
-	u8 *input_buf, *output_buf;
+	u8 *input_buf, *output_buf = NULL;
 	u64 output_len, input_len;
 	int rc;
 
@@ -129,7 +129,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 
 static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 {
-	u8 *input_buf, *output_buf;
+	u8 *input_buf, *output_buf = NULL;
 	u64 input_len, output_len;
 	int rc;
 
-- 
2.52.0


