Return-Path: <linuxppc-dev+bounces-18398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67791088E42
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 22:24:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbjzj6hFcz2ygK;
	Thu, 19 Mar 2026 09:24:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773872657;
	cv=none; b=hEzvHKXbg7qpCSqdkE5YL02PsJ1j8W4Srn62hgTgNt0TGDKUpmknLRy04a1ThcbyCQamDQGbPwE5mB4cU5avBp5ecjuRYnYUuwTPYCg80D6B+J1FKeAskfirS1y5eC1w1y0MV0HKUfhGXsX0I/IvefaCcWEOzp4GwX8yAtmhd5QPcp5T62ZgEcFDLQQxRP6yu/gFozFQvauJ2z7nrlJeH9tXJTsXOehpAym8eL4wCqN5odH9dcbJIzSFnh/NZHgUY75yt0rTB2fZxW/qy8KjLrAJ04YO8XczCKp4LlFyTuXonD8thHVOOFR/WO96jNk5xLha9f5Pd5oAZbeqUxKDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773872657; c=relaxed/relaxed;
	bh=1myLUp5Tc1S7jlKg7VBZyHnNtLYo0bwBC2G3B53l9os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2ciJceqWHEMlcrEXkSQ1Z9r90HQ3Hl/NXDHko6GkRRVCN7Phl+t3Rbs58NZV1e/6tSC6XyVTDNmCNY3O13K5AbiJ8zBDVYlg+fGjnafaTLQdL0r9eNzOQnveSUSNO/c/K9F9j2ZEvJYNDSm9xYtJVfc7yOtAxTsoI0wjbOcjQIjRglrVoFi7sz8QAzq0KL7LtuESPpSRkFKn2ZTeXlieJ2Ou6mfZqzDp70Mu3BMbjUjwcUxCVEUh5sOxRkCEFWx7jg15Sc5hIv+jk4RoWGtR0UdDbORGcKQLKDuSwtPRd2F57f+5WQSD7MiMnW4aE5wKUVZ+diaTKqqJQBeHXKqxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OUAwZl2m; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OUAwZl2m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbjzh6K8Hz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 09:24:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E6CA416F8;
	Wed, 18 Mar 2026 22:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BC8C19421;
	Wed, 18 Mar 2026 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773872653;
	bh=h6ndzAFvIQVHqH354HE+77ZIUYrbNgvOw6/MHKSXkcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUAwZl2mzfE6ZOYdjgXflyKsVp07YDgb/YHhAMsj6KAffhy3k44djep/2i4RjEsDH
	 DgCO455CMfC5YLsj77FsAcijiCBVU3b59EcTx/x4Kr74UwesFclFSemVn0HmwAWIDg
	 /IzFB520uDimKtkJ0sqtTcXd7xJYan/Ow23b3Yqakompc8vBYgW3JoTimW47hLJR4B
	 +eFGnHcP8jwuKGDnTJyJai0Of7NfJ/0HF0AeJjbjSZKWcdtn2EzLQcGsAWnKZtY5fu
	 WHYwaN4C9dnWdiUHWDmCYIM+8Yfcsv37Qz+K1NxmIvA9Az7Ygs7dPwCnkawFsehwDx
	 9RJQ2HPwFHPXA==
Date: Wed, 18 Mar 2026 15:24:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Simon Horman <horms@kernel.org>, wei.fang@nxp.com,
 netdev@vger.kernel.org, xiaoning.wang@nxp.com, vladimir.oltean@nxp.com,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org, krzk+dt@kernel.org,
 frank.li@nxp.com, claudiu.manoil@nxp.com, chleroy@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 imx@lists.linux.dev, pabeni@redhat.com, f.fainelli@gmail.com,
 linux@armlinux.org.uk, edumazet@google.com, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next,13/14] net: dsa: netc: initialize buffer bool table
 and implement flow-control
Message-ID: <20260318152408.002d1bd6@kernel.org>
In-Reply-To: <3dab3f5b-fb94-4c63-bcfd-aad4268e2ac3@kernel.org>
References: <20260316094152.1558671-14-wei.fang@nxp.com>
	<20260318145452.1898637-2-horms@kernel.org>
	<3dab3f5b-fb94-4c63-bcfd-aad4268e2ac3@kernel.org>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 15:56:39 +0100 Krzysztof Kozlowski wrote:
> On 18/03/2026 15:54, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> 
> Why are you removing the "PATCH" part in the email subject?
> 
> This completely messes up with the filters and causes this email to pop
> up in places it should not.

Sorry about that :/ We pull patch info form patchwork and for some
reason patchwork uses this notation for the "name" of the patch
when showing the list of patches in series info.

I'll hack up the scripts to fetch real thing from lore.

