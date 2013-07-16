Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3444E2C0151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jul 2013 04:17:00 +1000 (EST)
Date: Tue, 16 Jul 2013 13:16:40 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-booke: Work around erratum A-006958
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72E2@saturn3.aculab.com>
 (from David.Laight@ACULAB.COM on Tue Jul 16 03:28:06 2013)
Message-ID: <1373998600.8183.334@snotra>
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

On 07/16/2013 03:28:06 AM, David Laight wrote:
> > On 07/15/2013 11:53:54 AM, Scott Wood wrote:
> > > On 07/15/2013 03:45:36 AM, David Laight wrote:
> > >> Also, if the high word changes, there is no need to loop.
> > >> Just return the second value with a low word of zero
> > >> (the returned count happened while the function was active).
> > >
> > > That would be more complicated than looping.
>=20
> I'm not that familiar with the ppc instructions set, but on x86
> the equivalent instructions are synchronising ones - so can have
> performance penalties, so a few extra 'normal' instructions to
> avoid re-reading the timebase counter may be worth while.

The core manual doesn't list any special syncronization for it, though =20
it does take 4 cycles.

> The branch for the loop might also be statically predicted 'taken'
> leading to a branch misprediction penalty as well.

The branch predictor should work fine most of the time.

> > That said, it's since been confirmed internally that the low word
> > should always be zero when this happens, so we could share the Cell
> > workaround code -- as long as we do something special in the =20
> timebase
> > sync code so that we don't get stuck if the timebase happens to be
> > frozen with TBL=3D=3D0.  This would avoid the need for scratch register=
s
> > (other than CR0).
>=20
> Yes - if the actual errata is that the low word is read one clock
> later then the high word then the only illegal value is one where
> the low word is zero.

It's actually the timebase itself that is updated in the low word =20
first...

> In that case it is sufficient to reread the counter - it can't be
> wrong again!

...which means, while it *probably* won't be wrong again, I'd want a =20
statement from the hardware people that this is guaranteed if we were =20
to rely on it.

The workaround for a similar bug on Cell rereads until the lower half =20
is non-zero, which will be fine as long as we avoid the workaround in =20
timebase sync code (when the timebase is frozen).

-Scott=
