Return-Path: <linuxppc-dev+bounces-18289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEA7FB5EAF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 04:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZfgD2rWWz2yVP;
	Tue, 17 Mar 2026 15:51:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773723080;
	cv=none; b=CEolMcNiFjFjPuxwbworC8ZsuOZd1UpHZSmOqLAIrfjy7E3guJ9K2REGScuSkvOWhBWv6B4dXPF+P8BEhoXGT5sbdo54MNlmY+8/ojJ+TbIn3Zq8U4FlluNjMFesrphHOiOce6nJGRI9ibVIFG9gnaFxRogj6Za4LWOacEK5Xmo40LG1kU41KtVTp399JxGKf0cy/K3x/2HkCDNDmt30krTVfstPqdyg2JNYbvJdsqB98GXB2hfNU+xUf5Q2ENYA0k7C2t2ES6f4kkJQIiTJCf9+WdJ1v9x5xoxZegN32/Zb61EhrqrZ20NEQcId59Lk/OBJV1WCZvlsP9qoATjeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773723080; c=relaxed/relaxed;
	bh=Ou/PwIWwnx5hF5W5acO73ZTiQBNTv8/B9JdyVA9P1lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EN7U9D7TK1i3dtxHZyqAqoFkjKNUt5bHrKUNUXA2nPh+fxBWeP9g1WBBY70c4kdghzYXapBefims8BqohZoUW6oeReQwFzXWVnzY7hpZfHrWZsTGFu3Qe2ARZkzlJkRtPHUgDgNwC68r+6LdOEztucGGuUHAYUBqLgpZlof/sF8rd1caZ1tnwBQaezgdtltftQuRSOpimQ3MZKg2yUpEwlfRbB6fPmfF/KjD1fOVAzArGBcrltniWyPzL4/nDUgcHnPpXmE96tNXxv8xDZNqi51T75LWZzYypW3PrRvqBD/Af+A4nU8Pnz97gyIGWBX1OVDRaInuo8MOLCRBjT3KyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kTQl+5Nl; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kTQl+5Nl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZfgC2p69z2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 15:51:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CD3EB60018;
	Tue, 17 Mar 2026 04:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F59C2BC86;
	Tue, 17 Mar 2026 04:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773723076;
	bh=6wmzA6YeKKYQRTyDXyQWVPMulEEjCgindg0VmxPV6V8=;
	h=From:To:Cc:Subject:Date:From;
	b=kTQl+5NlPAyy2Q+qZwNe+TJAIgpLhmi4l3wxOMBcNsDMn6te04Uy4JEmZe6aDD+TP
	 oGsdhWv+KC2jz1VqcyKGoYgXoCSZLY3fiEdGc2sghbBcQTv+ewI/JNKCPpyl6VqkWB
	 nPWE6dVmKM1UWSUNFqjeivNNfbeF5eiRKOY/OOv+ecMZAwf3W++EJbod+7E3HLNokO
	 IUYVL/7/TqOeIra9rbjxYbOSOfpl80wbUFZOO0RvWxgU1zb1MdFKBRxSvxj+KLE0Uq
	 YE+WZ2aYDmGsPEybxOyhBgI7aR1fqWujTShlVm1DvZNpmUrDJU2cjYeXXV5+sgdmak
	 +zKRioypK1yIA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] lib/crypto: powerpc: Add powerpc/aesp8-ppc.S to clean-files
Date: Mon, 16 Mar 2026 21:49:25 -0700
Message-ID: <20260317044925.104184-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Make the generated file powerpc/aesp8-ppc.S be removed by 'make clean'.

Fixes: 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized code into library")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 725eef05b758..dc7a56f7287d 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -53,10 +53,13 @@ endif # CONFIG_PPC
 libaes-$(CONFIG_RISCV) += riscv/aes-riscv64-zvkned.o
 libaes-$(CONFIG_SPARC) += sparc/aes_asm.o
 libaes-$(CONFIG_X86) += x86/aes-aesni.o
 endif # CONFIG_CRYPTO_LIB_AES_ARCH
 
+# clean-files must be defined unconditionally
+clean-files += powerpc/aesp8-ppc.S
+
 ################################################################################
 
 obj-$(CONFIG_CRYPTO_LIB_AESCFB)			+= libaescfb.o
 libaescfb-y					:= aescfb.o
 

base-commit: ebba09f198078b7a2565004104ef762d1148e7f0
-- 
2.53.0


