Return-Path: <Marc.Howard@kla-tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89C4167B58
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 11:20:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 440gx GPIO
Date: Tue, 14 Feb 2006 16:01:23 -0800
Message-ID: <91B22F93A880FA48879475E134D6F0BE023887B6@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@kla-tencor.com>
To: "Ed Goforth" <egoforth@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+marc.howard=3Dkla-tencor.com@ozlabs.or
> g=20
> [mailto:linuxppc-embedded-bounces+marc.howard=3Dkla-tencor.com@o
> zlabs.org] On Behalf Of Ed Goforth
> Sent: Tuesday, February 14, 2006 1:47 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: 440gx GPIO
> .....=20
> Well, I was able to manipulate GPIO9, GPIO10 and GPIO12.  It's time to
> turn it over to the hardware people.
>=20

It's AMCC's fault.  They aren't listing the latest errata on their
website.  I downloaded their rev 3.1 ver 1.03 errata last August.
However if you look today you get the rev 3.1 ver 1.02 release.

In the 1.03 errata there is the following bug listed:

*************

GPIO_1:SDR0_PFC[G11E] has no effect.
Category: 6
Overview:
The SDR0_PFC[G11E] bit does not control GPIO11, thus meaning that GPIO11
is always active (unless EMAC group 4 is selected and both GPHYs are in
modes 0 or 1).
  =20
Impact:No impact.
Workaround:
None.

**************

Thus the PFC bit doesn't do anything.  If you're using group 4 "modes 0
or 1" (which mode field are they talking about here?) you're screwed,
you can't use GPIO11.

Curious how they think this has "No impact".  If you're running RGMII
you don't need that pin and it should be available for GPIO11 but
apparently it isn't.

Marc
