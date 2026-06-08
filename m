Return-Path: <linuxppc-dev+bounces-22233-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D61CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:54:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4b52q2z3cZ2;
	Tue, 09 Jun 2026 00:52:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780930347;
	cv=none; b=Q9fV5vLyW0GCdHGfonnfONcvbHhSqrFuTVgysL+GxFftbcoYOY1+lCx/Acqh3R14MFERhtkTGka9t5jtHv3arO3uGIc2j/3zeIrWsjIxcNjQm/w0VhDoIK75aqJs/eK4K4CynS5P5hP1UzV2fcMl4siGY5XVfS9YYwecsVgFx04ienydJtt06/Njds+ZdURLueKKkOEIoytkM6PTK7C1AqItewageqml6JxQvpSDHFyFDZ71lOGeM1YmVNgf7/EJAsnJeRhARdnYoqQ8Kvxl0jy9ZwOT04fIqvoFFqY7cwly9Jh8/YYPuH0tBBXJSAoH/SLVITjhVyNfbVRFO1nT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780930347; c=relaxed/relaxed;
	bh=ZTBXjJEF/DsV/qcPFtiUDZ9ungvC+HRp6AGY/SyLCu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu0UJia7eRYYooVcelVfYRRi6heOqn3wVNoe+wlRBm39CBI/PAgv2qBipAh2Nu1V5+T3yYGsSIdGybt/YkWqRQxd6/eX56iPk+gS9Bq+knTxtgYrrsKnvMjTi5T4eN4vby1VxYgV/X6PlQIZ41AgWSn5zJYLLJ0LxF0onp7E9g+sz1OUYnwZlOh3jrriugXYoRihAIewf7XdbHvnNZTNChV0NRZRKw69shKru4z9cgBNu0RgyTKi6kSeOrK/9f3g78DRQlYmvoVqmwCIEVgJC8GmBbdHjaujH7p2n4oQkaILO+UogFXw/3a2mHdgy0JUF2B/iHitfiUqydaR0SOTTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYw4M3Bjbz3byZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:52:19 +1000 (AEST)
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EF34E2028DF;
	Mon,  8 Jun 2026 16:43:17 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	nsaenz@amazon.com,
	anelkz@amazon.de,
	James.Bottomley@HansenPartnership.com,
	Melody Wang <huibo.wang@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	x86@kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [PATCH 60/60] kvm: svm: Advertise full multi-VMPL support to the SNP guest
Date: Mon,  8 Jun 2026 16:42:52 +0200
Message-ID: <20260608144252.351443-61-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144252.351443-1-joro@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

Indicate full multi-VMPL support to the guest through the GHCB feature
bitmap.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 528c8bd3e8fc..0736e1c778d9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -43,7 +43,8 @@
 #define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP			| \
 				 GHCB_HV_FT_SNP_AP_CREATION	| \
 				 GHCB_HV_FT_SNP_RINJ		| \
-				 GHCB_HV_FT_APIC_ID_LIST)
+				 GHCB_HV_FT_APIC_ID_LIST	| \
+				 GHCB_HV_FT_SNP_MULTI_VMPL)
 
 /*
  * The GHCB spec essentially states that all non-zero error codes other than
-- 
2.53.0


