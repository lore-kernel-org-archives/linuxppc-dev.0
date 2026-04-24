Return-Path: <linuxppc-dev+bounces-20075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2342FE5206
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 11:09:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g29GZ2t0zz2yTQ;
	Fri, 24 Apr 2026 21:09:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777028998;
	cv=none; b=XgMFqehkoCM3fJkomUvLe7nP5UsnJL5Yx4JzjgpHFcAxER35QTFedFKINIFd1Sl424upj8QtVI90AQRGSKu5Jh1cch9JwUBeEeen+i5VG9xTVnLxZaAIKGbq02WIBggsTBY0szuvoZU4vGV8mlDxGZHVudbgrw4uYgjwIUqU9aRJl0Ef7YPhXz1Fy/AghFMkABWam5upEIPKsQX8J3PWJFALPmRe/Y1LDtb1iqut9+L3lkRLSoZyjbfZqBMnEis29iDOAbWlOK6LcAXvLjt0LX1Fy+uulu7bWUB3Aq2NMsfh61OF4XeJcKYMsbO7julwGb0DcVouygJCJZZYt+JlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777028998; c=relaxed/relaxed;
	bh=FDKNX6OzlxA7jl/VimGCsLSHmvQn0nEFxj0ZFcUDDEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0zgVxpLDKWhQGeS8z+d6DhUQgD8FFeegRf6doVIDYRTQzKG2s9SCVXzN+S0YOy+V74xXVSS8w+C4jepZ6RiFkB0sOPF1vKNwlQKLuoQ0w0JOx3VcZORwmIaduNWGmoNqCPmKvZCDv+N3Gb7zDvHHB9vvIk9GBor4cCMOdIKVYXnVoTT55i2wKubnks1PxP9JtkkQSa4G06o4dTpArA7D+C7AT2pVVGMsVfe+Cv86lmw/UpiitCByTsHtA63t14VWouqxPXu98sKjarpUz3aI0Y7brDhhTdvk+jzpho6sSnIaVGu1vAAtQN2V1jBwKyVitVkFnYO8xLNp/lC92Bb9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g9qPedEb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g9qPedEb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g29GX6R3Nz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 21:09:55 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so6354533f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777028992; x=1777633792; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDKNX6OzlxA7jl/VimGCsLSHmvQn0nEFxj0ZFcUDDEc=;
        b=g9qPedEbogZGlDIKur14NiY0HwnQFfsH3etA2JRDkLadnjjrxGjpAWhdgO80DfbDG/
         AZoNXcsTU/jLoFFLN2BGIgJU/otU0oCcoPIAySVq0ckSqQfVlFJnyjKJGhv/ALq6dsth
         aC8jGeNUaMIvJOsxFDbN9Kg31jFq86w5OIb7DxKrCjo1fPL12/WjkaJdzhdpJYFIwrjz
         ubwy8rX08tzODTsRhGS13bdbEhbtgwlFdA7ZNxg4N+O+Co5bCzia99TUJ16X3DGN0BZr
         pMBOM3OYI10VQebx0PbuTR7BHKNuIpupAMC0xsrBAkR96iU700l1fhKxKDWGOx+QVvE8
         C0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777028992; x=1777633792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDKNX6OzlxA7jl/VimGCsLSHmvQn0nEFxj0ZFcUDDEc=;
        b=o6tNAl53A01aRCujPgP1JdMmZlJQ8U9wc+t08PecvF2AOBu9cluXzxIFdfiv6oGW16
         A7a9Q204ud0sGUvy5fP4vcbHLBoa+3yvVBBT/vFO4tXut1sui5wZCiuH1Xbq+S7L9oQI
         MY6yQHBhjYW3D3Neb0wbPD8tQzkjP5qL5ej34mXC43gSkW+SAxEMBzfbZrtdLJqpsb3p
         puopHuwhz16RDVHE6nhFmHFmeRdG+S/9Y6r6riknEbzg0oK9xgSPAsAjRoDPxYPv8Pjc
         YE5XRdCCF89Gn9nITRmxtsMpN1uBA8lmTRrivk+TmMOpdzx1UewwQcHwvryxPJKTKegB
         /xww==
X-Forwarded-Encrypted: i=1; AFNElJ9NjZkVUliHxjUqlOdNSROgsWqn+2qWw/09jlniuuCUS1CZhmC0LCaycSJ2PkaGnjXQomsDy8JXxUVgDIQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxORsVefXZA6xb8wutICfuNJPH7gjoSoV3i3sB3Ut3/me5s+Ef5
	qKhkhfz3qT6aDZq5rzhjGGQGDqxNcesTUEtvdvK5kgL+NZamgskHCfYb
X-Gm-Gg: AeBDiesQCado9+he4s3gPCHRSeXJIWpaiM06wV5Q+etrcHqvlbDzAVzr8wY8Os5ug7C
	ce8KjGpD0a8MkqSJZ2byzcGx9j8BzNpnMBt0i22+FsicHgEBCAQhUbI4Cnl3kv0epc9vqZXA8wo
	Q1kSDtLa3gZmjZ4yTeyJfhjF9VGL2PVe6FoOLvqA24nJofhxDb07mKiWyfiNwZsuMplnlYPCUEC
	LTQEcJsezsaWIZ5m6ffjShPtTSjtC0X53HHyqVAdqghfYpCQjZXNUpSoRkpRs58+UuieYDRPw5A
	meSmvoYVuFfdiyrQ6ITRE/OLeS1OlHahA5al9C7fTxV1pnFZ1iA4ny6g+YazDhdbqSfs0fz2CAq
	6Tgu88vo5DuuDC6KP1CP98NzTWda6g+9PHeMvhaOjXqbOb1A57j+7y2/Y/e3Y+ucCyyKmqnLHQV
	vWXSNirv8ZC1xYSs9nSPFgFVrf9KSHnEGctVleCUjHiu0k1ItLMUk1ErSL62P+W9tbbe+yWpQbT
	4ZfAGFGzil3pA==
X-Received: by 2002:a05:6000:1863:b0:43e:a69b:d818 with SMTP id ffacd0b85a97d-43fe3e0ab5dmr49306229f8f.38.1777028991633;
        Fri, 24 Apr 2026 04:09:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0f31sm59174867f8f.12.2026.04.24.04.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:09:51 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:09:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, simona.vetter@ffwll.ch,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <20260424120943.4a65dd69@pumpkin>
In-Reply-To: <aes7L3M1d_LvvGKa@luna>
References: <20260424054742.45832-1-mkchauras@gmail.com>
	<20260424054742.45832-6-mkchauras@gmail.com>
	<20260424101425.6bde0e17@pumpkin>
	<aes7L3M1d_LvvGKa@luna>
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

On Fri, 24 Apr 2026 11:43:11 +0200
Link Mauve <linkmauve@linkmauve.fr> wrote:

> On Fri, Apr 24, 2026 at 10:14:25AM +0100, David Laight wrote:
> > On Fri, 24 Apr 2026 11:17:40 +0530
> > "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:
> >  =20
> > > From: Link Mauve <linkmauve@linkmauve.fr>
> > >=20
> > > The core crate currently depends on these two functions for i64/u64/
> > > i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t u=
se that in
> > > the kernel so let=E2=80=99s panic if they are ever called. =20
> >=20
> > Ugg.
> > Surely you can make it a link-time failure?
> > Or change the underlying code to avoid the divide. =20
>=20
> This is currently a link-time failure, which means if any of the core
> crate or drm_panic_qr are linked in, the kernel will fail to link.
>=20
> And since we rely on core, that means no kernel can be built on PowerPC
> without this patch.
>=20
> A possible solution would be to change the core crate to not divide
> u64s, but the last time I tried to do that I couldn=E2=80=99t quite figur=
e out
> how to do formatting without it, maybe I will just open an issue against
> Rust.

If the problematic code is (effectively) printf("%lld", val) there are much
better ways to generate the digit string than repeated 64bit divides.
On particular you can use 'multiply by reciprocal' instead.
For example see the latest (I think it'll be in 7.1-rc) version of
tools/include/nolibc/stdlib.h

	David

