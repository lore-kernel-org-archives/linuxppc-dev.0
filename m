Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F160A3804
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/r3xrdE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQJ462C0mz3bhH;
	Thu, 12 Nov 2026 22:26:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794482774;
	cv=none; b=QERau3WZIhcutklHUaEUIFXKtp5aOA2bcuUW3yf6O/WmKiwH+KCbCXEOx2Au55oXIIE7Ygr0wK9bA9QEE3YMaMrgWvpcio6P/0emFN2kC5ZWQIRbsj9t1jA60f1bRVSDUSGKSkMMAQCV1zfVZJ7oL5vbl66ile2UTg3PglYtb5pKVru2Tx2mHba8+TXUo8AAB8P6KRWQ33yvBQEJMEK8XWLTA0ePyv3GMvqL+WbhrT8rV4ZAdrC6tNw2mFBPPpe7uyWKQUCeBvaWdhsEq8gDH5vJC9U1vGKN22es1gWDmdUe+FN0yt08x7QEsdQsIR1/ijVyX3/UMsmze6ZCbHzY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794482774; c=relaxed/relaxed;
	bh=GZ4lZp1oW2s0U2uL8ErHvlu8up2Pjx215zhjtPcKJ2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6Tb2k+z3+20siHdxYLnTsQnMkqPIzSHxg5oOUyD0uMOTlk7KnHxWLv08BwgYo9tPXxS0qlvdM9a2mahHvl9GtGE0lSpNVpDLX4/5j3RSHItMI54hZNrKV/MdKWwO+diLCKhimh/daX5aHS9yh4ZYZ8Cl33mbj7oyWxWQ21G+nH+lweK2UyTEjpzXPg72C2hwOWxoNbAaL2iB9NAePtOzymi7D+ZuQ3Xa8n0L4k93sYMgyfQvfjEpHtpyosZ3rcuHqviexZu9/htUpRaUE8Mfo5E6MLzFEHbODnYvSCsioYBGTdcheHv8KA5qEy6RmfEszqAC4oRYuzqORjNm+qJGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/r3xrdE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/r3xrdE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQJ455K7Xz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 22:26:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 39F5941325;
	Thu, 12 Nov 2026 11:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC0C1F00A05;
	Thu, 12 Nov 2026 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482772;
	bh=GZ4lZp1oW2s0U2uL8ErHvlu8up2Pjx215zhjtPcKJ2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/r3xrdEhQleZV4yGgXPVqBfanfjsSKJ/g60PP/OJoc5XviAAJAUlX2KuMamvkihO
	 6S5H6k5b1RNd4xXJLVJ91kcuCCQCZTXO1k+1hQn6/O+7RvV8jNjkBRJXIlQ1V9idnR
	 9XiRe0gigvMNyWa7iIbigaFbf2JOHB8+iOYN0Ye9RreZ/JWwevZQj5VfLzPUXudYPN
	 9zN8Zh9SPvZmpMfi3VkkfJS4yMkZoVwR2dg8Pxff5QMrY76ACoV9Zd44FOHqSG8vPH
	 /mQ1HwpQ/1l+8doGR2M/t4fFEC8tmhl4Zq43fF36z8VjNjv8+aaMf4c4pJisKk9Stz
	 Dl7K858NfhsuA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v2 6/6] ARM: add CONFIG_VMSPLIT_2G_OPT option
Date: Thu, 12 Nov 2026 12:25:28 +0100
Message-ID: <20261112112528.1116405-7-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112528.1116405-1-arnd@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
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

Tested in qemu -M virt, both with and without HIGHMEM enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 797705a94b28..8992fedfdf37 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1025,7 +1025,8 @@ config BL_SWITCHER_DUMMY_IF
 choice
 	prompt "Memory split"
 	depends on MMU
-	default VMSPLIT_2G if HIGHMEM || ARM_LPAE
+	default VMSPLIT_2G if ARM_LPAE
+	default VMSPLIT_2G_OPT if HIGHMEM
 	default VMSPLIT_3G_OPT
 	help
 	  Select the desired split between kernel and user memory.
@@ -1042,6 +1043,9 @@ choice
 		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
+	config VMSPLIT_2G_OPT
+		depends on !ARM_LPAE
+		bool "2G/2G user/kernel split (for full 2G low memory)"
 	config VMSPLIT_1G
 		bool "1G/3G user/kernel split"
 endchoice
@@ -1050,6 +1054,7 @@ config PAGE_OFFSET
 	hex
 	default PHYS_OFFSET if !MMU
 	default 0x40000000 if VMSPLIT_1G
+	default 0x70000000 if VMSPLIT_2G_OPT
 	default 0x80000000 if VMSPLIT_2G
 	default 0xB0000000 if VMSPLIT_3G_OPT
 	default 0xC0000000
@@ -1058,6 +1063,7 @@ config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
 	default 0x1f000000 if PAGE_OFFSET=0x40000000
+	default 0x4f000000 if PAGE_OFFSET=0x70000000
 	default 0x5f000000 if PAGE_OFFSET=0x80000000
 	default 0x9f000000 if PAGE_OFFSET=0xC0000000
 	default 0x8f000000 if PAGE_OFFSET=0xB0000000
-- 
2.53.0


