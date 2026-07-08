Return-Path: <linuxppc-dev+bounces-23753-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C92AC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 01:59:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw1Vq45yzz2yft;
	Wed, 08 Jul 2026 11:59:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783475971;
	cv=none; b=Y/QWaJLlnCwA+CvlmA0EtRsHp0DKpQsRPeiAvOlHPtz4g7kxZUzR3Vju66PgDAyYrlCcH5qySisihs3W1SzSIxsFFO0VNsaFzr+nfZb7ZxPbYexiaNlvhOyCWqyQ2rQCl4dL0TgCMbpKEVvvyrUYroppXrrg0Bo5KdTErK/+F+ACIuaCjPv76/cfaXgXgaXnKk2e95ugg8AF/LggddQH2J1UlrWQl6Kc942+EYtFuG49xlJjl5pEyV3gGToK1GvXQbwae3rd/1Oe2UgNMA3hjvyoJXkHpZVcXSHtywog6hq/RNVc0NbQMKNAcDys2rmK/C6QcpcHbk9lwdXu4qNbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783475971; c=relaxed/relaxed;
	bh=CgbtFQiRgUYlPLNbl71Lsoe0XlANTDoqDmc3W6ANb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUw0M3jGjH9NT62kQTr7A7Ai88XknYn+kyKA5O4JhudH+pqNfJuNHFnF4P/cQBxos4Qp8/JPmN/kWtgijrPW4EfCsyFAQFxD/gfFAfg56Oa35yn2sPXJ30+CI1iPe8o+PRvGngtdFE4fYNRDbqoEr2KS2KhDWFmQd5Tcv/lTqggvIK1K2WScXkDya7UkTcjD9R6BgeN5QwPlTz4H63Terxze8r2lBq8bSGQ5J24FWLNiKFjXZTqSlpC/UXwqR+U1L3fL+90vZzkG3RcZhcxxUjr2EvIRqPSbRbhmZc3MT9A4EpfD7f3Fg/lo8683j8e9ThJgU83DYMJA0vZ0pPNVuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rz1a1a8u; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rz1a1a8u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw1Vp5L3yz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 11:59:30 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MmIuX163110;
	Wed, 8 Jul 2026 01:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CgbtFQiRgUYlPLNbl71Lsoe0XlANTDoqDmc3W6ANb
	0k=; b=rz1a1a8uQ91S2RifJyOadODCxHBlqUeyV8Q1ZjiJqnCzu1tU2xeaXD7W6
	P2ViEWK0TU/pzRgbb7sQ0oXFAkH/iP/J+oBPTUqsZMsfi89UUaowe01lbMMDXbxj
	et2hNWAve/hWcd5TpYbHLyHcZjHTTlHtQB23MrsExJwwCDy1k9j2G8HWBY3tvVWF
	W8Flh6RZTpwSjtFtpW+dJIkK0DJdiEQDpb518mFs4/uX8WDPjt2tbehk/UlbcmfC
	B9khuUDaEnVG5OOHGPPBiDuoletOWPn8oGo+FsFl9Qq91WXKUjxLg6jLs0wiWS/a
	OR64VuiWeJjjk806/XgqZH6FUW0sw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6ststjc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 01:59:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6681neNk001826;
	Wed, 8 Jul 2026 01:59:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hddcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 01:59:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6681xLtm11600430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 01:59:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75B9E5805D;
	Wed,  8 Jul 2026 01:59:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4709C58053;
	Wed,  8 Jul 2026 01:59:18 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.43.110.190])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Wed,  8 Jul 2026 01:59:17 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 08 Jul 2026 07:28:48 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc/pseries: Skip vpa_init() for boot cpu in smp_setup_cpu()
Date: Wed,  8 Jul 2026 07:28:40 +0530
Message-ID: <20260708015842.274690-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-ORIG-GUID: MB5yF88II93K-2As504KM_ssuJ9eMnGW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAxNSBTYWx0ZWRfX1IPEdsNFoZiP
 xkp/cXnUJdX23WXAbCFP/TION5op+8kAtcrMnz+gSRwKBsIh1uFObE31paUP2f0SEbXydHc93Pq
 1t0fT4ENaKbL/oHwlbSy2YM106vnKW4=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4daefb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=I9GVZC7YjNBg__zhnqwA:9
X-Proofpoint-GUID: MB5yF88II93K-2As504KM_ssuJ9eMnGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAxNSBTYWx0ZWRfX4jnx0/Rs2iva
 Uqpe1eT6IRyz+rMThvQ2Mtk/qPqp/IzxKHC0+fR9NPKc+A9uUq90tGPVZbdUr4+3IvQzEOyvJXI
 KE0NfDkFGjZamqLd9sAmWP9k3J3e3bvylglSLpojYRRhh1OXEgCf6RsZ/XiBxTExVEc6GbyjvAy
 GPjN8FXlXN6e+7GxI0/dOVXxMF2h8bSz8shHroETjIkAqW5kX7m0wouXs+/tA5IiWBnaxuJCpPv
 xJ/xdJFeY4NfzjdQ2nV/5CM0fFYHm02LPpB2FiX1UDVh5+RmVysy/LTVpQECBAKjOKToFW/M79O
 LV/RmHTmp0GK8e0pqTqcYfi5KrD8rV/JBDNo14sZbeZymV3W7aYDVLs1XQyfseubv+x9gBUOSif
 DfU4eEOk7jnpzikDQ21TwWo/xEzQu1XdyYRgaxJqvGCah1w3OpAnrxE9SD3kgAcMQasINWmWx5C
 Gpunbg007QRRo3RFZEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080015

During pSeries_setup_arch(), VPA for boot-cpu is first to be
initialized. However later in the boot, smp_setup_cpu() is called for
setting up VPA on boot and secondary cpus that were brought online. This
results in vpa_init() being called twice for boot-cpu and three redundant
H_REGISTER_VPA hcalls being made to the hypervisor.

Fix this by adding an extra condition in smp_set_cpu() to call vpa_init()
only on non boot-cpus.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/smp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index c6c2baacca9a..106f79a96edc 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -131,7 +131,12 @@ static void smp_setup_cpu(int cpu)
 	else if (cpu != boot_cpuid)
 		xics_setup_cpu();
 
-	if (firmware_has_feature(FW_FEATURE_SPLPAR))
+	/*
+	 * Initialize VPA on non-boot cpus since boot-cpu vpa was
+	 * already initialized in pSeries_setup_arch()
+	 */
+	if (firmware_has_feature(FW_FEATURE_SPLPAR) &&
+	    cpu != boot_cpuid)
 		vpa_init(cpu);
 
 	cpumask_clear_cpu(cpu, of_spin_mask);
-- 
2.55.0


