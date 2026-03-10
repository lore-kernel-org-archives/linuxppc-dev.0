Return-Path: <linuxppc-dev+bounces-17948-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18514EA8550
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 09:28:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVT8M14q1z3cB5;
	Tue, 10 Mar 2026 20:28:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773134915;
	cv=none; b=SZxII8LOjhRosH3ox0p0GHSWr6J5YWgqXwiEGHvIwP4gEibvoaXJz9Dn5+XWXSXHTasF6pD/zd2P8YvDlW08hYbqhHwTvm3WH+ffcSxmX9ySxXcz4fUbt6tUC5D1pg2dbFySC8jFKn37spSDGR0nXxb700S8OB+1g9T3+FHF3Y7b/eXUCiiOTEN7El1SXFh1RxuO5QT4MFXkfSXTdYjN5fXW8Buhc3IGXLQwJRiO7dq8+rc2q87MPnY0Nx/mac0GPIqFyWBZhsMFUKZQnNSnUdAaTF3aFIsQu8qJoqkQdBqAHfri92Df2rVOV9XIleFE3fuH30OhAzsVJJfuWsgnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773134915; c=relaxed/relaxed;
	bh=1sccsSHszdKIsz+3uGEy4u27jbbQUcwZRuCEl3AhZsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZm4ZSkrqSe3JtQqkP2NlldCSylaFVx/wcK6ljgJ6Bozso/izqSQoxAf8+zm1GSoy22Ey6EOXfXWbbFdSiCH+f0ydEuoVLXyVcAmYZpYgn75vHhN/qVb7wjqQQpvUGYNnyOI4iQPBa/F6QXx+/TmY8d973yKT5AfYG4Sz+ZpyFT4MT8u6GXPek/DHJ4RqL5wBFSTb9yuL5FeFStETDkfS7eq6kg0CmJorrgQQjjqfyywaTMUiqkQU8S2LdeOxLCob1Q8GN0g5yuqpr/Lw9evXoD8QyHSWjJZuBy8MVcybN0+5nCtRA8hlwGrN4w+ZezY7wPrd/rJWr7PXWCLaiN5dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o7Y1h7iX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o7Y1h7iX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVT8K5x8Kz3bjb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 20:28:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F371A60123
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 09:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C471C2BCC6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 09:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773134911;
	bh=dZHL6ALzbbg+d0OTHFPpy1ega8D7sQ79hXGEXtGGk2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o7Y1h7iXC1ZdVfl1KUOlDDpKxFznmLXSdkFkkpD2R6qrfrJxHZWbeePjghWSZJ7iW
	 kHdGuco0Gs0skZt6PvhChT/yDUeRXjhDSLXDYgZeMURQdjEK4UvZ75eNAK8F1gCH/J
	 JMyTl3LDbhorPpLwwX2gigbzsDFTZmr8wfGHm5jVHaXNMsYZ7k3NjDXCLBmujQc4fO
	 yxV/S1HRDp9Mh+2ISz0crxx/r15tV/PaEAVnNYSbvjzvX7RpYQUaHnNBINfoQuSPFa
	 I07mRSe3f5Gx0Z11MvnR98//b94k11DXqYt/Q39jp/DttYudpWQ9ONHmo2MV4LeGo1
	 biYMSP3x4Lvpw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a142464316so3593269e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 02:28:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG8fkSLFw6T0AqDbvh0JrRkFZekncZ+3ui/asbkKfNbQ16cKxfN/+5QVzx7HA9W8PP//wyjGONXoCRQr8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyP/940FREJHHL0jrslCErxP6F6d/vIwD9dE7WiV99+t1L00Pla
	j4e4NYt5aRcE+c64oHjfjxsWkuKlOBGg7tOaxkz5Wb9EjAOuKFBnM53aSH3xxAFTrvT01V87aSi
	G4C2gQkT+um89YWOZwf3c/utxeRv9y2Xb1v4KcjiOeQ==
X-Received: by 2002:a05:6512:33d1:b0:5a1:44c9:a8ef with SMTP id
 2adb3069b0e04-5a144c9ab04mr3592708e87.26.1773134910130; Tue, 10 Mar 2026
 02:28:30 -0700 (PDT)
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
References: <aaFcs1miP88QWmtH@hovoldconsulting.com> <aaFfEsfh0xTh0b1y@shikoro>
 <aaFsZbiLYSz_YEjw@hovoldconsulting.com> <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
 <aaHI_VavZugXjVoL@hovoldconsulting.com> <CAMRc=MdKF29McBJ9U=qELkzf9GYV1CQpRF7U6OweDNtVzMXo7A@mail.gmail.com>
 <aacE-27iaYneKCJi@hovoldconsulting.com> <CAMRc=Mcx8Hu407arSEo3o-Xhmep_ZK4BM2TVi_55nXGwYcaijw@mail.gmail.com>
 <aar1PDUB2t7DgEP6@hovoldconsulting.com> <CAMRc=Mcv+ZMGaC_MD8WRH113rDuuxdiZXuW5JAXWga1V7vM_ng@mail.gmail.com>
 <aa6hcT7MROZqxF1j@hovoldconsulting.com>
In-Reply-To: <aa6hcT7MROZqxF1j@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 10 Mar 2026 10:28:17 +0100
X-Gmail-Original-Message-ID: <CAMRc=McXGZFVQm0B2OddSLLV8r513tDmbEzeY4hvPcakSv9N7w@mail.gmail.com>
X-Gm-Features: AaiRm51wQp574GnYnSDIqyJgBWyPwbXLgs-qc-SDGATXP4oGmj2-sapttc-0urY
Message-ID: <CAMRc=McXGZFVQm0B2OddSLLV8r513tDmbEzeY4hvPcakSv9N7w@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
To: Johan Hovold <johan@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Khalil Blaiech <kblaiech@nvidia.com>, 
	Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-actions@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Fri, Mar 06, 2026 at 06:34:43PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Mar 6, 2026 at 4:39=E2=80=AFPM Johan Hovold <johan@kernel.org> =
wrote:
>
> > > You have posted changes that will prevent driver from accessing the
> > > struct device of core i2c structures. This is unexpected, non-idiomat=
ic
> > > and subsystem specific and therefore a bad idea.
> >
> > That's not true, the changes provide a helper to that end.
>
> That was supposed to say "prevent drivers from accessing the struct
> device *directly*".
>
> > > Again, this is a core feature of the driver model. You can't just ign=
ore
> > > it and come up with random ways to work around just because you disag=
ree
> > > with design decisions that were made 25 years ago.
> >
> > It absolutely *can* be done differently. There's nothing that imposes
> > a certain API design on susbsystems. If you design the subsystem code
> > well, provider drivers don't need more than one reference (taken in
> > probe(), released in remove(), for instance via the
> > register()/unregister() pair) so the counting can be hidden within the
> > subsystems that control them.
>
> Yes, there is nothing preventing you from diverting from the idiomatic
> way of doing things. But my point is that that's not a good idea.
>

"Idiomatic" is a just buzz-word. I don't know why you insist on it
being the only "correct" way. People have been doing all kinds of
driver data management for a long time. You recently looked at my
series for nvmem - did you see that nvmem_register() only takes a
config struct (which may be a stack variable in probe() for all it
cares) and copies all the data it needs into refcounted struct
nvmem_device that the subsystem allocates and manages?

An nvmem provider driver only has to do
nvmem_register()/nvmem_unregister() and, while it can access the
internal struct device, it never has to in practice.

There's no:
  nvmem_alloc()
  nvmem_register()
  nvmem_unregister()
  nvmem_put()

I don't see why we wouldn't do the same in i2c:

  struct i2c_adapter_config cfg =3D { ... /* dev id, driver data,
whatever... */ };
  adap =3D i2c_adapter_register(&cfg);
  i2c_adapter_unregister(adap);

I understand that you doing the work will give you some discretion as
to the implementation details but I'm asking you to at least consider
this as a viable solution when used by others elsewhere. While you
have criticised my proposal for i2c rework - fair enough - I don't
think you have ever given an actual argument against this simpler
register/unregister-sans-alloc-and-put pattern other than it not being
"idiomatic" which is honestly quite vague.

Bart

