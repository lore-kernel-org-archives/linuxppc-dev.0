Return-Path: <linuxppc-dev+bounces-21749-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8146CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 18:25:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRsGN0lqgz2yQH;
	Sat, 30 May 2026 04:25:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780079100;
	cv=pass; b=gP8SJNDljolEG2lOHbFGUs72BVuiBZQgi2lrsJGDWNtfwKJoLsBh+gKTqmzTlAwQx00Fs+2oH8a84Kt1NbAQxBAaSJfcXfkwOgwcy8yqFKVUVHZOuH4PGp0FfDmw/nnRteTzTPMyu7qnHttWvhHOgCPZ7GE4InQfKEQBWCS6ns1g0mLIgQ3yZ6u5qkgY5p1J1yGKYUjLYBlCVT9kIipfIa8CW3ZeocDB7M/t4iN3K+PAPBDaqSNMhddj29QB53xvdVSZokdsuAWsLW25K3epDv7z/mtSaNC7IWJlZbi0fbWJ/hVcSSDNMWf6EEddJTdPUoF0QNVdCpxLijUGxmc9HQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780079100; c=relaxed/relaxed;
	bh=raC80FL97vnFyloJA70eiiXfMtUS5ezjCgjeJ5g0ugg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnyqCJFcRkh2F1CyVmYTftXcLo8y/id8A1QAjIeL9RTAEdaTb84KtvNGL9FF3f+yYNrZVwqF7YH0CrEQ2i2VbQm5eAJwnedbzoltAQCgf/QWKrjqufj48s0EYhbh4GUqQkCeTP78TJV/TqbtTZe7ckI3Wg8fAwmnxNmSWQ50i9hvkfuhEI/gHPGYo4954z90YhJ3+Nern9nfMWNRJvFIDA8D6jzlRf4B3Xs9nIFWqhYhFLK+XcjqVCPFzNqrCLiWJCE1lpeVbmtQQ6gx1D4jCL4+/TcyRK/ftdYTm5jqbUC0a1o4qFQnP5wofd01arKjiVfIgOtNrNkq2pB9kUQ/XQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZJfwtdQG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZJfwtdQG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRsGM2m9tz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 04:24:59 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3664df32e91so15793830a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 11:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079097; cv=none;
        d=google.com; s=arc-20240605;
        b=Cy1ympi9pl1QiH2p4+D5WMmHSaEvgwUPnpBzF1t5+meJz9MbsdrGv5V/BvxSDm3jFm
         Ad+n5L8ZoiXr5//Tlj2GtqbbD2mOKFD5iaTtPXzrWASTQXDuM2Q9n/5Y9vf0XwBwu6EO
         zT2EJgWoXnxvxPpeb/96CDSBihfv6e90Ry7mVgt5F3jFmzekbOi6Mt2Z04Vmfg7iSZeA
         k+KkSgFE1kSsIj/3klLM0fVKdoqxGhQwXA3TuP9BteRmdmy4T0YN96/C7le++hqoA+SO
         63Ns3v9ja4OTvhgt4igSTTGYRoDAVHUIL38GwbNL7h1LgtBg5Wsyp7Ja8/bjJVLlYZut
         nhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=raC80FL97vnFyloJA70eiiXfMtUS5ezjCgjeJ5g0ugg=;
        fh=huTge2+oJfeOweDm/BUZlp5zHVdy3Bt7q/rKgfZtJXI=;
        b=fbvb21tsHr/JdNJycOlU6G/Fl/IUB+lh5qqfYMZqvRnEYi0UjND/VtiFFbjTgGfgpK
         FKgZYEuIx/v6Eb6crc0exIE/7/06oeVUBcuOv2wNRXfge8J+ASheOVvwcJ/Gfj1ozUwv
         QzCgnHYcqlF0eoFiJ5yhCwoqJ1z7e2mA0WukvXvNKACOXjV1yyTn6X1FtY0zM+dzoijh
         CtoF3qNqiDNmOf2xPAhn3mkXwAgebeCx2SnyBWRquL9UZLkcrwDw8zd+CUUcth981plR
         Epd+8rRnWYKZOlHz1i6RVfltPOjd2whJNrr1TQObgVvTnr3LOnXKqSs16YgaxdgnmJ6Z
         kStg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780079097; x=1780683897; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raC80FL97vnFyloJA70eiiXfMtUS5ezjCgjeJ5g0ugg=;
        b=ZJfwtdQGpXEhMeVT2QJt7uhComd2QtWpZNhwmuVHwsQmTbHiWZbAO7DeJZ8bmSpJGe
         yjmuJ1YiuOQ37D21Em+Li1i+lKWZ631/aovzz7Y6Y0f1rD5fvEgtm0c3ZMTXECPk8JxS
         iKYaqUAQ4OJcJt5jIm8IRb1yoo9ghOg62+BGRXfK+2+YyRBwYAVrpCaBxF0lokocEnmV
         /fuKA/4PGtd/BwckQJwaNo4U7XCkNzrwpZTaPdi9kNHe9+UcdFj+KCcYr2/tnzQUUK9Y
         tMnUINKknOhi1vHwUFh0+8sxp1mB+ZkjOupMTaJScFYrHRD/MtGRrTDam6+C4locOW5P
         /cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079097; x=1780683897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=raC80FL97vnFyloJA70eiiXfMtUS5ezjCgjeJ5g0ugg=;
        b=lbqEBvFKWn7oZ6chQLLeklVWqCywLr3m/AIUA9EqFRhAH0Tq7Ijm3pfhmtP800mwGs
         2JdBq6kUUrVAO9OhdYGaNYl46gaF9D84QtKejzdolMa04EaK+ZFO5xVbF66E2iujBkz3
         meICnzcQhm/Ic24p3kMW17KIrwY5JtUNJC0PxePg8l/ltr/iCMUmDdxnD0jCLIuB5YT3
         ISK1UJr5urt5ghUBYhUq/jBAGTt3EBrDi03l3TzHwzr5/z9VLgSZCmFR9PhqgRn5JMmE
         Bg0F1T5BdhuBvfi1ZscvL9EGhoY8DofdkpJRYiw0pM5N7ZuOtMmwLUOr6ynD6iFmhL9z
         4xjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9py/5UbQtBv6SNfDDzCQdniURReAucJzzyVxPVxX/+K36fMjOXIcwGYbev+uOPNXt/0aGcOVjb3ZmmQoI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz5mCjieOsPxieQ02akEkoZ/iCZszrUd8zk2rjn+J46VIttQIKY
	wZePyyTNIZeAXUF0gi43BqHCTX39UmuFl8P8YD+CD4BmvdxonQNsWZ6F/8AV42UwFJObBAYbHNC
	vMoFz/q/AHlc0vAAFsxWkr4IEPz05SEDpC5aCT8RI
X-Gm-Gg: Acq92OENkDfuT7EYywvAuY4j+BYXPFiFhXpeGewDieFBKoS/Dw8gObClyc9rcO4Behz
	flI++jGYXUYSLJJrSgmKI4UJY1Va25T3DczBHPqx6lKiz4Da2vX5P6/20sSh9yuc1tWRGGy33Al
	gg9GK9ZxijoUtWqgq9QCsQtr5yGocvutkMB9DFIrGBL3nTD6LAIzcrvY58nNKbYyXqjiB2z9nHz
	pi3zgUWNnQy0f1Z4BQ1JXUWm4MrjaAJn5f/WvD+l/PMgKx8Q1uvqhsPN89u8XuYp3Ahlvf/VtVP
	m+TSa3ad8L0xobkhDw==
X-Received: by 2002:a17:90b:5212:b0:368:b176:c5a8 with SMTP id
 98e67ed59e1d1-36c501e747emr374444a91.15.1780079097303; Fri, 29 May 2026
 11:24:57 -0700 (PDT)
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
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
 <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com> <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
 <CAEjxPJ6DqhHKdjwC3ddZfUK4HVPwOTzb1Kkuabi5WmwmF8Lu_A@mail.gmail.com>
 <CAHC9VhSEjSmdVgNxg=PvwS6RXnJzFybJtFhCJbOsKiRhXi5PJQ@mail.gmail.com> <CAEjxPJ5wS+sXvCjO3q2sfrckuMo71_Y3uSdgu+Vte7xLkW0Huw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5wS+sXvCjO3q2sfrckuMo71_Y3uSdgu+Vte7xLkW0Huw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 May 2026 14:24:45 -0400
X-Gm-Features: AVHnY4JkvYYnGXgtS-r6uyAoqJa9j23y-gvS34JWyjHW-_UBDjUi9Ylaj-ADNeQ
Message-ID: <CAHC9VhQT43Dq=NeSBwKkeF=Xr9mqdG+Gi0L+xs0pCCxuMoZBZQ@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: rppt@kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	selinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:11=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, May 29, 2026 at 11:39=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Fri, May 29, 2026 at 11:19=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Alternatively, I suppose we could just update the dentry_path_raw()
> > > call to also pass PATH_MAX, but
> > > I don't see why we want to use __getname/__putname() instead of just
> > > direct kmalloc/kfree here so
> > > the size of the buffer is immediately evident to the reader.
> >
> > It's reverted, see the posting below:
> >
> > https://lore.kernel.org/selinux/20260529153608.30853-2-paul@paul-moore.=
com
> >
> > I think there is still value in using __getname()/__putname() here as
> > opposed to a simple kmalloc()/kfree() pairing, but either way we need
> > to adjust the buffer length in selinux_genfs_get_sid() accordingly to
> > use PATH_MAX instead of PAGE_SIZE.
>
> IIUC, __getname()/__putname() were originally internal helpers for
> getname()/putname() and allocated from names_cachep for struct
> filename. commit c3a3577cdb35 ("struct filename: use names_cachep only
> for getname() and friends") switched __getname()/__putname() over to
> just generic kmalloc/kfree so that other users of those helpers would
> stop allocating from names_cachep and noted that those lingering users
> could be converted to explicit kmalloc() over time. So I don't think
> vfs folks want new users of __getname()/__putname() but I could be
> wrong.

Whoever wants to submit a patch to do the conversion again should
chase that down.

--=20
paul-moore.com

