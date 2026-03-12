Return-Path: <linuxppc-dev+bounces-18123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CAE106703C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 15:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWrqV5737z3cG5;
	Fri, 13 Mar 2026 02:18:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773328726;
	cv=none; b=O4bdfrmd7acm1VR95xjdob0XRwehGwYrGycgMjg+SkjMjZsoUdYrneoB/eO6TeEPa7XiIZYacxMIbbeG/hV1MaV0ceHJ0nOEMQN4LGa/xtvlt6u3nR7Aj6z0MV/GfdzV7RaAXy+I0zxNulz+shNX4dgvFErKcM0jDHSyfsOrUcJeaj4gVZi4Qu7e+49ReaVr+SRCsoonJCRqACX8Ls0oesmdFuVquM0Hmh3uZqKlZwLroDG6EcO5TED5akR3qSgp8a5ZzWmv0zvLyKxFw8Gv9aNxwZ/9+R/DTDVVgJXphwLEhDWsJewffXsZdc+8SRpC9dGDZRj/60Vi7Ko2oUQOag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773328726; c=relaxed/relaxed;
	bh=hRkr9tlQtutDgkuphlYmn7fRBgJ/GwVX/ag0J9/X/gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI2LxVpPQj4FJH0xlSP1G6JbdRuz/vXR9L2tpBTtkX07TRhJc7ises5LxL0viBKe6XItGsrJQJCTs8nYXm1nM2pY4UjDn951OTlw2T4tDi+iamoKI5JQrg8MBSlzi0XLVx215z6B5YpCPPaB0ZwiCG3+2/6+xA2woIjKTa2B6Embgd1WAIarWaYwVgqx8n8x9pb4xqGp8L+h1XT8RTOEIEOIl3ccYa7U3yExXwT8LqVH1orP2akd4v3jUAMy7HQ1yYhC71M1KMM+2GtKAGdby59JtBKvBr0VSjsAW1nz8OCJSMDUMlAV5+Pb2CqFIyM5qW5c5uN8mIkdXjLBwzOTsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=V1k65cmJ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=V1k65cmJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWrqT5GjQz3c9r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 02:18:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4452960142;
	Thu, 12 Mar 2026 15:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24701C4CEF7;
	Thu, 12 Mar 2026 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773328722;
	bh=RU7mCgn4p4aFt4z17AtB/HzQEKVXpAiuBbfZS5Sysa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1k65cmJmmo+ZdpjbsNZv8nsCPVPi61VKALCKXZeOdH3/KVdSz+l5mdTs2j4pTFLz
	 TjGA79gCGU23W5C90XwC6e0xdRba2zTRj0weRhQoxKvJs12V/HeNxVa41VKe9AjWPv
	 fXDGMebsWeyd/6rYWviq9pQAuQImG1jFn3xPJpkk=
Date: Thu, 12 Mar 2026 16:18:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev, driver-core@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 0/9] soc: remove direct accesses to of_root from
 drivers/soc/
Message-ID: <2026031231-whiff-speculate-805a@gregkh>
References: <20260223-soc-of-root-v2-0-b45da45903c8@oss.qualcomm.com>
 <20260224183832.GB3239922-robh@kernel.org>
 <CAMRc=Mft5vc-C8miKVdw6C-qRdYsqfgm-UgLZJOctFwagMF0iA@mail.gmail.com>
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
In-Reply-To: <CAMRc=Mft5vc-C8miKVdw6C-qRdYsqfgm-UgLZJOctFwagMF0iA@mail.gmail.com>

On Thu, Feb 26, 2026 at 10:28:26AM +0100, Bartosz Golaszewski wrote:
> On Tue, Feb 24, 2026 at 7:38 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Feb 23, 2026 at 02:37:15PM +0100, Bartosz Golaszewski wrote:
> > > linux/of.h declares a set of variables providing addresses of certain
> > > key OF nodes. The pointers being variables can't profit from stubs
> > > provided for when CONFIG_OF is disabled which means that drivers
> > > accessing these variables can't profit from CONFIG_COMPILE_TEST=y
> > > coverage.
> > >
> > > There are drivers under drivers/soc/ that access the of_root node. This
> > > series introduces new OF helpers for reading the machine compatible and
> > > model strings, exports an existing SoC helper that reads the machine
> > > string from the root node and finally replaces all direct accesses to
> > > of_root with new or already existing helper functions.
> > >
> > > Merging strategy: first two patches should be either acked by Rob or
> > > picked up into an immutable branch based on v7.0-rc1, the rest can go
> > > through the SoC tree.
> >
> > SoC tree is good.
> >
> > For all but patch 8,
> >
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >
> 
> FYI Rob also reviewed patch 8 now. Who would pick the patches up? Greg
> KH? There does not seem to be a centralized SoC maintainer in
> MAINTAINERS?

Sure, let me take them now, thanks.

greg k-h

