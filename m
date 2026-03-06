Return-Path: <linuxppc-dev+bounces-17829-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAB3FCB618
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 15:50:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS9pX6ByZz2ySS;
	Sat, 07 Mar 2026 02:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772812212;
	cv=none; b=E2Rd5IzeMZ5FV435Uy1HTD3nUnaxQmymmvQunZK8fGUgL4gnJGztCx5CoPfPxsbVPpyyJ4nqDD3JOk1o9PwkveYnwdyAIn4uPucNJpsb8zjbGF+7+VGbmFWI8qs3XSK6eojuShzMhx5RAicApUXp/DIP/uHLS/WRFr00w7eppba6Y7KyjLvWvuUyFc2RpoUdBkSIKD3CFoX8zyChJ1dsiYe7zEZw02B4MQ5vbPNnNlr4gNJgDQAY+ej8QcnKoCwJRNgM5vxC5j0CaJyQqU4GY1IOjXYhPBi3k4//HDSe33OJpjLB5CROHfmG1j+n7jr4xv37o8jgghDN2CRFW1VAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772812212; c=relaxed/relaxed;
	bh=B7k7dsqXUHzbdGRlbXLh5u6zdYvYJuDYBSGiRNEpXmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVT/xwaATKvgv7JUrxKPkclyomLOQuZ6hXSZFKcn3fYaPqm2+F3l5sdRjggYenOGnd9f+XbHNE5MeA3kSPSp9eskK6Gtntdt0vuk7FLB6tEEPOX/3aotCe2sY0L6X76QgBu/jamJRq+xXn/2tLM0IVDi2BrZPCZoV7Au9QLSumiqpvVCIMpkPRRhVqdf1EA7gS4jwjwE4bJmJPdL+gwDfkAK5+WCxlqnBRN0bot6brKe49ZTjMxntkXpMCcoIj+6tKfTlsTcU4BkCsJmTUGrFBPFxOu9iB1MaSgXiKK8HCLe4ZIYNt3CZkXLnsT4lANOgWbR6iDKzQlEba04CzZvMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LWpu2YpT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LWpu2YpT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS9pW5dyLz2xqm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2026 02:50:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BAE3560018;
	Fri,  6 Mar 2026 15:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8FDC4CEF7;
	Fri,  6 Mar 2026 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772812209;
	bh=KUIQRc9tgbyHTJUuThQoWuAHIhnO8IJXlH/NpCUfX/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWpu2YpTj8vcXxPE930Lbh7K3HPPHOPYU4057N5XlkcAU350B4eGrfGCFrH1Vakc3
	 ELmUXCxbtLHv3EvBrSE1u87VVpzhryqmtdFMjXEqDW9rStLlq/GLEwJu+CJbGxU+V8
	 VNpqETQCQiZAMUvjLQ7a+BpKgi7hbYKlwp4pynFQXrOQ74xkwEF36so+k82sfXhRWE
	 /1YYlYC2n4Y9Jx84iCEJF5UcCWutF2SXumszmChG5D/U8ICzmBK4k3BiPJSC9M/zjv
	 WZ1R2Lxv7kjqHd51Qu1Cngb7AnBHl7r+NdzDTbN1ZI0vtC2kLb8mnKzGzwUK4fioGJ
	 UObE+mDWikQ4Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vyXRG-000000003rl-2Tvg;
	Fri, 06 Mar 2026 16:50:06 +0100
Date: Fri, 6 Mar 2026 16:50:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
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
	Manivannan Sadhasivam <mani@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aar3rj7Db6NmTVS_@hovoldconsulting.com>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaFcs1miP88QWmtH@hovoldconsulting.com>
 <aaFfEsfh0xTh0b1y@shikoro>
 <aaFsZbiLYSz_YEjw@hovoldconsulting.com>
 <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
 <aaHI_VavZugXjVoL@hovoldconsulting.com>
 <CAMRc=MdKF29McBJ9U=qELkzf9GYV1CQpRF7U6OweDNtVzMXo7A@mail.gmail.com>
 <aacE-27iaYneKCJi@hovoldconsulting.com>
 <CAMRc=Mcx8Hu407arSEo3o-Xhmep_ZK4BM2TVi_55nXGwYcaijw@mail.gmail.com>
 <aagSewpM88KAZDcJ@shikoro>
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
In-Reply-To: <aagSewpM88KAZDcJ@shikoro>

On Wed, Mar 04, 2026 at 12:07:39PM +0100, Wolfram Sang wrote:
> Hi Bart, hi Johan,
> 
> > And I agree: doing the above would be even better but you'd need - for every
> > driver - to move the i2c_adapter struct out of driver data and make it a
> > pointer. That's in addition to providing new APIs and using them. I2C drivers
> > are spread treewide. There's a reason why nobody attempted it for decades. I'm
> > proposing something a bit less complex: allow drivers to free i2c_adapter at
> > unbind but make i2c core keep a private, reference-counted structure for as
> > long as it's needed.
> 
> I am still with Bart, the above paragraph sums it up extremly well IMO.
> I also recall that the outcome of the Plumbers session 2024 was "go for
> it!". Nobody said the approach would be "fighting" the driver model.
> There were a lot of experienced developers in the room.

I don't know what was said a conference some years ago or whether there
was any misunderstanding on either side. What matters is what was
posted.

> > I'm frustrated because I'm spending time working on an actual solution. I've
> > explained what I'm doing and what the end result will look like based on what
> > works for GPIO (struct gpio_chip's lifetime is bound to device's "bound" state,
> > struct gpio_device is refcounted, I want to mirror it with i2c_adapter and
> > whatever we eventually call its refcounted counterpart - let's say:
> > i2c_bus_device).
> 
> I am super-happy and thankful that Bart volunteers to spend all this
> time on fixing this decade old problem. I know this alone is not a
> reason to accept a technically bad solution. But I think it isn't. I
> think it is a viable approach to keep the churn and potential
> regressions lower than a theoretically ideal solution which is nobody to
> do anyways because you'd need to refactor drivers from the 90s in a
> quite intrusive way.

We've done bigger refactoring than this, and after a looking a this a
bit further today, I don't think it's going to be that intrusive at all.

Bartosz seems to agree that my suggestion to decouple the driver data
from the i2c_adapter would be better, and I'm willing to do the job.

Johan

