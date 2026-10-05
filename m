Return-Path: <linuxppc-dev+bounces-28927-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3539CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 10:43:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hywwX2ddRz2yDm;
	Mon, 05 Oct 2026 21:43:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791197020;
	cv=none; b=bnpyW+fjgmom5HKkE3THE8LlIzxaTgLeHKDdK7307RZTZnb8N6xOlfWBYvit143ota57wh5TFrAn44UWIMXarpQ7qpHcnbjNauwXChc+Ystqw+2wdtyr7ms6LLrR7MVLdrkAS6zX6WUckFA1ny5WPmkrdBPps2COaddCh2Q2Jszaf/8B3EKprgHbIqT7bBdSnzz99wjlqhHLit3YgRtaGu6NMc41tAwCMMhT1I0wxgm3N21LKKgQRCDT/177OaLliwTG5ji9al2ftFcnRx91dVG2e/KBocQJIgEHf3pNZDEej9Bfw9olGvyBHHyYla5N67jv5yY3gWlWTvrt4TMLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791197020; c=relaxed/relaxed;
	bh=UE1ia2+Nnud8lkNlwJM2jeNw6p+Ex5NbnOjwL06Qys0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGbQyAQMnHGT2XTfikAORHNa5I1vumk6NL7xfJ/LuO+beqM4wz888KTzEx9cfaxTzEInXeEJ/O/ti2HivLFhBZgLQLv5V4pRkv/zMDKt9wAB5brS6/auI++3nJCvL52yTgHwTAxYbWpoOvedsju5fbF313lnTltHh4hmkCE5a+AKReAgEV/8iTpwwATZ2PxaU4kaJHPItcuiw1FJbtMOUaqze+Zcn+gJB6MS9k8RozWq2rMOLl+Rc/hiXOYnpgosB2Nn39zPgdOy0aUkv6lLn9nJQ1PPMjeEx34thdI1p4z9CkjJpt6zIUydZdiiBApdoEA2atO93BPmVsyJ4namDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbDtHklA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbDtHklA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hywwW2zNmz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 21:43:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9443660A6F;
	Mon,  5 Oct 2026 10:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92031F00893;
	Mon,  5 Oct 2026 10:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197016;
	bh=UE1ia2+Nnud8lkNlwJM2jeNw6p+Ex5NbnOjwL06Qys0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WbDtHklAq128TTT3jUfClAR3xWOifVFJPEnubk4AizHnxIh19nAdiBH00borMMGqb
	 MAByAPlZgwLeHr29YA1AU3O1TrkOcGP8mkFJ77PQAefyTWj54GNmaJ6dsHYSAVvuhF
	 O7/xIkhsHbhsIrTaLqeX/r9UCJs4OQdtwHfaQ6srnFxfRdv9zj4I7r+4qsD/y98567
	 dz6LKDD+C5PGOiwV7+J+fdUI5btnNGAIIjpsZQOSuXg2UoLwqLLEIlHUZYPe4wTd64
	 aolLoU0lhO0Cq6uPtbMKV+YBEjXPTlioPWrLJM1iCBBlPSdL5aJcjUBfY3VFs78swS
	 iQYCnEjoBAsDQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Myeonghun Pak <mhun512@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] soc: fsl: dpio: Fix IRQ cleanup during probe and removal
Date: Mon,  5 Oct 2026 12:43:20 +0200
Message-ID: <179119699110.180542.13258001668157935133.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002194802.375497-1-mhun512@gmail.com>
References: <20261002194802.375497-1-mhun512@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=783; i=chleroy@kernel.org; h=from:subject:message-id; bh=JwNYDRoRQhU9WQin3CftpaZ6xeoE0xQIsjPgxSQIBJM=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQdrveyvLVe91fb/K1b+vZIn2RcyCvKuOO23mmNkocn9 xxs6Fgq0lHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAm8uoeI8OzmZGPhVU/fPia Urxe8uK9vqSF5slLv1fx/C26nXtn2fbHDP/UnrerP1ip5bfrmxavl+KEKbdXqs//mverxb504nO z8tdMAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 02 Oct 2026 15:48:00 -0400, Myeonghun Pak wrote:
> This series fixes two DPIO I/O object lifetime issues during probe
> failure and device removal.
> 
> Patch 1 releases the I/O object when IRQ registration fails and removes
> the unnecessary unregister call from the probe error path. Patch 2 frees
> the managed IRQ before returning its resource to the MC pool and before
> releasing the I/O object during removal.
> 
> [...]

Applied, thanks!

[1/2] soc: fsl: dpio: Fix cleanup on IRQ registration failure
      commit: 899559907f9d8bce0720f6d4336b2871e83957ae
[2/2] soc: fsl: dpio: Free the IRQ before releasing the I/O object
      commit: c4ddf1eb1d321e40d82fb89d34b61edb3f927198

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

