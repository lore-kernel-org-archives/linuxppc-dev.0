Return-Path: <linuxppc-dev+bounces-25261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783C9C55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 13:05:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDH3B0kL9z30DY;
	Mon, 03 Aug 2026 23:05:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785762326;
	cv=none; b=lTnPxFmD8z1/ADGlddFqB2jflZd+KpwhhlcG3YxAnbRXSZbOoaJVMh1ut1LOUueDwPmmOFde+72oE3h7TnwEGV+U0SN1B0y8nTFrTG7LCe0DxgMPL+P4iq1XWQoF6FcJwXPfsafi612z+3WUnQvLQO+6NJNCXQMDTi64CuxtAe1E0ngNg6ARVYM4LANh8dSUHDH3zeta2aF7Qj4A9aKrOcciKYAu3B0h5h6+TZQTbkC3sk35KJsxaP2K/Y8W2uHsluQfJvi6XUmIMCuD2GlvqgSjVz0R2PjEp6r8wbs5Xch7Kfz3qP5LzJqWMIxgN0V4o+jzJjRRep/I7o7apQUiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785762326; c=relaxed/relaxed;
	bh=BZP+7X3Uw5ZiqZ3CWxhIlqmxPiDSX9P3cuwNS1v6h28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wy0wwAb4ZKaKyXTRT7JogOXOJPXmufvXMTZTdCy7qhNTyLGd9eczvBilROIzkNxB8qaRbK2c8aCqEUJQgxES1/ppKwVGm0zjng8cVh4rV19ZTpWBEm5b2D3SW1qTSDEpBf5mnQmhQkxtHhb0nkV4Pl5hUUtD729XP8Nc7JtKkrFQKTLF8X88KZYdUXJMsIlUnTQG61GJBbFX1NjvWKMqd1R+4+6U6T/Jt/+fXPZ45HF/50gGI3HBhCvxS27HeHU9AdWpY9AlCqNIVsh0B5qFPrTUs/j6bYohnrnPl6NmC/TTTm24OTkWOx93N1OcWZl+aJblT+yEo5E4q6naAk/iIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4GcgWSk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4GcgWSk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDH390Tgsz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 23:05:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 60AA841B42;
	Mon,  3 Aug 2026 13:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209181F000E9;
	Mon,  3 Aug 2026 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762321;
	bh=BZP+7X3Uw5ZiqZ3CWxhIlqmxPiDSX9P3cuwNS1v6h28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M4GcgWSkF5genYsVaSXBZ3AMIxtPWql/hNVnqEDY+FEZTO2CTFXyYeWn/5eRWkpYV
	 MEmHNqCGPLfZY3H6sPXh3wvhb3dcaghqWZNdH97WuoI+cxHXT1AEKVV/IsoKWU/lrF
	 roJe6Jsgt2WY9Wji19Pp7dBQrR0mPbzWPvXSbRLAs6tFX/RfP4tuKWUSE7sltft8ZM
	 5Nzc8WwOb1pXknvLGJtOvt36QC4YN0BvlIhDwLnWZyF9TNJcYp6lhHyDVugCxx6afE
	 10hKu6BRks1nYkWsUxEoob59+0z5/fK4NfdmVf3nuweQc2oncWNX4m2pv5IyhsW7qc
	 7vgIiHQnZ2tpg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: RAGUENES Jean Noel <jean-noel.raguenes2@cs-soprasteria.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: qe: implement get_direction()
Date: Mon,  3 Aug 2026 15:05:01 +0200
Message-ID: <178576221776.155079.14811751064714928381.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <30b3f278a10b46252783458c81dc438df176f86c.1785405882.git.chleroy@kernel.org>
References: <30b3f278a10b46252783458c81dc438df176f86c.1785405882.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=383; i=chleroy@kernel.org; h=from:subject:message-id; bh=IrBaPxnph4YWN6xCAfs0TkjBzFIy+/PMRzuA4pYF9aw=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQVTGLccCD81pRn7Av/J7fduq5Q1K0Rf5/D9R+LlpNF0 V+RW5x3O0pZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBE/LIZGaYmGVlJi25uOTL/ Yf/204tnpr0sfeHmmrxGbVe/9cnEFXMZ/immvJ0i+EtmeuxL1vg4h6W8DzPdbsk+35PxoCx9o1B dFicA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Thu, 30 Jul 2026 12:09:40 +0200, Christophe Leroy (CS GROUP) wrote:
> The lack of get_direction() callback in this driver causes GPIOLIB to
> emit a warning. Implement it.
> 
> 

Applied, thanks!

[1/1] soc: fsl: qe: implement get_direction()
      commit: e460ef309f44b39480209970f1dd462f051d6f30

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

