Return-Path: <linuxppc-dev+bounces-18165-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B43105F783
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 09:23:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXJtb2S95z3cJk;
	Fri, 13 Mar 2026 20:23:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773393783;
	cv=none; b=beM+4lgFbXBGVD7bYYXFgbWz+vsHkA7GupNZQZayo7Ftjc/YwMHEt+a+zfZghJuOlvP5EQvUOSRKVgMhMTm/lh5Jm7pbknZ7EkcGMX3NGgc0SGwviahNBaF+s8aCZjFyleSV4+8rvDzM74xDvazLViTLHD+le39Byt5RW2WRk7ji+yQ4p1e6MEMpgUvN6Z2ivqJMs8hrKuDlwAth4uJgbzmgRxL3k6QZcaofxgAZqlosv9GQPFtDrZpti8rghJu2v4H4q+R42Rkyg3jpxQePCFCUqSPp1c0aLrycEIlI9kZKvj0J8U3J/tVH0GKR4vFwUcHhllNpwPwBqs2eAmwJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773393783; c=relaxed/relaxed;
	bh=X5QnXfVQ0hqJvfUwJ7gOEOH7kwY3Eu5ATH2Q/qu+Ugo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngvn9CcSj0hPQ8NqQ/EYRu32WNfqAxDBvSLDFO7cA7dBB5A6xgZAueacdgRUvYp+lY0p8l0jHLWC+ThjHCXJQxWKhQWMzQMhMr1B6QsXFejllPKqzR5ETVti51NjfgqtbUEBhcKKFxQ1+Y8fuY73tYal9JA/UGcWVm1fBp48e2hRuqxvWCfCVtnlyf2/uVVKn6bjwgrv3lwUX3h0Fr9gyfzrzSdID64IMxb67LqaPpaFwttR3C37VrQLF3ePEb2v9QqUOqPy3fCwPNygOJ78YAKMLO0zZuCZQTHaOfdJ0uBlkFahakf5fRmXtap/qA063Cn8Tj6bbF2HPp4xTvA1ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KP5AFQsV; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KP5AFQsV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXJtY6XWHz3cGf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 20:23:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 38F8D4347E;
	Fri, 13 Mar 2026 09:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B8DC19421;
	Fri, 13 Mar 2026 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773393779;
	bh=OSkNcbUS9YGvPKDa8n1+2Deyv3usv6l4sfKN/25R4mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KP5AFQsVD2fnagL9ktzranuODnZj5yec3IGDn8dCtYe3/snhvHtHl4hCuJDk5mIFX
	 XTi/wT2P5RBqBcwVVK9nopqfH93px8aj7zV3cxTXaMox5XwwKQhJr6ATgMV4ahilsI
	 wa5hi4eh1jsInBssCel8lPW4fKrsAbdJ0wHbpL84=
Date: Fri, 13 Mar 2026 10:22:48 +0100
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
Message-ID: <2026031332-widen-unpack-1f6f@gregkh>
References: <20260223-soc-of-root-v2-0-b45da45903c8@oss.qualcomm.com>
 <20260224183832.GB3239922-robh@kernel.org>
 <CAMRc=Mft5vc-C8miKVdw6C-qRdYsqfgm-UgLZJOctFwagMF0iA@mail.gmail.com>
 <2026031231-whiff-speculate-805a@gregkh>
 <CAMRc=MdhhEMJn5JTB3wn_ScmV=a0o6fTnaUDSDjOLN5WH5rOFQ@mail.gmail.com>
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
In-Reply-To: <CAMRc=MdhhEMJn5JTB3wn_ScmV=a0o6fTnaUDSDjOLN5WH5rOFQ@mail.gmail.com>

On Fri, Mar 13, 2026 at 01:36:49AM -0700, Bartosz Golaszewski wrote:
> On Thu, 12 Mar 2026 16:18:38 +0100, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> said:
> > On Thu, Feb 26, 2026 at 10:28:26AM +0100, Bartosz Golaszewski wrote:
> >> On Tue, Feb 24, 2026 at 7:38 PM Rob Herring <robh@kernel.org> wrote:
> >> >
> >> > On Mon, Feb 23, 2026 at 02:37:15PM +0100, Bartosz Golaszewski wrote:
> >> > > linux/of.h declares a set of variables providing addresses of certain
> >> > > key OF nodes. The pointers being variables can't profit from stubs
> >> > > provided for when CONFIG_OF is disabled which means that drivers
> >> > > accessing these variables can't profit from CONFIG_COMPILE_TEST=y
> >> > > coverage.
> >> > >
> >> > > There are drivers under drivers/soc/ that access the of_root node. This
> >> > > series introduces new OF helpers for reading the machine compatible and
> >> > > model strings, exports an existing SoC helper that reads the machine
> >> > > string from the root node and finally replaces all direct accesses to
> >> > > of_root with new or already existing helper functions.
> >> > >
> >> > > Merging strategy: first two patches should be either acked by Rob or
> >> > > picked up into an immutable branch based on v7.0-rc1, the rest can go
> >> > > through the SoC tree.
> >> >
> >> > SoC tree is good.
> >> >
> >> > For all but patch 8,
> >> >
> >> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >> >
> >>
> >> FYI Rob also reviewed patch 8 now. Who would pick the patches up? Greg
> >> KH? There does not seem to be a centralized SoC maintainer in
> >> MAINTAINERS?
> >
> > Sure, let me take them now, thanks.
> >
> > greg k-h
> >
> 
> In the meantime Geert sent an alternative to patch 8/9 so this single one can
> be dropped from the series.

Ick, ok, I've now dropped that one commit from the tree.

thanks,

greg k-h

