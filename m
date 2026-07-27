Return-Path: <linuxppc-dev+bounces-24876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D2FC531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:43:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7wDc0tZ9z2ygn;
	Mon, 27 Jul 2026 20:43:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785149008;
	cv=none; b=mR+BaVNBKRNztuVnxpgGTvSbjAGWAy8/YNDOQIkwsrhjDbJQmf3XGis6gvIuXgk7KB04dagQvAWpqeohFElfSYQ35zDQMDfXMqprU5RW3tk8Ygs6tXa13+JFY6j/z8BKSNYL7RxudPbMDGUd5+ceUnkbsFhe1pqa/xJMs4TURy48j6W3xixPXhOLfUrhWGq4K1/esBOsYp4rJKv4tBl2w9EwN8o+bCskza1bCSam4Do8OQOeJKOogFE8w9vrby765/HESqS2p0ZRjLf9OhQEsf8SX2q/QukWh37k2Y1tqdZwAZOqAnq1xIkj55fig7fJg3ZQuT8xukI+l5S+CHpfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785149008; c=relaxed/relaxed;
	bh=amQkJBx/VTXWtfwDC8s+JiVB9zRjVH9H9qnr7Wd/IU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwgDfi+Kem23gHlUd26TdGEfEskhuPDcfU2nhaJiq//09TeziaTgNISoKgM8JxlEf4eoWcnsf7BGAbjdlIjhaykhnLMgZ7NSo1fn2mgndIdyUMeCgUi0ucJ0WyGkLd5QWaVSpb+ZZpcQ6Ii9SQ6CnC2jGdv3iZbG53VQjl2BiJyhyqaZ6/RzOP/WPVQAA7rUf1QFk1C5kXOVFXg8A9TevARSaM703yNExXiPl4xAry2WNtoOB9jew3Gxn18rEuXS+W4RYYUznd2FfXA9K2Ppm+5ugz/Y0fzm5ft2YOos3Zp5t3IjH1IsiNLuq59R9ke1EA8W9G20xTS/PkkyLjPA7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=SsvmN2EG; dkim-atps=neutral; spf=pass (client-ip=54.206.16.166; helo=smtpbgau1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=SsvmN2EG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.206.16.166; helo=smtpbgau1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7wDX2q9hz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:43:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785148958;
	bh=amQkJBx/VTXWtfwDC8s+JiVB9zRjVH9H9qnr7Wd/IU0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SsvmN2EGa45UXrVkkDSkB9kyWjlfsdpskbbMWrFt9HVPxu3g2/vvFceLgRzG4nKvt
	 dq3mF/vQF9vE5OuQlLSCZl5OoTtKA9tCrhjpZlhpjXTMzGhEysMO1VkYKKK4uRHHiB
	 G9p7Gng7KczNK+S0oBI1EVzfLLLI01zPfV8cbEMk=
X-QQ-mid: zesmtpip2t1785148944t6dfcc41a
X-QQ-Originating-IP: SqqlL9OqxNRDVT626BIWVwQXYXnjMUjufYNhI9LUY3Y=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 18:42:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12286011520992601610
EX-QQ-RecipientCnt: 21
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	namcao@linutronix.de,
	peterz@infradead.org,
	sshegde@linux.ibm.com,
	kees@kernel.org,
	lgs201920130244@gmail.com,
	srikar@linux.ibm.com,
	ynorov@nvidia.com,
	nilay@linux.ibm.com,
	clg@kaod.org,
	benh@kernel.crashing.org,
	miltonm@bga.com,
	mkchauras@gmail.com,
	akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH v3 1/5] powerpc/xive: make xive IPI allocation NULL-safe
Date: Mon, 27 Jul 2026 18:42:11 +0800
Message-Id: <20260727104215.184786-2-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260727104215.184786-1-gouhao@uniontech.com>
References: <20260727104215.184786-1-gouhao@uniontech.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: Mh0xRtMdhgZRI/SVuefY9v4qPo0ufnpvxm5LRe1EwsfTUKduNcrgshyP
	B2DayNZvrEa19fMTVyiJ6A5SfkRfsRfPG0CXWbM2KkRK6L+yFFoOTH55JRvd0BSjyzZpnl0
	6LWj9hv+u65muoSC6/JolZ4kDEJ7ZRfaxQK080PWSfoxmG4GeLMSTt3+LlRQvSK0DMuO2gv
	4Yv7Z50SA2agIZzw02/0szMWr92J/rKJPLMxLRn+jc4r89R2UANc8woM9BiSAlBwqKZZbQ/
	Rs6nCR1IzkyqnMRUljBkaVYbL+n3MqSdCRBkKGIDjZRRay/8Y4SB21YC2EbNKeikB6frdCh
	N1vF6wanwrNSC8oZQRBsasq2C0igbLzQIgsRtzT3NQFcIMrPwMg9jiXQnCnfWD5R/9onu7x
	m6+l0/26lE46o05Zh8fAkLWdoSwxptOU4F9B2mOsgk4imVbWbdrU3AorExP2cFVtVAVlN1K
	y6k0mEXD/KyVkZn/g+OqycqFH3Ny7c7Dh0AvB0ksl9H3QZY+Xv9eeomHqA9QkWLs5Gw3/C0
	GBXqgN8IuyAVrsDY4cedaK4ZVNysUf9Ipea4wMi3dJuvobegimIfF3+rwaVY17OAX+c157U
	en4wlGqGbQuzXeL7kJ2RGY8fgR3o8uBc93fPHIDHrvazar0qzXTBolsGXpKl+27m2zStfMz
	Rp0mSNBlhLN+TLh50e6ZIX0LHqlUl7C5id5zCTnCG8o98PR9TKhCsAIv65LOLSODyGMkRu7
	ZYqz9MsBjM5+0+R8QX3+caQiCR2GEAFK+Oba2HLUCDiSVAz3zCgkUmkXu/DW+bx452oUgQ8
	h89m/SGfign6pPNJ4Qm2breOQW1aCbnIyW2739cq92+3rGPV92Ryr0vd+gdjsqEqRcHYDCN
	YDuzUj2BkbHfR6NLPWLv41V8dpF12VLTJOSyOUp6IAC5RhPiPOhoSUT1wAQyPSVHb5KPcYa
	/pDWt8fMUHTzsVZjHGjrzHXeNTUlKY1NlaSuv5e9bB1QtNPsjFkTip/ctB531gAoX33toxm
	KUjUQ4xLLKCHo6bm1vj2WrzU6JNQix/nbL7FKXtYrqiixaphCDT0hcFZ2XNM6Em2xiBL+e1
	A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

__GFP_NOFAIL should not be used in new code [1].  xive_init_ipis()
allocates the xive_ipis array with __GFP_NOFAIL, which makes the
subsequent NULL check unreachable dead code.

Remove __GFP_NOFAIL so the allocation can fail, and make all xive_ipis
access paths NULL-safe:

- Return XIVE_BAD_IRQ from xive_ipi_cpu_to_irq() when xive_ipis is NULL.
- Set xive_ipis to NULL after kfree() in the error path to prevent
  use-after-free.
- Guard xive_setup_cpu_ipi() and xive_cleanup_cpu_ipi() against
  xive_ipi_irq == XIVE_BAD_IRQ to avoid dereferencing an uninitialized
  or already-freed xive_ipis array.

No functional change when allocation succeeds.

Link: https://lore.kernel.org/all/20260725202632.dcb325658896a470df91cf57@linux-foundation.org/ [1]
Fixes: 7dcc37b3eff9 ("powerpc/xive: Map one IPI interrupt per node")
Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Cédric Le Goater <clg@kaod.org>
Suggested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/powerpc/sysdev/xive/common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index dadd1f46ec93..86c78af1f68e 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -74,6 +74,8 @@ static struct xive_ipi_desc {
  */
 static unsigned int xive_ipi_cpu_to_irq(unsigned int cpu)
 {
+	if (!xive_ipis)
+		return XIVE_BAD_IRQ;
 	return xive_ipis[early_cpu_to_node(cpu)].irq;
 }
 #endif
@@ -1132,8 +1134,7 @@ static int __init xive_init_ipis(void)
 	if (!ipi_domain)
 		goto out_free_fwnode;
 
-	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
-				 GFP_KERNEL | __GFP_NOFAIL);
+	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids, GFP_KERNEL);
 	if (!xive_ipis)
 		goto out_free_domain;
 
@@ -1158,6 +1159,7 @@ static int __init xive_init_ipis(void)
 
 out_free_xive_ipis:
 	kfree(xive_ipis);
+	xive_ipis = NULL;
 out_free_domain:
 	irq_domain_remove(ipi_domain);
 out_free_fwnode:
@@ -1190,6 +1192,9 @@ static int xive_setup_cpu_ipi(unsigned int cpu)
 
 	pr_debug("Setting up IPI for CPU %d\n", cpu);
 
+	if (xive_ipi_irq == XIVE_BAD_IRQ)
+		return -EIO;
+
 	xc = per_cpu(xive_cpu, cpu);
 
 	/* Check if we are already setup */
@@ -1234,6 +1239,9 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
 
 	/* Disable the IPI and free the IRQ data */
 
+	if (xive_ipi_irq == XIVE_BAD_IRQ)
+		return;
+
 	/* Already cleaned up ? */
 	if (xc->hw_ipi == XIVE_BAD_IRQ)
 		return;
-- 
2.20.1


