Return-Path: <SRS0=LEFZ=7J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919BBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 15:13:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4308E2084C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 15:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UISXtkJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4308E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49XDqv2Dk1zDqVK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 01:13:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49XDWH4ZSWzDqKD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2020 00:59:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=UISXtkJ1; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 49XDWB06Zxz9sTk; Thu, 28 May 2020 00:59:18 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49XDW85kpTz9sTN; Thu, 28 May 2020 00:59:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1590591556;
 bh=Mx9wkwSKR46Eja8f0fUCjU0Z3LqMh1qJlLO0gH08bDI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UISXtkJ1OAts55yuOU8Xuw1GfKwbuPBqobjdpA7Jd1wj179H+uvJvx1TO7XAUzFXk
 xQsUu+QjM03hfr6pTkU11C9v/1u0y8hzjMQXKMhWkziRfd+hQGiEIpSgSeYP5xfeBi
 Esf4m6gwyWduWA4H0qIQrJ5pmnbhepXPeStqD3bjFhPinT5Krtoaf8YjfmmPJ77RfI
 K8M9RTegbvEejYgpd7RxhaFIqCE/KjxFybl1ks1NRSmv3dPr949Cw1cLd/BMjOpYob
 3SH6piBirGgng6g9uIgWKJePaqiI7wfZFxLosYZtABzrGFRvCy1FkH+1t8eCOHKkJz
 r2JLfjpP52R6g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 3/4] powerpc/64s: Save FSCR to init_task.thread.fscr after
 feature init
Date: Thu, 28 May 2020 00:58:42 +1000
Message-Id: <20200527145843.2761782-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200527145843.2761782-1-mpe@ellerman.id.au>
References: <20200527145843.2761782-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alistair@popple.id.au, mikey@neuling.org, npiggin@gmail.com,
 jniethe5@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

At boot the FSCR is initialised via one of two paths. On most systems
it's set to a hard coded value in __init_FSCR().

On newer skiboot systems we use the device tree CPU features binding,
where firmware can tell Linux what bits to set in FSCR (and HFSCR).

In both cases the value that's configured at boot is not propagated
into the init_task.thread.fscr value prior to the initial fork of init
(pid 1), which means the value is not used by any processes other than
swapper (the idle task).

For the __init_FSCR() case this is OK, because the value in
init_task.thread.fscr is initialised to something sensible. However it
does mean that the value set in __init_FSCR() is not used other than
for swapper, which is odd and confusing.

The bigger problem is for the device tree CPU features case it
prevents firmware from setting (or clearing) FSCR bits for use by user
space. This means all existing kernels can not have features
enabled/disabled by firmware if those features require
setting/clearing FSCR bits.

We can handle both cases by saving the FSCR value into
init_task.thread.fscr after we have initialised it at boot. This fixes
the bug for device tree CPU features, and will allow us to simplify
the initialisation for the __init_FSCR() case in a future patch.

Fixes: 5a61ef74f269 ("powerpc/64s: Support new device tree binding for discovering CPU features")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1dcf0e214a22..a74bfd09cb38 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -685,6 +685,23 @@ static void __init tm_init(void)
 static void tm_init(void) { }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
+#ifdef CONFIG_PPC64
+static void __init save_fscr_to_task(void)
+{
+	/*
+	 * Ensure the init_task (pid 0, aka swapper) uses the value of FSCR we
+	 * have configured via the device tree features or via __init_FSCR().
+	 * That value will then be propagated to pid 1 (init) and all future
+	 * processes.
+	 */
+	if (early_cpu_has_feature(CPU_FTR_ARCH_207S))
+		init_task.thread.fscr = mfspr(SPRN_FSCR);
+}
+#else
+static inline void save_fscr_to_task(void) {};
+#endif
+
+
 void __init early_init_devtree(void *params)
 {
 	phys_addr_t limit;
@@ -773,6 +790,8 @@ void __init early_init_devtree(void *params)
 		BUG();
 	}
 
+	save_fscr_to_task();
+
 #if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
 	/* We'll later wait for secondaries to check in; there are
 	 * NCPUS-1 non-boot CPUs  :-)
-- 
2.25.1

