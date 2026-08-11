Return-Path: <linuxppc-dev+bounces-25741-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65152C5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 13:25:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKC6M5Dr4z2yyJ;
	Tue, 11 Aug 2026 23:25:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786454715;
	cv=none; b=lDF6tYoziudo5/gHJgPZ1A3EsK31NhWqVDp/y5uFP6fybIxdMTtUWL7qfdnyZa1c8hYiOxfz7g1CNVllQY3/gsDf2WV/3HqJSbS4zxkdAwOp0+Yb7hKFgUyZ/5Pj3zi0g2/X8OGfu7q1x+A61Qo4LoWtRLyoH7iBxRWrMCUsql0380mo34nQR43qCX015Rdd8D/3UhIIa/AZ9H8h3XSuhlMgaoEscdX0QPZRXIqIXZc5KJzq9MATmhSYFajMZVat9YsoXcTsBduBwKgEdgyM/Wrx9NAlrsBJrLjcbB6JiZn638HXsS3luHyz9ShTMkn6ZjJ4Ej9uCkbzslXA2GHm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786454715; c=relaxed/relaxed;
	bh=HfUDfNxB65XZqovwWVBLkrKpJgUq3OtZ1XoJNMhjK1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiguYevpBNUhAD1/0BeT9Xs97prz7fYLkllZXkJpWJwj0KEj+HvKlC+FTdpSVsCx+/PbGL0PhBRBQy+sM0CANw3h7bJvYTu4n0Nl6SvHoTE8bDDdLeYeBjFxNZX49ALj3JMJ31miu1ThPkGaVx165BUWMH9vp4TZ+FneEjOTOkY7Lk8jWRDn0mm9pqI0rvvNKhsyt+drHZb02OPZyd+MqwZrdcqzGhgqUOmH5E6uy620tab3pg23ifeiEeRS+nnYGgZLJ0sq95iJkRDc6u7EpvKNcvrqT9Zm+nXemxnOT+cIewnQKOHAXTVS9GDbYtoZrq502eq9dxGDA9OPSX9yDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CVte+Xc+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CVte+Xc+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKC6L32Cbz2yrC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 23:25:13 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so16047545e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786454710; x=1787059510; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HfUDfNxB65XZqovwWVBLkrKpJgUq3OtZ1XoJNMhjK1c=;
        b=CVte+Xc+uF4TgBw5WaNBgs6eMoR5qw+9n5nPTjoELY2V/TlfTrmS4EaMysZZnBLXtz
         dSAzItXdjfuzm3VVQf44A0WaxNWW2wzk8WMVFn9cIHPY7+mbbxgudPc/I2lm6ThehAx/
         TtuSvZB/q5NKeh1M4Q00hThjDyWm1ZRfqFv8vCOJQZMAxKIDZgAZCStkXN4K2VRDHiUK
         T9S3oEydsNkPx3Une07oSdeT+GNekCfB+RmuqGhLreYHubGAfAfHMTZFTesqXiwmjDFw
         P/Oy4P5W2clRE8U6acMFie/LqXPUcz0+dFBqfThgjVRrmQZFrkN4y+2t0MW69QfIkxM5
         575w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454710; x=1787059510;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfUDfNxB65XZqovwWVBLkrKpJgUq3OtZ1XoJNMhjK1c=;
        b=o8wMwE8AKIwA9N8piVaOdWyKEDmRf+fj9z5fgW6C+w58XddLzFmgoBVz1FocEVCB3Y
         SkXUq+AIaKG7tP/dznaTwlkZCjDr6nfpJsZK1zbDzptOCKSyGMVYuZRX8IasvCxPcltR
         SAqZKQ0rg2XPzFJgmc8qp2n6VVfOrc9gpEoAKQX3b6sChPMSXu1oOCYj4NO4J9sddy+y
         KDIrs7SgrX5TiUflPs0mcKS+bVPOOx3r8fbmX/C9eOW1rdTGf5Fy2vhNgg7PCSlCGwFj
         gXZA40KqAbptfvgkGfMgBeBq02sU/KxBWtTpRVCNlr1lxF/fz9R4IjSUDzkdUXAjhLEg
         RuNw==
X-Forwarded-Encrypted: i=1; AHgh+Rrtze3FgL+D0F8nd8HBWpPJXeOLCsaUhbgvmmP2WFM2fVyHsIab3qvZNROmFd9kLA1u8zxD50kSqUJDO7A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx8UkntjwdnH4MWu9Pb8NIpOj0y2K82CLv70IaABBfNwxCg6vZY
	1Vva7zq1DAhvtreoopL8dkC/s3Ci/qET2HlDK/ycZCSTNIQOC8pZNy7z
X-Gm-Gg: AR+sD13tisNYxyutP6ESzy+I8T7hmvsxM2BktQAtCmwQGLK2/QUV2mzj19ZxRdwInPi
	cuVNVUzloqJgBThle/tCBzc85tYnKx+EjxwzPIiqhrwWIrM+uzzIRxY0w8LM9QEkqqAkB3j9C0B
	V7TYxeIJPZorsKDnTMMiiypyJD/WHQ0pdHI4+PZjOF5oxvyUr2GxrPT2BLvC2r9J3fx8fvFnNM2
	ri6sTJPqty6DkBMkJHdev61nVYoWyWzMeSGSyOzekSgihHEgNAuqHje0XCYxyvbSas3uqyItIjQ
	/om3WBwZcUJm8Cka3hKZU1iceWOsL3qL9iC1VlRXCQg01Q2bJactHKLOcalfg5pk8by/FPcnDGB
	Q0QOqxU8EYKy0Qmn8CDYcPJhT/eSoju8tlU/hS+5CQw12qTRwnK6PSjeop5pFVRoosmDKw8g7H1
	Yhpojm7zCyqpjwvc1NmYUwrPYvhbhl09RW8Q7hVtx1NQ9M2CasaZGXY5NXIvszCZXj/PlVZ9fXB
	s/sjq0ZN8FHYzQ7VyXHmteJrVZS9k5uTwRU
X-Received: by 2002:a05:600c:4513:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-49978468c2bmr48261215e9.9.1786454709883;
        Tue, 11 Aug 2026 06:25:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977df9489sm83541285e9.1.2026.08.11.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:25:09 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:25:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Message-ID: <20260811142507.4c6c760f@pumpkin>
In-Reply-To: <01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
	<20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
	<01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
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

On Mon, 3 Aug 2026 15:59:35 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 14/07/2026 =C3=A0 16:03, Kevin Brodsky a =C3=A9crit=C2=A0:
> > mm code often needs to know whether some mm represents a kernel or
> > user address space. This is currently done by comparing the mm
> > pointer with &init_mm; besides not being particularly elegant, this
> > ignores the fact that other mm's (e.g. efi_mm) may also represent
> > parts of the kernel address space.
> >=20
> > Introduce a new mm flag MMF_KERNEL and set it for init_mm.
> > Subsequent patches will use this flag to replace comparisons with
> > &init_mm. No functional change is introduced for now. =20
>=20
> Did you consider performance impact ? This test is usually done in quite=
=20
> critical memory handling functions.
>=20
> init_mm is known at link time. Before your patch 08/22 there is just a=20
> comparison of mm (r3) with a constant (loaded in r10):
>=20
> c0014048 <assert_pte_locked>:
> c0014048:	3d 40 c1 09 	lis     r10,-16119
> c001404c:	39 4a 03 98 	addi    r10,r10,920
> c0014050:	7c 03 50 00 	cmpw    r3,r10
> c0014054:	4d 82 00 20 	beqlr
> ...
>=20
> After patch 08/22 we have, it first checks that mm is not 0, then it=20
> loads the word located at mm+528 then AND it with 0x1. This load might=20
> be costly.
>=20
> c0014048 <assert_pte_locked>:
> c0014048:	2c 03 00 00 	cmpwi   r3,0
> c001404c:	7c 85 23 78 	mr      r5,r4
> c0014050:	41 82 00 10 	beq     c0014060 <assert_pte_locked+0x18>
> c0014054:	81 23 02 10 	lwz     r9,528(r3)
> c0014058:	71 29 00 01 	andi.   r9,r9,1
> c001405c:	4c 82 00 20 	bnelr
> ...

Thought...
Could the check be replaced by one that checks for kernel static data?
That would require that other mm that represent part of the kernel
address space be static (and probably not in modules).
ISTR there is an address range check that can be used - and might be
cheaper than the explicit test for init_mm on many 64bit archs.

	David



