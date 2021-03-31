Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E2C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 14:50:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82776100C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 14:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82776100C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9Tks3N4zz3dw6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 01:50:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9Tk65ksHz2xgC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Apr 2021 01:49:50 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F9Tk251NKz9tyld;
 Wed, 31 Mar 2021 16:49:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id k23tHx2rxXUs; Wed, 31 Mar 2021 16:49:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F9Tk23q4Rz9tylL;
 Wed, 31 Mar 2021 16:49:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AF3828B828;
 Wed, 31 Mar 2021 16:49:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5VnhnE2aZFBo; Wed, 31 Mar 2021 16:49:47 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 69E838B829;
 Wed, 31 Mar 2021 16:49:47 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4808767647; Wed, 31 Mar 2021 14:49:47 +0000 (UTC)
Message-Id: <539c4204b1baa77c55f758904a1ea239abbc7a5c.1617202094.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1617202094.git.christophe.leroy@csgroup.eu>
References: <cover.1617202094.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/4] lib/vdso: Add vdso_data pointer as input to
 __arch_get_timens_vdso_data()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 31 Mar 2021 14:49:47 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

For the same reason as commit e876f0b69dc9 ("lib/vdso: Allow
architectures to provide the vdso data pointer"), powerpc wants to
avoid calculation of relative position to code.

As the timens_vdso_data is next page to vdso_data, provide
vdso_data pointer to __arch_get_timens_vdso_data() in order
to ease the calculation on powerpc in following patches.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  3 ++-
 arch/arm64/include/asm/vdso/gettimeofday.h        |  2 +-
 arch/s390/include/asm/vdso/gettimeofday.h         |  3 ++-
 arch/x86/include/asm/vdso/gettimeofday.h          |  3 ++-
 lib/vdso/gettimeofday.c                           | 15 +++++++++------
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 7508b0ac1d21..ecb6fd4c3c64 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -155,7 +155,8 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 }
 
 #ifdef CONFIG_TIME_NS
-static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	const struct vdso_data *ret;
 
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 631ab1281633..de86230a9436 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -100,7 +100,7 @@ const struct vdso_data *__arch_get_vdso_data(void)
 
 #ifdef CONFIG_TIME_NS
 static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(void)
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	return _timens_data;
 }
diff --git a/arch/s390/include/asm/vdso/gettimeofday.h b/arch/s390/include/asm/vdso/gettimeofday.h
index ed89ef742530..383c53c3dddd 100644
--- a/arch/s390/include/asm/vdso/gettimeofday.h
+++ b/arch/s390/include/asm/vdso/gettimeofday.h
@@ -68,7 +68,8 @@ long clock_getres_fallback(clockid_t clkid, struct __kernel_timespec *ts)
 }
 
 #ifdef CONFIG_TIME_NS
-static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	return _timens_data;
 }
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index df01d7349d79..1936f21ed8cd 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -58,7 +58,8 @@ extern struct ms_hyperv_tsc_page hvclock_page
 #endif
 
 #ifdef CONFIG_TIME_NS
-static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	return __timens_vdso_data;
 }
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c6f6dee08746..ce2f69552003 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -49,13 +49,15 @@ static inline bool vdso_cycles_ok(u64 cycles)
 static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 					  struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct vdso_data *vd;
 	const struct timens_offset *offs = &vdns->offset[clk];
 	const struct vdso_timestamp *vdso_ts;
 	u64 cycles, last, ns;
 	u32 seq;
 	s64 sec;
 
+	vd = vdns - (clk == CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_COARSE);
+	vd = __arch_get_timens_vdso_data(vd);
 	if (clk != CLOCK_MONOTONIC_RAW)
 		vd = &vd[CS_HRES_COARSE];
 	else
@@ -92,7 +94,8 @@ static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_
 	return 0;
 }
 #else
-static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	return NULL;
 }
@@ -162,7 +165,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 static __always_inline int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
 					    struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct vdso_data *vd = __arch_get_timens_vdso_data(vdns);
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
 	const struct timens_offset *offs = &vdns->offset[clk];
 	u64 nsec;
@@ -310,7 +313,7 @@ __cvdso_gettimeofday_data(const struct vdso_data *vd,
 	if (unlikely(tz != NULL)) {
 		if (IS_ENABLED(CONFIG_TIME_NS) &&
 		    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-			vd = __arch_get_timens_vdso_data();
+			vd = __arch_get_timens_vdso_data(vd);
 
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
 		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
@@ -333,7 +336,7 @@ __cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		vd = __arch_get_timens_vdso_data();
+		vd = __arch_get_timens_vdso_data(vd);
 
 	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
@@ -363,7 +366,7 @@ int __cvdso_clock_getres_common(const struct vdso_data *vd, clockid_t clock,
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		vd = __arch_get_timens_vdso_data();
+		vd = __arch_get_timens_vdso_data(vd);
 
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
-- 
2.25.0

