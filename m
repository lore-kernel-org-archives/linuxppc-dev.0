Return-Path: <linuxppc-dev+bounces-25081-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B52C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9hnG6M6Pz2yjp;
	Thu, 30 Jul 2026 18:14:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785399266;
	cv=none; b=UEoo49mFD4PNzFknGO1WsW+nnsidA08Q88bxmFQWhCeWKBPFzMGuSUYC7SKwixQuslSZMfCM4jfQnZSETZ4Pt/tU8MWDtlN762e1qO3oY8psmuqS40FUVxhEdI5sJPC40YPKVOxfaVAIl6wgJuEdwJvt+uLP6jtMlLSIUyr+cypDq30H2l92OgFFs6MBXnId9tIGf43zxHro8wniDh2k2jHpemWYXB5q4LDQ/g/P4nX6Wi/BZPuaNcrqULw5PQSvvx9FwU7yRxZsdjtKGQCvOFRcxCgp/z298g2tXwNbycMbV6UkG3Apgyl6bXhVPHr20ehdYgz2AUKa8o4FHAk2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785399266; c=relaxed/relaxed;
	bh=z5CSwG55YADucmpwN1DahTYwaTO0UaQN77qVWu7jJdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlcNRgXL9LrGG4xczjhkFAigDXfwqv3m72kol89p26DL7p3YYKqc5jM71rizzeN/bMmYd5KN69wOG7bw3rYA2S1nsiqOiQu4Xclf/ULropPSnmHD+bK3KRAkIigZi0jZ+w2Fu2sbXkHMgKLxPrsjbpdZLzIuSHQJz+8bMsWogs8lYdbhOv+MJdakpZhwCYmyQGEp5TQP44GreH1tO33t5n1Um762L5F65Phc1Q3tP7fcYFtXsx1yiO9CMgQ7d0uX0bhnmvo2AnbKab4j2Ja7qq2rU3EGxBmJYSyqkDyi3y4twW193wDwWkxK4kgJmXKhR7a+UPjTaZvWd1ZZ9cv0yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtfpqxMO; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtfpqxMO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9hnD4pBJz2ynW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 18:14:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AA3FC41507;
	Thu, 30 Jul 2026 08:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FC51F00A3A;
	Thu, 30 Jul 2026 08:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399261;
	bh=z5CSwG55YADucmpwN1DahTYwaTO0UaQN77qVWu7jJdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZtfpqxMO3QFI6FhUxbO7MgZno07408HCX2BJ13cnCuh3ST+y4ee4fOVozzS1/seAh
	 QPqyySyPTKLuQTJs27mRwDqh7kMkdTuCFGdyY0VS5igbyXZhp2ggaAIEKJ5VpslOv5
	 tKVz7WuBlUau1LGTw3U5i/HJcOXqYIpKlSOgEv9wPwcjyaJUpZpmPHAFj2r0yIcfYE
	 puphLa9ipeR8KVzGq+JLk7re19uPRuPOQFq6uEj1/kexkaAw6FLNSynRLxMLSPlKzm
	 2DBfZ+TCexWh2rOM3B2+ANpXosCD+gwfVJE37cKKdmIo+J/hJTzfRDt1wDSGF4I9Qw
	 x8fgGgMRdsxbg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kees Cook <kees@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Pan Chuang <panchuang@vivo.com>
Cc: Christophe Leroy <chleroy@kernel.org>
Subject: Re: (subset) [PATCH 0/2] bus: Remove redundant error messages on IRQ request failure
Date: Thu, 30 Jul 2026 10:14:04 +0200
Message-ID: <178539922194.574381.11201940278716774894.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710110930.462109-1-panchuang@vivo.com>
References: <20260710110930.462109-1-panchuang@vivo.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=chleroy@kernel.org; h=from:subject:message-id; bh=oet0d/75qkhExnrQA65w4zG1pGl8gFrf327e7raz+Go=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRls1/4FTg9MmSmW90GaflLi9Rf2n3MfDlhZ2+RoYrtt XsBV2d86ChlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATmV/C8D8jZU7FqhQO9cXr JJR7mR8o9JySPL1IN6BDyUb2Ys3cuY8Y/rsFR/dVZyr252o9WX/zJrvmFLcHRwpyJR/eyg5a2a+ 9lhUA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 10 Jul 2026 19:09:25 +0800, Pan Chuang wrote:
> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> [...]

Applied, thanks!

[1/2] bus: fsl-mc: Remove redundant dev_err()
      commit: 1831c3b0fb726221671ace9b10c760b80dcce597

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

