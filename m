Return-Path: <linuxppc-dev+bounces-25091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682B0C54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 10:56:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9mMx6jncz2yYd;
	Thu, 30 Jul 2026 20:56:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785408973;
	cv=none; b=XvL7cX3ZN9ckHlkFjQFDtI5hzOgYw8969wL4RSAgu++HQPbEqtHrnSy8DAbCF6CQugAbIjC9EpznjnRHzXre2LYIyBslnJ0ULWMU9rRCurrCvudNp3prW1lP2QkMT5fodIc8zFvUG6AXfz8Qx9D+zui4QGit2ozd1uMhlPgVWD6PbiE39bpfB2oNZ9YzdEwfWvKQOKk6ABQp9tzuokD0bUi1tQsTUqSnTvC8vif86chRV1YkNA4JVajrOr3vIO9mhDti8qQ/6tfvXMqEAe4gBM1Vh2EPjQVXPmHAWGt/tCZeU7JRtgKJq4vYFHJuG5Z9k5JyXus0gsJOUYhR9Znc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785408973; c=relaxed/relaxed;
	bh=gmdoyhDQ0F1lIF+Ps/wT3taC7ugYELp2GdpkWLxhc8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3tSAvZBfGI/mAMcOChnHeK7y4i9GHuGnFb0MJjKKtP7OeEuLoau6LOBT17fn+kCJQtvayBEQRuEyeZGm45ip/qbHuq4XALi6OI3RGRcP/u/kAQWbY7mH7RVEJq0T/JzrGs2pKZ1OF5tFhAkgKbT6KQZwdYUhh+ekIShRIvS1+fi3tKOeicTJgDHD04PDDzN2cHRYcnK4F6JTkDnn3aJnHp4CT9wDsbfJlc7/+rBr1EGUPSPq/reCxRynwQu2fo3IC4TnHy/ytQxpQoGQ3xp7AouH7gGmkZXu+H/BiIl3PB41RgJYGlx0jq3WfbpZeSq9B+7KtA0MGh17ZDuLL4PaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yhla/gSG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yhla/gSG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9mMx18v7z2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 20:56:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 37F92439AE;
	Thu, 30 Jul 2026 10:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85551F000E9;
	Thu, 30 Jul 2026 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785408967;
	bh=gmdoyhDQ0F1lIF+Ps/wT3taC7ugYELp2GdpkWLxhc8s=;
	h=From:To:Cc:Subject:Date;
	b=Yhla/gSGJGzEVaMnOFoF3aZnqCxOrMHG591x8d360300GFIuJG3Nj7j21wKAKlMxz
	 pDzUHOelNu000gdr5hrNA/23GscWo9eDyzYSYDynoFXIvAObwdjINgfabeenbkDFSS
	 NL4iQ4Ac31OlvSl5rc1uF59FNLxfSRzxJ20rgyJkZ0hY4utC+QLvImnWS4kdH9eK3q
	 R1itAus5bX4cpo/kCmGeIQoBhYasgbgJKQHfrWVH/1/qVJMrUk+QLDlOoeCxvwAxm4
	 uhbbqJZpYIdoB/UigGqZtTHWOfCdFwvMwL2kJ/kUukqOXqPqEFVsn5Xp0ECxsakg9E
	 nms8BRYwba/sA==
From: Michael Walle <mwalle@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	David Heidelberg <david@ixit.cz>,
	linux-edac@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH RESEND] powerpc/configs: enable CONFIG_RAS to fix EDAC support
Date: Thu, 30 Jul 2026 12:52:18 +0200
Message-ID: <20260730105546.3658570-1-mwalle@kernel.org>
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
I've missed the EDAC-CORE maintainers before. I addressed Borislav,
but it (apparently) had a stale mail address and there is no mailmap
entry. Hopefully, the patch will reach the right people now.

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


