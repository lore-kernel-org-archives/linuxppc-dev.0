Return-Path: <linuxppc-dev+bounces-25739-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678FFC5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 11:19:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK8Kg4VXdz2yyJ;
	Tue, 11 Aug 2026 21:19:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786447191;
	cv=none; b=mV6AUAzOGa+5v+sFEJManiesVjJGfA7gZUsPjHAs8CXYi4l+ft35RcQ2Q6bVi3H6vFgtYxTUGszdtERIis224qW/W8Zz9/IuHMQAPrcqG5veKhaiUbzWpT+XnaiFcSC2/DbZ78G7Rb4CcUWIr4ybS+WsRAZyLM+TA4qX0f6g5/kSv8JYlOrs8Nv9581qX0e/TUk8f3zxJuJXl0MfZ7caC1ObcoJpHReaLyzZ/dkPOTk4cC5FjaavZTbAoAM/o3YQ5PXbq2ABOGgFNevB9RZGzPoy9oIASMALv5ja/rglJiWPqaVNco+jN1tF9ZdjYMlvNNx8HrXtYQ7vgWyIvWCvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786447191; c=relaxed/relaxed;
	bh=WpHpX3dMx1OmUziffO2NidzvFmW3rlX7MNbm6J/WhK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLqZyhSIEz4I7QMaZmGf8au6qsRauampA3O9yEeObD21PK4rYdrcZ6o0b+KM2F9+rj+shuZXNgRoC4W3v/qgLUjh9sSMZvBxSp2h8PJtYOL0bN+hkmofPMzojXCzQPxteYNPRy6uRJKZQ9KwnSgh5pFkVDzQYi2l+fc+UNIbJPZMDIemg4z8nMu8H0LbFI305uZIJK5jqswFBV5d/cSrNlUOKjWj29+PvH9nnKhV+LCJHGM12rUb06BGfcYsEwN/lgj8uvaT3x2ARr2pMvbyqFiE1Xn7hGkhmr+7B03iL3GC6jTJQLHc3wkegLcOrZGFJuXdaZz66Pj9k/KP1knaYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hr1Rd/lV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hr1Rd/lV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK8Kd2Sslz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 21:19:48 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-481412f1828so682878f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786447185; x=1787051985; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WpHpX3dMx1OmUziffO2NidzvFmW3rlX7MNbm6J/WhK0=;
        b=Hr1Rd/lVNdbYBcDGmPCiJENT49nOs5DUG/3AiqqDYb7s0wXZa90gGYZGYbK6yd4fIT
         R9aqcy4SNAqhbdE0L/t/QKQ0oELcFBV5Olzk52e2RGrvKG5fN8jpyMPzWQSpGNinRB7M
         7Rzed9P9U1y+BT1MTdWNs4hdvSZNWs6yjx01vpwIlFby3hgfQYlPAo+lgPBxwhRWsVaL
         EJCo7E381R/gsgbeIuI7usMRhU7V4UsmRVO8C60aAEZgACTC9gHDg2pqqCpWoxh6rvb+
         X9ksnzX4WV8v2+5F+lWSNcvVBZClPGfM1zH+t1aPfMAeGblbty8FgL531K+Km9kQ8p4Z
         hUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786447185; x=1787051985;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpHpX3dMx1OmUziffO2NidzvFmW3rlX7MNbm6J/WhK0=;
        b=XyM08k3mVVvcPtEy40PXuRWB7iZ0Y4Cu4B6M9dr9BRlO5Uu3lfMKRt5w6ifJakgGcW
         JtP1IFANKsTe6FYpt6pZpho0SQSPTEoNz1aqUylgbr/cbBmr9omcoMJCr0JFZf/okTIs
         XXkhaK3R9lz7Z9xY7EnexE83NYQUQ8JUX2fyZFpD+Mth6CR3lEw1rh+IcuXg5mQ7TVHZ
         bA2rCSbUM9HBhnd65fSKICPkYz4fCFRaWkjafwUpH8Qyn0rwUvhvfu/DYcgsj2g2teyw
         CAyfs5NVLPzJpVtQpx8Kn3Agjrn4w+RhPtLjdqyNB8J1VRafdLOr7HdShVIST0nTtfcf
         gIeQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNGR3F9PgpLFnlMOO9r36htpBCsUspBZCfWX4I7tPZGXoCP7TYrwL1qZ1pooZWCpA8QP/RXB16STvxaLE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQAonKjmhMa+txAZMQmXaFMUtsbmAZYHPYIFJT/OeMbZjeDL8G
	JY3NlEeYp/4UHoAN5dhWjI8pw6gLOIowWzhV3io4g80NZOga8R/z0pHH
X-Gm-Gg: AR+sD10ETmkQauTnEDjLRDRjnHawjGB1vHGd5iZzRpv8u/mhYlVv60skDjDSvfr1eoD
	/1mO1RrPq5QegR47qz5DF7l0+UL8x1mxBcAXKPNeN211DCOIJ+AH6LqZvGXRNe18W1nG9gaF7eU
	ufEwVMbLEVFj8oosi8/AL+SvLvXJsBBRzOcim4PWQ8EckjLwCetGn5NrW2noeYKBEAyWaohbQ4F
	HJ4qSxjdggE0gRnyPuMLN5nxZf9u8AdzqtZnzTmZ7Y7FZ98fQtFUmNbGyitCTCz/quCyLhWTfqd
	ydWNV3GsPsObGB3vagnp5bIYu95b8UFLDgwkOgLhxTsVUOCgxlDxBXyQxZ9q+ZneVmiBewf5VKZ
	AP0tc+76/gpENffphdVMS/6CUvuKwpqw0M4pLpVJzIyY3a/kgl++ofDvRW7vOjzs/2ePx33bYji
	P2uq3Sj66ocuoQ6lEPGzPk9qyypeccmCX45lCNIvooStPWnPMtqMVQXtkj5tlz2btSrhOVWaAAq
	sqb/Bi2Da0vje5e6cCnJIjWPg==
X-Received: by 2002:a5d:5e8f:0:b0:47f:6f6a:6a7f with SMTP id ffacd0b85a97d-4814ad890fbmr4370323f8f.8.1786447184497;
        Tue, 11 Aug 2026 04:19:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac75dsm3318120f8f.7.2026.08.11.04.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:19:44 -0700 (PDT)
Date: Tue, 11 Aug 2026 12:19:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, "Christophe Leroy (CS
 GROUP)" <chleroy@kernel.org>, linux-mm@kvack.org, Andrew Morton
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
Message-ID: <20260811121941.4ca20b88@pumpkin>
In-Reply-To: <643a624d-0106-44ed-a7f5-aaf9316f94fd@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
	<20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
	<01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
	<33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
	<20260811091016.5ca67143@pumpkin>
	<643a624d-0106-44ed-a7f5-aaf9316f94fd@arm.com>
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

On Tue, 11 Aug 2026 11:00:09 +0200
Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> On 11/08/2026 10:10, David Laight wrote:
> > On Wed, 5 Aug 2026 14:07:01 +0200
> > "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> > =20
> >> On 8/3/26 15:59, Christophe Leroy (CS GROUP) wrote: =20
> >>>
> >>> Le 14/07/2026 =C3=A0 16:03, Kevin Brodsky a =C3=A9crit=C2=A0:   =20
> >>>> mm code often needs to know whether some mm represents a kernel or
> >>>> user address space. This is currently done by comparing the mm
> >>>> pointer with &init_mm; besides not being particularly elegant, this
> >>>> ignores the fact that other mm's (e.g. efi_mm) may also represent
> >>>> parts of the kernel address space.
> >>>>
> >>>> Introduce a new mm flag MMF_KERNEL and set it for init_mm.
> >>>> Subsequent patches will use this flag to replace comparisons with
> >>>> &init_mm. No functional change is introduced for now.   =20
> >>> Did you consider performance impact ? This test is usually done in qu=
ite
> >>> critical memory handling functions.
> >>>
> >>> init_mm is known at link time. Before your patch 08/22 there is just a
> >>> comparison of mm (r3) with a constant (loaded in r10):
> >>>
> >>> c0014048 <assert_pte_locked>:
> >>> c0014048:=C2=A0=C2=A0=C2=A0 3d 40 c1 09=C2=A0=C2=A0=C2=A0=C2=A0 lis=
=C2=A0=C2=A0=C2=A0=C2=A0 r10,-16119
> >>> c001404c:=C2=A0=C2=A0=C2=A0 39 4a 03 98=C2=A0=C2=A0=C2=A0=C2=A0 addi=
=C2=A0=C2=A0=C2=A0 r10,r10,920
> >>> c0014050:=C2=A0=C2=A0=C2=A0 7c 03 50 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpw=
=C2=A0=C2=A0=C2=A0 r3,r10
> >>> c0014054:=C2=A0=C2=A0=C2=A0 4d 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 beqlr
> >>> ...
> >>>
> >>> After patch 08/22 we have, it first checks that mm is not 0, then it =
loads the
> >>> word located at mm+528 then AND it with 0x1. This load might be costl=
y.
> >>>
> >>> c0014048 <assert_pte_locked>:
> >>> c0014048:=C2=A0=C2=A0=C2=A0 2c 03 00 00=C2=A0=C2=A0=C2=A0=C2=A0 cmpwi=
=C2=A0=C2=A0 r3,0
> >>> c001404c:=C2=A0=C2=A0=C2=A0 7c 85 23 78=C2=A0=C2=A0=C2=A0=C2=A0 mr=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 r5,r4
> >>> c0014050:=C2=A0=C2=A0=C2=A0 41 82 00 10=C2=A0=C2=A0=C2=A0=C2=A0 beq=
=C2=A0=C2=A0=C2=A0=C2=A0 c0014060 <assert_pte_locked+0x18>
> >>> c0014054:=C2=A0=C2=A0=C2=A0 81 23 02 10=C2=A0=C2=A0=C2=A0=C2=A0 lwz=
=C2=A0=C2=A0=C2=A0=C2=A0 r9,528(r3)
> >>> c0014058:=C2=A0=C2=A0=C2=A0 71 29 00 01=C2=A0=C2=A0=C2=A0=C2=A0 andi.=
=C2=A0=C2=A0 r9,r9,1
> >>> c001405c:=C2=A0=C2=A0=C2=A0 4c 82 00 20=C2=A0=C2=A0=C2=A0=C2=A0 bnelr=
   =20
> >> Is that a real problem, though? =20
> > The cost of the read is likely to matter most if the branch gets mispre=
dicted.
> > I'd also guess the mm isn't usually NULL - so that branch needs to stat=
ically
> > predicted correctly as well.
> > I'd also not assume that the mm is in the cache (unless the surrounding=
 code
> > has already accessed it), the L1 data caches are small. =20
>=20
> You're right, I didn't think about this the right way round - in general
> it may not be easy to predict that mm points to init_mm, and an
> arbitrary user mm isn't guaranteed to be cached. Repeated calls to
> mm_is_kernel(mm) in the same function shouldn't cost much though.

Depends.
If it is real function call the code will be in the I-cache and is likely
to get predicted correctly by the third call.
OTOH if inlined you've all the I-cache loads and that static branch
prediction might get them all wrong.

Oh, and saving the result in a local might cause a register spill.

	David

>=20
> Would some (micro)benchmark be particularly relevant to measure the
> overhead, if any?
>=20
> - Kevin


