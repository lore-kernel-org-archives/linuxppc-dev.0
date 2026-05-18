Return-Path: <linuxppc-dev+bounces-21118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AE0CD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 14:24:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK0SQ1rN8z2y7Y;
	Tue, 19 May 2026 00:24:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779114294;
	cv=none; b=OfUrU6+7W+BM78GOtFpjtI/CZkJ+9LWl4lfppjgjOaJVmrZzdNnvqsxT3uFzBYymkoN/Fd3zbrFx3UEGBp61VoiLa0bzlvz7F+Vzot0SZlauK6FUyK2RKSGPcUhQuDppkGvODEfnmtGfvpz6NKFMGdnkJ4aBcl93poL5sDsgJtmxjhUT+MOkAGo3ikuNhxhQtpOBFZ2HnV9PvH3RG8KaOgm5+HpcD6qSkYXPQ7oVVcgAy0jhH4qnMJnwd9SEaYlakSDxbVK+IQF193Z3/+NsdWwQxOzikuPaZIkGQ+dWRVH4tNiPpDYJrTIjGtvIvzMVriN79/SgXe3h+eGz+cXwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779114294; c=relaxed/relaxed;
	bh=Z0Dm7Bwbwc9xXwKezX1v6HRSth4UWwHEasG4a/Lc+Ss=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcAc9fD3qE17dqQWKdfSxAu4NtXVB5BSCFxk9gN5ih7zqQgyTlUpOozHSfk5FXHY7BrLFeOJRGvVrRCLMF1KF3hO1WRZ3umyS+1vO+vIZ3McmGhcpEeLcbQI8Nii3ckoFb+dgxXhtpJ1zb2vGUGPNPh8C9zikWdYYJBUn/DQ2hC269mWDTJy8NIBlHazQFzdPjKEIgq0DEMY+C1h7nIKagabngl95Hod27cFglaYaVVWyB3xKmU3wyFy29EXMYsU+fxqLCJO3ybSLMh8/i9y7AClrxdF/ftKRRwvgcKbx4pp6u4nyLE0DpMXO4e9fnLT8uxNkLniOHbhvYC2OHVUuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A3cPUUO9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A3cPUUO9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK0SP2GYmz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 00:24:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3FF50601E2;
	Mon, 18 May 2026 14:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AACC2BCB7;
	Mon, 18 May 2026 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779114289;
	bh=NQzXUWfuik4p8/X6Mq+YKIxubdBZwsEPXwN2WjUJQNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A3cPUUO9olszTBpNAQhMjSpIuuA1s3Y44RXS4EigvVEq2l0Ue1/e07joDRjyR5+27
	 nV/BUtBB2hFos/OW2m4jTbU68py7zwyhl+6QCIJI7dWPLxiFUthPtRPzJJHK/MjzYo
	 rXYd9mK5qwR4VgHEGTY6f30ywiYCGl7Hq53NH0gazaQm+WVr8miMjMgLTjGk2gDwU1
	 OQN7/kYkC5SMmtt/NpuLhvxD76qvbb6HkCLk1hunb7qGPmCZ2ALM9h3G29tFK98fur
	 7m7aagKlKjWkUEk+RfrrWMGFWmrvsfFhftpDxeuHK6cynzb+4lfUKKSvHBxpEAi6hf
	 RZU5xdBoUIh4Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wOytj-00000003Ygm-2eqk;
	Mon, 18 May 2026 14:24:47 +0000
Date: Mon, 18 May 2026 15:24:47 +0100
Message-ID: <86zf1wx0b4.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/6] fsl-mc: Move over to device MSI infrastructure
In-Reply-To: <4f34dc22-8dd7-42fb-8c16-4e359faf60d6@kernel.org>
References: <20260224100936.3752303-1-maz@kernel.org>
	<177209938125.547814.7154250802402503122.b4-ty@kernel.org>
	<87v7cva080.wl-maz@kernel.org>
	<4f34dc22-8dd7-42fb-8c16-4e359faf60d6@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
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
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: chleroy@kernel.org, arnd@kernel.org, ioana.ciornei@nxp.com, tglx@kernel.org, sascha.bischoff@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 18 May 2026 14:51:48 +0100,
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
>
> > > Do I need to respin it?
> 
> No, I'd like to avoid having to rebase again. If you have changes to
> the series please send followup patches.

No follow-up patches for that particular series, I just wanted to find
out whether I could start posting additional changes that do not
directly involve fsl-mc, but that are prevented by the current state
of the code (such as trying to move the ITS initialisation much later
in the boot process).

I'll postpone my changes to 7.3, and keep my fingers crossed for this
to hit 7.2.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

