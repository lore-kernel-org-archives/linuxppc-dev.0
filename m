Return-Path: <linuxppc-dev+bounces-18738-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C7FEC0EB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:43:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgHSt5Bdtz2yng;
	Wed, 25 Mar 2026 04:43:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774374206;
	cv=none; b=hlpmq3U34sGONA0z77dLeLogKeX9rKkezCD9DVEzu2vvl99Ll6iT4M3lM/OFQrFMiIhy9U940VL4Tz7ryyPB49hrCTvn+gBSZz3OydK/3vDueJovXYloo/XRe86UZvCbDqDDv+2J4nzikMby+nMb/pGZQYBjcxBt/jXFApUlr60SaFLLhImhLtyI0lEQOVPFiHMD4WEyp5FL/cBRHpAaQaG4I7zo6DeBoPpB00Fz09QWk1rGDY126PSHPXKMFzW63P29sj5azmRNMSet35XconU0Ydc8WGytl2oj00KZnFB9xYjtl7NdD84faYf3yFfEC0vDw2o9XWVlcnRMOdJOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774374206; c=relaxed/relaxed;
	bh=AP49Wml/Qr/wzH3y6BxqbwOt7JtkHcoMn8XiWeebrkI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KkPvkdOK4zOrNOCQBw5PynJUVBvoQ7Sf9KMCGCBnB9k5VbmhStX+VvFqU/l2p7T9NDWkSWSuKSHq4J55CY5N8lLiDEJXLdZZFd0dEHttheFoIcYqzgLisqC7yOJyDlhsN932t6ALxj92wYL7MAT+lHC4X/9XSzzqsbqjPOa6V2LKkpFPtPw64SeaoCSkdQHGQlv88cZB3gdKPqs5kos5PHtpxqDRGVO/modZK+HYbeMH7w5PxQETZueNyayRLFcczSZyQkSN1ttKYYRIxM6C99ghMHa4g+xlGrfTcs64htAlCzckYO9UNMoyrWfj7XoHvoHwE7zN05nL0fzHKTQLpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=YOgsvd8l; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=YOgsvd8l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgHSq1kPnz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 04:43:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=AP49Wml/Qr/wzH3y6BxqbwOt7JtkHcoMn8XiWeebrkI=; t=1774374203;
	x=1774979003; b=YOgsvd8lK8vSzcL/e3EAcPJZ0S/g4bZORGwHQY8NquyLRbADXeuWmuzMo3ffC
	350JTb6+2VSL9LFNBvXu3RJHr5LpB6jro+MGwtsBirXpZyZ248oXZT8Iq9Q6EvUkkIr12kkf5p0CH
	F/trQVPs+OnBbi7/TLM0xNbo7AyNkHc3FUQf8m9DtZt0bpA7mL7M3360WTgYmuL2P9z30VHqlDYb/
	PSUa0VQgt4eabxfEGRth0+ZvKnHV4OepAIIiS9Ie+G0UTDjN7eEZY9pXyh0UK8oCy/mxO6PgqdVYX
	KP2j5kuDqTs5Pltwdq/CiBGHLkK9mHBdaAQAjerqWFiuNX2w/g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1w55mW-000000048aG-0PwD; Tue, 24 Mar 2026 18:43:08 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1w55mV-00000001qau-3Gph; Tue, 24 Mar 2026 18:43:07 +0100
Message-ID: <5de97ed9556bfcc3b1f26bd71e09fa4016ae3ff8.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 05/10] am68k/PCI: Remove unnecessary second application
 of align
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Guenter
 Roeck	 <linux@roeck-us.net>, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Michael Ellerman	 <mpe@ellerman.id.au>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar	 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen	 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Chris Zankel	 <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Madhavan Srinivasan	 <maddy@linux.ibm.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker	 <dalias@libc.org>,
 linux-kernel@vger.kernel.org
Date: Tue, 24 Mar 2026 18:43:06 +0100
In-Reply-To: <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
	 <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
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

Hi Ilpo,

On Tue, 2026-03-24 at 18:56 +0200, Ilpo J=C3=A4rvinen wrote:
> Aligning res->start by align inside pcibios_align_resource() is
> unnecessary because caller of pcibios_align_resource() is
> __find_resource_space() that aligns res->start with align before
> calling pcibios_align_resource().
>=20
> Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
> result in changing start either because 0x300 bits would have not
> survived the earlier alignment if align was large enough to have an
> impact.
>=20
> Thus, remove the duplicated aligning from pcibios_align_resource().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/m68k/kernel/pcibios.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index 1415f6e4e5ce..7e286ee1976b 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, cons=
t struct resource *res,
>  	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
>  		start =3D (start + 0x3ff) & ~0x3ff;
> =20
> -	start =3D (start + align - 1) & ~(align - 1);
> -
>  	return start;
>  }
>=20

Sorry if it's a stupid question, but what does "am68k" in the subject refer=
 to?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

