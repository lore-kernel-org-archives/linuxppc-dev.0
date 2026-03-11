Return-Path: <linuxppc-dev+bounces-18051-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641E6104BEDB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:39:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW6gD3nXyz3cGS;
	Wed, 11 Mar 2026 21:39:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773225544;
	cv=none; b=YqW8RBbRRYpV0617kBN1XD6Y2cR7sLSc5ADrodQPC4qwBXY5sD1gIkG0+kakUR/Gga6mx/c8n7t9CEPq1kt8LXXK0F/YxL8HwHq9lI28yPkmiFTl+gzKnB/7JlzmSAKSNI10dsJNttREMAkR2bZhC/kc2QgLUpbTWwuNVa0hSjfANcDCq5yCelTRaJRWig0QoiM905JxXanBdwyPhaRue20PlZWz6FuEt5PrKfuVCqQeG1QBw6xIO5KCEyq1o6PhyDjTwfCJr59f/d89vdFibn9B0eSzQRyv3PDo+vY+nTnKjkIksmCSr8TvhM9ys3ITUvlcn2GZlGqoA7E5iqziWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773225544; c=relaxed/relaxed;
	bh=X/BxnOsKpXyJQnekkvYf+o8NWkmGy4DjNnbucwVbsLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzPtkv3kkKyFWddAplP/yCtMG8V0JDCT2i2/jeOGC+4JdTLCXKvr/u8eEV4GWaETU7jDVdCqwpKtnGyrsLp1Wx9Zeb5RGVk0OZTu5nTzRroJGtPMcRVDm5/PwZScCYDN9UAsk1LwR1Kyp6s9y7TThKL3qdRiwZC3NN8KAzIgAB9UqFuKOXGoKdhasr9mh+9zCwNq/SZcfiv+f2g3B2Q6K6+dVtW1rf5gmK1+mmmeGTng4ZBEz14sjxY+wY531gQJ6BsjUoCsZr1qf2e+jOJKFce/LUF92EMrpm6NlKfzEBglSm+FdQnRZUi3m5uNymavTqGAz1eJ0O95TvqFxPGsrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EPXTMuVt; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EPXTMuVt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW6gC3rYVz3cGL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 21:39:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 98527600B0;
	Wed, 11 Mar 2026 10:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4256C2BC86;
	Wed, 11 Mar 2026 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773225540;
	bh=W7ULGNJxGs/DGU9Myuy1oXiG5LI/4bcuMikaWvPhafA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPXTMuVttZqUZ/o7JPPcYnite3Um4wggHLpvXqpIoWuC2usNA6k425SfK6rMs77rB
	 CYWeP0jsQTNUcUIy8PnTh9S3O1nsMJGjNBhq2Dq0SHWq7cP3w5ZyXyw9RdDTA3R1eW
	 S440F5uh0GmInYEkvybjOxJt938zdDJqpyKVdapOCNKsje+vi1+1YLP/xkfpiLNDws
	 05TBCJ8PNE7rD4f12++HjlcvSoHkNaTbYC0bbQKnbCiOof2KrsmYEZaZiY5R+JFXdj
	 /8xPc+/68mvyzrREgIspZOqMj2/RD7sCmgpK/s0D84g4YnUN/WpSgEaH93P51o62GI
	 KrW++eDJAd9HA==
Date: Wed, 11 Mar 2026 11:38:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI: endpoint: Introduce pci_epc_bar_type
 BAR_64BIT_UPPER
Message-ID: <abFGOoZUX_vexLWR@fedora>
References: <20260302095913.48155-11-cassel@kernel.org>
 <20260302095913.48155-12-cassel@kernel.org>
 <dtxdgxrewfby5hu3cu3pu5kljylm627uc43sw75gk7loimmm6r@ei4w6wmqgd6a>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dtxdgxrewfby5hu3cu3pu5kljylm627uc43sw75gk7loimmm6r@ei4w6wmqgd6a>

Hello Mani,

On Wed, Mar 11, 2026 at 12:05:59PM +0530, Manivannan Sadhasivam wrote:

(snip)

> This also brings the question, do we really need to mark the preceding BAR?

From a pure code PoV, marking the preceding BAR is enough even with the
current code:
https://github.com/torvalds/linux/blob/v7.0-rc3/drivers/pci/endpoint/pci-epc-core.c#L101-L103

However, the current documentation claims that the succeeding BAR must be
marked as BAR_RESERVED:
https://github.com/torvalds/linux/blob/v7.0-rc3/include/linux/pci-epc.h#L207-L210

I want to change this to BAR_64BIT_UPPER / BAR_64BIT_UPPER_BASE, so we can use
BAR_RESERVED for BARs that expose fixed hardware resources (e.g. eDMA regs).


Thus, an EPC driver does not strictly need mark the succeeding BAR with anything.
This was done mostly for clarity. (E.g. with BAR_64BIT_UPPER_BASE it is obvious
that this BAR cannot be a standalone 32-bit BAR.)

If we don't mark the succeeding BAR with anything, IMO, it is less obvious that
the succeeding BAR cannot be used as a standalone 32-bit BAR.

But... since the code already does the "right thing". We could simply nuke this
part of the documentation, and drop the .type for all BARs succeeding a
.only_64bit BAR, if you prefer that option over having a dedicated type for the
"upper base of a 64-bit BAR".


> Why can't we let the PCI EPC core to always assume that if the previous BAR
> has 'only_64bit' bit set, next BAR cannot be used as a standalone 32bit BAR?
> 
> I find it weird or redundant to mark both BARs.

Redundant, yes, but in my opinion marking both BARs makes it unambigious
that two BARs are used when a BAR is "only_64bit".

E.g. Manikanta originally wanted to add code comments for the upper part of
the 64-bit BAR:
https://lore.kernel.org/linux-pci/20260217-master-v1-2-727e26cdfaf5@nvidia.com/

Sure, we can just skip the .type for the succeeding BAR...
But is that really better than clearly showing that a "forced" 64-bit BAR will
always occupy two BARs?


Tell me what you prefer:
1) s/BAR_RESERVED/BAR_64BIT_UPPER_BASE/
2) Change documentation and drop .type for a BAR following a .only_64bit BAR.

And I will respin with that.


Kind regards,
Niklas

