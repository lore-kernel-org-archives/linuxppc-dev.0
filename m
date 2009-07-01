Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B9AACB70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 03:04:41 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D707DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 03:04:40 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n61H4aaP013886
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jul 2009 10:04:37 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n61H4atj023619
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Jul 2009 12:04:36 -0500 (CDT)
Date: Wed, 1 Jul 2009 12:04:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Detlev Zundel <dzu@denx.de>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
Message-ID: <20090701170436.GA502@b07421-ec1.am.freescale.net>
References: <4A4901A8.5010402@mlbassoc.com>
	<97dd5fd20906291113t5ea98285h2db6379ff1a940c@mail.gmail.com>
	<4A490AE4.7000509@freescale.com>
	<97dd5fd20906291324jf085addjaa61ff48dfca3d04@mail.gmail.com>
	<4A49249C.5080101@freescale.com>
	<97dd5fd20906291346s3ee60edbr1863c27280ae373c@mail.gmail.com>
	<4A492C1A.6020302@freescale.com>
	<97dd5fd20906300911k7b1e72banf61bcb9ff500787@mail.gmail.com>
	<97dd5fd20906301048o30354271haf603a9bae29b0fe@mail.gmail.com>
	<m21vp0vbx2.fsf@ohwell.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m21vp0vbx2.fsf@ohwell.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 01, 2009 at 02:13:29PM +0200, Detlev Zundel wrote:
> Hi,
> 
> > As for my device tree, I reverted back to the original version with
> > nothing filled in and just replaced 0xfa20xxxx with 0xf000xxxx as Gary
> > suggested earlier.
> 
> Would it be a problem to also dynamically fixup IMMR in the device tree
> from U-Boot?

Yes.  It can appear in multiple places in the device tree (for exmaple,
in things like the localbus and pci nodes where we have some IMMR
registers but need ranges to point outside IMMR); this introduces more
dependencies between u-boot and the input dtb than just getting the
address right in the first place.

-Scott
