Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D0606A31F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=qH213BZh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGccs54g1z2y89;
	Sat, 31 Oct 2026 10:24:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793402669;
	cv=none; b=YTNgyBzkg/k/bizxzJLjg+NfT8dqOvTfkHIFdhn3ZFwdCdgsD2GfEFnzR/Knid7/UHe8Eif7szdvuKxhn2jmylTUkHLqs3s9VUmc3Z1Ex4egqCWzHlbhAgFLkp/u2Q7RzPKecEn3CJ3jvm7hBoDPvj21L8YiP07XFQWwuvZimXMnWK03dxrDuX0DmVp37bRSrwfXgo+kFnUvoXX0IVRSCv06Z1DW+DACBC+EMyEk6ZqioU3crlO2Ox72iq3wLYgJ47PXzYeDtHI0h9CX0kjhR4xwfRKgAv71RZ2TQVhN5SoSZN6XRQdnDkuqwjdngn7e4Q7uPJACk0uqJbx6PCmS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793402669; c=relaxed/relaxed;
	bh=p8PKPotJoD0jhi3l1VncVirXzxS18uQyTptF2D+D6D8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bT+5xwTp2a+rvVYpojBiD1n4wSLHJYY1bJRI2Hbkl4evn9apC821Ib+p1siIHJS4jl8grxNYsIXfoPxp1CraZk887KMPwvf3lDbjeImTU0dfodiAZUiwyy8eLGI7l4VEUK2W3SHUyjEVhZu7w7V2kqzd4PKHzP5VSZoYNImAM5+wuuiXmc9qsynjBzPCHGJaanc6oHxyrtYboCk0zICXwYLVhwhuDyI0g9gkVu9WHX7X7u7fLzJGnGv71LoYl/R0cbANA0ABwGGr1wxBHjSoMC25pqv1dx8zteEkyk/RbUdzclmZBdJ+gzVCm+iYwPbKxV+FvGemF5VrU7q2Mb8zcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0x0f.com; dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=qH213BZh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=daniel@0x0f.com; receiver=lists.ozlabs.org) smtp.mailfrom=0x0f.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=qH213BZh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=0x0f.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=daniel@0x0f.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGccr395wz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 10:24:28 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-14394530ec6so1654293c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1793402666; x=1794007466; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p8PKPotJoD0jhi3l1VncVirXzxS18uQyTptF2D+D6D8=;
        b=qH213BZhbUI87ciwCuXZ48iMACEGK5nNyH6W8EB7vMK3JiQlnXa1H55SPaDhlBooLr
         ITJE/OIdUotIJsy5A9ZyS4DN0gHfGAYUksqojaZlQWrwgY+dWbmhJPg6eDHQmIAw2bAl
         uOI4S/L+QT8Zob8fnEduW2nYfiCBusJhLW+Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793402666; x=1794007466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8PKPotJoD0jhi3l1VncVirXzxS18uQyTptF2D+D6D8=;
        b=O1jSvov+KcnE1CNe5kNRMO+vUbTHz2AmJOJglPgoC/gMPJuM9WYqof3r5erD6g48Ug
         MgcL5AfUQIUg0ktEAghoogb3OIIA3dW1fL0Reg0YIvRVncCA1cCZJIXD1NvmCfx3b5dA
         rlTngfeFFh5kyQ9Q5lYMM4t3thAfZFUNxu3R9Bs/cXT3AlvzcDXDCMa2mfXJmM5YAH9m
         L9HnP0jQi98TR/K+YQ/htausAfCD9iR6Tgn9TWe1BBGfvG5S/YK05b3l9nbHvlqoPgZJ
         BM9gPx3OOARZ095ttIry3VerlSxgA73RM6r4yusWT7XsTCCHxjTmELZgSkkCro59IqKK
         rEpA==
X-Gm-Message-State: AFq9FYIIPKXUWgcs3NW/Vh8KU3gL4pPpI1kjDDWtYM0a5vu/nht0Y3+r
	sGjZmmtq4PEoJ4btT15ev/i1WRBa00bdQWaED/979VBFSnkV5UBHAbwbAm7UNLbDmk4=
X-Gm-Gg: AYBFou3HQzZN/SRqdVD1koeT5KPcnGSphrjoxAiYirfcRp2KYr+U9YIxYp5UXRnubRI
	NqIpMliweCyjRLBAPo/cWPcxBzBGwT9VHWaZKXJdY73jN9XrS84JuZxkmkpOYslQe2xzQKoOIY1
	IRrgbBKKvtaMSG/pYYmBu2DH+7h6k8nmnor7nwWwDsA+FszFFSz/6KKVCgUqch349tt5qj90Lb2
	6trvxvEaiLMMRh9Vi3Jmh/oHpkIxtrreC9+cpF6hrdDL0CQEnSz1wqcK1hHNn9+Qc2PHl/IGKAk
	6u9YDK/7ZTAQfxO7aUFZSOLm6Kqu720wnir9Dz+ivqNe7o6TcXY071j3vqAJtYrYrPm4DvybhlB
	D5D781KXeOzVY8vZL02AIGwKmm8u0vGGpCxv2PTF+rgHuMFlF2G7ow5GK7jVZpK+mxFNcifETd3
	MEyEzrwhYB56VoEiuqpyw4N6ClH0DlO7Kxv9XZbsHFtmvWrTl9eie1GBE/T6/QFe7HvsmtKmuhM
	TIpDRBWV1/oZQarXLioGNlSFu9eRKg6AFAB92uY8U/ZTkl76rb2x6XBv+hdZUk8LIYI3QBwPp9V
	QnEoo/Qe+jCbdFyHCOrj3Ae8YjFwrYedv92WuMpbIzpizIn7Ouxo+8iOJGa/CfK4DY87WdU=
X-Received: by 2002:a05:7022:f908:b0:14c:d84c:7182 with SMTP id a92af1059eb24-1ac5da75597mr4437875c88.22.1793402665906;
        Fri, 30 Oct 2026 16:24:25 -0700 (PDT)
Received: from shiro (p1795186-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.207.151.186])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm16104041c88.7.2026.10.30.16.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 16:24:25 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	bigeasy@linutronix.de
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] powerpc/powermac: Always close the timebase-sync i2c bus
Date: Sat, 31 Oct 2026 08:24:18 +0900
Message-ID: <20261030232418.1145779-1-daniel@0x0f.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

smp_core99_cpu_prepare() opens an i2c bus for "tb sync" and that is
closed again in smp_core99_cpu_online().

If a processor module is dysfunctional, not seated correctly or
otherwise fails to come online smp_core99_cpu_online() is not called
and the bus stays open.

On some G5s (tested PowerMac7,3) this i2c bus also has the CPU
temperature sensor and fan controller connected to it so not closing
the bus stops the kernel from making sure the working CPU doesn't
roast itself to death.

Rename smp_core99_cpu_online() to smp_core99_cpu_online_prepare_down()
and wire it up to get called when onlining fails as well so the
bus is closed and the working CPU stays working.

Fixes: 68e694dcef24 ("powerpc/powermac: Convert to hotplug state machine")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/powerpc/platforms/powermac/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 88e92af8acf9..e310b6fbbede 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -865,7 +865,7 @@ static int smp_core99_cpu_prepare(unsigned int cpu)
 	return 0;
 }
 
-static int smp_core99_cpu_online(unsigned int cpu)
+static int smp_core99_cpu_online_prepare_down(unsigned int cpu)
 {
 	/* Close i2c bus if it was used for tb sync */
 	if (pmac_tb_clock_chip_host && smp_core99_host_open) {
@@ -893,9 +893,9 @@ static void __init smp_core99_bringup_done(void)
 #ifdef CONFIG_HOTPLUG_CPU
 	cpuhp_setup_state_nocalls(CPUHP_POWERPC_PMAC_PREPARE,
 				  "powerpc/pmac:prepare", smp_core99_cpu_prepare,
-				  NULL);
+				  smp_core99_cpu_online_prepare_down);
 	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "powerpc/pmac:online",
-				  smp_core99_cpu_online, NULL);
+				  smp_core99_cpu_online_prepare_down, NULL);
 #endif
 
 	if (ppc_md.progress)
-- 
2.55.0


