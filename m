Return-Path: <linuxppc-dev+bounces-24871-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A85AC5321C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:18:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7vgt4YYLz2yjg;
	Mon, 27 Jul 2026 20:18:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785147514;
	cv=none; b=b761sroOuZG/Dw2Rr8AS0HX9dVdId6fOcgyUjJvoPSU8G3XgLfhSXd1djThmVaiBmPJBW9TP5FzJenoQqJ68SPNg1Q+emNrb4/IwgDM/42OiQsuhpNg6morjttLsANf78QRwVXv6aBUywbfrQhtyGzLMsI6sV8+UWCqZLdKDPbEx3aV4ZDwACND3gg9WzNWaoGWkR+webHESCak+8A4N8Tp8/xTfwlbNEbkymVljvz5OQmgnh1EWeSxbM8sN6uSDsZl3oqLIuSPDqsV7WLsKAQsAHzUrnItuStmUIkshEecJYADQie/bY5coPOrSDXf//3jQoKBsKniRS8VjqkhBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785147514; c=relaxed/relaxed;
	bh=dYQwJyuPm8mudO0A82O+YdFMew2F6X5ocyHqJKJlVts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCSJvqxoRCEaeNJk3HnFEebIWcy3U6TqAGDjWlbxZOrJYRW/andaTQeeS5GsJfuu4iO21lxGneOrnIdypnPzdk797H2eTpkPZqclgWrEYJotHy4fBCrZbu6Xag32fjiFreNE8fsf9kEbtK7aUzvesJvZHKQ9tlQWMdDjKXfrztBOiEMjJmgFFQ2GACGuEWNrfe/DQ0PLClSYKdKxZkls6C90RuoLolOAQ6gyIDhCQs5O5fD7SwUa3Xblfa6M+QZ+BiyQLz/V+ONIAdfzC/7YKLX9Z7L5kyfrRRmMdD1lBnyy/P17FFkurzPZmT/sU/yuGW8EBT8YnadWmdyxqDfbZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT/ip6M7; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT/ip6M7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7vgt0hGvz2yhb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:18:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 14D7660A6D;
	Mon, 27 Jul 2026 10:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC941F00A3A;
	Mon, 27 Jul 2026 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147511;
	bh=dYQwJyuPm8mudO0A82O+YdFMew2F6X5ocyHqJKJlVts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KT/ip6M7L+3VK1XpOBQn7hYOugi9szjNGfpYyqJ0BoSqVMihiw0Ma0Vp1rmeXkxsw
	 ezt577ls+SXAzVcmlwtmACP0uGuVzXPBKsp6tQrYjts1pROtqXgBJ9YBP2ULo4KWuS
	 GXifjhDzV4srf0ChfpaO7sUBECKTUX2S6YNvByfsz4nTx1a1mwBVHGtwCDGeiItdtw
	 90fSLMz7H5tq2cT5sCkjG6+T4P4vkhGNwxyzQsD2HPoxUbvWN78lty9DOQbBU2Lt/a
	 qsCF9lE2KqhoAQ5rI06208fAY1kH4qDKr++Ez3D3YG7/U41CxejmY83IEqWXFTM105
	 JraMshIDVPGkA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	david.laight.linux@gmail.com
Cc: Christophe Leroy <chleroy@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH next] drivers/bus/fsl-mc: Use strscpy() to copy strings into arrays
Date: Mon, 27 Jul 2026 12:18:00 +0200
Message-ID: <178514745085.65524.5154457607232721554.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608095500.2567-1-david.laight.linux@gmail.com>
References: <20260608095500.2567-1-david.laight.linux@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=398; i=chleroy@kernel.org; h=from:subject:message-id; bh=axsqdnFVyozTb7QT2kt9d7xybmK2/K1u7HJn6I4CUT4=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSlGyQ5hnLK1M0VbCy2akn8f4LthAHL5WX+enyzXivzM TZnMXl3lLIwiHExyIopshz/z71rRteX1Pypu/Rh5rAygQxh4OIUgIlc2cbwh3/dbitrpTkSv1ax cF2xt5x8Iq/MMdoy8llDxbcuw3R7MYb/Od4S82bY9GepO0xaeGe9U96utvX78/yWK/7ziazepd3 JDAA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Mon, 08 Jun 2026 10:54:56 +0100, david.laight.linux@gmail.com wrote:
> Replacing strcpy() with strscpy() ensures than overflow of the target
> buffer cannot happen.
> 
> 

Applied, thanks!

[1/1] drivers/bus/fsl-mc: Use strscpy() to copy strings into arrays
      commit: e0bdf39890814b5dd5481c8f9c80c5f8399fa6cb

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

