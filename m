Return-Path: <linuxppc-dev+bounces-15974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00F6CA5FF6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Jan 2026 11:03:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvncj2xg9z2xSZ;
	Mon, 19 Jan 2026 22:03:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768820597;
	cv=none; b=ChcBUgACfXG528U97Ob9Cgf8eSscNb6kg8x74QzEpOKCwgazU5UOpsAvQD8hEl2G78KvJ6zoA5TmgqMnQzRgZN+Nu8i7NuEahlLfaT0IGUR0e6y67mb3SCcwM+TrGn9yf2r4kyKuHwu7kNqhmbph4PVKbs4zifl9z/5x4ClAVXgTFrIjSQOJPVlVY/EYpXxroh5iwwtdQ1BmCxiNAVuq0OKj15EAMS5zc7r78UenZ0jtfxTUkUVN9O6mwcWa84pFHKkQT+rpx8dJneK7AI3U5VL9pEyRuyMdGPG8u8fLf3oAE0A91ZUfuQJLWJVBP5DTlPDUtVyYg0o/YvOA4PW6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768820597; c=relaxed/relaxed;
	bh=3eeu1NoLap5pNHeOyVFOwLQY4O5RAV8xxm6CRPXLCCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSKecoAae7v77IaFRjP3dwLsR0ZEd0FbFLJIuisL7C31pnMz+hHgtClYj7PrcV9vdQhbhBo2GHH7sT2XE9TXTMrj2rCLJ22qqgx798v5BNCuwAFLMgZefDBzDo8SQFe3K/VuDh8oJW4VHtmZdKC8tpjCpP7nYImxb9bnA6bjVyecfxa6Va75NqfA6zaLqiSDt+78DEHvwWNAZO/Zdax9VsSQhzEev9Isb340lIza43rEPoL0W3o4jQhV2ujLZh2Laj29/6gIeHoN8q0o98KIVfAToGZrPOP/ZkMyohvbk25U1jumSgjxyz02dOYBFXCfwR4eKP3jifmjzDv79PAlPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U4pl0ofF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U4pl0ofF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvnch47v9z2xHW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2026 22:03:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C4DC460140;
	Mon, 19 Jan 2026 11:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7800BC116C6;
	Mon, 19 Jan 2026 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768820593;
	bh=Mt0lTtW0SXUZ+bfiJxVUlnJJ2N4AYGqAw+VCdzmAl/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4pl0ofFVaZCWtIpWJuGDssLs+2l2nRdSBXVxh6DBcRX26quEJJHUBZTwC44GHoYU
	 Sq3KC8JHsAD2+9OD17hTSWRkgCPsL2XoZOgE1LIPMtGdrDJmK6bgGER6XgwtSO3VZs
	 ThFtbVqn/JDqSueZGKjpbzJxoaTdLR5M7m2QsV53lTG++FOzrXWIUHwOHZU0KECT9W
	 cVGuEJwW7PmX+lXcVYQ1dDPeuEkOtWecV4nFkcsYEUAgQf9U2VH40udzyT1pKMnPvX
	 QW8lrTHNl9UJPMIZtkdEAaBSnysDMlF7KWo+vbtJHtdW+gMOl2YDSTr+H0R+NNLWvw
	 GZo3UpMCsJcnA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vhn2I-000000000vD-10Ay;
	Mon, 19 Jan 2026 12:03:06 +0100
Date: Mon, 19 Jan 2026 12:03:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Khalil Blaiech <kblaiech@nvidia.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-actions@lists.infradead.org
Subject: Re: [PATCH 00/12] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aW4PajoKqmyjkciY@hovoldconsulting.com>
References: <20251223-i2c-printk-helpers-v1-0-46a08306afdb@oss.qualcomm.com>
 <aUql_tZisfH8E1bq@hovoldconsulting.com>
 <CAMRc=MeHL5=s=ciUjHGw_poKpeVMWVi_2LBDFY_ugvXBaaE0vA@mail.gmail.com>
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
In-Reply-To: <CAMRc=MeHL5=s=ciUjHGw_poKpeVMWVi_2LBDFY_ugvXBaaE0vA@mail.gmail.com>

On Tue, Dec 23, 2025 at 04:11:08PM +0100, Bartosz Golaszewski wrote:
> On Tue, Dec 23, 2025 at 3:24 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Dec 23, 2025 at 11:02:22AM +0100, Bartosz Golaszewski wrote:
> > > It's been another year of discussing the object life-time problems at
> > > conferences. I2C is one of the offenders and its problems are more
> > > complex than those of some other subsystems. It seems the revocable[1]
> > > API may make its way into the kernel this year but even with it in
> > > place, I2C won't be able to use it as there's currently nothing to
> > > *revoke*. The struct device is embedded within the i2c_adapter struct
> > > whose lifetime is tied to the provider device being bound to its driver.
> > >
> > > Fixing this won't be fast and easy but nothing's going to happen if we
> > > don't start chipping away at it. The ultimate goal in order to be able
> > > to use an SRCU-based solution (revocable or otherwise) is to convert the
> > > embedded struct device in struct i2c_adapter into an __rcu pointer that
> > > can be *revoked*. To that end we need to hide all dereferences of
> > > adap->dev in drivers.
> >
> > No, this is not the way to do it. You start with designing and showing
> > what the end result will look like *before* you start rewriting world
> > like you are doing here.
> 
> The paragraph you're commenting under explains exactly what I propose
> to do: move struct device out of struct i2c_adapter and protect the
> pointer storing its address with SRCU. This is a well-known design
> that's being generalized to a common "revocable" API which will
> possibly be available upstream by the time we're ready to use it.

Revocable, as presented in plumbers, is not going upstream.

> You know I can't possibly *show* the end result in a single series
> because - as the paragraph before explains - we need to first hide all
> direct dereferences of struct device in struct i2c_adapter behind
> dedicated interfaces so that we when do the conversion, it'll affect
> only a limited number of places. It can't realistically be done at
> once.

You can post an RFC converting one driver with a proper description of
the problem you're trying to solve.

Johan

