Return-Path: <linuxppc-dev+bounces-24756-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B40C531D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 02:29:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5sQX6G6vz2yYf;
	Fri, 24 Jul 2026 12:29:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784860196;
	cv=none; b=ffxuIXdcVOfqeeOxwP5QyA9MyJcGdPSmWMOhzvV5/WG9xUQ3R+OK5kJXrXfQwsDQ0C9TjFE4LEZjTCITuTEv9+/wepImdmlEr4f3sbZhOE0EcDNW+r1aoA2KCihFfloyNRZp6Hd+OxzknqKc9072MM9SN+FxtOrUgSbZSG7otV0YksCxjXGs6Wy6NtbfkR2KZHDe+2KVoPtls3UXClzQOhcVil8t1moCqVashABJLxIgYtMzM3zHq3eCc7z8W2UtiFsld+IlOW363eRyGxM+vPmKREKNnllr7HT8e0PKj0cBIJ9eiX+9LbgUFwF7TvHhNAg1cDjCCxfi7qkhBeEILA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784860196; c=relaxed/relaxed;
	bh=HXOSjewrugfoFYAviBCdTNIHqggVZlJ3YZl/fwlFoCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ExmH/GtVdpYNwhAJIcHu8sOWGCYUrqLO2/tsBd415pDxLHQSSxjQeaRUNZjPVNTQ8tSZd9nc5m/LnLEgJLNDr2/K8TekwHBANvKANvBQuhzuwTKrknarZEJtBVrCfg+rso2tbhRZMNMUbiUfTWBvg5d2HZ3w5gi6+Qf4DrMv1Zi0YXJPXk7dO8QnUcg//j56Q+f+99jNEYCkWHgDFvesNA3c58q9GT+1096RALGDWbi19x/qiHIiHmqQVduv42CEjG0WRBuSQB31wU2Am4q+rNiHR0cs1/L3yExUHGEEVDJzIgT6Vd/RQjkaZyH9dX0RoRFss84H2upOMSvU9Sm2Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=i5eHHhsH; dkim-atps=neutral; spf=pass (client-ip=54.254.200.128; helo=smtpbgsg2.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=i5eHHhsH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.254.200.128; helo=smtpbgsg2.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5sQT4Wz5z2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:29:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784860154;
	bh=HXOSjewrugfoFYAviBCdTNIHqggVZlJ3YZl/fwlFoCA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=i5eHHhsHHpRZ0lSujb0HJstrwVUkYb7+cVuSksG1vsmtoOSLgnWMJNncKh4Jq/oaB
	 E5iamDL0pJ6SgoQ2IaLnL4bNnexSndtCdpGO8WSkkcKgIAzDcT/kRZj4JU819Ny3W4
	 Xlr1iEGiM/7AybrJrPCfiUzK321A4T9nXkI/EQjU=
X-QQ-mid: zesmtpip4t1784860146t7ae6cf1f
X-QQ-Originating-IP: wWBgv0NV/7CKCdcjUMM5igbrbPg1ViC8PwqJvYK5y/c=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 10:29:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4050712520101716894
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
Subject: [PATCH v2 2/6] powerpc/xive: add error return value to xive_smp_probe()
Date: Fri, 24 Jul 2026 10:28:47 +0800
Message-Id: <20260724022851.466017-3-gouhao@uniontech.com>
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
X-QQ-XMAILINFO: NQPN/EATMxZDFUrjxbnurp8jsl8V7EKgnLU4Ts242AJtF9KqS9g/En7g
	8RhK1iaAVD5UARtgwQbJws9k1Xrw74Hn/bvmz/Z8oanQg4WPkb4M03uty0fgW12VdqYq1eb
	s1U5eCdXjoplTA8fLgmfMiGTLF2NNuZ4Z9sVQPxFgW69skUQgT46AiP3jRp/e1noqnfLuKy
	uQz91KT1RpM8Mn0USCPF4cAeNbDJLMk3ZkzTqsatiiRzPPbZ108UafcjEO73B3RDlB9klM8
	E+gSzn3w+xuppSn4MzrRf7wH6la9gFcjQEH4ythDTlZIz6MM+5mt+1NAYd/QAigzYBrtIt2
	Z11sfTdpg14dUdHJaE8vwBWt9J5wx9tj+lqATtXWqKNC6NU7C229ucLH34AIWdWoXblag8N
	qBWC+gpQwIw8zoog+JsWTeO9meJPXb9a9kdYzlH2qa3abKHgLT9uDfyQdKJNjm4NHp/xGY7
	MUjITUaFuKZs8Gk0mVuWfwzPSjXN93srws43u0j6jznaUOwGkV13F377svomEOA1n/tJDC7
	zZaypIK/SSNEz8Hrd21qMfZGpefM7NK4SdP+7YE2NKWYW+3gAneJBKPbdEzcGXFz44jo34W
	Ibt58us/TkGY6d9bLRbVpOriL+R/NUbKjALRsG4Ql4+YhZrGytOWxE0S7lWBgE8PtIxnePx
	vK52ejH6Qm0LWLKaXQ4HlI1b5L6vU6As3mE9HN8C4kf3XvgjNVR1bt1Msy7GTNe5S8bkhGj
	d56fjEObMC57jj5poV0h2BQWRuxYHEt2sS1k+NdIQsQ4E1Onx/Nqrcz7bkfWsaIScFghmMc
	vF/r719kbl44xWA8/KwJ+p9/Lzr4vVxV5KdnUWQieYlw+sKXqMV+63rp/k90QDzS+B8k/mq
	ysW0pdCMM1sYgupnWiFqE4GxhXLoYanLEzjbBpuHpQ0VueVylYuCinbbNjKrcgZydEc9JCg
	XP1T80RUkK2pFyALT16P1fdJ8+VOJHjts+aNagZyR85RJDVrF3rpI25VWAZG7TjA5e/lLym
	lPrJNF0rS4R9Lwh5xQCfkzA+zQLu/hmbbTIkZAlZMnjPIvyg8i
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

xive_smp_probe() calls xive_init_ipis() which can fail, but its
return value is currently ignored.  Change xive_smp_probe() to
return int so that errors can be propagated to callers.

This is a preparatory patch for the next one.

No functional change yet; the return value is always 0 at this point.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
---
 arch/powerpc/include/asm/xive.h   | 4 ++--
 arch/powerpc/sysdev/xive/common.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index efb0f5effcc69..4e3e3358993c0 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -91,7 +91,7 @@ static inline bool xive_enabled(void) { return __xive_enabled; }
 
 bool xive_spapr_init(void);
 bool xive_native_init(void);
-void xive_smp_probe(void);
+int xive_smp_probe(void);
 int  xive_smp_prepare_cpu(unsigned int cpu);
 void xive_smp_setup_cpu(void);
 void xive_smp_disable_cpu(void);
@@ -153,7 +153,7 @@ static inline bool xive_enabled(void) { return false; }
 
 static inline bool xive_spapr_init(void) { return false; }
 static inline bool xive_native_init(void) { return false; }
-static inline void xive_smp_probe(void) { }
+static inline int xive_smp_probe(void) { return -EINVAL; }
 static inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
 static inline void xive_smp_setup_cpu(void) { }
 static inline void xive_smp_disable_cpu(void) { }
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index f2904a5c2b7bf..f9a1229cede73 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1254,7 +1254,7 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
 	xive_ops->put_ipi(cpu, xc);
 }
 
-void __init xive_smp_probe(void)
+int __init xive_smp_probe(void)
 {
 	smp_ops->cause_ipi = xive_cause_ipi;
 
@@ -1263,6 +1263,8 @@ void __init xive_smp_probe(void)
 
 	/* Allocate and setup IPI for the boot CPU */
 	xive_setup_cpu_ipi(smp_processor_id());
+
+	return 0;
 }
 
 #endif /* CONFIG_SMP */
-- 
2.20.1


