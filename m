Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1A5E22C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 04:43:19 +1000 (EST)
Date: Tue, 23 Jul 2013 13:43:04 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] power/mpc85xx: Add delay after enabling I2C master
To: York Sun <yorksun@freescale.com>
In-Reply-To: <51EEA34A.9050400@freescale.com> (from yorksun@freescale.com on
 Tue Jul 23 10:37:46 2013)
Message-ID: <1374604984.15592.34@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: albrecht.dress@arcor.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 10:37:46 AM, York Sun wrote:
> On 07/22/2013 05:33 PM, Scott Wood wrote:
> > On Mon, May 13, 2013 at 02:27:08PM -0700, York Sun wrote:
> >> Erratum A-006037 indicates I2C controller executes the write to =20
> I2CCR only
> >> after it sees SCL idle for 64K cycle of internal I2C controller =20
> clocks. If
> >> during this waiting period, I2C controller is disabled (I2CCR[MEN] =20
> set to
> >> 0), then the controller could end in bad state, and hang the =20
> future access
> >> to I2C register.
> >>
> >> The mpc_i2c_fixup() function tries to recover the bus from a =20
> stalled state
> >> where the 9th clock pulse wasn't generated. However, this =20
> workaround
> >> disables and enables I2C controller without meeting waiting =20
> requirement of
> >> this erratum.
> >>
> >> This erratum applies to some 85xx SoCs. It is safe to apply to all =20
> of them
> >> for mpc_i2c_fixup().
> >>
> >> Signed-off-by: York Sun <yorksun@freescale.com>
> >>
> >> ---
> >> I'd like to get rid of the #ifdef if mpc5121 is OK with the longer =20
> delay.
> >
> > Are mpc5121 and mpc85xx the only things that use this?
>=20
> No. 83xx and 86xx also uses this file. But I am only unsure if mpc52xx
> is OK with this extended delay. I guess they are but I don't have a
> proof, or someone to confirm.
>=20
> >
> > Are you sure the delay always works out to be longer?  What is the
> > relationship between fsl_get_sys_freq() and i2c->real_clk?
>=20
> Yes. The max divider from sys clock to i2c clcok is 32K.
> i2c->real_clk is the clock I2C controller pumps out, not its internal =20
> operation clock.

32K is the max for all implementations?

BTW, Where does the "2000000" come from?  Shouldn't it be 1000000 if =20
you're converting to usec?  If you're trying to add some slack, say so =20
rather than having a comment suggest that the output of that formula is =20
64K cycles.  Or is there an implicit assumption that i2c runs at half =20
the system frequency?  Is that assumption true for all implementations =20
that have this erratum?

> > In any case, you should send this patch to the i2c maintainer and =20
> list.
> >
>=20
> I don't have the name on top of my head. Is that =20
> linux-i2c@vger.kernel.org?

Yes, and Wolfram Sang <wsa@the-dreams.de> is the maintainer.  This is =20
listed in the MAINTAINERS file.

-Scott=
