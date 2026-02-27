Return-Path: <linuxppc-dev+bounces-17382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB528FD5332
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 10:06:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMkVm1lhwz3c4d;
	Fri, 27 Feb 2026 21:06:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772186768;
	cv=none; b=Y59i0ucP8eSspaU4+y8MqEYf7AbsSFuf5d7FaJw284Is4i4GNP/DecVCFYzdKfmuIm2PuRCpx707I8H3PSTKKMnlVsq/RLUejuzdQh/CTN5XYOpUw9dMjIQ/AiBblFVLBC1l0UDXZQUTkX7+H28RnbmdzQ4YOJttsfNnRRJZMMUJ/DewPfD0VZ9ZVWsam10q3FSqSPiQwxUSR5drfOAw+B/JGWRNsRCTmdD10Dx0yS7tCSkfO9hlsmJngrw1k3f23S3K/mWIS2qTwNVPDnvAd/XnSHdSe+exrM6MG9x+rwIY4qfkVA7UdyvOj3cujyz+gAqU4q5bgBzRojGBDXfcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772186768; c=relaxed/relaxed;
	bh=EKxcJlHIf+yQ0kzOm5919T83WP0WfJyFdhVwxt+TYcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL7ITENO+jCoo07mLvngc5+0Bkk3xUC6sX7nXU0PfBOOhwYMRX7ABXTjOrEJ356DIXcX7uzb+jcFe/k8cxnX+sBLDO71P7wHDExFEgUD/Cc4+uzgoIkA5N9nX5dkRaRUf4ZvS4YqyOqhS7YzQcFi7ohcnh6xruQjdHY+/Ca64c5GxcczcSzuZQF6ZlFq5W2nIfjkB3punOuW9v8Vo+mYZmYR3X+oxfjYI6MMOj7HIiN4ORWMZUHswXpKhxu5fZaEexkqDJdk9FZ1k0rlj2JjvlYM9RPgvsWB1Q/k6vG73LpzWp2UiC/g9ld7H3cYJ+M9YnDyMU2aYxrEQyeTjt3QLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KA6BpxXq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KA6BpxXq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMkVk5Xsvz3c40
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 21:06:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D2C340B50;
	Fri, 27 Feb 2026 10:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59527C116C6;
	Fri, 27 Feb 2026 10:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772186764;
	bh=g8f6lyvqvkopdOsANRzZGlHrXaOkJBu0JPpZhwX5M7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KA6BpxXqIQtvhRJQdxeyUdvh8qnuCG2MwP7HMeafULwbKoZynqIvEQBkLHp9aZGK0
	 2oLKsaZ1WAC1gSwDjpwlGilTDG17yKZ26o1IppOdmKcABFxAjpIXVOJIynO7C2axOH
	 YxoBp2vE+TGq6f7+/hhaKae3sDsCZppNsiskCFDz73pp8KIaqjcHkHMaqA0q5sY1ou
	 exQVqox+NTjea/w0RSIXOSix0uh70nSe4nBxuW16ckfJVRMzQGZyB70JK0Z8+LH3/K
	 0ZKBjpmAdcl0WLsvRezNg53bkP8AVI2HOmeJbmpWThnBUWOaQpN4A9DebRoY4Y2x0J
	 GomXPlN8wjOuA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vvuir-000000004gQ-242t;
	Fri, 27 Feb 2026 11:05:25 +0100
Date: Fri, 27 Feb 2026 11:05:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aaFsZbiLYSz_YEjw@hovoldconsulting.com>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaFcs1miP88QWmtH@hovoldconsulting.com>
 <aaFfEsfh0xTh0b1y@shikoro>
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
In-Reply-To: <aaFfEsfh0xTh0b1y@shikoro>

On Fri, Feb 27, 2026 at 10:08:34AM +0100, Wolfram Sang wrote:

> > Wolfram, I noticed you merged these last night. Please think again and
> > let's discuss the end result here. There's no question that there are
> > lifetime issues in i2c, but this is not the way to solve it.
> 
> I did think again and do not see a way how the life cycle problems can
> be solved while drivers happily access the device struct of the adapter.

There's nothing special about the struct device. What matters is that
drivers don't free memory that's still in use by the core.

> Whatever the solution to the core problem is (revocable, custom SRCU,
> something else), I still think this step is needed in any case. If I am
> wrong with this opinion, please enlighten me. Pointer to some existing
> thread is OK, too. I didn't have the bandwidth to read the revocable
> mail threads.

It's not even about revocable or SRCU, that's just an implementation
detail.

It seems all that is needed is to decouple the struct i2c_adapter from
the driver data and have core manage the lifetime of the former using
the reference count of the embedded struct device.

Then you can use an rwsem, SRCU, revocable or something else to handle
devices going away while they are in use.

Johan

