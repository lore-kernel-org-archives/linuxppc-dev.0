Return-Path: <SRS0=w0cb=TX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F013C04AAC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 08:47:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90242175B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 08:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90242175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458jnB3d4pzDqFB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 18:47:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458jlk6WXNzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2019 18:46:26 +1000 (AEST)
Received: by mail-ot1-f67.google.com with SMTP id g18so4664973otj.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2019 01:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8QKOuZsXCKoGRlpO5lyxyoXP3MPWfoKuTRCqNZgNN14=;
 b=dMssHPc0Ij4uWetf6IMklJk88fD4M9112PepGCrfLeR7WMMUkJxJqpt9XmuPx2W0BD
 UuntER5ZLh+fStaZcIn4HnNLpAbPu9mpIjbssrlOI4w3XGWINkk5JXoZS83UDcUBo8J6
 D93PXChP3EuRBOMnZ+vWVSZ250KNGiR9bBhtXalXINfuIxkZKQdjfrmkNsJ8deOAQ2SW
 eL+4XjOwWYNluKu5ah7P89PTlIOUUOiN2hKSnJGP/RVOr1lhr5Munyu42Tzalj0Oaqpd
 vEbqOqqEnr/sYzCtOb0Xdxa5bp93wqs8O2anXYjSZMHnpwPn0U9pxwugyM7UiYp2MJS5
 k5cg==
X-Gm-Message-State: APjAAAUP4hDm0e/7eCo7tJ3YSTbA0ln2hOs9HCWJCXUxFn4fFD7Kvfq2
 XELKKHaoXWwiaAedgxVrnCny5zCfqz7pAgZ3RBY=
X-Google-Smtp-Source: APXvYqyfpnWGmk78Wp+Tex6dY2geI0TRhZzhpXj/jaLgRpO1+WSqUb0sPhy4CanjkjlByE4ZI5fx6wnq5raiDJ8RkO4=
X-Received: by 2002:a9d:1a5:: with SMTP id e34mr29923888ote.59.1558601184167; 
 Thu, 23 May 2019 01:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+7wUszwugJeS_x_ExaHPUb8p23D7Zo2f2qqXfLQwr8EiLsk2g@mail.gmail.com>
 <33ab57c7-294a-6ae4-d678-1490ce5b97f1@c-s.fr>
 <CA+7wUsywReRnB1ASdbVrNRkWyPkSKhruBKo57kX--1qmU8hv7A@mail.gmail.com>
 <9b6e027e-0fa0-e088-d9a3-47b005cbc356@c-s.fr>
 <CA+7wUsxOxvtsp511c63HK-=Wm22qyEtDcg=p4rfRD+n55UQmiQ@mail.gmail.com>
In-Reply-To: <CA+7wUsxOxvtsp511c63HK-=Wm22qyEtDcg=p4rfRD+n55UQmiQ@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 23 May 2019 10:46:13 +0200
Message-ID: <CA+7wUsy+tY1Ny2dOr4Y9ZDxVn1UUgu3a3vJUQou0nx2ss4dYRw@mail.gmail.com>
Subject: Re: Failure to boot G4: dt_headr_start=0x01501000
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 23, 2019 at 10:29 AM Mathieu Malaterre <malat@debian.org> wrote=
:
>
> On Thu, May 23, 2019 at 8:39 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
> >
> > Salut Mathieu,
> >
> > Le 23/05/2019 =C3=A0 08:24, Mathieu Malaterre a =C3=A9crit :
> > > Salut Christophe,
> > >
> > > On Wed, May 22, 2019 at 2:20 PM Christophe Leroy
> > > <christophe.leroy@c-s.fr> wrote:
> > >>
> > >>
> > >>
> > >> Le 22/05/2019 =C3=A0 14:15, Mathieu Malaterre a =C3=A9crit :
> > >>> Hi all,
> > >>>
> > >>> I have not boot my G4 in a while, today using master here is what I=
 see:
> > >>>
> > >>> done
> > >>> Setting btext !
> > >>> W=3D640 H=3D488 LB=3D768 addr=3D0x9c008000
> > >>> copying OF device tree...
> > >>> starting device tree allocs at 01401000
> > >>> otloc_up(00100000, 0013d948)
> > >>>     trying: 0x01401000
> > >>>     trying: 0x01501000
> > >>>    -=E2=80=BA 01501000
> > >>>     alloc_bottom : 01601000
> > >>>     alloc_top    : 20000000
> > >>>     alloc_top_hi : 20000000
> > >>>     nmo_top      : 20000000
> > >>>     ram_top      : 20000000
> > >>> Building dt strings...
> > >>> Building dt structure...
> > >>> reserved memory map:
> > >>>     00d40000 - 006c1000
> > >>> Device tree strings 0x01502000 -> 0x00000007
> > >>> Device tree struct 0x01503000 -> 0x00000007
> > >>> Quiescing Open Firmware ...
> > >>> Booting Linux via __start() @ 0x001400000
> > >>> ->dt_headr_start=3D0x01501000
> > >>>
> > >>> Any suggestions before I start a bisect ?
> > >>>
> > >>
> > >> Have you tried without CONFIG_PPC_KUEP and CONFIG_PPC_KUAP ?
> > >
> > > Using locally:
> > >
> > > diff --git a/arch/powerpc/configs/g4_defconfig
> > > b/arch/powerpc/configs/g4_defconfig
> > > index 14d0376f637d..916bce8ce9c3 100644
> > > --- a/arch/powerpc/configs/g4_defconfig
> > > +++ b/arch/powerpc/configs/g4_defconfig
> > > @@ -32,6 +32,8 @@ CONFIG_USERFAULTFD=3Dy
> > >   # CONFIG_COMPAT_BRK is not set
> > >   CONFIG_PROFILING=3Dy
> > >   CONFIG_G4_CPU=3Dy
> > > +# CONFIG_PPC_KUEP is not set
> > > +# CONFIG_PPC_KUAP is not set
> > >   CONFIG_PANIC_TIMEOUT=3D0
> > >   # CONFIG_PPC_CHRP is not set
> > >   CONFIG_CPU_FREQ=3Dy
> > >
> > >
> > > Leads to almost the same error (some values have changed):
> >
> > Ok.
> >
> > When you say you are using 'master', what do you mean ? Can you give th=
e
> > commit Id ?

Sorry about that. The problematic commit for me is:

54dee406374c Merge tag 'arm64-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux


> >
> > Does it boots with Kernel 5.1.4 ?
>
> I was able to boot v5.1:
>
> $ dmesg | head
> [    0.000000] printk: bootconsole [udbg0] enabled
> [    0.000000] Total memory =3D 512MB; using 1024kB for hash table (at (p=
trval))
> [    0.000000] Linux version 5.1.0+ (malat@debian.org) (gcc version
> 8.3.0 (Debian 8.3.0-7)) #8 Thu May 23 06:26:38 UTC 2019
>
> Commit id is:
>
> e93c9c99a629 (tag: v5.1) Linux 5.1
>
> > Did you try latest powerpc/merge branch ?
>
> Will try that next.
>
> > Can you send your full .config ?
>
> Config is attached.
>
> Thanks,
>
> > Christophe
> >
> > >
> > > done
> > > Setting btext !
> > > W=3D640 H=3D488 LB=3D768 addr=3D0x9c008000
> > > copying OF device tree...
> > > starting device tree allocs at 01300000
> > > alloc_up(00100000, 0013d948)
> > >    trying: 0x01300000
> > >    trying: 0x01400000
> > >   -=E2=80=BA 01400000
> > >    alloc_bottom : 01500000
> > >    alloc_top    : 20000000
> > >    alloc_top_hi : 20000000
> > >    nmo_top      : 20000000
> > >    ram_top      : 20000000
> > > Building dt strings...
> > > Building dt structure...
> > > reserved memory map:
> > >    00c40000 - 006c0000
> > > Device tree strings 0x01401000 -> 0x00000007
> > > Device tree struct 0x01402000 -> 0x00000007
> > > Quiescing Open Firmware ...
> > > Booting Linux via __start() @ 0x001400000
> > > ->dt_headr_start=3D0x01400000
> > >
> > > Thanks anyway,
> > >
