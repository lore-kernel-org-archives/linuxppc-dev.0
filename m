Return-Path: <linuxppc-dev+bounces-18740-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE14FFEC0F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 18:36:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgJfN71frz2yng;
	Wed, 25 Mar 2026 05:36:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774377404;
	cv=none; b=UTND35+cFlLUAOJ2E8vfnMBM04cLL/Va9xQQgPGbTGNfLm0fc5Ghu2y9ne0PbJacrBJVVowOKCwVjXO9h6cPOvX595X8GLyDa5Pah6qKoxO2vqmI6xeaSCBqhUy0DoEAJ62SzRTyGxmBE2cE8k0hdKiCdLcLRV2kI2g8RwJ028a4IOo/WhKvUb+juMAgslzqx996COJLjcGa4ZcNTFqQfCq74nZKB9o56pwvfejlb321jApCMGM8I4aGSBqvmjuF8Dijyw7n88unWn+jz8aBpopP1prdcvyxVrOspt9c6ZQnWVGVBhWhrqS/A3d5385RqH0LL87eyL63oTTnbECZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774377404; c=relaxed/relaxed;
	bh=TMacGYMUcDU/ZfxMzZ5qB4lAQfMCgWI9xYNANb/3NJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IYwb8LtbpTumGtIKgZd3xlFG9ywGixHAyua8sO5INZQ6DkQVfqVYWdixtoFmDGpHAexDL4T8RKPt8fMHolwb0DDqLcOmGGEjBgRdS4eDB82VFSBQuXRPep0Riye427+gUNIRXbuYerdJiOJG8JkiMi4j1mO7FZSyzdNt3WUyyBDnkuLni5zZQ/KQ7fI6s5ywjepkm46uGMy+CVGpTgVN3/o2Zqjh5AHsLsyjjUStQEhivod+FKMgEGx+xH+y/FypS82b4nZTYaeIZ4fRxkwjDp94yhYzHmbTupfVGDmG4GfKjtFL5mQjtXp1cYhXgqvqEvTmWfG2w3fjWH3J/6ocLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=MSUm3+Zo; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=MSUm3+Zo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgJfM6HHVz2ynP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 05:36:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=TMacGYMUcDU/ZfxMzZ5qB4lAQfMCgWI9xYNANb/3NJE=; t=1774377404;
	x=1774982204; b=MSUm3+ZoQTykJpwheR2FNJ18j275eUtz8Kxh2QQNkKBKOEFmDmhJOEUk4FOLi
	rk7nEJX4Wv3O3so8txnqshnSFvUN4JTROsLC0Zj7ysSsZJLwPLMDkkH+FhEuvPgk9+/3wRj70Xobk
	aq1kghprHhXpXVnMweP3Gcy+WtujcXDO3C+QWvUsbbUKUoYkLivNjxSdkFbne5li0pcxg6a8k3PNm
	LcQAJhUF4yqoCQQ9iVj0L4Dk95yhond0TsUMhV509JK+H3AWP30/SDoLz7A5xFM+Bv6xlPiuO0mV8
	f3IEG6BEz8YMU3ZoJSAZ1DwIYryV5o1IgtSJ76VxQukPDtuAtA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1w56c9-00000000BcZ-2HRb; Tue, 24 Mar 2026 19:36:29 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1w56c9-00000001y8z-0w0E; Tue, 24 Mar 2026 19:36:29 +0100
Message-ID: <de9bf8fef8e311f37335507f0e715d113cd91bc5.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 05/10] am68k/PCI: Remove unnecessary second application
 of align
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Guenter
 Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, 	linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, Russell King	 <linux@armlinux.org.uk>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  Helge Deller	 <deller@gmx.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner	 <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Chris Zankel <chris@zankel.net>,  Max Filippov <jcmvbkbc@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, LKML	
 <linux-kernel@vger.kernel.org>
Date: Tue, 24 Mar 2026 19:36:27 +0100
In-Reply-To: <1c08efcd-25e8-6436-52ab-ac3d50dcf58f@linux.intel.com>
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
	  <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
	 <5de97ed9556bfcc3b1f26bd71e09fa4016ae3ff8.camel@physik.fu-berlin.de>
	 <1c08efcd-25e8-6436-52ab-ac3d50dcf58f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
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
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 93.197.95.41
X-ZEDAT-Hint: PO

On Tue, 2026-03-24 at 19:55 +0200, Ilpo J=C3=A4rvinen wrote:
> On Tue, 24 Mar 2026, John Paul Adrian Glaubitz wrote:
>=20
> > Hi Ilpo,
> >=20
> > On Tue, 2026-03-24 at 18:56 +0200, Ilpo J=C3=A4rvinen wrote:
> > > Aligning res->start by align inside pcibios_align_resource() is
> > > unnecessary because caller of pcibios_align_resource() is
> > > __find_resource_space() that aligns res->start with align before
> > > calling pcibios_align_resource().
> > >=20
> > > Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ev=
er
> > > result in changing start either because 0x300 bits would have not
> > > survived the earlier alignment if align was large enough to have an
> > > impact.
> > >=20
> > > Thus, remove the duplicated aligning from pcibios_align_resource().
> > >=20
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  arch/m68k/kernel/pcibios.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >=20
> > > diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> > > index 1415f6e4e5ce..7e286ee1976b 100644
> > > --- a/arch/m68k/kernel/pcibios.c
> > > +++ b/arch/m68k/kernel/pcibios.c
> > > @@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, =
const struct resource *res,
> > >  	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
> > >  		start =3D (start + 0x3ff) & ~0x3ff;
> > > =20
> > > -	start =3D (start + align - 1) & ~(align - 1);
> > > -
> > >  	return start;
> > >  }
> > >=20
> >=20
> > Sorry if it's a stupid question, but what does "am68k" in the subject r=
efer to?
>=20
> The extra "a" is a typo. I'm sorry about that.

No worries, I just thought I missed something obvious and felt stupid to as=
k ;-).

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

