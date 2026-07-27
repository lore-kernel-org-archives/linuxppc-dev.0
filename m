Return-Path: <linuxppc-dev+bounces-24880-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCC1C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:49:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7wMx30Mpz2yj1;
	Mon, 27 Jul 2026 20:49:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785149389;
	cv=none; b=VvxETP96xcEq9/jBNvplak9PO+YkF6Mah8EsKh18XXQZyMfTzP+7A7g5ordScwGaaVwpwU/LpGnSZrykzMuhq2rRn09L5FYsM0GhWqBPSJEQXVY4J17XmhE6Zb2y0eVd5GTJBcS8GwMdBuKT2Y5ZCLK3DyP/apI1aFSVV1SQfI45N+VozyAUcZ4RVW64uhJ4DakN1uqlZpBlXr7Tl1gf3ERjWUfkFWHUeFRYOZi+dBGZkdLqf6jse+ncz9A1DdOU75V3pQvyb9zxAeZimczc0wN65P59gksZvvliTsp1NyrMlq0KbQgfnNprNGl2IFhblucB6cA8I/zYUSXC4yf2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785149389; c=relaxed/relaxed;
	bh=pVlGai9VmWKHUqywuRSziVQmPqN76V+tnlu+JS+HKYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rbnu+WzJHH7plP4oYT1Q16fyHo5yImv7U9rMlS5yKsoI/eOmh2LllDw+TUT7IkaZrJEWR7NnuJ8Ae2Q/zf6QKQ0diQrZ0WYdB50LquVyA2D993Pqo7kDrpBTIKgqZrPC1XswYChLMnrOeF60KXVgrChDolqK9m+oxTeu5/l+MemQpoAykBRq9J+y6gyWt80qdJ0iRzW2TetOxQP2FLrueTh5JoE8qzyNlx5LznhhDyK1/FKENPrYMoWXVqPzWoFixXN7kttxYs/tA3ARL33oBMqWV+sF97RfUy8ZIRpe1+8/TPCo0gphSgBsSG3RTdIKO/YRibiaT2pC3SSsrQ7zaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=U7wPsMTN; dkim-atps=neutral; spf=pass (client-ip=54.206.16.166; helo=smtpbgau1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=U7wPsMTN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.206.16.166; helo=smtpbgau1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7wMt5djGz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:49:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785149375;
	bh=pVlGai9VmWKHUqywuRSziVQmPqN76V+tnlu+JS+HKYo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=U7wPsMTNc0hRZTRCCDdKNfZpuwbT1jfotuvTrZzgE1IJJOUmXwtlYsDikuEQQaz5Z
	 ZAjFNYs6/sMM5vVjoBIG2D/dy5vRYMj05v5ielv8svC3hJ4JSXaLRluagvsl0rGTof
	 kD0F2wk0+cC1FZMOzT6KrhJvZ+cRvBaRES0eIzoQ=
X-QQ-mid: zesmtpip2t1785148949t7f349374
X-QQ-Originating-IP: JSoIvhrzmEr9F1zGXaKFPI4vMNsT6QM3jyuP3ByWAAM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 18:42:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2649363968427690431
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
Subject: [PATCH v3 2/5] powerpc/xive: add error return value to xive_smp_probe()
Date: Mon, 27 Jul 2026 18:42:12 +0800
Message-Id: <20260727104215.184786-3-gouhao@uniontech.com>
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
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MVMn5D3ouL6CGiukHhajuhce/iQHg5QjeioCNUEHzl4/w2N54Qsjdvld
	hN73QXrE2uThGOPNOYIdpNs1FvX+zv4BCCXYknSMdJKsb5c4krFM/+yciYuGsz15oN0oxN6
	6zrJqTjfU914u8r6r4WKcCcXTYGoQ1R2RFC6WDm+3CAmgTJBVvZ0m/mS5Am1wdKedwXa69l
	XmdOjxbP4JQhYjnW73GZz51ap+UK8IiypyPZb6GFl5+z67kXCV27YZ2re+fjClT9PJ8NXRt
	ik+yPMxHNecFPY8NPbZLpQyjgwV1538QBVvE4oGL0GuvdFZkk9scZVyVAhkPBk7adAQGU+T
	B2+wAJTnUl2QY6GYEKpWW2sV0snmIJly6rX2Rn3BqHz+zQARgLmBXUcCkr5nYanLSx4gkfa
	OjxkL7kqkoAv3EEU4AycAkoDkp6iNvbYDIOfMI8fYbOMWLvCK0eo6YxRiiouE2TqGtgY57R
	Of/DWA0UdWRlKm7YUxh88SgZMmOrBELUZwXh7THfj7zKWi76uGpJMkNs+Hf3gkCCY7pR88T
	0ZJ9sJyNqXJTHfNeTxEO4efxyO1PiEJb2V5JsAn2v6OUWoogQWvsfBxNphQBSMAX0lydghc
	71EQg/7MoS74veW4lDxE9rSpRN9wLJZj1knkDyRzCsxb1xbOYfbFZ8oQ5LzTrolBnfszWeN
	e8lFWyPFYHU8nbpA3gMysfS+Oixv758+RN9f93KYh7QKQhC3JKhlAZuHuVTNhHWqM0MfwCs
	bBHEo2W04dV1oGRinz8L0GSmz3fkFGs9geDy/OPToyIBJaZ5L4vFoK3tRdsKKJ2kPU99w+X
	hvO3YwJDTD8v0EmLjKu6yPerNCauvxaDGHyZNv3V3BN7gJvm5zmhzt7wLVTCJmPJ6HjW7n1
	YdS3kVDkWm/6c1ekkj2ITnktfwLM4lFQbddfdngM90dap/3MJV63eZZaeBn43b1gynqVuaS
	s55rlxf6VeMyReIauDcV/+/EmyWRuZMYWfaNy/550Ye/npzelxkvByM/wic0w6dcNPCHuFN
	RSAjBLio4k+PAsgtAtI2gATefgrq96XkXmRioK9WPntMXRsVmwAiztLjl1sREIBuraLJFdN
	jN2nBHQmqES
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
index efb0f5effcc6..4e3e3358993c 100644
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
index 86c78af1f68e..9f80c16be23f 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1265,7 +1265,7 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
 	xive_ops->put_ipi(cpu, xc);
 }
 
-void __init xive_smp_probe(void)
+int __init xive_smp_probe(void)
 {
 	smp_ops->cause_ipi = xive_cause_ipi;
 
@@ -1274,6 +1274,8 @@ void __init xive_smp_probe(void)
 
 	/* Allocate and setup IPI for the boot CPU */
 	xive_setup_cpu_ipi(smp_processor_id());
+
+	return 0;
 }
 
 #endif /* CONFIG_SMP */
-- 
2.20.1


