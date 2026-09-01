Return-Path: <linuxppc-dev+bounces-26348-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FFEC61DFD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 02:09:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYq7T0hbFz2yps;
	Tue, 01 Sep 2026 12:09:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788228597;
	cv=none; b=mZ7sTbJZ7/fTgp//aK0EP6HvWGthNmOmBBnVYHTHkRlEdHZCJNmyx/vg53fx5TrFkLxGvGeeZz5WR5TzK/1THDyn8w7zEbFbnDR7Hho3mrDzKToyJ+Dmh1fG6maYqUhIwbqQMlTz9GM6nI0Ogg5lVhvroV9K1l0YYNeOQkZDVHFWqO0rhecR0s4fz5zWOqf5ZlRrx9jwA/bReurP0m998957TpWhGqTaA/uI4oa3VGfuC+m9sQ/31ED3hw+9Eb2S/ye4IFRKptnDaCEf07TsrHENVi4sSU4zj+zXjQ5wfrdK2SPz3PiFH9T1YFaetIl/HV1k1eCtTcF6iT2ZzqyrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788228597; c=relaxed/relaxed;
	bh=R4ecXQO9vqNzXOeLVTWPt4EelG5cYusY7/xAh/+zYqA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2v+iv7ok8h9xDFwdHgO83pVHzsOP2utVSnkNgmvwOHC81Ty08q8m1KspDaiVzgmGXm8FtkqXOyONWUTiimnYF0houWz/vDDsuzEzPu/seT1Fk0Z3Fba74GuVg7vrGXFWc6A3tnf2xs6F2eGLqVaiJr68y9tmTHK6YpHMEr6AoMduIBeMAIl2WczEzPV61Sxb3VmNL0oGoxNS0H9GDAcqTHI0NB0RB2OWkpIVFYMcPnX6vo7OpHPNTfTiydDdxpiPiWFI+dpT+2Pk4i079xvm+oc4/qL0xciWq/SuNU9dpmc4upmUCo78zAgP0ndzelNh8IWi23GWOVAqxoO0iDAAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmxFSkD2; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=andersson@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmxFSkD2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=andersson@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYq7S00sJz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 12:09:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AC032602C4;
	Tue,  1 Sep 2026 02:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A476B1F0155B;
	Tue,  1 Sep 2026 02:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788228593;
	bh=R4ecXQO9vqNzXOeLVTWPt4EelG5cYusY7/xAh/+zYqA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=TmxFSkD2YCDQouxFmPH971PgYOqSEV2vSyQpxt8rtsUCLoj8DDSnAsxeLNFc1Y/WP
	 fWaNooKbLzCqmNqcJMgo/9tsuldIwoBJVX8hfq+P+D1rh51Jvg0AIqfUSPkSwnFXBk
	 TkAW7TzUwFPA4Ih1R07fWPX4Ohm150DERZSF1R0UX6XrvLxqfaBQlV2HO6H24yeJ56
	 nJwT1nlZhfXANy6prsIETo4v0wkXz8pLMAn1tErzAXp2sPrFP450iifYvMLTYCmnOM
	 QNfFJw9VL6GaeCTK2MV9EOptRZFEy62ni/3zRtxaEFV+Ud2yDG8HUZaVW79Bc+xRXG
	 5l2vcvhSTLZqQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Roy Pledge <Roy.Pledge@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@openwrt.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Gary Guo <gary@garyguo.net>,
	Sumit Gupta <sumitg@nvidia.com>,
	Rahul Bukte <rahul.bukte@sony.com>,
	=?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Subject: Re: (subset) [PATCH 0/7] soc: Remove redundant error messages on IRQ request failure
Date: Mon, 31 Aug 2026 21:09:28 -0500
Message-ID: <178822856264.1835959.6354603328430924135.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720095920.542801-1-panchuang@vivo.com>
References: <20260720095920.542801-1-panchuang@vivo.com>
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
Content-Transfer-Encoding: 8bit


On Mon, 20 Jul 2026 17:59:06 +0800, Pan Chuang wrote:
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

[4/7] soc: qcom: Remove redundant dev_err()
      commit: 29b96e2769def61531c19aa537f5a3cf3ef38e41

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

