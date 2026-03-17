Return-Path: <linuxppc-dev+bounces-18293-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4362DFD7074
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 10:28:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZp7q6jpKz2yj1;
	Tue, 17 Mar 2026 21:28:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773743287;
	cv=none; b=fcwgRkt1LbGW5E7lQ0Z7zUEYGlUVPy+uS0jdwcMhku5i4Vy36kXNWqwcJrdDGdj4RWsniO2iB6iiuf3pPR/mQxsc8n78KFX0xYsqoiVUNWqAtRd6PNqo1cb8ktva2wSqaM+pDJH9qVljbukyOiztjtC+cY+jTUGMZPde2BuHNKQmCdKRo43PIqsW1TobZZpOeF2tVaC9HdAJUr9x6ZNheugWXPF+eGEbu8KNwOmliGU4SY77bi6HDePjfh6/IKMiBUnZnpBqPDookfVfDbwt1z5XAi01PYEv0FWHI6Oq4ytsyCuxf7hSxR85zd9pTraZVyfo0AdJ4w+BXp5611DLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773743287; c=relaxed/relaxed;
	bh=+s2M7y9EWmfo3pnC8rfpaOTqH482fuTkp+K0CN0HGE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmMXZQ6kx1CRohGHgjLs/REC0UfUgi7Pp+yc6RfL63z6a0Z6lMJgY7I5mgVIGFvi/w5qOO0zOU7Ob4lL0OPjeGoBxTflPkxv70siWQc7iEswS2mGkCY900F4SUakxk53JBS9u0uQEY7TWboglstxpekaruAxGwrEHsNtx22HNfiHV47GadSqN2ODfGgg3Vb9eWn+GqCzr7cUbFgfA8srDezILdUau4Jc90EAQ8b7IgWDWnlgb34rJwjq+4DA+84h7El4KVQTvO4/US+7YhXks8pPFF8LYx10wDQC+7dsUtB7eTSXvhSvlpCAPn+gqFs5eekGQTdfuv4ZHEG/cVpMXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o8xtv3vv; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o8xtv3vv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZp7q0yBvz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 21:28:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2CCE660008;
	Tue, 17 Mar 2026 10:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDBCC4CEF7;
	Tue, 17 Mar 2026 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773743283;
	bh=1xbKBSlkozJZVHo9aWAqFEve5sj6lCI9yEzMc1miQSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8xtv3vvdarHsmUyInVVAPUWhHzbvSKQhDx4fZK4XpDV/UBzN0OZIR24xJ2R4Dt5L
	 4hRILK7tJ0/V9pT5ryBqrlF0TBUT7uQxKTVZY8LWyD3DlRNwmzJBUHTnDrgULu71NU
	 dK+Qlbx2YcNx3HJ1gOWPakoZYxG8crAjXBz1qSa3ecwPxJMNfhOFrxqbpBu+NbESva
	 wqtZfW3kSs8MLR9P2wOUA+GX/DWynBZVts+mKGWl5U9ReZGOsRBJt1J00VfSqG0Bu0
	 7oAqB+pvVrJHBbMhjwD8U6rcw/vvtojEX0WHKBsow/19fu5zNweqcFVrGUrZFqQK7A
	 kHA80/SxGSIXA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w2Rea-000000006oc-42C1;
	Tue, 17 Mar 2026 11:28:00 +0100
Date: Tue, 17 Mar 2026 11:28:00 +0100
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
Message-ID: <abkssPv559MBM61V@hovoldconsulting.com>
References: <aaFsZbiLYSz_YEjw@hovoldconsulting.com>
 <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
 <aaHI_VavZugXjVoL@hovoldconsulting.com>
 <CAMRc=MdKF29McBJ9U=qELkzf9GYV1CQpRF7U6OweDNtVzMXo7A@mail.gmail.com>
 <aacE-27iaYneKCJi@hovoldconsulting.com>
 <CAMRc=Mcx8Hu407arSEo3o-Xhmep_ZK4BM2TVi_55nXGwYcaijw@mail.gmail.com>
 <aar1PDUB2t7DgEP6@hovoldconsulting.com>
 <CAMRc=Mcv+ZMGaC_MD8WRH113rDuuxdiZXuW5JAXWga1V7vM_ng@mail.gmail.com>
 <aa6hcT7MROZqxF1j@hovoldconsulting.com>
 <CAMRc=McXGZFVQm0B2OddSLLV8r513tDmbEzeY4hvPcakSv9N7w@mail.gmail.com>
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
In-Reply-To: <CAMRc=McXGZFVQm0B2OddSLLV8r513tDmbEzeY4hvPcakSv9N7w@mail.gmail.com>

On Tue, Mar 10, 2026 at 10:28:17AM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 9, 2026 at 11:31 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Mar 06, 2026 at 06:34:43PM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Mar 6, 2026 at 4:39 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > > > You have posted changes that will prevent driver from accessing the
> > > > struct device of core i2c structures. This is unexpected, non-idiomatic
> > > > and subsystem specific and therefore a bad idea.
> > >
> > > That's not true, the changes provide a helper to that end.
> >
> > That was supposed to say "prevent drivers from accessing the struct
> > device *directly*".
> >
> > > > Again, this is a core feature of the driver model. You can't just ignore
> > > > it and come up with random ways to work around just because you disagree
> > > > with design decisions that were made 25 years ago.
> > >
> > > It absolutely *can* be done differently. There's nothing that imposes
> > > a certain API design on susbsystems. If you design the subsystem code
> > > well, provider drivers don't need more than one reference (taken in
> > > probe(), released in remove(), for instance via the
> > > register()/unregister() pair) so the counting can be hidden within the
> > > subsystems that control them.
> >
> > Yes, there is nothing preventing you from diverting from the idiomatic
> > way of doing things. But my point is that that's not a good idea.
> 
> "Idiomatic" is a just buzz-word.

No, it has a meaning.

> I don't know why you insist on it
> being the only "correct" way. People have been doing all kinds of
> driver data management for a long time.

Yes, subsystems do things differently, and unfortunately also gets
things wrong occasionally.

By separating allocation, registration, deregistration and put you can
avoid some of the mistakes that can result from combining these
operations.

> You recently looked at my
> series for nvmem - did you see that nvmem_register() only takes a
> config struct (which may be a stack variable in probe() for all it
> cares) and copies all the data it needs into refcounted struct
> nvmem_device that the subsystem allocates and manages?
> An nvmem provider driver only has to do
> nvmem_register()/nvmem_unregister() and, while it can access the
> internal struct device, it never has to in practice.

nit: It looks like drivers can't access the internal struct device
currently.
 
> There's no:
>   nvmem_alloc()
>   nvmem_register()
>   nvmem_unregister()
>   nvmem_put()
> 
> I don't see why we wouldn't do the same in i2c:
> 
>   struct i2c_adapter_config cfg = { ... /* dev id, driver data,
> whatever... */ };
>   adap = i2c_adapter_register(&cfg);
>   i2c_adapter_unregister(adap);

Because it's unnecessary, would amount to a lot of churn, and has no
clear benefits. We already have an adapter object, it just needs to
refcounted.

Johan

