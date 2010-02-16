Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23B44B7CE2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 07:14:05 +1100 (EST)
Message-ID: <1427337.1266351240290.JavaMail.ngmail@webmail08.arcor-online.net>
Date: Tue, 16 Feb 2010 21:14:00 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: iws@ovro.caltech.edu
Subject: Re: [PATCH/RFC 1/2] 5200: improve i2c bus error recovery
In-Reply-To: <20100216194922.GA27811@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20100216194922.GA27811@ovro.caltech.edu>
	<1264191475.2224.1@antares>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ira:

[snip]
> I see this exact hang on a MPC8349EA board. I poll my i2c sensors every
> 500ms, and it takes around 12 hours to produce a hang. The usual hang
> has (CF | BB) set, however I have seen a hang with just BB (only once so
> far in about 2 weeks).
>=20
> I think the fixup should be run on 8349 as well, if not all processors.
> I'm happy to test patches. I have a way to reliably trigger a lockup,
> using another master on the i2c bus.

See my other post - hopefully a new patch is ready tomorrow/Thursday...

[snip]
> >  static void mpc_i2c_fixup(struct mpc_i2c *i2c)
> >  {
> > -=09writeccr(i2c, 0);
> > -=09udelay(30);
> > -=09writeccr(i2c, CCR_MEN);
> > -=09udelay(30);
> > -=09writeccr(i2c, CCR_MSTA | CCR_MTX);
> > -=09udelay(30);
> > -=09writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> > -=09udelay(30);
> > -=09writeccr(i2c, CCR_MEN);
> > -=09udelay(30);
> > +=09if (i2c->real_clk =3D=3D 0) {
> > +=09=09writeccr(i2c, 0);
> > +=09=09udelay(30);
> > +=09=09writeccr(i2c, CCR_MEN);
> > +=09=09udelay(30);
> > +=09=09writeccr(i2c, CCR_MSTA | CCR_MTX);
> > +=09=09udelay(30);
> > +=09=09writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> > +=09=09udelay(30);
> > +=09=09writeccr(i2c, CCR_MEN);
> > +=09=09udelay(30);
> > +=09} else {
> > +=09=09int k;
> > +=09=09u32 delay_val =3D 1000000 / i2c->real_clk + 1;
> > +
> > +=09=09if (delay_val < 2)
> > +=09=09=09delay_val =3D 2;
> > +
> > +=09=09for (k =3D 9; k; k--) {
> > +=09=09=09writeccr(i2c, 0);
> > +=09=09=09writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> > +=09=09=09udelay(delay_val);
> > +=09=09=09writeccr(i2c, CCR_MEN);
> > +=09=09=09udelay(delay_val << 1);
> > +=09=09}
> > +=09}
> >  }
> > =20
>=20
> The old sequence has always un-hung the bus for me. Yours might be
> better. I'll try it next time the bus wedges up on me.

The easiest way to verify the /waveforms/ is to simply call the function so=
mewhere else (e.g. in a i2c write call), and then record SCK and SDA with a=
 scope.  I saw *huge* unnecessary delays in the original code, and by some =
creative interpretation of the (not very clear) 5200 data sheet I came to t=
he write's and delays above.  If you have a scope, you might want to repeat=
 the test with your '8349.

Best, Albrecht.

Immer auf dem Laufenden! Sport, Auto, Reise, Politik und Promis. Von uns f=
=FCr Sie: der neue Arcor.de-Newsletter!
Jetzt anmelden und einfach alles wissen: http://www.arcor.de/rd/footer.news=
letter
