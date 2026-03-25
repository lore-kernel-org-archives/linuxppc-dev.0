Return-Path: <linuxppc-dev+bounces-18773-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDD5106B506
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 12:04:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fglvB17X8z2xlt;
	Wed, 25 Mar 2026 23:04:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774440262;
	cv=none; b=R4ieYfj13+f/OvCvRrRyWASYon9gf4XV0aBKsWpBQqiMP0bdB5fUwV7IkcjRVWBdjiB4eCBvHtW1e5iRWAp+bKUr6QhfrAnuFfHu6DSsu+OZ73xygPRTU1fNwnEZxGmMp04HnO6qcKoHqLVyl78k0yLhuMWyZ8C/r3LYjmG6rbFsX1f2Xw9RRA0kvoXmHIOPLOkXsLrnHDjdEt5fcLMTThJ8vBmgsuE2KlKtmG1/MVL7BYmbgLdkcVDTpoWRJbCooL1wqUtiFqjTf2aItcfrMfxGU71J29EeWGcYCl3y3khtikaSgeamB/HFWM35nYUxYfQB7BcRyndu7bfRV/AhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774440262; c=relaxed/relaxed;
	bh=cUg0TZE02i0OBp5PS3uAaiZ2fcbewL1haWJ/BT+KAlo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A+mh8IfyJz90yupRBofXbexXjmVF3cO7ypBI5QRHRqfy3gY1fvJB/PLEk55oSJ6C3QNG70YbriRjJekAjhV+uXTXSuNWH16QZHJgbATzQvxGxnh7fUiMMlMcS5w1OsCG20n+y2SyOR9jOBc1fUsQ7l3weWkFTJ48261xEwaMv1jUNhmQ9yxUphw3LooblHUt3OwV4DnFcvKX9LQ5Wd13hX3GHRp8IPvJUIhrR7/tujxJCjb/XC/8A/Vkoo33v80bENA/f5nGo3Yvyh0ZW7+2WR9wjD6c2nRJlArLldDIv4ZU/RPPBui7xO0wY/+ySIydTcznjmExEPQygwJhZkW4hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O/v7lq0B; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O/v7lq0B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fglv75235z2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 23:04:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774440260; x=1805976260;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pthnvpb4bRgKrgjRM/7gqeUF0giUw3hMBAx3mtd0Tfk=;
  b=O/v7lq0BkpL/9inHRU+zpx0ck0NkBuVkPeIZl47Xwjbo6Ss0WyNOIkZT
   m3/eQu24mNDdU5zYVKbd3PXf8u0+Kk3qPe+JlTRLrOoJyqiEl96I2GFDb
   AaoQHxFF2aUc7UzZs4FJy3xqSGB9eAA0+ob6oyQfAHeV6M79CKn63OeUt
   SMnSXQApS3qVr29Q2Jw6jmew3/0ZfWTXYEMe7CRKAS7GC7bbacT8soVhe
   5ZHmPA97U3C2oL8TDLsDhat2NMgey6UhX+EI82ZRaayWH80PCsv4mZtk2
   yZ5bnQAfInlGX9SsTBMK1S1eZFu41Cd7pXg6A6qF44fGiH11VPmRuXQtP
   w==;
X-CSE-ConnectionGUID: b9vVka/8QWWS846xRH6udA==
X-CSE-MsgGUID: dWOrvaVdSRaqrnFoSQKNwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79381343"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="79381343"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:04:16 -0700
X-CSE-ConnectionGUID: GDVCGG5yQPG4XMQBFBjvAw==
X-CSE-MsgGUID: 2mzDZ70tTHGJhYkLqZAkRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="255160046"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:04:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 25 Mar 2026 14:04:03 +0200 (EET)
To: linux-pci@vger.kernel.org
cc: Bjorn Helgaas <bhelgaas@google.com>, Guenter Roeck <linux@roeck-us.net>, 
    linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
    linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
    Russell King <linux@armlinux.org.uk>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
    Max Filippov <jcmvbkbc@gmail.com>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Nicholas Piggin <npiggin@gmail.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, x86@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] PCI: Align head space better
In-Reply-To: <20260324165633.4583-10-ilpo.jarvinen@linux.intel.com>
Message-ID: <3a51ad39-558f-860d-4920-9f757b7d5131@linux.intel.com>
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com> <20260324165633.4583-10-ilpo.jarvinen@linux.intel.com>
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
Content-Type: multipart/mixed; boundary="8323328-1062646629-1774440243=:976"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1062646629-1774440243=:976
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Mar 2026, Ilpo J=C3=A4rvinen wrote:

> When a bridge window contains big and small resource(s), the small
> resource(s) may not amount to the half of the size of the big resource
> which would allow calculate_head_align() to shrink the head alignment.
> This results in always placing the small resource(s) after the big
> resource.
>=20
> In general, it would be good to be able to place the small resource(s)
> before the big resource to achieve better utilization of the address
> space. In the cases where the large resource can only fit at the end
> of the window, it is even required.
>=20
> However, carrying the information over from pbus_size_mem() and
> calculate_head_align() to __pci_assign_resource() and
> pcibios_align_resource() is not easy with the current data structures.
>=20
> A somewhat hacky way to move the non-aligning tail part to the head is
> possible within pcibios_align_resource(). The free space between the
> start of the free space span and the aligned start address can be
> compared with the non-aligning remainder of the size. If the free space
> is larger than the remainder, placing the remainder before the start
> address is possible. This relocation should generally work, because PCI
> resources consist only power-of-2 atoms.
>=20
> Various arch requirements may still need to override the relocation, so
> the relocation is only applied selectively in such cases.
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221205
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/arm/kernel/bios32.c         |  3 +++
>  arch/m68k/kernel/pcibios.c       |  4 ++++
>  arch/mips/pci/pci-generic.c      |  3 +++
>  arch/mips/pci/pci-legacy.c       |  2 ++
>  arch/parisc/kernel/pci.c         |  3 +++
>  arch/powerpc/kernel/pci-common.c |  2 ++
>  arch/sh/drivers/pci/pci.c        |  2 ++
>  arch/x86/pci/i386.c              |  2 ++
>  arch/xtensa/kernel/pci.c         |  2 ++
>  drivers/pci/setup-res.c          | 39 +++++++++++++++++++++++++++++++-
>  include/linux/pci.h              |  5 ++++
>  kernel/resource.c                |  2 +-
>  12 files changed, 67 insertions(+), 2 deletions(-)

> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index 7a0522316ee3..994c3bd36ef2 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -185,6 +185,8 @@ resource_size_t pcibios_align_resource(void *data, co=
nst struct resource *res,
>  =09=09 */
>  =09=09if (start & 0x300)
>  =09=09=09start =3D (start + 0x3ff) & ~0x3ff;
> +=09} else (res->flags & IORESOURCE_MEM) {

I'll be adding the missing if into this in v2 (found by sashiko). It seems=
=20
lkp didn't test this so it was not caught earlier.

> +=09=09start =3D pci_align_resource(dev, res, empty_res, size, align);
>  =09}
> =20
>  =09return start;

--=20
 i.

--8323328-1062646629-1774440243=:976--

