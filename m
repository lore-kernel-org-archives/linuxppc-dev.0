Return-Path: <linuxppc-dev+bounces-24759-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE2AC531F9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 02:30:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5sQy0lVLz2ygK;
	Fri, 24 Jul 2026 12:30:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.169.211.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784860218;
	cv=none; b=AhwF3tDDzdx4fPECWbAdm9M+ZzIE6vp44sSYBu4yFiylrG+/wTLa2rV9I0zOfNkQsPzkKIsCH8a3Oopf2BmmlPfNysYYFF/O0iKgkZjhURblgRqsaMQR9WfI65Dj2SQj7jKHCGtmfR8LaYDdykbH06Yw88B2Fj/6W1Qe8rRd7tUoau5n0Ow8NvcTpns83ayA4p0z4035yrHdmwmC02bTX1ns295IqLetUAzcdotil28ED3ek90ZtPwGGJ0FxDGANor6UmxjrplH6nm8ni42BqEOmUC16fTMCG1ON5931rk/WH/FuKdWvsVuuQ062nnFwUYopxd1aHB4pjuSnSrcGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784860218; c=relaxed/relaxed;
	bh=nFjFFaXMkLzxoExHNfOEPPaBXmUVyvwpIJWfb32uFmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XndXrNilG2uplenJumiv2q4yee1J1OQuiG9d1a1Tg3LooscEYd6xcOYpJy/053UTffkUBHmiOc+GlKO+mAPgv0lrKfHnIaLMt88Vat2ZIqzhW8LRxrqDGovN0olMox0af/YZUEtJjRmAo4JfT1JE2EMezZxh/S6/cmIo1AKvXHL38uzP6pjZax26xUm7/+EQtD11mFn5eozvwyZy5UhQkzMWPzKhmU2cIlz9ZUoEPAeZ7dl8UV0Kg6901vWZp0bYRtsf1adO4YXewrL42eDfmUvKsZs1/Y+2EcuF6KyvP/UQSJ6zfr/JtYdsWHWnLUiU8HyqX/V0VLt2AErXQ1+j5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=VEpWfQTO; dkim-atps=neutral; spf=pass (client-ip=18.169.211.239; helo=smtpbg151.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=VEpWfQTO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=18.169.211.239; helo=smtpbg151.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65032 seconds by postgrey-1.37 at boromir; Fri, 24 Jul 2026 12:30:15 AEST
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5sQv6GWgz2ygJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:30:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784860159;
	bh=nFjFFaXMkLzxoExHNfOEPPaBXmUVyvwpIJWfb32uFmU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VEpWfQTOL9zLFbyFogjNmCQMlKaiv1ch5DwkSrh7BZ+2RGOKv9qZ7NQ96vbvWgZmY
	 KwQNpO8VjSAxaUait8NuD9BWwrJ1h3vH+OgEytvIu6MQ1/hxpbQjl0nsQJY4UcPi9c
	 xu9ZTSK/V3GsC9xazytGPIPjuS5mw3UeNUlk2aLo=
X-QQ-mid: zesmtpip4t1784860151te3c12dad
X-QQ-Originating-IP: Q0VsYdJjns2x4KkOcgSLM6b/xTyYuD8mV2X7QLUMAvc=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 10:29:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9743323694755543151
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	bharat@chelsio.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	akpm@linux-foundation.org,
	gouhao@uniontech.com,
	namcao@linutronix.de,
	ynorov@nvidia.com,
	sshegde@linux.ibm.com,
	nilay@linux.ibm.com,
	clg@kaod.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-mm@kvack.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH v2 3/6] powerpc/xive: fix use-after-free of xive_ipis
Date: Fri, 24 Jul 2026 10:28:48 +0800
Message-Id: <20260724022851.466017-4-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260724022851.466017-1-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MShfLn39PbN2l+blDShduB1X9iebRAT5qDFedbrrqQbUgZS1c9E9R+x+
	8Z5evE7qwSSNKS5fWkyAqsloxq8zg6kn48MO133LodvIgdUKORIw31oHWPzeU8n0+MFnAnY
	wqBpuCKD3QTroE/efd8m2YD2UdqtSJM+ZgmHjm1gERoup0o9MOqb9PNCCpTDe5b28emWvOq
	iVnbBDaHX3SpuHZy1qvjLrxijlJJeKUsHhjby03igj3EHpmzRguzUV3KoOm0yzbwlrh+cZt
	UdmhYmVY4WRiNAVbPz8/7RVLPhjmXHEakAeKofcwBXaa70Gi7u9TLAk0vjaiJY8mWtf2Qp8
	Uk3tbEsHWwJj5W3VW/jreYIJzuDKMbBA/k3+VMPvUmRpy5MIACpU1l/WPtnF2MBOhxIqzns
	mjN1DklG5Enuz0WA5zuubqpe1WNz9Fd67EWHOFeVYsvbKqxK2qPg9sXzvjvO2TCvgUvxMDv
	nQiBTIwopkRLpFSTmq7QY4lQcpD2JBHdYvOiLwg/CoOUtK7yw063vxcQizitZGEylNB5psT
	pR3j2NP76pW2nEL8MR8I99WHwPYAG3+txj8vJgLI0CbUYjQXCI82u0gAvc0x5QOweR7GGg/
	0VfheQ1kacRfogatLT6U4vQg7XyIUEqqj+YXlcOZBIMuxZyFH5mlXGWfsQgYxPDkwFUir6b
	GNBXwTTSutBq9ry3CrYnIOqf7uiEo7iPrr3pe7U13BClVn04TuFlQj/WI4gDDmk6Ly/URD5
	cfDRV31qO686+IXjll03CTOy2pEfnEyIGzEinN4tiriAqOEyYm1MzbHNcZCRDgZ3TmLEoyL
	fHdD5moEFn6eChs6cfivVBhNK0nWBwyQbmPz3bCUPig272Urz7eQfCVUWVXKO1oXUO/ZfR1
	a7SAMZ/ewVTxvVEbwjuzKg2tD4DmQwdQ91jlPU657PB2HkMtYDRmjKCs3CrTttjMatffT1S
	q/ihiso+CPHMmrGNg+B1RFnUz2kvBMvsnA0LImGEsiRH4hjhQSlDpQV4gyKN2FPx/PDvJx3
	3bA9b/G99k0IOK5zPVxr7zuntPpXdP+DJJG7YyE+u2WQwrA8AJNzvhHRqqYQE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

When irq_domain_alloc_irqs() fails in xive_init_ipis(), the error
path frees the global xive_ipis array via kfree().  However,
xive_smp_probe() ignores the error return and proceeds to call
xive_setup_cpu_ipi(), which dereferences the already-freed xive_ipis
pointer, resulting in a use-after-free.

Propagate the error from xive_init_ipis() through xive_smp_probe()
and check it in both pnv_smp_probe() and pSeries_smp_probe() so that
IPI setup is aborted cleanly on failure.

Fixes: 7dcc37b3eff9 ("powerpc/xive: Map one IPI interrupt per node")
Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
---
 arch/powerpc/platforms/powernv/smp.c | 8 +++++---
 arch/powerpc/platforms/pseries/smp.c | 8 +++++---
 arch/powerpc/sysdev/xive/common.c    | 6 +++++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 8f41ef364fc6f..b1201dbafcaf6 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -332,10 +332,12 @@ static void pnv_cause_ipi(int cpu)
 
 static void __init pnv_smp_probe(void)
 {
-	if (xive_enabled())
-		xive_smp_probe();
-	else
+	if (xive_enabled()) {
+		if (xive_smp_probe() < 0)
+			return;
+	} else {
 		xics_smp_probe();
+	}
 
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		ic_cause_ipi = smp_ops->cause_ipi;
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index db99725e752bd..14cd0634eeca8 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -194,10 +194,12 @@ static int pseries_cause_nmi_ipi(int cpu)
 
 static __init void pSeries_smp_probe(void)
 {
-	if (xive_enabled())
-		xive_smp_probe();
-	else
+	if (xive_enabled()) {
+		if (xive_smp_probe() < 0)
+			return;
+	} else {
 		xics_smp_probe();
+	}
 
 	/* No doorbell facility, must use the interrupt controller for IPIs */
 	if (!cpu_has_feature(CPU_FTR_DBELL))
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index f9a1229cede73..bb6ce07c1699e 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1256,10 +1256,14 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
 
 int __init xive_smp_probe(void)
 {
+	int ret;
+
 	smp_ops->cause_ipi = xive_cause_ipi;
 
 	/* Register the IPI */
-	xive_init_ipis();
+	ret = xive_init_ipis();
+	if (ret < 0)
+		return ret;
 
 	/* Allocate and setup IPI for the boot CPU */
 	xive_setup_cpu_ipi(smp_processor_id());
-- 
2.20.1


