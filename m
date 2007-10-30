Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2536ADE338
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 03:23:26 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9UGNE5J002560
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 09:23:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9UGNDnj014394
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 11:23:14 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC:  replace device_type with new "class" property?
Date: Tue, 30 Oct 2007 09:23:14 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3035F278B@az33exm25.fsl.freescale.net>
In-Reply-To: <20071030005146.GF29263@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Olof Johansson" <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Explicitly specifying what device class bindings / conventions the
> node complies with is cute, but not actually all that useful in
> practice.  If it looks like a "duck" class device node, and it
> quacks^Whas the properties of a "duck" class device node, it's "duck"
> class compliant.

Don't know how cute it is, but I think it is practically=20
helpful.   Take another example:

Say you-- a human reader-- see this in a device
tree:

...
interrupts =3D <b 8>;
interrupt-parent =3D < &mpic >;
...

What does the 'b' and '8' mean?  You look
at the interrupt controller node--

  mpic: pic@40000 {
     clock-frequency =3D <0>;
     interrupt-controller;
     #address-cells =3D <0>;
     #interrupt-cells =3D <2>;
     reg =3D <40000 40000>;
     compatible =3D "fsl,xyz";
     big-endian;
}

Note-- I removed the device_type property and changed
compatible somewhat.  How are you going to find where
the meaning interrupt controller's interrupt cells are
defined?   What spec will you look at?

device_type =3D "open-pic"; makes it perfectly clear.
It's an open-pic type controller and follows that
binding.

Stuart
