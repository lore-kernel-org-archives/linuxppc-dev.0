Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1291FDDED2
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 06:21:29 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3MKKOgH020751
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 13:20:25 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3MKKNTq026345
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 15:20:24 -0500 (CDT)
Date: Tue, 22 Apr 2008 15:20:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC POWERPC] booting-without-of: bindings for FHCI USB, GPIO LEDs,
	MCU, and NAND on UPM
Message-ID: <20080422202023.GA23165@ld0162-tx32.am.freescale.net>
References: <20080422194135.GA27822@polina.dev.rtsoft.ru>
	<fa686aa40804221308w5960ces1f03a6a8c049edd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40804221308w5960ces1f03a6a8c049edd4@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 02:08:45PM -0600, Grant Likely wrote:
> > +    Example:
> > +
> > +       usb-pram@8b00 {
> > +               compatible = "fsl,mpc8360-qe-muram-usb-pram",
> > +                            "fsl,qe-muram-usb-pram",
> > +                            "fsl,cpm-muram-usb-pram";
> > +               reg = <0x8b00 0x100>;
> > +       };

Why not put it as an additional reg resource on the ucc node, instead of
in its own node?  That's how existing CPM bindings do it.

> > +    t) Freescale QUICC Engine USB Controller
> > +
> > +    Required properties:
> > +      - compatible : should be "fsl,<chip>-qe-usb", "fsl,qe-usb",
> > +        "fsl,usb-fhci"
> 
> Again, I'd leave out "fsl,qe-usb" and "fsl,usb-fhci".

QE is the name of a specific IP block, and is unlikely to be broken in a
non-backwards-compatible manner without having a new name such as QE2.  I
think this is taking "no generic names" too far.  If these names *are*
left out, then at least document which chip we're supposed to pick out of
a hat to claim compatibility with.

-Scott
