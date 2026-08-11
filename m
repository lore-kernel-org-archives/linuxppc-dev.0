Return-Path: <linuxppc-dev+bounces-25733-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C37C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 08:10:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK4790SqXz301Y;
	Tue, 11 Aug 2026 18:10:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786435829;
	cv=none; b=m7geMCuI1hR3r60yRP1VtOWzSpc6MhGCixg1SChiSQRMj3Yzt5Nc4BvOT8FnQ88CbGMtF23idiA7VlgfyUzU7dqjVAq304Z32tGdAskwQuvjgBgCrGJoa1qrrg78qML5EcxJfVUHgtH4CmMSUwVyMGzTbqogm6ZxEODLoi1fCtR6NN6dntJrG/YLs8J4xHebJ3ebg0xYEk0smjzIEhmByNPmloG1JuZoNBlp+3dMyea6ZcBGITniAIMNwTWOM3ypctun+p6t6NqZXCDL0R6pNuaHHZmIhObcj5TGdZ2biSi5w+vLvFjTzfeMCISHWiuOhGqR9pbuKh4PuObTnS+lHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786435829; c=relaxed/relaxed;
	bh=kRDEH2ssIQhIkVPOR6PkKFR0aBPP8ALbaUyGO3LvVVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWsmMEcEntZby05f7nl/sulaMdRJOmSMjmjzs35Gz0eXZuLrcsaAp7wZ0grCUpbmugkpkceZm4smco1qycAnJ2Hyj0fGHEGi30cJRFcAu5PDk+MymWtV04j+f3vJy6I7e5l/G1HPuUt0eTmTlprcq2dOAd12VS3Nma0g494aSF/5J8HqBfTh7GmrwCHNClNMFnfwF5h671DjAdSDfe1FkWSHjgv/LKR/3xauWezDGmGmujByrTBqf2gqMkXo+lXjqsdBjWk5Kq6ZSNi6n/arDnNG+4OMFNB6xs4V2V5W2e1WL322fqIaBxwMNQ6EUBFmDY/LB5gksWWwrJ7oJr/uSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L3wrAB3c; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L3wrAB3c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK47765tcz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 18:10:27 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso31419735e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786435819; x=1787040619; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kRDEH2ssIQhIkVPOR6PkKFR0aBPP8ALbaUyGO3LvVVE=;
        b=L3wrAB3cXnln+V9IthJBTJTHkH8rZa4OwFacvPeBNQO8E4jAITDH5N7X2LrLGalHUb
         4cvB5MGaAK3Rur6mq2SO8ApGf/HjmHbRey36xPHdtkyJa5bA4ISnptjTBzMQHa79q44j
         ffNrpw4MC8+r0GgfeatX+lZ24+rRU3d8tFpV3Tnjf4/5JFl1Nr47qB2CeNdgqnQrK7Sw
         tbLa8zaREGjTgGWCvdMrCwRJJ+FR3fE7VPrglwpFap/+Dz5qu0OSp4EFYyITDivGMJi8
         zvXTM3K+D1D6PSNv5rUDxB6SJD15Sn68yB20M1Z78qAE1IWjiXDDqdVuVdFAmFFCFWCD
         vy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435819; x=1787040619;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRDEH2ssIQhIkVPOR6PkKFR0aBPP8ALbaUyGO3LvVVE=;
        b=fPTp6CAY35lR0lbSCdWDppxckiGL6Hj1Aujie35jurR+h5dI2/LYCCtzbIhgJvkB8+
         Wbmj0ASWWCA5dHtqdlDGcbmB4thoea/dlO8quWSStPiWq3LRi0ebn05zb2b0TwjyFRFh
         +gtGYrRJoJhkpUwL6p+OoN2BmQD75GhrpG5TDG8cRvxnTmJCGYnSHgnWHiRpkkouyQHl
         MAG83ORpHb26j/oxsp7P8/AbwY4xSe/iMxPxObybQ//5oN9kZVXseayqODwu25x9Vrxv
         lmmofCyWAf4SDSTLAMX0kNwy2ZEhQJnd7UbMnx3foQ5rUzphVf5K5SgYOlTqBkwkAggq
         VWdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrL5eMcHUFyD6d0N/WHhXgHxexIqfwAQaDruOZvIxn/nmuv/cYKKOKajePQTJuDothR1RyVFsLpNQsly8Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwhpixdQCnezSWdZcwVP3yv7rs66evurGpwh28yNQF2Jo0gfOko
	KwnAds6cIAFwVBC5XGIaRukbOkYAaHuLshWRspid3ZRrtEQRiwLL5Q02
X-Gm-Gg: AR+sD13wxk3Ua11E/IHZihUOA/v3X135njn2tGie6Q6uemod7z1nmR1mFhFXwY1CZsJ
	uo6OlZOEf2keQSxK+UZQ/Wwi/CTUbO+EtrwFtyJvFIZKTVxwsXcJRcUKL+dZ8ZWXf8Om92/v7Pj
	X4fBEAAVkFMkCjO1ev9+djVZwd/M18em7Rn13Ppgf/llXE6HMwPUDxWCSWMicznclvV6bABD/4e
	CqewQRu41gLijp/9GC1J97biTUSetUsXw8OU+JOrycqIGLnNyt680gge8rHOGyMRFBMa9g9BHr+
	oRnM3x4Ox3W5zE3w9iyIIjs0w/BQuPfSG3+4hvX/kxrjQiQi/z/XS+pIvSDVnN02N5JPTuL/aE1
	QqAEpWnceuqqzH1/JhQf/cZnHkkuamCg+AtGzUsfSYab5fUv/gIVI/0u3rxvoM+H01Ophm4/J6I
	raVPwGrn0W0K7/P0gZBbZr6RP9PyxxEfa0sNBaNY1igldmXUrAOHbMEfdOuuZWDAR/T37VOPkVJ
	tzlptFmElPZSsc3sxtsbemXiQpqy4L5ZbY=
X-Received: by 2002:a05:600c:821b:b0:499:6a92:fff1 with SMTP id 5b1f17b1804b1-4997847e9b5mr25827975e9.18.1786435818734;
        Tue, 11 Aug 2026 01:10:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac6e6sm2454288f8f.6.2026.08.11.01.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:10:18 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:10:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Kevin Brodsky
 <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, x86@kernel.org,
 tboot-devel@lists.sourceforge.net, Ard Biesheuvel <ardb@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, Vishal
 Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 03/22] mm: introduce MMF_KERNEL flag and set it for
 init_mm
Message-ID: <20260811091016.5ca67143@pumpkin>
In-Reply-To: <33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
	<20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
	<01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
	<33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Aug 2026 14:07:01 +0200
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 8/3/26 15:59, Christophe Leroy (CS GROUP) wrote:
> >=20
> >=20
> > Le 14/07/2026 =C3=A0 16:03, Kevin Brodsky a =C3=A9crit=C2=A0: =20
> >> mm code often needs to know whether some mm represents a kernel or
> >> user address space. This is currently done by comparing the mm
> >> pointer with &init_mm; besides not being particularly elegant, this
> >> ignores the fact that other mm's (e.g. efi_mm) may also represent
> >> parts of the kernel address space.
> >>
> >> Introduce a new mm flag MMF_KERNEL and set it for init_mm.
> >> Subsequent patches will use this flag to replace comparisons with
> >> &init_mm. No functional change is introduced for now. =20
> >=20
> > Did you consider performance impact ? This test is usually done in quite
> > critical memory handling functions.
> >=20
> > init_mm is known at link time. Before your patch 08/22 there is just a
> > comparison of mm (r3) with a constant (loaded in r10):
> >=20
> > c0014048 <assert_pte_locked>:
> > c0014048:=C2=A0=C2=A0=C2=A0 3d 40 c1 09=C2=A0=C2=A0=C2=A0=C2=A0 lis=C2=
=A0=C2=A0=C2=A0=C2=A0 r10,-16119
> > c001404c:=C2=A0=C2=A0=C2=A0 39 4a 03 98=C2=A0=C2=A0=C2=A0=C2=A0 addi=C2=
=A0=C2=A0=C2=A0 r10,r10,920
> > c0014050:=C2=A0=C2=A0=C2=A0 7c 03 50 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpw=C2=
=A0=C2=A0=C2=A0 r3,r10
> > c0014054:=C2=A0=C2=A0=C2=A0 4d 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 beqlr
> > ...
> >=20
> > After patch 08/22 we have, it first checks that mm is not 0, then it lo=
ads the
> > word located at mm+528 then AND it with 0x1. This load might be costly.
> >=20
> > c0014048 <assert_pte_locked>:
> > c0014048:=C2=A0=C2=A0=C2=A0 2c 03 00 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpwi=
=C2=A0=C2=A0 r3,0
> > c001404c:=C2=A0=C2=A0=C2=A0 7c 85 23 78=C2=A0=C2=A0=C2=A0=C2=A0 mr=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 r5,r4
> > c0014050:=C2=A0=C2=A0=C2=A0 41 82 00 10=C2=A0=C2=A0=C2=A0=C2=A0 beq=C2=
=A0=C2=A0=C2=A0=C2=A0 c0014060 <assert_pte_locked+0x18>
> > c0014054:=C2=A0=C2=A0=C2=A0 81 23 02 10=C2=A0=C2=A0=C2=A0=C2=A0 lwz=C2=
=A0=C2=A0=C2=A0=C2=A0 r9,528(r3)
> > c0014058:=C2=A0=C2=A0=C2=A0 71 29 00 01=C2=A0=C2=A0=C2=A0=C2=A0 andi.=
=C2=A0=C2=A0 r9,r9,1
> > c001405c:=C2=A0=C2=A0=C2=A0 4c 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 bnelr =
=20
>=20
> Is that a real problem, though?

The cost of the read is likely to matter most if the branch gets mispredict=
ed.
I'd also guess the mm isn't usually NULL - so that branch needs to statical=
ly
predicted correctly as well.
I'd also not assume that the mm is in the cache (unless the surrounding code
has already accessed it), the L1 data caches are small.

	David


>=20
> What we could do is to just keep the =3D=3D &init_mm check internally on =
configs
> where we know that there is only a single such MM context.
>=20
> Just a thought.
>=20


