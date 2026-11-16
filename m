Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C00606A332
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpjC7PZJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSnk26KSfz30DZ;
	Mon, 16 Nov 2026 23:49:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794833354;
	cv=none; b=FikiLmT3Q5xurhUsxFvoF2wmL5pR/E4LNdyVP1YmKB0IxxCHZ5wLuirviTkuzhHqGixJhWUr4/4F/GoYHyAM30yGEj3rkrmwXREL++Oglk0CUd/S2L96vb7SG52SQN00aqY/rh1pT6UcwBpC4PPD8zeN2O2eTBoU1xTNUu5LWfHlC4/gTaNOtDzsm6kaODp6Az1Yf5UXKPVhZmq8Qttn3fD1QYzQ9HJ9xnVOt+xTHOR6LIW6cqI+sETaGfPDBLCfBD7dHXG50Bk5VsY8DmpU+q1xTgjzJf4zwqQnuC4kG7QHYlRG9c7J3YovKzJpY/dKZUiTv2fm+IxmCSf6VUvg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794833354; c=relaxed/relaxed;
	bh=yqMiao7IUsYqKs54ICvEuqwO8zDV+6ATbJVBuhC4jzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADMumWCw2a6EQVAFzRQ+Z895K2cqluSOr2/r1FBa3Os6ovvobpE3g7zpwuNNh0l9lklRbyWraoCUnyLFvh5B3bLPwgKJS9ZdlKS1h1ZJkqYgh1OyDqhGptnvCNQEf3u7dhlxnYcCjE+XqNvenDkaYwiGJVi+r8m2aerW/Tja3Cs8MYUI0F4dCE+lfbY3P/Xs2GYIJiXZJhDG9j0IgdRbcYjBMTvRMUkBWKrAGDqpBl6cC7CzAjTnGxlzyoKG4WWxjVDUJt+f0Pd08PQr/jAk+Qaz0s6DpJtPv1g0in6hcuE6jw8XFmwAaCNqnyO9n0tOAM9uzUyIIsBnBIS0JT8/Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpjC7PZJ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpjC7PZJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSnk20S14z2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 23:49:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DB4E6612ED;
	Mon, 16 Nov 2026 12:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C31F000C5;
	Mon, 16 Nov 2026 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833351;
	bh=yqMiao7IUsYqKs54ICvEuqwO8zDV+6ATbJVBuhC4jzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gpjC7PZJmXae3Ug6YBRcR+8bfcqu4PinQAZYVOw+KwcZk6WxhZD4lN24ddrIomqNG
	 Tjc7iRfpoEVYgnl2OjTRIDVmKZYCzKQYV4Xkj263XiW4qgji+556X1K0E+4G//fyn/
	 i1HzLH6xsPRXu/fCpishNMA/oZUalIKcIOocxcogWC/je5O4ts9z97s/t6sw2F+N9R
	 4Euy1GQaelLkbtRVa05un7cyZynZsXxkTqTSnvzvbZE0hIUN5oy/ekJ6RyfbXl+zPx
	 z8Vx7uVvTxw3/gInPP+Kn5cYLwYfOUuXpks2xvFUidQy15WoNQKtH2MtWImunv6Cw9
	 zU6NBp8N1IOtw==
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
Subject: [PATCH v3 05/10] ARM: add CONFIG_VMSPLIT_2G_OPT option
Date: Mon, 16 Nov 2026 13:48:27 +0100
Message-ID: <20261116124832.662455-6-arnd@kernel.org>
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

Unlike x86 and powerpc, there is currently no option to use exactly 2GiB
of lowmem on Arm. Since 2GiB is still a relatively common configuration
on embedded systems, it makes sense to allow this to be used in
non-highmem builds.

Add the Kconfig option and make this the default for non-LPAE builds
with highmem enabled instead of CONFIG_VMSPLIT_2G.  LPAE still requires
the vmsplit to be on a gigabyte boundary, so this is only available for
classic pagetables at the moment, same as CONFIG_VMSPLIT_3G_OPT.
Keep ARCH_MMAP_RND_BITS_MAX at 15 for this.

Tested in qemu -M virt, both with and without HIGHMEM enabled.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: Change ARCH_MMAP_RND_BITS_MAX for PAGE_OFFSET=0x70000000 (Sashiko bot)
---
 arch/arm/Kconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc66d52d847e..270ae2b89407 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -333,8 +333,8 @@ config ARCH_MMAP_RND_BITS_MIN
 	default 8
 
 config ARCH_MMAP_RND_BITS_MAX
-	default 14 if PAGE_OFFSET=0x40000000
-	default 15 if PAGE_OFFSET=0x80000000
+	default 14 if PAGE_OFFSET<=0x40000000
+	default 15 if PAGE_OFFSET<=0x80000000
 	default 16
 
 config ARCH_MULTIPLATFORM
@@ -1039,6 +1039,9 @@ choice
 		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
+	config VMSPLIT_2G_OPT
+		depends on !ARM_LPAE
+		bool "2G/2G user/kernel split (for full 2G low memory)"
 	config VMSPLIT_1G
 		bool "1G/3G user/kernel split"
 endchoice
@@ -1047,6 +1050,7 @@ config PAGE_OFFSET
 	hex
 	default PHYS_OFFSET if !MMU
 	default 0x40000000 if VMSPLIT_1G
+	default 0x70000000 if VMSPLIT_2G_OPT
 	default 0x80000000 if VMSPLIT_2G
 	default 0xB0000000 if VMSPLIT_3G_OPT
 	default 0xC0000000
@@ -1055,6 +1059,7 @@ config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
 	default 0x1f000000 if PAGE_OFFSET=0x40000000
+	default 0x4f000000 if PAGE_OFFSET=0x70000000
 	default 0x5f000000 if PAGE_OFFSET=0x80000000
 	default 0x9f000000 if PAGE_OFFSET=0xC0000000
 	default 0x8f000000 if PAGE_OFFSET=0xB0000000
-- 
2.53.0


