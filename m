Return-Path: <linuxppc-dev+bounces-23822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384DCC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 14:27:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwL67579cz2xpn;
	Thu, 09 Jul 2026 00:27:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783520863;
	cv=none; b=PY1MefKZVnQecRzwNalGInt+UJ9DuFrX3m+9DfLTRaL0dHZXx9GlC2CBNKLWTV+9srD26OFW9LfTFPfS4bZTb3KTWmjbaoScWVPrTGsKJ42B/iXkE8nidqmpwEEONWYr9vk6eFJIQsCLwlkfT7+U1WGbUVr1GHsNYkNqJsHMtOVcvet7AypZOnSpXk7eighTSn30smXITvzG9+XiJsybBe9L+395tt23WLga5awUwflLgd081CUlf7gmEuC27rnas4r39My4ByT1k/w9zwzl2VHZXfquAjQHhhr1tbt84I0AfTDiCVHqPrRdKY2cW/wLf1aqPDmKRZAVoRegJBKAKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783520863; c=relaxed/relaxed;
	bh=G069rs2BbsmgpmEyNXCNFwIMLK7A3UzeN4Nnul8nixQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QCnXrhKaUWEqC0VwP2geIvoNPL3rdfrgrh+Iu1fZsdT2Ge3UX9gthQPdI8HcJuiBDhbB+M8vjHH/suphP6bLsQ4IowxpHRZDDhZJnuEPsY+kD5ThmX2ulUwFpBNgtb2CVr/NvqDBYba61Qvh18YS9VOlEnDmr6er6qQOxJHHtzC6LMi18bfLHGeWdvfRXE4FM9+KgEQIu6WBMyUuLihWOBlBdpL2Kvtpyh6lCT8Xzez68NHTcZTm0wwVk+yyNRLljNXBXQa9PkN4b5afMhuteVMfyZdcaRpN3Z0iKw5gcgUW+oYCQZz/JjD+EA/tlS8djq5gXbSkc2lPw0u2vl21bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIxU/yUG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WIxU/yUG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwL65241dz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:27:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4D51A40C30;
	Wed,  8 Jul 2026 14:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083501F000E9;
	Wed,  8 Jul 2026 14:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520857;
	bh=G069rs2BbsmgpmEyNXCNFwIMLK7A3UzeN4Nnul8nixQ=;
	h=From:To:Cc:Subject:Date;
	b=WIxU/yUGw+3l01erNXfQqIx7/oeaVm7WAa0SWPeL+XKiZJrPmV3Q3q2vmne7sPKBa
	 MAKMDi8puClJKWQ1ZMjt0mbgclmyvSEis1+kTgdB9wQjaIFJiEJKlSxx5lvmbq2ss8
	 oOLXuOYr/x4Vegw/zrTmmj9y1c8nH2p90Ky1JqTs8i3+ZNdujiyUWgNhAe3yUcr/Yp
	 J+fSQ0ADootCnWF5ZPoCMALkZ+sUWYnXYJwyz0tslbJ9Eizcl5dvigzjI80ecnrpUJ
	 qSB6duNhYC7qKYRMVvY7nqqQ8foN2NtYy0ImrcFBt98lC7iJqcY3Og97KH0I6Qn0ug
	 BBxZcy9k+jdrQ==
From: Michael Walle <mwalle@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Borislav Petkov <bp@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	David Heidelberg <david@ixit.cz>,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] powerpc/configs: enable CONFIG_RAS to fix EDAC support
Date: Wed,  8 Jul 2026 16:27:02 +0200
Message-ID: <20260708142725.2113684-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Before commit e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC") EDAC_MM_EDAC
selected RAS, after that commit, EDAC depends on RAS, but nobody enables
it. Enable it in the config again.

Fixes: e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/powerpc/configs/85xx-hw.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
index 2b19c20a9a2c..6b8471810143 100644
--- a/arch/powerpc/configs/85xx-hw.config
+++ b/arch/powerpc/configs/85xx-hw.config
@@ -90,6 +90,7 @@ CONFIG_PPC_EPAPR_HV_BYTECHAN=y
 CONFIG_QE_GPIO=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_RAPIDIO=y
+CONFIG_RAS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
 CONFIG_RTC_DRV_DS1307=y
-- 
2.47.3


