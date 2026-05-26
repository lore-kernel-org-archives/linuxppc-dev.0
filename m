Return-Path: <linuxppc-dev+bounces-21506-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F69CD5BC8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 10:21:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPph8389tz2y8t;
	Tue, 26 May 2026 20:21:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779790904;
	cv=none; b=onlzv4XEuhSAnou62FXhEVPxdjqOKReiq23sXtGvebfwokAy0k60kNX/sDGVl81K886reomerg3Lcl/ynG27SL587GkNNaVaejZouHvSjCJStbxSjahv7Pf3cYOJ5vUOZdn8NpweLff8d2LZNxblzR9JuXYFpmsY+Eh0jNCVGuq8DugKJUjWvNRTwxtJCkbPT5dnc59nVzLhoVVBKXCRThh3cGNuedfwqhaVax37cOU872EBqLSasbApoBHQjDthFVFZe/ZQslYFUJFRC2qAQpPHVgIBJumbzwr22e8yI/3av3C80MKljdKoIELqEVdB7+BhxRwmRj3fzI+fF4LLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779790904; c=relaxed/relaxed;
	bh=rsGgpnBZc429OlLc+sfTkX+ix4uTLQuTZY4VW1h618s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cij+J9R3Jv47EuUeww2CenT3va3Vt/BCmOY/kivWJI6Q1FdMXLK6SklZQoupEHgvlGmZuMyUqBPhvon0V1YTWeRbGFKhg++3zfx6TXTi168EyGhl4eosyZMhJsXs41iSxkNABB2TyGT3Iiz4Zn1kue1JJLmm2BTX9vrJxYJw67aRjv/dw9JQIuVskFIjh4/Z3gjfHwpiHau628TfPPWkCVhIIAkDf+b7aVocJFTFGqz6ueu4CALjuODHtCCWF7pY211qNTACt4VVIWM6KIXVTYnDaJaE0Wlj2+bF8so9RZ7p6Hx5mVvItSRct0oc3DMOipeq33dUayh81vJa1DPgUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iT+HtmsE; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iT+HtmsE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPph71SJ2z2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 20:21:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 89415600B0;
	Tue, 26 May 2026 10:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C71F000E9;
	Tue, 26 May 2026 10:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779790900;
	bh=rsGgpnBZc429OlLc+sfTkX+ix4uTLQuTZY4VW1h618s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iT+HtmsEGT9G0HHbIzt3B4MB70dCX6C0ptZcZWFsCZ23nquy8QEKR1HZyW8+8ymzD
	 0S7/iinPB+2fF1BQ+GZ6yBcyee4tGcrKm61/cE8zgXUOqTHoxzxTrH2NDTWGfp1pJZ
	 GiY/JkhF/ihb0sgTzs0S/rnv3Ki66n8jtU6XvF57XkDWrvymUMplh1M/xMr/TrDoEy
	 QRY0HV1GLryksl3nnLfVp0znku3m4KlukFFiLENipTsEM49zoHcWKCTbV4WoUjfoKK
	 HWylIhLQ1N8Q2e6gDNOC3Z6/zciu1yq85Q8PokixL1vGBWjwiKYmb9+nrdNQqFCn7W
	 +OmaLw4uLopbA==
From: Arnd Bergmann <arnd@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"T.J. Mercier" <tjmercier@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Andrew Davis <afd@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: export memory encryption helper functions
Date: Tue, 26 May 2026 12:20:38 +0200
Message-Id: <20260526102113.2594501-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260526102113.2594501-1-arnd@kernel.org>
References: <20260526102113.2594501-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

The set_memory_encrypted/set_memory_decrypted functions are exported
on x86 and arm64 but not on powerpc, which leads to a new build failure
because they are now used in a loadable module:

ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!
ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap.ko] undefined!

Export these the same way we do on the other architectures.

Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/pseries/svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 384c9dc1899a..ab8f8c722741 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -6,6 +6,7 @@
  * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
  */
 
+#include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
 #include <linux/mem_encrypt.h>
@@ -50,6 +51,7 @@ int set_memory_encrypted(unsigned long addr, int numpages)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_memory_encrypted);
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
@@ -63,6 +65,7 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_memory_decrypted);
 
 /* There's one dispatch log per CPU. */
 #define NR_DTL_PAGE (DISPATCH_LOG_BYTES * CONFIG_NR_CPUS / PAGE_SIZE)
-- 
2.39.5


