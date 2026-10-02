Return-Path: <linuxppc-dev+bounces-28749-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC0BCA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 11:04:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx5XR4Vvkz30Cj;
	Fri, 02 Oct 2026 21:04:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790939095;
	cv=none; b=iNLP5L7X+1GAVRmJAoj8tAYUL1ctf4bfRVfrZjK3w/lk4YUCU20MZjJiGx0yOwcd0j4i7ejc0gGFruOWSXvsztBStZK5Ey6Zh2SP8R1BKSxQWmhrntpCJLxhBRXB6pI3KKKkOEepa2Q9ruxO7Q8Lww6QXxlxOuLH+p0m/HWjIkAmFyuL/8mQmhyqbNeuRRWfZ+YASLosK6YF/gmZObF5PvMOQ1Xd0anM1QS0u1oQ3ELARRDCKoM5odJmnbdmvJrU8crGasP0cuEcjN5MvgxrxzkLzMrIPl/qF12zFCoEwl5clg69L7yrS4mOOG1A9AuE0UXRMLKG7t6XKBywqervuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790939095; c=relaxed/relaxed;
	bh=DhtSlGxVpN4gfAt2heOQ6JWTRzQQHHGc/XLa2VbWt84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3N61dq4+QFBATe0eez1XN/0D1+wBQv42MSqeCn2U/dYuuIcWPLMelQ0WVLjMpbis6AXEo/4l9xDLkYxKqJfuiQux8InULNXbfH8qwK4E1QMBeS3IgXeKV2I2w+8xLSNX/PIdZenRWfP19US28AbQCjnerjccYs5PwMeYMmT3cN8+g9Okwo4Wk4YoIvQJcTMKZzvcb5bMKAgdUv3OuXy+VGUkHioff9wlCKxTFmo58clEhZcEYFWf+wTGjBZlCtd+ahCw+aX9scceLGG/Sch/dpyLvuwTc9bu8yLxfYL1Ei3nsCQbg9BIpjZ4yrb6w8Bd7qjG+f53stQ6NW16+Agog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKbeITJd; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKbeITJd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx5XQ6pfJz30Bd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 21:04:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 787C660A70;
	Fri,  2 Oct 2026 11:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D431B1F000FF;
	Fri,  2 Oct 2026 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939092;
	bh=DhtSlGxVpN4gfAt2heOQ6JWTRzQQHHGc/XLa2VbWt84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKbeITJdCzmPeTovw+XZ8kkJAJpKYLDH1Ks+q/vxE+FoY/du4MhtEZqvgorR1ZT6n
	 4Z+EABNUsCA6Qf/3zZzW+1pVBNL7laawoWexu0VNCUDSHWUmGcnOSjKQ7tBPu/fAqX
	 5+sxi11HAKt7afK2aPjA/dXc9MKxKODNOlxnxdk8SvRw2jgmmC4v4eoGyZUC7Vm00z
	 JMPf/FZvtTOFjrKbqBTApvrxuLu9bFl0zJ2mANOBCScPm99dEpxeLJLd7l1g9s+2Vr
	 6wOEKY6UaQZRTtJQZK/f1STWf+0pcaV5bk/fW8IlKvRhY0KdKRgh/EFSd1gLY88R5b
	 xLAq8hohXeR4Q==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vincent Jardin <vjardin@free.fr>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: fsl-mc: drop the fwnode links of the dpmacs nodes
Date: Fri,  2 Oct 2026 13:04:40 +0200
Message-ID: <179093906677.150939.1030233104910633428.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930-for-upstream-fsl-mc-dpmac-fwnode-links-v2-1-13f7b6ef000f@free.fr>
References: <20260930-for-upstream-fsl-mc-dpmac-fwnode-links-v2-1-13f7b6ef000f@free.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=631; i=chleroy@kernel.org; h=from:subject:message-id; bh=ILFrlKdhUCWpzIUG4as2word+u2G/Sedm4tKKOcL2/E=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTt7z/rwCgxLzfkVHOUx5uClVeCVRs6zmz8+1zQwuSza tzj8CXtHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAi6Q8ZGXbOF1kVwbapjzF7 A+f2i/PeXF8sscpw70TmkL8C0hkP7F0Z/vtosnRs2bnfaIPwno3abAsi7n/Ksn6ySN/3qsKTg7U VyZwA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Wed, 30 Sep 2026 22:15:48 +0200, Vincent Jardin wrote:
> A DPMAC node under dpmacs/ is never the fwnode of any device:
>   the fsl-mc bus creates dpmac.N objects without one,
>   then dpaa2-mac finds its node in dpmacs/ at connect time.
> 
> fw_devlink therefore attaches the supplier links of those nodes (phys, ...)
> to the nearest ancestor device, the fsl-mc bus, as SYNC_STATE_ONLY proxies.
> 
> [...]

Applied, thanks!

[1/1] bus: fsl-mc: drop the fwnode links of the dpmacs nodes
      commit: 31053c50487aa7c5fca9a139f28edb35287a1f45

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

