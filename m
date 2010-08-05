Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id CE060B6EE8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 04:47:02 +1000 (EST)
Received: from mail22-tx2 (localhost.localdomain [127.0.0.1])	by
	mail22-tx2-R.bigfish.com (Postfix) with ESMTP id E7DA2BF8487	for
	<linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 18:46:58 +0000 (UTC)
Received: from TX2EHSMHS029.bigfish.com (unknown [10.9.14.242])	by
	mail22-tx2.bigfish.com (Postfix) with ESMTP id 8BAEB85804E	for
	<linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 18:46:58 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o75IktcG012614	for <linuxppc-dev@ozlabs.org>;
	Thu, 5 Aug 2010 11:46:55 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o75Il1Zd010256	for <linuxppc-dev@ozlabs.org>;
	Thu, 5 Aug 2010 13:47:01 -0500 (CDT)
Date: Thu, 5 Aug 2010 13:46:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: Relocating bootwrapper causes kernel panic
Message-ID: <20100805134654.70f8f787@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTinqLCvRii4zCArHG=whHa0H6bparf=5sUkGDUTw@mail.gmail.com>
References: <AANLkTi=x-EA59xfn_r5xMuJL6mufObSvSSEOeY9KTjQS@mail.gmail.com>
	<AANLkTin3u=U-L2grncS_UtWqkGnb9bNUy4a4nqkRhQQ9@mail.gmail.com>
	<AANLkTikS3f8q+Kuq8aYX1vhRotfSMHN_S+qKPwrfDn2j@mail.gmail.com>
	<20100805123725.63d009b1@schlenkerla.am.freescale.net>
	<AANLkTinqLCvRii4zCArHG=whHa0H6bparf=5sUkGDUTw@mail.gmail.com>
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

On Thu, 5 Aug 2010 11:33:44 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> >> > Before the flat tree was accessed, I checked the DTLB and didn't find
> >> > any entry related to 0xc0be4300. After the exception, I found the
> >> > following DTLBs.
> >> >
> >> > 30 : 02 =A0c0be4000 =A0 4KB ------ -> 00000000
> >> > 31 : 00 =A0fa000000 =A0 8MB VI-S-M -> fa000000
> >> >
> >> > The DTLB#30 doesn't seem right. Why would it map to 0x0? I think this
> >> > should be something like 00be4000?
> >
> > Note that the valid bit is clear -- it's not mapping to anything.
>=20
> Did the exception handler try to set a TLB here but the setting was
> not completed?

Probably.  You won't have any page tables yet, much less an entry for
the device tree.

> >> I think the cause is clear now. But how to fix it? Two questions:
> >> 2. If the DTLB miss exception handler is not the right guy to load a
> >> proper TLB entry, how can I set one entry based on the link_address
> >> and the address of the flat dt blob?
> >
> > Given how early in the boot process it is, it's probably going to need
> > to be handled specially.
>=20
> What APIs can I use to set up DTLBs?

I don't think there is one that works on 8xx.  You'll could hack up
initial_mmu, or else write some C code to insert an 8xx TLB entry.

-Scott
