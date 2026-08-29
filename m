Return-Path: <linuxppc-dev+bounces-26177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EBBC61DD6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 03:35:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hX18z3jZSz2xnS;
	Sat, 29 Aug 2026 13:34:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787974499;
	cv=none; b=N/WQ3SdYOSVyaacDRiy0FK0Q5fOlPE9PUINh+7JausOICwr0RIZLmGg2hXSJ5s+RFqQNSKxzBCRcBcm5KSMj1EwIDuUXujjeGE3C3KxilDcTr4U3cOCWqGMoqL5hIsnrQ5/r4t5WPg8Z0WqXGzyaIGto8URPDuz3NK6wXIz4bd8K+8hnpG00k5xfYUspMREuBEcixvYGjcCahJcGhDMt00jLIN9udLiVRRH9YLlt1HY11rgqqMLTyp64X1IQoQnFlelNEPXV8zxpVSgEqs/Mm9e6nv9cGyGriBTFNnwtqEHQtb2MoM/ijkE39p4BJcwa6yJuoUNPlEpCx46EVn+Syw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787974499; c=relaxed/relaxed;
	bh=kCzIDdL5g+UsBlRYny58cWjdyNu57PG7/tAMQ/Nw7gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjbBwxp6O0+XPWSfnJXbZHhmYLxGoCNiocOuioWzjjNnke22YUv46d0TFSl7Ekf6L2Gy6ZEKKqWtDa8jexfPNWGKj8Zg25jomHkqRewYqOZppgNUhqXzMlEAD9Ja+Yz/8ZXSCHHhT82v8fLyvFhUsaRMXPOcoJlEcNgQBCUsLvaKWuWPoyhOJjpgZFc0H7Gsgtc7JuEmbZzT0QpMFuTgc2cuo3aaTGim6XFAGb4xN0cKmlUPi9sN6TELeGKP3i6sqm1uTesL85rm7d71RV6Il8Gw35mHxkGTe1Z54O/lBLUpYNShnotFlQKGPUTJVPcbAO4HmBRr6JkzMpsoqYKm7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWToiR6+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWToiR6+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hX18y4Kt7z2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 13:34:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C423641763;
	Sat, 29 Aug 2026 03:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D701F000E9;
	Sat, 29 Aug 2026 03:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974496;
	bh=kCzIDdL5g+UsBlRYny58cWjdyNu57PG7/tAMQ/Nw7gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TWToiR6+eShgoICjqfDpPY31kZtXMa0guvWcNUghDfUjW8k57rRBGmartntVVSjd9
	 JCfP9CrMNX6JHPNv5ra+Kvpvp5U7O6qIdpa+Op5iEBK7D9DNlRm13KFAB0v4G2hmGT
	 KpQYC01HtQiFfZ6qepHjlIpCYvRcTP9kfL/VNs5y6r+cWiV/BiP5AuTG9h+8hsMBtD
	 rs9O3g2CGF0cHkQohKCISzBSWVvB5fPRNIJIkF/oQm8WrKBpuxpuPWiPbQ93qPq55+
	 HzxbpVa8Tfm1ScGq2PtgkfEeU4uUEry/77sqiLQO+HSiWKh9P7zdqMNeiJt3LnQysU
	 FHD/s5egXLQwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 6.6.y] Revert "usb: phy: fsl-usb: Fix use-after-free in delayed work during device removal"
Date: Fri, 28 Aug 2026 23:34:41 -0400
Message-ID: <20260828-stable-daily-0010-revert-fsl-usb-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <32dc704af59ce1a137f076a1bdec4f2aa0034463.1787901681.git.ralf@mandelbit.com>
References: <32dc704af59ce1a137f076a1bdec4f2aa0034463.1787901681.git.ralf@mandelbit.com>
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

> The reverted commit uses disable_delayed_work_sync, which was introduced
> by commit 86898fa6b8cd ("workqueue: Implement disable/enable for
> (delayed) work items") in v6.10. The function is therefore unavailable
> in 6.6.y, causing configurations that enable CONFIG_FSL_USB2_OTG to fail
> to build.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

