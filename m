Return-Path: <linuxppc-dev+bounces-17402-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FCAFEFB6A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 16:41:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMvGb6lRGz30N8;
	Sat, 28 Feb 2026 03:41:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772210471;
	cv=none; b=CjMJ4aDpDpOaVR1tVGBlnm3Aga5CackcpdsT5ymvqamBngpFKHeOs98DyuI0Bzps1DXwkkpOPVbArHrCBQDTOHtFEyms4bYhsYqcuPQl3gm9u772QfX51bPgpONZ97sq9fNSrMqcOB6YuVT0Loa7xf8nbvQ+BiprjEwW0A+bbQSZltouBg85AeX3sfz0Z0DPTHh3tsk0wF5lMwII28rg0vhhBK8qXXxQh/Ky0iWPgzx5OP/FTV22Fak7Np871ti0n9gyKKh7xleZhBTda9jQI1Bx4juKUjQbW1cDF5/xqaCe8/6bT6zwvMpFtCVJ+Imm5XDN4IxyzL1gj2tdKTAt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772210471; c=relaxed/relaxed;
	bh=Ra4gGeTukVvl+IUi3kpBx/h8Xrcr5tcq4BLIbbsXf6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSVuCvuG2vx3YCwR+ktBtr0aGabdudKESoNILlHotHbxMlrPUMZ84tMUXevCqUZDFwH0g5tjuKEt75by7ED0EFQCc6R8Tuw9/7wVtNgcGErM2ZtZ1itOVoUsGY7NB91pzCON3Zva9np/V+f14B0abNLk5KrXVhbY+UjXCsW7EbiTiVSsG4kDLi6EgGBMkvsO2y8t+6wJP/87lMUq9dqgylwBvKseycxnjNEEMWNX2ulhwOiehbLJrZ0vVRbzdHxZePoBTqqZ7ESJ7u5cIyEd2jQO4rMrEqBkUKm8FVu/lY1HEobmCV78TJRJMAIFBpyyT+kixh/GG+es/BjHpXxeKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kaYFALf4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kaYFALf4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMvGb0RdDz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 03:41:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0784E60054;
	Fri, 27 Feb 2026 16:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A9DC116C6;
	Fri, 27 Feb 2026 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772210468;
	bh=Ra4gGeTukVvl+IUi3kpBx/h8Xrcr5tcq4BLIbbsXf6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaYFALf4xSZVQAbA312F7K02ns0zy5kcaOvWHFJNWY9AvATt7pUW+bvMJKbdtChtm
	 tH2uUwehXsL2Hj8fdwwpVCcWuHdDsb63uUFJP2cMF43xNCJTDSxZcHpwvTLSu1U7Sl
	 M2FUvnb6mDY3PWKJMno+e3SWOYvxG8KKG8vxw4MEn6hOq41EUPBH23+RINiw2vhX+e
	 FbHp3qUfZvbZuE+CnrnSZvs5NqaaWkofdWxMYqTtE/Z0RbEfnkD+zmDgc1t+2WJ5x1
	 9nBJrTX+Zzefz1LyUgn8uO+y6uQ40gkpU5G5jKsZVOMPxB3x2051Wg3WzGAPsaffSQ
	 nrMMZp0t1q53A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vw0tB-000000002TD-2FBk;
	Fri, 27 Feb 2026 17:40:29 +0100
Date: Fri, 27 Feb 2026 17:40:29 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
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
Message-ID: <aaHI_VavZugXjVoL@hovoldconsulting.com>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaFcs1miP88QWmtH@hovoldconsulting.com>
 <aaFfEsfh0xTh0b1y@shikoro>
 <aaFsZbiLYSz_YEjw@hovoldconsulting.com>
 <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
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
In-Reply-To: <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>

On Fri, Feb 27, 2026 at 04:42:09PM +0100, Bartosz Golaszewski wrote:
> On Fri, Feb 27, 2026 at 11:06 AM Johan Hovold <johan@kernel.org> wrote:

> > It seems all that is needed is to decouple the struct i2c_adapter from
> > the driver data and have core manage the lifetime of the former using
> > the reference count of the embedded struct device.

> This is a weird pattern you sometimes see where a driver allocates
> something and passes the ownership to the subsystem.

It's not weird at all, this is the standard way to handle this. We have
these things called reference counts for a reason.

> This often
> causes confusion among driver authors, who logically assume that if
> you allocate something, you are responsible for freeing it.Since this
> is C and not Rust (where such things are tracked by the compiler), I
> strongly believe we should strive to keep ownership consistent: the
> driver should free resources it allocated within the bounds of the
> lifetime of the device it controls. The subsystem should manage the
> data it allocated - in this case the i2c adapter struct device.

Drivers are responsible for dropping *their* reference, it doesn't mean
that the resource is necessarily freed immediately as someone else may
be holding a reference. Anyone surprised by this should not be doing
kernel development.

> I know there are a lot of places where this is done in the kernel but
> let's not introduce new ones. This is a bad pattern.

No, it's not. It's literally the standard way of doing this.

> But even if you decided this is the way to go, I fail to see how it
> would be easier than what I'm trying to do. You would have to modify
> *all* I2C bus drivers as opposed to only modifying those that access
> the underlying struct device. Or am I missing something?

Yes, you have to update the allocation and replace container_of() with
dev_get_drvdata() but it's a straight-forward transformation that brings
the i2c subsystem more in line with the driver model (unlike whatever it
is you're trying to do).

Johan

