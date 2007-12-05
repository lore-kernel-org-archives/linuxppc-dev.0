Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF038DDEEC
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 05:05:13 +1100 (EST)
Subject: Re: [PATCH] Add aliases node to 8641hpcn DTS file.
From: Jon Loeliger <jdl@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40712050938j2d286655o94534a00131872e2@mail.gmail.com>
References: <1196875970.8544.12.camel@ld0161-tx32>
	<fa686aa40712050938j2d286655o94534a00131872e2@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1196877907.8544.15.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 05 Dec 2007 12:05:07 -0600
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-12-05 at 11:38, Grant Likely wrote:

> >
> > +       aliases {
> > +               ethernet0 = &enet0;
> > +               ethernet1 = &enet1;
> > +               ethernet2 = &enet2;
> > +               ethernet3 = &enet3;
> > +               serial0 = &serial0;
> > +               serial1 = &serial1;
> > +               pci0 = &pci0;
> > +               pci1 = &pci1;
> > +       };
> 
> I had thought aliases were supposed to be full paths to nodes instead
> of phandles.  Was I wrong?

Indeed, that is correct.  And they are!

=> fdt addr c00000
=> fdt print /aliases
aliases {
        ethernet0 = "/soc8641@f8000000/ethernet@24000";
        ethernet1 = "/soc8641@f8000000/ethernet@25000";
        ethernet2 = "/soc8641@f8000000/ethernet@26000";
        ethernet3 = "/soc8641@f8000000/ethernet@27000";
        serial0 = "/soc8641@f8000000/serial@4500";
        serial1 = "/soc8641@f8000000/serial@4600";
        pci0 = "/pcie@f8008000";
        pci1 = "/pcie@f8009000";
};
=> bootm 1000000 - c00000

Grant, you need to keep up, man.  Just this morning
I pushed Gibson's patch to DTC to support this. :-)

jdl
