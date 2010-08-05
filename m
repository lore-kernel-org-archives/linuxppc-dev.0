Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id D80F9B6F0E
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 03:37:32 +1000 (EST)
Received: from mail121-va3 (localhost.localdomain [127.0.0.1])	by
	mail121-va3-R.bigfish.com (Postfix) with ESMTP id 10ADAF68244	for
	<linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 17:37:29 +0000 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.249])	by
	mail121-va3.bigfish.com (Postfix) with ESMTP id B6D4C11D8046	for
	<linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 17:37:28 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o75HbRLx000964	for <linuxppc-dev@ozlabs.org>;
	Thu, 5 Aug 2010 10:37:27 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o75HbXi1023871	for <linuxppc-dev@ozlabs.org>;
	Thu, 5 Aug 2010 12:37:33 -0500 (CDT)
Date: Thu, 5 Aug 2010 12:37:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: Relocating bootwrapper causes kernel panic
Message-ID: <20100805123725.63d009b1@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTikS3f8q+Kuq8aYX1vhRotfSMHN_S+qKPwrfDn2j@mail.gmail.com>
References: <AANLkTi=x-EA59xfn_r5xMuJL6mufObSvSSEOeY9KTjQS@mail.gmail.com>
	<AANLkTin3u=U-L2grncS_UtWqkGnb9bNUy4a4nqkRhQQ9@mail.gmail.com>
	<AANLkTikS3f8q+Kuq8aYX1vhRotfSMHN_S+qKPwrfDn2j@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 5 Aug 2010 00:23:17 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> >> The flat tree located at 0xbe4300 as the kerne message showed. Why
> >> cannot the kernel access this area? No TLB set for this area?
> >>
> >> <1>Unable to handle kernel paging request for data at address 0xc0be43=
08
> >> <1>Faulting instruction address: 0xc01fdabc
> >> <4>Oops: Kernel access of bad area, sig: 11 [#1]
> >
> > Before the flat tree was accessed, I checked the DTLB and didn't find
> > any entry related to 0xc0be4300. After the exception, I found the
> > following DTLBs.
> >
> > 30 : 02 =A0c0be4000 =A0 4KB ------ -> 00000000
> > 31 : 00 =A0fa000000 =A0 8MB VI-S-M -> fa000000
> >
> > The DTLB#30 doesn't seem right. Why would it map to 0x0? I think this
> > should be something like 00be4000?

Note that the valid bit is clear -- it's not mapping to anything.

> When the early_debug is enabled, the kernel can boot successfully. I
> checked the TLB settings and found the following.
>=20
> 28 : 00  c0000000   8MB V--S-M -> 00000000
> 29 : 00  fa000000   8MB VI-S-M -> fa000000
> 30 : 00  c0800000   8MB V--S-M -> 00800000
> 31 : 14  04919000   ?KB V---WM -> 00e45000

That last entry looks weird... might want to look into that.

> So the kernel can access the dtb at 0xbe4300 because of the pinned down D=
TLB#30.
>=20
> I think the cause is clear now. But how to fix it? Two questions:
> 1. Should this DTLB miss exception properly set a new TLB entry for
> the new dtb address 0xbe4300?

Not if it doesn't find an entry in the page tables.

> 2. If the DTLB miss exception handler is not the right guy to load a
> proper TLB entry, how can I set one entry based on the link_address
> and the address of the flat dt blob?

Given how early in the boot process it is, it's probably going to need
to be handled specially.

-Scott
