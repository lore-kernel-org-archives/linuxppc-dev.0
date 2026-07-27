Return-Path: <linuxppc-dev+bounces-24878-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A77C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:43:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7wDm6GyZz2yhY;
	Mon, 27 Jul 2026 20:43:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.67.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785149016;
	cv=none; b=SQwnFObPH9KvNl2EsdNTW7ziozkeDTXusWRBljelMUxj7hpvqR+rJnfv+U4fSIg7bjb37Jo43py5pSS1v+MorVDxKu/zacvATQRC4QxBOFdLcBRD7+ifv3TtBam2L60vr6hpJALYoqPAkXrFdnLtAdJBuf+SFdkjVKYsDuuX+eioMZ3hndod+42fMVZlBZS4frYqWB3WLgCQxeEoLvZbqo3+sUfaLTMXOXyfOvT8nwjGHSzA1a70nS0QB8X750JOu1coZR+hUb2xEfAbnqwVhRBHy6mMcKwwTv11U8MjXqYa1lFmxfJGkBXTIeJoNw2lZoyngwIz1yk2GTYR/DLmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785149016; c=relaxed/relaxed;
	bh=I/fnuTVnx7CMJPcZidDHjHGqG0uQuo9fgxe/9gGFCgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXbDroB0i3cLGerTjJsmWdGY560nHUv97PhcRHi3Ai7nV+AbvR4N9KJ+5Tto4+oDVPGCgTvpnvjKy6LDsACg5GMQ1sM3LnBeovoLczIM19K6JI0EqQ2jsxJKjKWXvR40US/bQcMJsBgEA1U/WkGK65Ar7JdX3JNsroCpQnZPkCo2Hs+JdidosSvsPkohZnIc2TIXPlpDJTdSHh32cqg+/eZBvITG1z1apaWTib/iQot2NCnliD1DEWM+6r8gRGVv3r35w3LO6FqNgt76N24bQ0gLr/7+HK3HqWaZHSi6PzDq6JRjnVm/UVxiRf98a3V0dDiJTNGZ14FwsxxwmwM6oQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=FWcnwO9C; dkim-atps=neutral; spf=pass (client-ip=114.132.67.179; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=FWcnwO9C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=114.132.67.179; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7wDl2FvTz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:43:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785148966;
	bh=I/fnuTVnx7CMJPcZidDHjHGqG0uQuo9fgxe/9gGFCgY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FWcnwO9Cgs7OSqdAmyN6oywVNeuZI64kgNs4LzmkdlBhCv04bNhmNVilxouWsfJIQ
	 CA3j4m64u6d3uIgzpfkyrP6NCZ5Jdr4okcx8zYE99XtEQW+EygPgzv+9AKLT1petD/
	 eGBw1gVcMLIdzS1bnINi6RXGCJKcVhein1V4zbws=
X-QQ-mid: zesmtpip2t1785148954t6bc5e272
X-QQ-Originating-IP: DAiKkE6FqfAhF/JHeS/I6ndY6PFpfS8EXhFLIXWFDng=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 18:42:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1489267076884197094
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
Subject: [PATCH v3 3/5] powerpc/xive: propagate IPI init errors to prevent use-after-free
Date: Mon, 27 Jul 2026 18:42:13 +0800
Message-Id: <20260727104215.184786-4-gouhao@uniontech.com>
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
X-QQ-XMAILINFO: MJ6pzQSz6S9mPeyuck42t9bql4EaE3+bYoodmIhgwwghVuFXFYzsj3n1
	y+/coymgS4/VVd8T/alEdceADzIP6TzQyqbWoNPzbn11VE+5kNFKol3q+8lwl4aYKw7zXUm
	38gXh5knSsqT6uZBys+uRclIafjVEm7UBq33PPMqTL8wZzBp04lY0+Kw02kS0wWpSDdfdp+
	zuJKV4penXMb9MuyWbeXF3v1CaPuOpwyQIOF1o+TBEAochkZcNAApDjXxG6DThzH04BUiI7
	XOHYiSgxCWJ9PJgnQ4waEcs8joLVVNcdVtRy/JZWaZYWwSzaMYpJlBhIBgCdLgv1jJ+gJH1
	r/ZSKAM5W0jF+/eD6957TEgYBOp2v4LYxqtus9HzeU3rMQOKDZ/alflgO77RcTJecO3lt5b
	YmtWAHWs9yjlOYnVirBh/XTh8Q6z4NPPeULHyNyAf3BY2jcGWtgtdlqwR91aKAjH5LhBXxX
	b2CNMDHarBIPEpTCb1uD6aPB19N16iwrQOiCuN/VXdUnX0JGjj7Im7/Ak3ckDUcSd3LtxED
	74Nbgvhxz48sp+9G6zY3usrjFqeXfmM2O1B+gGupaVME4mc1VZYSwOGgroNMB2tfXKykzKq
	4f/oGCidNJ7QBDvaautU9qUjrN/2sf7nGOtCuGd9sfbO+oinAVjdANMTTDRDNA1ChVYxfZB
	zRJotuyDsAiecNOFXHlRxWijofcM7HFQtf8+JvXoFIFlH1HzzOGSRZcxXCyR/TS7bZ2SRVQ
	oUhjZLDyesrJHpX7VqIC09iUJ3QK09jD6+sPWqcCoD3+TlRdxDfqYFsYBPWtpNx/VY3DXx4
	ZKZ99OdNWgaFGddYz+hARouSqHOuXTzUA+m0j66pumnk4MUiaUL4Vi+j9CiYk831W0WGG19
	MOSd7yzsBIFo77gLHl/X5nNbyStKqQKvgrX23lHJ3OWxm+VLQs+qgi3DC5Aw+dbn3oJrWK2
	5Ua/Dd6cLt6N5pzvWqjS5qlm9jG7ZyBJQ5hxRMKZfvvBvovqjFoNAX7CTXvOHfmNyW7xO2j
	wOMWnYuN83u3ukyoPYOPTOk6tn7pzSK3+YD2eMWBeqocxaHWxBJjhn+77znjwBIiTcP2C4f
	heEkFKoOBjmcKdb5yy/LJA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

When xive_init_ipis() fails (e.g. irq_domain_alloc_irqs() fails),
the error path frees the global xive_ipis array.  However,
xive_smp_probe() previously ignored this failure and proceeded to
call xive_setup_cpu_ipi(), which dereferences the already-freed
xive_ipis pointer -- a use-after-free.

Now that xive_smp_probe() returns int (previous patch), propagate
the error from xive_init_ipis() and xive_setup_cpu_ipi() through
xive_smp_probe().  Check the return value in both pnv_smp_probe()
and pSeries_smp_probe() so that IPI setup is aborted cleanly on
failure, avoiding the use-after-free.

Fixes: 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE interrupt controller")
Fixes: cbc06f051c52 ("powerpc/xive: Do not skip CPU-less nodes when creating the IPIs")
Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
---
 arch/powerpc/platforms/powernv/smp.c |  8 +++++---
 arch/powerpc/platforms/pseries/smp.c |  8 +++++---
 arch/powerpc/sysdev/xive/common.c    | 10 ++++++----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 8f41ef364fc6..b1201dbafcaf 100644
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
index db99725e752b..14cd0634eeca 100644
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
index 9f80c16be23f..bbe7c85274ea 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1267,15 +1267,17 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
 
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
-	xive_setup_cpu_ipi(smp_processor_id());
-
-	return 0;
+	return xive_setup_cpu_ipi(smp_processor_id());
 }
 
 #endif /* CONFIG_SMP */
-- 
2.20.1


