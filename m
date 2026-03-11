Return-Path: <linuxppc-dev+bounces-18072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9520D1125857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:13:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWHQ52Vn2z3bnJ;
	Thu, 12 Mar 2026 04:13:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773249197;
	cv=none; b=NVU6BGv6XyZrWZlt/W1rVN7PcZJwzB2jclHcQ3haCkJuUxLl0gw3a3Xv0vVVH/jK1L1fYCeNzuPydRQ3kaHo7he6wmD/+dxdl3/krd12+IHrIfTnkB4zcUe65ne3FZtu+Is5sTaMZeoQh+Lfrv6XlvEChFHgA3OoNLK9/Ay/Sy792GFlSyX50Vfm/A1T/9UTur3EtvXY+ZPumt6G6ZcFvw26JGPgxl1p6z6R66DSJRYxBawcReB5KaWYj5nxlsw1EGEOZCHBlkFRb620YGGhLCAQjxWcu85HawZseekmuvKzRjoiexh1Mnii8UYc6MEJiqYQof0VYDbPoNWTEOOMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773249197; c=relaxed/relaxed;
	bh=9LVSuSaXQ9BgK0Bmfla/t/18Rpzx3jf4FXS7kg3VvUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbhN+Ac14XqFePSwXU4NMcaVSUhl7n+Bcrl56PAJSENTUkLzA57bVww3PCC8JUnqKh0ZAAtDQ1B0FsCzgepU7mRewulbGw/qUzBXmhEI4A7qg8ncPVW5fnjud5fZiY1pp9529oq/2koogS5JhaO4DbJljlzHJ/pxMYaYVvZiEVh4mPOg8i10cRYzYfkV9osH1OBIV/h/gg02yj8PgAc9u16f0ds7ap/93kagPh4TtyjYZh50XJENA68d3NRsjDps0M2MtoSy0T0N7Lm4tYvUlcjKkLnLYUBgpEmDbL5G4y7b4GAeHewWF6H1JJi1T5xdZcWGIVDUlP1tOGKSmpu6kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RcjXj8/D; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RcjXj8/D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWHQ418yMz3bf8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 04:13:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A6184055B;
	Wed, 11 Mar 2026 17:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9331FC4CEF7;
	Wed, 11 Mar 2026 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773249194;
	bh=HnZ43XwIpl7dh8HMwqHbhWOqb5h5K/qibXtHrWYtI2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcjXj8/DHiK3t9Ki5/dVU994YOCV7pkhmvdfHpP4Ni5RfLuvggNyoukzjJy+iUcM/
	 yYF4laxETNu7z5UX4GLlXBVcBKhNJCJHqn6mM3E6eHbZq7wMw2ouAYu1SN2ILjvQYw
	 J8A0r77BE53yNF+8d7rbvjB6vSmCFGwqsiLHpGE/KW2Dt37kEJJc9RlFVidiyXemGr
	 p5YdhtPe4yojoe38FQJsWiCJ6ye2eC5KbXlgTUSM8cF8v1rQrqBC/ZvzQa1rfEeFJm
	 k4tniKn4qUAyyWP4hNn60exginXUH7wdQa2jvpFX2LMzC2CHmbNC5do1atv2h6UAyW
	 cn5vNsYhBsrUw==
Date: Wed, 11 Mar 2026 22:42:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
	Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srikanth Thokala <srikanth.thokala@intel.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	Koichiro Den <den@valinux.co.jp>, Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI: endpoint: Introduce pci_epc_bar_type
 BAR_64BIT_UPPER
Message-ID: <6b6w7ni62ty3oimj3cwfzyv75evslx2vhojp3f6rpnbxtamv7g@o35zul3tkbrf>
References: <20260302095913.48155-11-cassel@kernel.org>
 <20260302095913.48155-12-cassel@kernel.org>
 <dtxdgxrewfby5hu3cu3pu5kljylm627uc43sw75gk7loimmm6r@ei4w6wmqgd6a>
 <abFGOoZUX_vexLWR@fedora>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abFGOoZUX_vexLWR@fedora>

On Wed, Mar 11, 2026 at 11:38:50AM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Wed, Mar 11, 2026 at 12:05:59PM +0530, Manivannan Sadhasivam wrote:
> 
> (snip)
> 
> > This also brings the question, do we really need to mark the preceding BAR?
> 
> From a pure code PoV, marking the preceding BAR is enough even with the
> current code:
> https://github.com/torvalds/linux/blob/v7.0-rc3/drivers/pci/endpoint/pci-epc-core.c#L101-L103
> 
> However, the current documentation claims that the succeeding BAR must be
> marked as BAR_RESERVED:
> https://github.com/torvalds/linux/blob/v7.0-rc3/include/linux/pci-epc.h#L207-L210
> 
> I want to change this to BAR_64BIT_UPPER / BAR_64BIT_UPPER_BASE, so we can use
> BAR_RESERVED for BARs that expose fixed hardware resources (e.g. eDMA regs).
> 
> 
> Thus, an EPC driver does not strictly need mark the succeeding BAR with anything.
> This was done mostly for clarity. (E.g. with BAR_64BIT_UPPER_BASE it is obvious
> that this BAR cannot be a standalone 32-bit BAR.)
> 
> If we don't mark the succeeding BAR with anything, IMO, it is less obvious that
> the succeeding BAR cannot be used as a standalone 32-bit BAR.
> 
> But... since the code already does the "right thing". We could simply nuke this
> part of the documentation, and drop the .type for all BARs succeeding a
> .only_64bit BAR, if you prefer that option over having a dedicated type for the
> "upper base of a 64-bit BAR".
> 

Yes, let's just remove that comment.

> 
> > Why can't we let the PCI EPC core to always assume that if the previous BAR
> > has 'only_64bit' bit set, next BAR cannot be used as a standalone 32bit BAR?
> > 
> > I find it weird or redundant to mark both BARs.
> 
> Redundant, yes, but in my opinion marking both BARs makes it unambigious
> that two BARs are used when a BAR is "only_64bit".
> 
> E.g. Manikanta originally wanted to add code comments for the upper part of
> the 64-bit BAR:
> https://lore.kernel.org/linux-pci/20260217-master-v1-2-727e26cdfaf5@nvidia.com/
> 
> Sure, we can just skip the .type for the succeeding BAR...
> But is that really better than clearly showing that a "forced" 64-bit BAR will
> always occupy two BARs?
> 

To whom are we showing? If it is a developer, then he should understand that a
64bit BAR occupies two consecutive 32bit BARs. The flag should only be set for
the code not for the reader.

> 
> Tell me what you prefer:
> 1) s/BAR_RESERVED/BAR_64BIT_UPPER_BASE/
> 2) Change documentation and drop .type for a BAR following a .only_64bit BAR.
> 

Let's go with 2.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

