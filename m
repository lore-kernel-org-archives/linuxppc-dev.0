Return-Path: <linuxppc-dev+bounces-18923-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7615110ED658
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 10:29:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhxhb6pZtz2yjm;
	Fri, 27 Mar 2026 21:29:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774607359;
	cv=none; b=fhNdppu6F0OqGR1S0gX1HyqncuMyeHz8aJm/P6NcT1edVag6LmjP0UaXwBkRfeu4ZkIDAXKyyYWbpCndYgbj335RgHRBNK5ON87JAKgtPg/+0WyXmQs+P7Z7tjWvDh5ejCRq7P6rd+p84f1w1Vpa82TjFM6XAiPFwDrq6wWIVS+NRFj4nShk7oHTWKUyAWRh0f7wkrQIa/mU6R5J6Cgfme8do7JRWOkQn4p9lRd3SndY9cbzI61OQ0ValCdAFyYDj6Za7R8ofFdIFInlFbjt3UOXZw3AeN1GfLLcJowSNLvgnWDrqeRNoTe/D6lMZCUW3pGu0TeR+oxh+nwafv2VAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774607359; c=relaxed/relaxed;
	bh=SLijcu1fUO48QXHdB65tn3LL9j0JNLmqgKL8ts8akEg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YmCXLTIPGHbLt9cS2c8iPSnHUtcHJ6yaJSgZ1RqqrXVSyXt45fXuP1FfkXeeNZ160ITz5P4dD1yGzPYe6OnEwKyBybbUiV5CZhr+mwKKiocNidk7fKMxDd0hNzgwHUIlkxaZXYGMOqcaOIWSndWr7V+W/XgP6xGjXcXZSxx68XNPt/Rm4j+SKubVkQjIGQCTvPf6nQfmhVzWMODwqJ9HpK6b3nuLnr/RhUq1sNHTdj/GroY+xpB3Kkb9+rZilR+5aBatD4wdj/KP/mnmPUk/bxUNnrRgAetsBfRj/vVSX2A50RPx4OShp2FSuConsEK2jrH6/WXfMJe7nRcp89Pynw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CKnhLC53; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CKnhLC53;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhxhY2VhTz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 21:29:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774607358; x=1806143358;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AQrZsYS87uRLSAUzR2yt6e8HOvPMEsktxMC+0rqw0oY=;
  b=CKnhLC538G1acSAfGLVQ8OEmNbge3QYWTJiugyn0Mam586Wz7pFEn6V5
   KfPEifWhGV8sNTm7PQeK9FggjqnhffmOaWUImPhNE2tP3JdYfsj3nI3SQ
   MctWSSGH1ZnysrkszLGj/Z1YAUZGUHotCIfHINeDOyyPpAgt78vAwx2tp
   wAaWQnexf+2C3EZU7/ssyZxaaIs7nXRxFpg2u66gcC8MzcloJMpZ8XvEM
   OxcUdLAAv07SWoJxYiOphcNc2t5nTn1+OeBWF6l1LHeStbk619HZ93+7D
   0cHoJEmqvIRu8Ni80bih7VixEPF4g/+oActtKCY7KIitcFvdd1qt3gJuQ
   Q==;
X-CSE-ConnectionGUID: TPiGADKmSfqSWzjTxODMuA==
X-CSE-MsgGUID: Dxx54oEHTaSjzViGUEUM7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="93259320"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="93259320"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:29:12 -0700
X-CSE-ConnectionGUID: tBARr7F7SaCXrVZYlacT+g==
X-CSE-MsgGUID: 6iZuzsYWQBOngO/GpRvA3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="263218208"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:29:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 27 Mar 2026 12:28:56 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
    linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
    linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
    Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
    Max Filippov <jcmvbkbc@gmail.com>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    LKML <linux-kernel@vger.kernel.org>, Xifer <xiferdev@gmail.com>
Subject: Re: [PATCH 00/10] PCI: Improve head free space usage
In-Reply-To: <20260326192520.GA1337681@bhelgaas>
Message-ID: <7207cde7-d47e-f79c-afe9-9b1daa79140c@linux.intel.com>
References: <20260326192520.GA1337681@bhelgaas>
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
Content-Type: multipart/mixed; boundary="8323328-307680389-1774607336=:1037"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-307680389-1774607336=:1037
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 26 Mar 2026, Bjorn Helgaas wrote:

> [+cc Xifer; thanks very much for reporting and testing!]
>=20
> On Tue, Mar 24, 2026 at 06:56:23PM +0200, Ilpo J=C3=A4rvinen wrote:
> > Hi all,
> >=20
> > This series attempts to take advantage of free head space (the free
> > space before the aligned start address) in order to generally produce a
> > tighter packing of the resources/bridge windows.
> >=20
> > The recent changes to the resource fitting algorithm caused resource
> > allocation failures in some cases where a bridge window that is sized
> > to be gapless could no longer be assigned. The previous algorithm left
> > a huge gaps which allowed it to place the remainder (non-aligning part
> > of the size) before the start address of used for the gapless fit,
> > whereas the new gapless approach always had to place the remainder
> > after the aligning part of the resources. There is not always space
> > for the remainder triggering those failures (e.g., when the aligning
> > part must be placed at the top of the window).
> >=20
> > This series attempts to allow placing the remainder once again before
> > the aligning part, but now without leaving huge gaps to retain the
> > benefits of the gapless bridge windows. The approach is somewhat hacky
> > but should work thanks to PCI resources fundamentally consisting only
> > power-of-two atoms.
> >=20
> > There maybe cases where architecture would not want to do such
> > relocation. This series adds the relocation to arch
> > pcibios_align_resource() functions to allow all of them taking
> > advantage of the better resource packing but if somebody objects doing
> > this relocation for a particular arch, I can remove it, please just let
> > me know (this relocation doesn't seem critical unless there are
> > regressions).
> >=20
> > Ilpo J=C3=A4rvinen (10):
> >   resource: Add __resource_contains_unbound() for internal contains
> >     checks
> >   resource: Pass full extent of empty space to resource_alignf CB
> >   resource: Rename 'tmp' variable to 'full_avail'
> >   ARM/PCI: Remove unnecessary second application of align
> >   am68k/PCI: Remove unnecessary second application of align
> >   MIPS: PCI: Remove unnecessary second application of align
> >   parisc/PCI: Cleanup align handling
> >   PCI: Rename window_alignment() to pci_min_window_alignment()
> >   PCI: Align head space better
> >   PCI: Fix alignment calculation for resource size larger than align
> >=20
> >  arch/alpha/kernel/pci.c          |  1 +
> >  arch/arm/kernel/bios32.c         |  9 ++++---
> >  arch/m68k/kernel/pcibios.c       |  8 +++++--
> >  arch/mips/pci/pci-generic.c      |  8 ++++---
> >  arch/mips/pci/pci-legacy.c       |  3 +++
> >  arch/parisc/kernel/pci.c         | 17 ++++++++------
> >  arch/powerpc/kernel/pci-common.c |  6 ++++-
> >  arch/s390/pci/pci.c              |  1 +
> >  arch/sh/drivers/pci/pci.c        |  6 ++++-
> >  arch/x86/pci/i386.c              |  5 +++-
> >  arch/xtensa/kernel/pci.c         |  3 +++
> >  drivers/pci/pci.h                |  3 +++
> >  drivers/pci/setup-bus.c          | 15 ++++++++----
> >  drivers/pci/setup-res.c          | 40 +++++++++++++++++++++++++++++++-
> >  drivers/pcmcia/rsrc_nonstatic.c  |  3 ++-
> >  include/linux/ioport.h           | 22 +++++++++++++++---
> >  include/linux/pci.h              | 12 +++++++---
> >  kernel/resource.c                | 33 +++++++++++++-------------
> >  18 files changed, 149 insertions(+), 46 deletions(-)
>=20
> I added Xifer's tested-by, fixed the "am68k" and missing "if"
> typos, and applied these to pci/resource for v7.1.
>=20
> Ilpo, if you post a v2 with more changes, I'll update to it.  I
> applied the series now to get a head start on 0-day building and into
> next.

Thanks.

I don't have anything in addition to those.

--=20
 i.

--8323328-307680389-1774607336=:1037--

