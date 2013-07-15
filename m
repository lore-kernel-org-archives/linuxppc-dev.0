Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D98A2C0138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 02:54:08 +1000 (EST)
Date: Mon, 15 Jul 2013 11:53:54 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-booke: Work around erratum A-006958
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72E1@saturn3.aculab.com>
 (from David.Laight@ACULAB.COM on Mon Jul 15 03:45:36 2013)
Message-ID: <1373907234.8183.297@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2013 03:45:36 AM, David Laight wrote:
> > +#define MFTB(dest, scratch1, scratch2)	\
> > +90:	mftbu	scratch1;		\
> > +	mftbl	dest;			\
> > +	mftbu	scratch2;		\
> > +	cmpw	scratch1,scratch2;	\
> > +	bne	90b;			\
> > +	rldimi	dest,scratch1,32,0;
>=20
> Are the three mftbu/l instructions guaranteed to be executed
> in order?

This is the architecturally defined instruction sequence for 32-bit, =20
and is what the erratum writeup says to use.

> Also, if the high word changes, there is no need to loop.
> Just return the second value with a low word of zero
> (the returned count happened while the function was active).

That would be more complicated than looping.

> If the mftbx instructions are synchronizing ones (or need
> sequencing), then it might be possible to only have 2 of them
> by reading the 64bit value and the high 32bits.
> (The correct order depends on the exact definition of the errata!)

Again, I'm not sure how helpful that would be, and it would be =20
deviating from the instruction sequence called for by the erratum text, =20
which says to use the instruction sequence used on 32-bit.

> Another option is that the 64bit value returned by mftb is
> (presumably) only likely to be wrong when the low 32bits is
> very near zero (either side).
> A second mftb could be done in this case only with some logic
> to work out a valid result (I think):
>   High changed - 2nd high, low zero.
>   First low -ve - first value.
>   First low +ve - second value.

Likewise.

-Scott=
