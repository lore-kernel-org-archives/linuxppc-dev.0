Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D65CC4332F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Nov 2023 05:58:36 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Phtdf1Fh;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SPcwB6xgfz3cJW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Nov 2023 16:58:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Phtdf1Fh;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SPcvD0sR7z2ydW
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2023 16:57:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1699336664;
	bh=WLSmH2YPB6ObGHIHtgDYQTqiAIGZxZwcz5obGeCszlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Phtdf1Fhfq/erjjW2irSLi9DfgpGK3jtR86PifRopkpQ7EorydzfZltVCcBlW+oNr
	 4tlI4jOopCn9HgMgvZ/AFrRpHLQ8l3KSZwzYlq+rD70c8btUhG8k9qNbLDcfCkuXlh
	 dTeGNoM/yBJWPmBqXJ5z9kkiHgyxEQkn7INidyhIt4i/jXSDpJVhc7Hi8eKEnwCjF4
	 VnyS+Xf1E0IFSOqVSyXozXRMIjmMGQwGM1XVfLpgihoQ9YjlVe02p+3T0qmJ+RlP84
	 j2sc5y7RhEO95k4iGNaISatDNllYL42OHEKZkP9d/GUm1T8i45x5e7LjP12eUdIws/
	 hRAO81FEAEpCA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPcvC5Yfbz4x7q;
	Tue,  7 Nov 2023 16:57:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Walleij <linus.walleij@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Fix signature of pfn_to_kaddr()
In-Reply-To: <20231106-virt-to-pfn-fix-ppc-v1-1-93197a7ccab4@linaro.org>
References: <20231106-virt-to-pfn-fix-ppc-v1-1-93197a7ccab4@linaro.org>
Date: Tue, 07 Nov 2023 16:57:40 +1100
Message-ID: <87ttpyw1ez.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Linus Walleij <linus.walleij@linaro.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Linus Walleij <linus.walleij@linaro.org> writes:
> There is a const in the returned value from pfn_to_kaddr()
> but there are consumers that want to modify the result
> and the generic function pfn_to_virt() in <asm-generic/page.h>
> does allow this, so let's relax this requirement and do not
> make the returned value const.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311061940.4pBrm44u-lkp@i=
ntel.com/
=20
I'm struggling to connect the removal of const with those bug reports.
It looks like all those warnings are about 0xc000000000000000 being
outside the range of unsigned long when building 32-bit.

Is it the right bug report link?

The current signature of:

  static inline const void *pfn_to_kaddr(unsigned long pfn) ...

seems OK to me.

It allows code like:

  const void *p =3D pfn_to_kaddr(pfn);
  p++;

But errors for:

  const void *p =3D pfn_to_kaddr(pfn);
  unsigned long *q =3D p;
  *q =3D 0;

  error: initialization discards =E2=80=98const=E2=80=99 qualifier from poi=
nter target type


Having said that it looks like almost every caller of pfn_to_kaddr()
casts the result to unsigned long, so possibly that would be the better
return type in terms of the actual usage. Although that would conflict
with __va() which returns void * :/

cheers
