Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50486B7E7F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 04:15:20 +1100 (EST)
In-Reply-To: <2921453.1266505456809.JavaMail.ngmail@webmail09.arcor-online.net>
References: <2921453.1266505456809.JavaMail.ngmail@webmail09.arcor-online.net>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: "=?ISO-8859-15?Q?Albrecht_Dre=DF?=" <albrecht.dress@arcor.de>
Message-ID: <OFC412BED7.5D5934A3-ONC12576CE.005D5F44-C12576CE.005EBE55@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 18 Feb 2010 18:14:51 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	ben-linux@fluff.org, iws@ovro.caltech.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Albrecht Dre=DF" <albrecht.dress@arcor.de> wrote on 2010/02/18 16:04:1=
6:
>
> Hi Joakim:
>
> [snip]
> > >   static void mpc_i2c_fixup(struct mpc_i2c *i2c)
> > >   {
> > > -   writeccr(i2c, 0);
> > > -   udelay(30);
> > > -   writeccr(i2c, CCR_MEN);
> > > -   udelay(30);
> > > -   writeccr(i2c, CCR_MSTA | CCR_MTX);
> > > -   udelay(30);
> > > -   writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> > > -   udelay(30);
> > > -   writeccr(i2c, CCR_MEN);
> > > -   udelay(30);
> > > +   int k;
> > > +   u32 delay_val =3D 1000000 / i2c->real_clk + 1;
> > > +
> > > +   if (delay_val < 2)
> > > +      delay_val =3D 2;
> > > +
> > > +   for (k =3D 9; k; k--) {
> > > +      writeccr(i2c, 0);
> > > +      writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> > > +      udelay(delay_val);
> > > +      writeccr(i2c, CCR_MEN);
> > > +      udelay(delay_val << 1);
> > > +   }
> > >   }
> >
> > I am curious, didn't old method work with by just wrapping
> > a for(k=3D9; k; k--) around it? How did the wave form look?
>
> Sure does that work!  The waveform was somewhat "streched", mainly du=
e to the
> delays between some of the writeccr() calls which don't change the sd=
a/scl
> lines.  Unfortunately I didn't take shots from the scope.

Yeah, the long delays has to go. So the wave form was the same but more=
 stretched
in time? I ask because I don't understand the writeccr(i2c, CCR_MSTA | =
CCR_MTX);
is supposed to do.

>
> However, for *one* cycle, the old code needed (only counting the udel=
ay's) 150
> us.  For 9 cycles, it's 1.35 ms, which isn't really nice ;-).  At 375=
 kHz real
> clock rate, delay_val is 3, i.e. each cycle consumes 9 us, or 81 us f=
or the
> whole fixup procedure.  If the clock is slower, the gain is of course=
 a lot
> smaller, and at 20.5 kHz each cycle again needs 150 us...
>
> My feeling is that the delays used in the old code are just "some" va=
lues
> which work for sure, to if you like, my change is basically optimisat=
ion...

The old code only works when the device is stuck at the last bit. To co=
pe
with any bit (worst case is the first bit) you need 9 cycles, 8 bits + =
ack =3D 9

Just toggling the clock 9 cycles should unlock any slave stuck in a rea=
d operation.
To unlock slaves stuck in a write operation you also need to generate a=
 START in
every cycle too.

As far as I can tell your patch does all of the above so

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

>
> BTW, related to your earlier question, I checked the timings recorded=
 with the
> scope at 100 and at 20 kHz against the nxp's "I2C bus specification a=
nd user
> manual", rev. 03 - everything seems to be fine.

Good, thanks.

 Jocke=
