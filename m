Return-Path: <fkan@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2F91ADE1C4
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 12:19:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Broken PCI on Sequoia
Date: Fri, 30 Jan 2009 17:19:11 -0800
Message-ID: <2B3B2AA816369A4E87D7BE63EC9D2F260674E7E3@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1233351024.18767.32.camel@pasglop>
References: <alpine.LRH.2.00.0901291819440.22142@vixen.sonytel.be><1233267061.18767.5.camel@pasglop><20090130001842.GB3943@zod.rchland.ibm.com><1233281333.18767.15.camel@pasglop><alpine.LRH.2.00.0901301334220.13283@vixen.sonytel.be><1233349323.18767.31.camel@pasglop>
	<1233351024.18767.32.camel@pasglop>
From: "Feng Kan" <fkan@amcc.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi:
   It looks like the top bit is hard coded to 1. There doesn't seem to
be anyway
Of changing it.=20

Feng Kan
AMCC Engineering

-----Original Message-----
From: linuxppc-dev-bounces+fkan=3Damcc.com@ozlabs.org
[mailto:linuxppc-dev-bounces+fkan=3Damcc.com@ozlabs.org] On Behalf Of
Benjamin Herrenschmidt
Sent: Friday, January 30, 2009 1:30 PM
To: Geert Uytterhoeven
Cc: Linux/PPC Development
Subject: Re: Broken PCI on Sequoia


> For that sort of 4xx PHB (ie, the PCI 2.x ones, not the PCI-X nor the
> PCI-E), we only know how to program 32-bit of PLB address. IE. The old
> code would have cropped the plb_addr when writing to the register, the
> new code complains.
>=20
> I suspect some implementation support a register to put the "high"
part
> of the PLB address, and that it already contains 1, so the old code
> would have worked by chance, the new code doesn't because it bails
out.

Hrm... from the doco it's also one 32-bit register... I'm starting to
think that those guys always assume the top 1 bit is set or something
like that ...

The doc is unclear. Maybe somebody form AMCC can confirm ?

Cheers,
Ben.


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
