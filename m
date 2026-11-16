Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18D606A332
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwjzLPrS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSnkH63cqz30V1;
	Mon, 16 Nov 2026 23:49:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794833367;
	cv=none; b=fztn+1+mMojrpe0mg9q5kIhYUBEHnBSSn24mKrdVbxyOqCoqqTWWstg561mP9aIdS8q30y3pT0R5NESxNPUFc23USyGv6eNV3B+J1kBi+WcfLe2MBPtnezTgO+flFIRDrsj8Fv+wBNka4MZ6z6o2Mj7iM9a2WflQ3jq2LSOUJNiMhQFIjaQiSV1SiH9BNyF2JHBwmSDDjK8VvjnCX5ElSHrzk/RW3v85MtO8zOPlNaBHJJfW908Ad3de0XdsGexu9hhK3UML4hA5f/WLoZImj01iQVzlos4UKrJHw4bTQY8dQJ+mUSPPv8u9Yjii2AZK4ApmzEd70KH9zLyVu2tYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794833367; c=relaxed/relaxed;
	bh=3u1YbP0glgrlPVSZVLO7Md+O8bEthJ8oEllh+tqqYIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWaY4UyPF/kjxgfd6vMt14hlVgNSDsBUiGtx5wkPVNt7MOlvOVewUyaaA5Emf1KduxSN9PtW8jhuTrWpTTJ7VYJvjPuPfhuVVV8iUguV9i8rkYHCobW67UAiPvXhzEUk+5LFVkgXc/NbkdTDOcFUdfm2kLBZeruDTLtgnX6jrfvKGhIDPrsYhIychTPwiP9628novn40sj3K2AWjQEWam7YKccygQGX6IRPd0QCP1MOn0iaT36Gk8EOc6lNCc3K1ixshX02by7N6WAHmR7g4iMGSN8tXOjCg0sNN13RHYjJXo3NOTg4R5GeOlIo8bevkJxmJHuQHcwcaVvUybSzBHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwjzLPrS; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwjzLPrS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSnkG5XDSz30P3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 23:49:26 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CE3D5612ED;
	Mon, 16 Nov 2026 12:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA631F000C4;
	Mon, 16 Nov 2026 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833364;
	bh=3u1YbP0glgrlPVSZVLO7Md+O8bEthJ8oEllh+tqqYIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwjzLPrSZpfGTVk4lN0Ho9oJpr0gZLkBoAC029OaRpb2ldn3xDllvh2HnLoT94Fb/
	 TDYQNRfyLKplvKQWdKlBl5GUJFKxnE1srWWg1c5WgPjV0cA3xM96ik5Y34iJ6OfNWM
	 tbRUmyufSXh88UFfS0u89a2YfwULjV+IbEEPsLcfzSubqsmHTOJaFp8XR9Tk53cMv8
	 y3jkV6Qv3iRMqD1R5bOMquB7vTnY7u7ucMjlf7xKmSttLEz4PA7bTmoUBx4o45yMCr
	 9JeOqh6bWP2quBFFxZQDDDTkeDpCk6/CFlsdoY4DOMT0fwCQe0ZnOIVph7buF6qLKK
	 E1ytUvDgbIMqQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linusw@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v3 07/10] ARM: defconfig: turn off highmem in favor of CONFIG_VMSPLIT_2G_OPT
Date: Mon, 16 Nov 2026 13:48:29 +0100
Message-ID: <20261116124832.662455-8-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116124832.662455-1-arnd@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

The multi_v7_defconfig and omap2plus_defconfig attempt to support a
broad range of hardware. This is at odds with the setting for highmem
being slowly phased out on the one hand but still enabled by means of
CONFIG_ARCH_OMAP2PLUS_TYPICAL, leading to a default CONFIG_VMSPLIT_2G_OPT
split.

None of the upstream OMAP2+ DTS files actually list more than 2GiB
of RAM, so it seems fine to just turn off highmem by default and use
CONFIG_VMSPLIT_2G_OPT from the defconfig to still support the same
hardware but not require highmem.

This also changes multi_v7_defconfig, which currently supports all sorts
of ARMv7 systems except those that require LPAE.

The best comprimise I can think of again is to use VMSPLIT_2G_OPT in
place of highmem. Compared to highmem configurations, this should be
an improvement on most machines with 2GiB of installed memory for the
lower overhead and complexity, but it does degrade machines that rely
on highmem to access all memory, as well as reduce the available user
address space (1.75GiB instead of the traditional 3GiB).

For aspeed_g5_defconfig, the decision is trivial, as there are no
4GiB configurations we need to support, but g6 is known to use
up to 2GiB.

If you run into problems on production machines with the new default,
with the absence of highmem, or the smaller user area, please complain.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/aspeed_g5_defconfig | 3 +--
 arch/arm/configs/lpae.config         | 1 +
 arch/arm/configs/multi_v7_defconfig  | 1 +
 arch/arm/configs/omap2plus_defconfig | 1 +
 arch/arm/mach-omap2/Kconfig          | 1 -
 5 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 1327a09e163a..060797cc6726 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -25,9 +25,8 @@ CONFIG_MACH_ASPEED_G6=y
 # CONFIG_CACHE_L2X0 is not set
 CONFIG_SMP=y
 # CONFIG_ARM_CPU_TOPOLOGY is not set
-CONFIG_VMSPLIT_2G=y
+CONFIG_VMSPLIT_2G_OPT=y
 CONFIG_NR_CPUS=2
-CONFIG_HIGHMEM=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_VFP=y
 CONFIG_NEON=y
diff --git a/arch/arm/configs/lpae.config b/arch/arm/configs/lpae.config
index 1ab94da8345d..535696d6de96 100644
--- a/arch/arm/configs/lpae.config
+++ b/arch/arm/configs/lpae.config
@@ -1,3 +1,4 @@
 # Help: Enable Large Physical Address Extension mode
 CONFIG_ARM_LPAE=y
 CONFIG_VMSPLIT_2G=y
+CONFIG_HIGHMEM=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 069d5a49f01c..c3e427ce8d88 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -103,6 +103,7 @@ CONFIG_ARCH_VEXPRESS_TC2_PM=y
 CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
 CONFIG_SMP=y
+CONFIG_VMSPLIT_2G_OPT=y
 CONFIG_NR_CPUS=16
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5791953b75ff..b00789279f25 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -36,6 +36,7 @@ CONFIG_POWER_AVS_OMAP_CLASS3=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_SMP=y
+CONFIG_VMSPLIT_2G_OPT=y
 CONFIG_NR_CPUS=2
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 79f8afe3a6bf..d145e448a6b8 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -135,7 +135,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 	bool "Typical OMAP configuration"
 	default y
 	select AEABI
-	select HIGHMEM
 	select I2C
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
-- 
2.53.0


