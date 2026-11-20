Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1C60A2621
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gds1zrGo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW9pH5GJtz2yQl;
	Fri, 20 Nov 2026 21:01:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795168871;
	cv=none; b=moXzgVJQLe7G6lgDVmw0WGoF449GiC4Fo8fuUUtPpbfEX2qDRMMUc4y3eSsIw26R7HJXIjmWqF+HV3RZX207nip42cBbD55Pc5iJ5AWfPPx0GeA+DFTkOJzj1S743EtIkZlUwum/hPyxe2wv5fpcWCgjB9I37V3iUxW0sqB/EwNL6MfKWJQTQBtEJB+39UEkmfxWQxC7mGAPfFjcJWRaw2YRmGNl5gIuOA45y5Q+NYHXiu7MPEucnmFzzovnRpu5hv3cSpZf4E8V4dr7Cky3A0QmuMZ6AraqKPq4Xx7OZFhh/AsRENYWGHGSeNdJdN5NAk6PdiIL3t0wQJhKJCG4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795168871; c=relaxed/relaxed;
	bh=DCpWSp/M5LKclo/Ms5TofKoWj6yGMkGVnhoSpcpUUmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lo/cq4cIciCeBAWnPPFrTtU/gMIjo/BiSFSfC+RvYRzqznOvzRfAL/Wy5RDMHLC6G48P/g8o4lWupVewJtq/pkIx/Gh7dahJ2ix5Ti6Gr0qjSNzZf6S5Qf7dFJQApSJZoBjrzkHXssHIDEQL9dk4KyEQmoEdWzG3WUvmP5H9Nx3ImSTdF0+7E4U+4OmS25zJCCMFfNCHyFAn+j2ts+tDDyXwKxdW26gNKsOKd4xpgqEWZqfunNV6B2ie4p7+wPHGLwGKnzr4V6ZAqjJ8Hc2Uv43L33MwqjwI294Pja1/GSwS9h+gDDGNg62ROXuzFfLLHyLQ5+poBw40HZFcpYB+GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gds1zrGo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gds1zrGo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW9pG5VWmz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 21:01:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2FAC0461CA;
	Fri, 20 Nov 2026 10:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E09D1F000C4;
	Fri, 20 Nov 2026 10:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795168868;
	bh=DCpWSp/M5LKclo/Ms5TofKoWj6yGMkGVnhoSpcpUUmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Gds1zrGokF4bTD5/MTaN4CvuKIDPLDsULAnnljkmdtnA2gZVBQSVYahlnWRnRom4F
	 xAwenH/8fqhDXN5rZycHXGvvMMUGO/N1Htc+Ds8/DSTnTtmhggqRYaTgPwSeVhkx0w
	 ED9EV1r4Vkf3Is+PQUlfcFs2SLHeHhfXeywWGdXF7kbcx4+uOr0FAWjriB9u+1ca20
	 uJu8SjhXefllS1/WQL2GNu6NL9LGjvr17WkFP/h9c3TsaKXWgvN5Y5+612ihgqbgsv
	 ip2g/RAx+8ixPkYQg61/JqWByUeUcUdZSC1iKnzKbc0ExH+/v4jNG0Dfypln0wE14t
	 KFBTFatjyURUg==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260919001931.723402-1-rosenp@gmail.com>
References: <20260919001931.723402-1-rosenp@gmail.com>
Subject: Re: [PATCHv4] dmaengine: bestcomm: use platform machinery to get
 irq
Message-Id: <179516886582.45276.6670084747027138465.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 15:31:05 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 18 Sep 2026 17:19:31 -0700, Rosen Penev wrote:
> platform_get_irq() avoids having to explicitly map and dispose of an irq
> by having the platform_device machinery take care of it.
> 
> This requires replacing the device_node with a platform_device in the
> bcom_eng struct so that platform_get_irq() can use it.
> 
> Conveniently, this also allows getting rid of of_node_get and
> of_node_put as the platform_device machinery also handles that.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: bestcomm: use platform machinery to get irq
      commit: 79e7dc8807afc1bf37861f893c8a0341e4238c3a

Best regards,
-- 
~Vinod



