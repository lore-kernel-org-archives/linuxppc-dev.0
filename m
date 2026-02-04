Return-Path: <linuxppc-dev+bounces-16571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCB1E8B397
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 04:05:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5Rb8074lz3cBG;
	Wed, 04 Feb 2026 15:05:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770177923;
	cv=none; b=jUg/+uWVQx4TrabiSkI8L9mOI40KzQBbhs5nsMVrleX1tC3iHWGXeE+eW/vjoigo1CcaLyJ83x+waWM4VY7S+0b5pSDneaOutd/ohGbWByZ3FL3JSi8ndNdZOYfwHCsh1XUQhzPFbbFxM/OxN/eR/HM/cinCE9rtx/taZUmVNt7LIz/LATpSUgAYeJ9YRQFoVLyaRuanFxQXi/n5yEPO7D3PqmV71ajg6YLcCoFD1qbpEqKi/mb7hHLyWBLFDSoaxeBHnOGBNTsBtuSjYoKKj4u4fUTLySknTBvlc3AuNT1gOAGQYfiFYt8TaInETkcDPrTHGp1UJxY2dDkp1KOVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770177923; c=relaxed/relaxed;
	bh=mvOPxfbchswmL3ky18gxwKjhN+aM3kdyUwjekTNS6e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfqsFVBo086pD7eNJUjChcmFvqJ3s95OCxSu2FkTJyDjaUp6s0cVHEsRL1R0anYc73ltbilaq+Xmmnz8ZI60ZNPhOgzWOGre71C2DnUab2zkuPoQGkcByj21bHv8WdXVPIp/SASGREhnEvGsnOcfoJfO47iY4yMpTBltpmntSKc7Un7PHBJ9evBfkL0wtldYJgT+qS7nEnDB8DeBID6bwEaUtMqrIe40PLGh+uBFid5RsmAwvY6MtSyEe+q+5eZd6xq22JO8xVgLQN4mGr5bPv0yxalO3nr1o+Ih466xIZavpp4U0+A1skMk8SLuzpOyYOe3n8hUi8Eb3rV6zUPgaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5Rb72zC1z3c9D
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 15:05:23 +1100 (AEDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 9C58BF43B4C; Wed, 04 Feb 2026 05:05:10 +0100 (CET)
From: Link Mauve <linkmauve@linkmauve.fr>
To: rust-for-linux@vger.kernel.org
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lyude Paul <lyude@redhat.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Tamir Duberstein <tamird@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	officialTechflashYT@gmail.com,
	Ash Logan <ash@heyquark.com>,
	Roberto Van Eeden <rw-r-r-0644@protonmail.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 4/4] powerpc: wii_defconfig: Enable Rust
Date: Wed,  4 Feb 2026 05:05:01 +0100
Message-ID: <20260204040505.8447-5-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204040505.8447-1-linkmauve@linkmauve.fr>
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
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

The nintendo-otp driver now depends on Rust, so let’s enable it on this
platform.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 arch/powerpc/configs/wii_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 7c714a19221e..b1172249e783 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -18,6 +18,7 @@ CONFIG_WII=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_PREEMPT=y
 CONFIG_BINFMT_MISC=m
+CONFIG_RUST=y
 CONFIG_KEXEC=y
 # CONFIG_SECCOMP is not set
 CONFIG_ADVANCED_OPTIONS=y
-- 
2.52.0


