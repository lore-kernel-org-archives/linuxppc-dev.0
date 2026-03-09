Return-Path: <linuxppc-dev+bounces-17885-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9927AEFCD7E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 10:31:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTtbD4zLwz309P;
	Mon, 09 Mar 2026 21:31:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773052280;
	cv=none; b=KVeW0zciEMW6xtULcG+GlAewbKB628hFzqRdSK7gmQt6e71OQfZDE4hFHBn/RHG93dvaW7wTWzd4ZN6CJcpjIyML5vvsRWy9VdT47Hi/YB89ol+6DosIRZ5akiQ/CKattJ2Scm0fpRZEbQ5DWG2CzuFDMcAgxaHaIwhekQ5WXIXHeNqJkK0wOTj6HGLJLtM1UBjYVYRjY9N3dwCbxsbULwq/wgXYSHc58i3u1RfkpQe0I0fxmi/ZoZElyMtvfbqESYXbrVrmY6giTswy3NLDIdiWFAiA7tujczi8YgkWs6zpM5VLhMj4Ndo3jueYxJn3QS5QqQtd0BaJduUvhaEQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773052280; c=relaxed/relaxed;
	bh=ysvPiqp562qCZQnJw5l8TL8cq4IhZO2GmAxe8p0UZ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxTdqLMABS63FF13niIFIaykRg1DZEs6lJIX0rWNAtsaFqZhqiZeCNg3bijvUhi3wwP0c+7UKaa5MvxkUJ48Fnr8F/nsvKZxafgXu+4Zf4yhcTiyIfTmB9+hcF4qUBgIbTwX9RuKAE63rD6yQuzUd5f8f1k7k+bIMBdXPtSdNJnJo791VoS3RxhUCU/FFA4tP1siivGFYpuiCsxPy6IPx0Ue6QIY2oIwYXBZzObX1bv/KlaR/B9jPWAd2fXIxQwkv0jnlT5JHTfeF91lCya5x8Y/V5ysobi9MoQ4ACAOnuDvVQU4O02rSRZ7pgVm5eDhzOf1Vf7WWyOJYFJ9500C9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X6j5855B; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X6j5855B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTtbC4SlVz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 21:31:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C257B600AD;
	Mon,  9 Mar 2026 10:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FDCC4CEF7;
	Mon,  9 Mar 2026 10:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773052276;
	bh=1dv+XhP5OwvToCXeXxaL6H6crc5uBccvLhwiXF5Big4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6j5855B86hH8+1MUUbQdzfRXXIEh36roQzDmNtZdLVlt+VtMSp7FWhuEC7HxLg+4
	 3ASrEfhKmLdpAm/VP1gGb5GQPHRZyzlA9Wv0XEN1P9t9gflLXWiWM6s0bOGH7yvuC+
	 bzFzU3sZ14p5clqbm5EJMcExCvTp6B+pn4mlEtyJ/vArl5P4gUHyApQeDYt0UIVnjD
	 fa5DgkOvoLJmWeP1nzIlE2PZbnVc5lUB/zjgDz6l71LVoy9/1JqpjV41i5czOq4RpO
	 WHnzI5JOAaJobCwW4FNmaOORDUiIpodIFsZfZXzTtQ7X18XgT4XUH6FBc26i7cEHtL
	 xVdATdgxh1BHQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vzXtJ-000000006A5-3p2H;
	Mon, 09 Mar 2026 11:31:13 +0100
Date: Mon, 9 Mar 2026 11:31:13 +0100
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
Message-ID: <aa6hcT7MROZqxF1j@hovoldconsulting.com>
References: <aaFcs1miP88QWmtH@hovoldconsulting.com>
 <aaFfEsfh0xTh0b1y@shikoro>
 <aaFsZbiLYSz_YEjw@hovoldconsulting.com>
 <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
 <aaHI_VavZugXjVoL@hovoldconsulting.com>
 <CAMRc=MdKF29McBJ9U=qELkzf9GYV1CQpRF7U6OweDNtVzMXo7A@mail.gmail.com>
 <aacE-27iaYneKCJi@hovoldconsulting.com>
 <CAMRc=Mcx8Hu407arSEo3o-Xhmep_ZK4BM2TVi_55nXGwYcaijw@mail.gmail.com>
 <aar1PDUB2t7DgEP6@hovoldconsulting.com>
 <CAMRc=Mcv+ZMGaC_MD8WRH113rDuuxdiZXuW5JAXWga1V7vM_ng@mail.gmail.com>
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
In-Reply-To: <CAMRc=Mcv+ZMGaC_MD8WRH113rDuuxdiZXuW5JAXWga1V7vM_ng@mail.gmail.com>

On Fri, Mar 06, 2026 at 06:34:43PM +0100, Bartosz Golaszewski wrote:
> On Fri, Mar 6, 2026 at 4:39 PM Johan Hovold <johan@kernel.org> wrote:

> > You have posted changes that will prevent driver from accessing the
> > struct device of core i2c structures. This is unexpected, non-idiomatic
> > and subsystem specific and therefore a bad idea.
> 
> That's not true, the changes provide a helper to that end.

That was supposed to say "prevent drivers from accessing the struct
device *directly*".

> > Again, this is a core feature of the driver model. You can't just ignore
> > it and come up with random ways to work around just because you disagree
> > with design decisions that were made 25 years ago.
> 
> It absolutely *can* be done differently. There's nothing that imposes
> a certain API design on susbsystems. If you design the subsystem code
> well, provider drivers don't need more than one reference (taken in
> probe(), released in remove(), for instance via the
> register()/unregister() pair) so the counting can be hidden within the
> subsystems that control them.

Yes, there is nothing preventing you from diverting from the idiomatic
way of doing things. But my point is that that's not a good idea.

Johan

