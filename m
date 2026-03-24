Return-Path: <linuxppc-dev+bounces-18739-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013E3FEC0E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgHlm32Jpz2yng;
	Wed, 25 Mar 2026 04:56:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774374980;
	cv=none; b=I5XJ4KpGbBrsulfNHLbHHvJDNDGQIG+rfuRNd1cUqoaaAIM7M1mfFiEmnXgMwqQjQuD22ljTuLneQuET3Ri2aecVHC3yn/OrwsHD9TyTYUh3AfdgV9rGkkHp1hRMGGJeJn4rK2TuS4sJdLQ/sXEL5IpjbJYGjn5qFug63CtUdXo0fCJso3HoFRo3h7gMkwWCtIACVa23pfwlmVjh1GAHpyMuBJaH9ULvd6svKegcIfBxT5x8yZQoRibfnpMiDdqPg3l0xhDw5ARbBy84ql0guGgZKDmnXpa2vHLLnCKVj4wSKscfbx1l9Maijif65PVt4a3BHBX1W8BgzdHqaRb6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774374980; c=relaxed/relaxed;
	bh=o4Skp0d0PaeQO+3Y+N+lz2SpTD1JG+jzc8wIlPQ0pik=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KGN8eMGWiJIq2uDi+t8/jW+CM5gwzy4a6hoJSrb5v3Dow/M8YHQjzWLgDVvg4CnjlgfsytnKxYbyXRfoEBBy39LNyRz/WRL53cV85pauW5sLMQHf4fokCsSvfcJDrSbh6Psj0DJhV1Ra4NCKBNyCZvzC5wSgB2EV9Wxbi1bmoMLzaLHtmmHbpw5CvK7udOhS+Y1DUeuujxrrqqamXSbSRVqs4gfR0Ape2T2lw9hqe/1DQR2Xc0stwhVjrK0R6Grr6vRfYScPnFaATF2Js8jgU7HDkRza8y+zuxYz+lo5qxZYetOVccrYpnxAg5IXseZUXk2S9wYn6VUFns4ZTU+oHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VLJCkQkf; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VLJCkQkf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgHlj6sN3z2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 04:56:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774374978; x=1805910978;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NL1mcB9ozeqOSsqCkkguLMRCIYPAgFUo0JaJzh10URc=;
  b=VLJCkQkfa91tOKK4dmtRsr3i3IZLqjakUDrbgumh/0lMn9AxB8/3rEYr
   3KE5TOevH/O1T9ZvSdL0LMwY7R9LvpjYJtu+LBv8NG0DENM8pfFJyWv6t
   XUKRr+EhOK+TJvbBFOoLl7zf4gJyla0+FsUBvZ8yqceUiaoz2gM9qVwcY
   6daXTCBfZ9I/doHgckSLKNXx7fmzw5H3xOvPWCg5L0NHQ+OsKphZRIgSb
   M/p9RkXD/Bh4l1NFMFgBrpGEFQLmKYInm9C1uVCn/wuYnTpLx4LCK0Ga1
   7eqmUCN4jPUDZOd4mSBkMzoKTCghJSBa2+0dMUn8mMYi881cTxad68fwL
   A==;
X-CSE-ConnectionGUID: nkcW9dEeRjeVvn1jO+arGw==
X-CSE-MsgGUID: qZdzIr4qR22IMzuFwxUgzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75307434"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75307434"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:55:45 -0700
X-CSE-ConnectionGUID: mUXuAQFLRnadhyMeGmty4g==
X-CSE-MsgGUID: bujbx+8xS52CYl9LobjFjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="220002724"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:55:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Mar 2026 19:55:32 +0200 (EET)
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
    linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
    linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
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
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/10] am68k/PCI: Remove unnecessary second application
 of align
In-Reply-To: <5de97ed9556bfcc3b1f26bd71e09fa4016ae3ff8.camel@physik.fu-berlin.de>
Message-ID: <1c08efcd-25e8-6436-52ab-ac3d50dcf58f@linux.intel.com>
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>  <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com> <5de97ed9556bfcc3b1f26bd71e09fa4016ae3ff8.camel@physik.fu-berlin.de>
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
Content-Type: multipart/mixed; boundary="8323328-641337346-1774374932=:1055"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-641337346-1774374932=:1055
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Mar 2026, John Paul Adrian Glaubitz wrote:

> Hi Ilpo,
>=20
> On Tue, 2026-03-24 at 18:56 +0200, Ilpo J=C3=A4rvinen wrote:
> > Aligning res->start by align inside pcibios_align_resource() is
> > unnecessary because caller of pcibios_align_resource() is
> > __find_resource_space() that aligns res->start with align before
> > calling pcibios_align_resource().
> >=20
> > Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
> > result in changing start either because 0x300 bits would have not
> > survived the earlier alignment if align was large enough to have an
> > impact.
> >=20
> > Thus, remove the duplicated aligning from pcibios_align_resource().
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  arch/m68k/kernel/pcibios.c | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
> > diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> > index 1415f6e4e5ce..7e286ee1976b 100644
> > --- a/arch/m68k/kernel/pcibios.c
> > +++ b/arch/m68k/kernel/pcibios.c
> > @@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, co=
nst struct resource *res,
> >  =09if ((res->flags & IORESOURCE_IO) && (start & 0x300))
> >  =09=09start =3D (start + 0x3ff) & ~0x3ff;
> > =20
> > -=09start =3D (start + align - 1) & ~(align - 1);
> > -
> >  =09return start;
> >  }
> >=20
>=20
> Sorry if it's a stupid question, but what does "am68k" in the subject ref=
er to?

The extra "a" is a typo. I'm sorry about that.

--=20
 i.

--8323328-641337346-1774374932=:1055--

