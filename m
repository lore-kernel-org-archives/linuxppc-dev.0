Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E60AB7D2A
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 07:02:13 +1100 (EST)
Message-ID: <23658638.1266350528301.JavaMail.ngmail@webmail08.arcor-online.net>
Date: Tue, 16 Feb 2010 21:02:08 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: grant.likely@secretlab.ca, iws@ovro.caltech.edu
Subject: Re: [PATCH/RFC 1/2] 5200: improve i2c bus error recovery
In-Reply-To: <fa686aa41002161131j7329a05cx16e66125f82fec39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa41002161131j7329a05cx16e66125f82fec39@mail.gmail.com>
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

Hi Grant & Ira:

Thanks a lot for reviewing the patch, and for the encouraging comments!  I =
will re-submit a new version according according to them, hopefully tomorro=
w or on Thursday.

Best, Albrecht.

----- Original Nachricht ----
Von:     Grant Likely <grant.likely@secretlab.ca>
An:      Albrecht Dre=DF <albrecht.dress@arcor.de>
Datum:   16.02.2010 20:31
Betreff: Re: [PATCH/RFC 1/2] 5200: improve i2c bus error recovery

> Hi Albrecht,
>=20
> Comments below.
>=20
> On Fri, Jan 22, 2010 at 1:17 PM, Albrecht Dre=DF <albrecht.dress@arcor.de=
>
> wrote:
> > Improve the recovery of the MPC5200B's I2C bus from errors like bus
> > hangs.
> >
> > Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
> >
> > ---
> >
> > This patch introduces several improvements to the MPC5200B's I2C driver
> > as to improve the recovery from error conditions I encountered when
> > testing a custom board with several I2C devices attached (eeprom, io
> > expander, rtc, sensors). =A0The error conditions included cases where t=
he
> > bus if logic of one slave apparently went south, blocking the bus
> > completely.
> >
> > My fixes include:
> > 1. make the bus timeout configurable in fsl_i2c_probe(); the default of
> > =A0 one second is *way* too long for my use case;
> > 2. if a timeout condition occurs in mpc_xfer(), mpc_i2c_fixup() the bus
> > =A0 if *any* of the CF, BB and RXAK flags in the MSR is 1. =A0I actuall=
y
> > =A0 saw different combinations with hangs, not only all three set;
> > 3. improve the fixup procedure by calculating the timing needed from th=
e
> > =A0 real (configured) bus clock, calculated in mpc_i2c_setclock_52xx().
> > =A0 Furthermore, I issue 9 instead of one cycle, as I experienced cases
> > =A0 where the single one is not enough (found this tip in a forum). =A0=
As a
> > =A0 side effect, the new scheme needs only 81us @375kHz bus clock inste=
ad
> > =A0 of 150us. =A0I recorded waveforms for 18.4kHz, 85.9kHz and 375kHz, =
all
> > =A0 looking fine, which I can provide if anyone is interested.
>=20
> These are three separate fixes.  Ideally you should submit them in
> separate patches to make it easy on poor old reviewers like me.  And,
> as Ben mentions, this descriptions should be above the '---' line so
> it appears in the commit text.

OK, will do.

>=20
> >
> > Open questions:
> > - is the approach correct at all, in particular the interpretation of
> > =A0the flags (#2)?
> > - could this code also be used on non-5200 processors?
> >
> > --- linux-2.6.32-orig/drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A02009-12-0=
3
> 04:51:21.000000000 +0100
> > +++ linux-2.6.32/drivers/i2c/busses/i2c-mpc.c =A0 2010-01-22
> 16:05:13.000000000 +0100
> > @@ -59,6 +59,7 @@ struct mpc_i2c {
> > =A0 =A0 =A0 =A0wait_queue_head_t queue;
> > =A0 =A0 =A0 =A0struct i2c_adapter adap;
> > =A0 =A0 =A0 =A0int irq;
> > + =A0 =A0 =A0 u32 real_clk;
> > =A0};
> >
> > =A0struct mpc_i2c_divider {
> > @@ -97,16 +98,32 @@ static irqreturn_t mpc_i2c_isr(int irq,
> > =A0*/
> > =A0static void mpc_i2c_fixup(struct mpc_i2c *i2c)
> > =A0{
> > - =A0 =A0 =A0 writeccr(i2c, 0);
> > - =A0 =A0 =A0 udelay(30);
> > - =A0 =A0 =A0 writeccr(i2c, CCR_MEN);
> > - =A0 =A0 =A0 udelay(30);
> > - =A0 =A0 =A0 writeccr(i2c, CCR_MSTA | CCR_MTX);
> > - =A0 =A0 =A0 udelay(30);
> > - =A0 =A0 =A0 writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> > - =A0 =A0 =A0 udelay(30);
> > - =A0 =A0 =A0 writeccr(i2c, CCR_MEN);
> > - =A0 =A0 =A0 udelay(30);
> > + =A0 =A0 =A0 if (i2c->real_clk =3D=3D 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(30);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, CCR_MEN);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(30);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, CCR_MSTA | CCR_MTX);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(30);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_ME=
N);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(30);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, CCR_MEN);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(30);
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int k;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 delay_val =3D 1000000 / i2c->real_clk=
 + 1;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (delay_val < 2)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 delay_val =3D 2;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (k =3D 9; k; k--) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, CCR_MSTA | =
CCR_MTX | CCR_MEN);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(delay_val);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeccr(i2c, CCR_MEN);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(delay_val << 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
>=20
> This doesn't look right.  Why is the old code being preserved?  Isn't
> it not as reliable?  It looks to me that the new block should be the
> only path, with delay_val getting hard set to a sane value if real_clk
> =3D=3D 0.  This approach looks to add complexity to the driver without a
> reason other than fear it *might* breaking something.
>=20
> If the new code is better, then be strong, stand tall, and say in a
> loud voice, "this old code is crap.  The new stuff is much better."

:-)  Ok...

>=20
> g.
>=20
> > =A0}
> >
> > =A0static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writi=
ng)
> > @@ -186,15 +203,18 @@ static const struct mpc_i2c_divider mpc_
> > =A0 =A0 =A0 =A0{10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
> > =A0};
> >
> > -int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int
> prescaler)
> > +int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int
> prescaler,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 *real_clk)
> > =A0{
> > =A0 =A0 =A0 =A0const struct mpc_i2c_divider *div =3D NULL;
> > =A0 =A0 =A0 =A0unsigned int pvr =3D mfspr(SPRN_PVR);
> > =A0 =A0 =A0 =A0u32 divider;
> > =A0 =A0 =A0 =A0int i;
> >
> > - =A0 =A0 =A0 if (!clock)
> > + =A0 =A0 =A0 if (!clock) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *real_clk =3D 0;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> > + =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0/* Determine divider value */
> > =A0 =A0 =A0 =A0divider =3D mpc5xxx_get_bus_frequency(node) / clock;
> > @@ -212,7 +232,8 @@ int mpc_i2c_get_fdr_52xx(struct device_n
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 return div ? (int)div->fdr : -EINVAL;
> > + =A0 =A0 =A0 *real_clk =3D mpc5xxx_get_bus_frequency(node) / div->divi=
der;
> > + =A0 =A0 =A0 return (int)div->fdr;
> > =A0}
> >
> > =A0static void mpc_i2c_setclock_52xx(struct device_node *node,
> > @@ -221,13 +242,14 @@ static void mpc_i2c_setclock_52xx(struct
> > =A0{
> > =A0 =A0 =A0 =A0int ret, fdr;
> >
> > - =A0 =A0 =A0 ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler);
> > + =A0 =A0 =A0 ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler,
> &i2c->real_clk);
> > =A0 =A0 =A0 =A0fdr =3D (ret >=3D 0) ? ret : 0x3f; /* backward compatibi=
lity */
> >
> > =A0 =A0 =A0 =A0writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
> >
> > =A0 =A0 =A0 =A0if (ret >=3D 0)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(i2c->dev, "clock %d Hz (fdr=3D%d=
)\n", clock, fdr);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(i2c->dev, "clock %u Hz (fdr=3D%d=
)\n",
> i2c->real_clk,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fdr);
> > =A0}
> > =A0#else /* !CONFIG_PPC_MPC52xx */
> > =A0static void mpc_i2c_setclock_52xx(struct device_node *node,
> > @@ -446,10 +468,14 @@ static int mpc_xfer(struct i2c_adapter *
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINTR;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies, orig_jiffies + H=
Z)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 status =3D readb(i2c->=
base + MPC_I2C_SR);
> > +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(i2c->dev, "timeo=
ut\n");
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (readb(i2c->base + MPC=
_I2C_SR) =3D=3D
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (CSR_MCF | CSR_MB=
B | CSR_RXAK))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((status & (CSR_MCF | =
CSR_MBB | CSR_RXAK)) !=3D
> 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(st=
atus & ~CSR_MAL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0i2c->base + MPC_I2C_SR);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc_i2c_=
fixup(i2c);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> > @@ -540,6 +566,14 @@ static int __devinit fsl_i2c_probe(struc
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 prop =3D of_get_property(op->node, "timeout", &plen);
> > + =A0 =A0 =A0 if (prop && plen =3D=3D sizeof(u32)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_ops.timeout =3D *prop * HZ / 1000000;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc_ops.timeout < 5)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_ops.timeout =3D 5;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 dev_info(i2c->dev, "timeout %u us\n", mpc_ops.timeout * 1=
000000 /
> HZ);
> > +
> > =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, i2c);
> >
> > =A0 =A0 =A0 =A0i2c->adap =3D mpc_ops;
> >
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
> >
>=20
>=20
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20

Immer auf dem Laufenden! Sport, Auto, Reise, Politik und Promis. Von uns f=
=FCr Sie: der neue Arcor.de-Newsletter!
Jetzt anmelden und einfach alles wissen: http://www.arcor.de/rd/footer.news=
letter
