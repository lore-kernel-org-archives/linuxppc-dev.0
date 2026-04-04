Return-Path: <linuxppc-dev+bounces-19317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8ECE63FE0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 16:55:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fp1t63CxRz2yC9;
	Sun, 05 Apr 2026 02:55:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775321710;
	cv=none; b=NljKQcsiCzm5dbCsctN1XavOJwAhXHQbPttJzncIRM85Y3zyzFLY1nNB7yFZI5GiQt9gYIm/m5kYKpZemNqdSzYSHNs14qzePlJXc6+ofKS1eqHJVIdonbyXxsUgBSIgCj5/kskZhvG+5dFn6MOcXNBusCVkcwe+YKoaJc7b/JkdqSO6bShKNyrr7QBAbrWUN2tl8xPazvQ3zRmqzFf1CBKzherA4dzV/KmcZhNc+zzv8XPlvY6NJaXSB2gJUano/OAoPiSZ4zX1PWyHodRJaWdWtr3jofywiCLxtfEbVjAvEbS5yr1B4nUXjmR1gQkafpsAFACeXRwMvn52tsbdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775321710; c=relaxed/relaxed;
	bh=HbvjPd0m6/ikuD+avdjH27lRW0g49VatVgLv1wio3qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiTYv6UrjF9HIJOusR0ZzD0+H/JHw51r26TtLjR1AdmbOYJ1aqSGRV6/jF0XbNeCk5dwHBXCtqrKXUlAI083Mz4Hp6tqtJD2c5zCJumU4CMQcsDr1KfNqw7FeWUYKr4MdPHFmU+ra2hJCXvNhixPg63WnqBEwbjTGokhWNogRrr+R6j+bJEkmuUbbRTvXir6j+S3x9hx3Dh0No0V5CpiPz9nn6yb966VACZh6j2aaxy3/jvhWYNBKxhYdYy/GSMVTA/OzrLdI57oYTTOf0ADkoZ+RVRgaNecAZpPTBuvwVZz+v2snY3AQRoJFqpwza7acGJ40ZWuhxOLVf5cBkj/XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FChKXjkb; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FChKXjkb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp1t538c7z2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 02:55:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B648960054;
	Sat,  4 Apr 2026 16:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB46DC19421;
	Sat,  4 Apr 2026 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775321705;
	bh=4I0Syyv3vQR+DkrWahsK8V2Eankd+SDEoxUqx0PhEvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FChKXjkbQ9HXPIJxwq/8fSloaJQzCGxXRy8KM0ewDSkyo7gjesdGoSm96WmKlUnO9
	 +plV3F1jJx66t4A+WnqBu4r7b2CNsJcYKUFidrElpGvE8ScyG7ct5Cj6IETlLQbT8A
	 iTk0i1i7SVPV1Bujo2r7ZLn1Y6Sl4LQ8v5IPsh7+3ac/ENl1JiOHloMy0hz7oOwAV3
	 a4oNbco57HKrLQZFpeFuggAOgptyjmRrXkamy+5CV1p5uUIPsmJPct8cbgrJaprs8W
	 32B7Zf+oLyyLPMceRLy2Si4DYPgb7eJ2cCLK2rVdoKmnQzblWOPPyqHipLnkPByTIb
	 gwijk0Mpf2ZmQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH] bus: fsl-mc: wait for the MC firmware to complete its boot
Date: Sat,  4 Apr 2026 18:54:54 +0200
Message-ID: <177532168485.9578.4495513211843642189.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260401144508.3062019-1-ioana.ciornei@nxp.com>
References: <20260401144508.3062019-1-ioana.ciornei@nxp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; i=chleroy@kernel.org; h=from:subject:message-id; bh=cPSyVI1LDIu2D+3WewYFT86CXmllo7aTQdIYGQz/XOY=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRedIrP8RLwZaqOihT5WlJ3ras25liRfPNBHo6o70/m1 HuonjLoKGVhEONikBVTZDn+n3vXjK4vqflTd+nDzGFlAhnCwMUpABNx/8LIMEta4GBG8qIFHpJB H7M+BsZfOlrxQV+59mjO0ZtnHCxaZBkZjpxucbnjf0EhJ7Ev37RF+fDDG/2eXYwn5mb7Gp+4v3g KBwA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Wed, 01 Apr 2026 17:45:08 +0300, Ioana Ciornei wrote:
> There are use cases in which the Management Complex firmware boot
> process is started by the bootloader which does not wait for the boot to
> complete. This is mainly done in order to reduce the overall boot time
> of a DPAA2 based SoC.
> 
> In this kind of circumstance, the fsl-mc bus driver needs to make sure
> that the MC firmware boot process is finished before proceeding to the
> usual operations such as interrogating the firmware to gather all
> existent DPAA2 objects, creating the fsl-mc devices on the bus etc.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: wait for the MC firmware to complete its boot
      commit: 208858b1b48eba83d073542372329cf8ed606526

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

