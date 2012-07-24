Return-Path: <B10812@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7AD62C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 01:12:40 +1000 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>, Singh Sandeep-B37400
 <B37400@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [1/3][PATCH][upstream]Adding documentation for TDM
Date: Tue, 24 Jul 2012 15:12:31 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079B7B35@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <1343040588-16002-2-git-send-email-b37400@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B6FA4@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6FA4@saturn3.aculab.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks David for the comments.

Response Inline.

Regards
Poonam

> -----Original Message-----
> From: David Laight [mailto:David.Laight@ACULAB.COM]
> Sent: Monday, July 23, 2012 6:02 PM
> To: Singh Sandeep-B37400; linuxppc-dev@lists.ozlabs.org
> Cc: Singh Sandeep-B37400; Aggrwal Poonam-B10812
> Subject: RE: [1/3][PATCH][upstream]Adding documentation for TDM
>=20
> > +3. TDM has programmable slot length (8 bits or 16 bits). This can be
> > +   configured by:
> > +
> > +	#define NUM_BYTES_PER_SLOT	8
>=20
> I presume you meant NUM_BITS_PER_SLOT ?
> These constants need name-space protection
>=20
> > +or
> > +	#define NUM_BYTES_PER_SLOT	16
> > +
This is a mistake, documentation patch not updated with the update design.
> > +depending on the type of sample. For example the sample could be 16
> > +bit linear +or 8bit u-law encoded etc.
> > +Presently only word length of 16 is supported which is the default
> > +configuration.
>=20
> For flexibility you need to allow for 8bit samples being converted as:
> 1) 8bit raw ulaw or alaw data (unchanged from line).
> 2) 8bit raw data, bit reversed, any hdlc protocol
>    is bit reversed from audio [1].
> 3) 8bit audio, converted from alaw to ulaw
> 4) 8bit audio, converted from ulaw to alaw
> 5) 16bit linear converted to/from alaw or ulaw and on a per-timeslot
> basis.
I agree. That we only support very limited samples. But We can add this in =
second step once the basic framework is in.
Also right now the testing infrastructure we have, we won't be able to test=
 all these scenarios.

>=20
> [1] most hdlc stuff probably can't stand the 10ms epochs though, so this
> is limited use for serious work.
Right now the framework has been customized for voice. We can keep this par=
ameter as a sysfs knob. Please suggest.

Regards
Poonam
>=20
> 	David
>=20
>=20
>=20
