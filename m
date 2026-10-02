Return-Path: <linuxppc-dev+bounces-28760-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20647CA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 13:36:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx8tt5Rbvz30B9;
	Fri, 02 Oct 2026 23:36:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790948166;
	cv=none; b=fvTS5B1wGArFXhsyUF7FHu8Qx3mcxe7CV2cjCAQPbk/29xHVbingfPihxZmdilYLftSq4wUp4EnTsqfMJ95ZBx0c/8yfhcvbIQnC/r57gCx79niqhB6p5YMOuEt3FfsqEdgHB8quWX/BzMV9dKF/sDvHxjm0399wAcgMnSq8976MZk050Re8cWuL6XNucltMWPSnPx4mS9O59Ennm18tTZwMXbdq+fcDP1p2WlC6OBFaqfTDPlX5hS93JpJb47lB+E2QZy3pqF6NDgLBZzvr4WT0tmEBHK8Bi/NLFa4I9BruOHf6gdkXC8lxP7fr/ErMR6i7J9Aa6kbAzq2F6EzglA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790948166; c=relaxed/relaxed;
	bh=yjbi9/c1VrImWNtJEnP+BlHeSMxTK9lWfNpXD7dyXn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7kSBf5/kj2etDQ0CdPmu3vpQVgqnOojr4hpgrZJ8+JA9xJF2ETPh/PCrzpLIzPN+RjCU3yK+ySpeU8RS74l2BuwXFFNwM8rQlgxAK87tbKgyA3VT6g8ukepmvmyn7TjRZphqTkzx+U45GATVJxH2Rwcno+XB446W1NgLjNKkIfaATsNJHClmhdD1gYlF1oSps5ub7xkS3Cc2I9v3VTWT7SXWn3QCSIIY9moCRTqVIGZCeRq1ec859I0oPOa2Fzy8XXYet/z8BmRscjj6dfopo5v7HKlbIP93UT/+1winAJaHoPLprWZdfjfeZ224MS13snj4WSB8nfHO0slGd9dHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBJpr6EE; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBJpr6EE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx8ts30JKz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 23:36:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0175860A8D;
	Fri,  2 Oct 2026 13:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AB41F000FF;
	Fri,  2 Oct 2026 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790948161;
	bh=yjbi9/c1VrImWNtJEnP+BlHeSMxTK9lWfNpXD7dyXn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DBJpr6EEspHlhw3V+cgQv5AtHdoUAjDZ+NvGoFmXvakvXHMf/y8FQaUlrebt+chyu
	 qOlXWV2L/di5rTJ+TGwrrwrmdPkWECJ+/oiAuRTSH8DmKVZtEWv/TwUpYOdTuVLBkt
	 jxk7RrvHHtfcHMjymiP+flXfKrFqsu8qLCBulLgxQ8TD/97axXTX/yUJvsEhw1AoCd
	 l0L9/TkJCVSSZnCKxHFmoOltPP9y/UuwAC6egNNM0A99rTaPppXLIkyRqevCf/7SCV
	 C3orf732YFpueQK+jI5XFvyst54YP82P1vmUWbaruSCvAhynt5o8zykhiRSWMelPkw
	 7Jzsw6iW4HAgw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	codemender-patching+linux@google.com
Subject: Re: [PATCH] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with __counted_by_ptr
Date: Fri,  2 Oct 2026 15:35:47 +0200
Message-ID: <179094814058.161441.1021426703218235186.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922223538.2287676-1-morbo@google.com>
References: <20260922223538.2287676-1-morbo@google.com>
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=704; i=chleroy@kernel.org; h=from:subject:message-id; bh=FzGXoQmG9DwM4d/cV6mXr3MHN7XZR/N+SpZKV92FTfw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTt32zsfK8k2dpj28ZjnnFLohdU2pRd+5TqcqyrJDI3b vUXpe8cHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAiHxUZGfa+/OR2M5D9n7zJ p/JtUo8OHXt4eN6Wb6kzV156+Uc+jPU9I8PMHUsEJ+pZJjO883r71Cvuqn7FVFXjJ9Of2C1ZUBB /JZIPAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Tue, 22 Sep 2026 22:35:38 +0000, Bill Wendling wrote:
> The GCC and Clang compilers provide the __counted_by_ptr attribute,
> which is used by KASAN and compiler bounds-checking to detect
> out-of-bounds accesses to pointer fields.
> 
> In "struct fsl_mc_io", the "portal_virt_addr" pointer points to the MC
> command portal virtual address. The size of this allocated portal in
> bytes is tracked by the "portal_size" field within the same structure.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with __counted_by_ptr
      commit: df0fd0f5af4ddd84a76e21da8e6b489928c5e300

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

