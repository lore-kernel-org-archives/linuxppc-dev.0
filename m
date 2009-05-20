Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 7D966DE169
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 02:49:36 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so281680yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 09:49:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <A88094362DE0AE49A118AB9B4EB3612403F9DEC0@dekaexchange.deka.local>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
	<20090519205706.GD27476@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBC@dekaexchange.deka.local>
	<fa686aa40905191636u6f4a23d0xc8c6c13904a65b8e@mail.gmail.com>
	<20090520064218.GA29102@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBE@dekaexchange.deka.local>
	<9e4733910905200814p63915ff8pf65614dbb8dc9adf@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBF@dekaexchange.deka.local>
	<9e4733910905200829o423bf483h5b0b6dd202367872@mail.gmail.com>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEC0@dekaexchange.deka.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 20 May 2009 10:49:15 -0600
Message-ID: <fa686aa40905200949q1fbeee8fy4b3a06d8e44d7c6b@mail.gmail.com>
Subject: Re: mpc5200 fec error
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 20, 2009 at 10:41 AM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> It looks like the phy is never getting reset properly after the FEC_IEVEN=
T_RFIFO_ERROR. =A0I threw some printk's into the fec mdio driver

Yes, that sounds familiar.  Most likely, the value of the MDIO bus
control register got clobbered and not reset when the FEC was reset.
Try adding this line to the beginning of mpc52xx_fec_mdio_transfer():

out_be32(&fec->mii_speed, 0x7e);

It's a dirty ugly hack, but it should help.  If that works, then I can
come up with a better solution.  Part of the problem is that the MDIO
handling in the current code really isn't very good.  I've got changes
queued up in -next which cleans it up quite a bit which should make it
easier to fix properly.

g.

>
> /drivers/net/fec_mpc52xx_phy.c
> =A025 static int mpc52xx_fec_mdio_transfer(struct mii_bus *bus, int phy_i=
d,
> =A026 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int reg, u32 value)
> =A027 {
> =A028 =A0 =A0 =A0 =A0 struct mpc52xx_fec_mdio_priv *priv =3D bus->priv;
> =A029 =A0 =A0 =A0 =A0 struct mpc52xx_fec __iomem *fec;
> =A030 =A0 =A0 =A0 =A0 int tries =3D 100;
> =A031
> =A032 =A0 =A0 =A0 =A0 value |=3D (phy_id << FEC_MII_DATA_PA_SHIFT) & FEC_=
MII_DATA_PA_MSK;
> =A033 =A0 =A0 =A0 =A0 value |=3D (reg << FEC_MII_DATA_RA_SHIFT) & FEC_MII=
_DATA_RA_MSK;
> =A034
> =A035 =A0 =A0 =A0 =A0 fec =3D priv->regs;
> =A036 =A0 =A0 =A0 =A0 out_be32(&fec->ievent, FEC_IEVENT_MII);
> =A037 =A0 =A0 =A0 =A0 out_be32(&priv->regs->mii_data, value);
> =A038
> =A039 =A0 =A0 =A0 =A0 /* wait for it to finish, this takes about 23 us on=
 lite5200b */
> =A040 =A0 =A0 =A0 =A0 while (!(in_be32(&fec->ievent) & FEC_IEVENT_MII) &&=
 --tries)
> =A041 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(5);
> =A042
> =A043 =A0 =A0 =A0 =A0 if (!tries) {
> =A044 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("Unable to reset phy\n");
> =A045 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> =A046 =A0 =A0 =A0 =A0 }
> =A047
> =A048 =A0 =A0 =A0 =A0 return value & FEC_MII_DATA_OP_RD ?
> =A049 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_be32(&priv->regs->mii_data) & FE=
C_MII_DATA_DATAMSK : 0;
> =A050 }
>
> and got this
>
> [ =A0127.085632] net eth0: FEC_IEVENT_RFIFO_ERROR
> [ =A0127.093401] Resetting FEC
> [ =A0127.096620] Unable to reset phy
> [ =A0127.322224] Unable to reset phy
> [ =A0128.321987] PHY: f0003000:00 - Link is Down
> [ =A0129.221034] net eth0: FEC_IEVENT_RFIFO_ERROR
> [ =A0129.228165] Resetting FEC
> [ =A0129.231384] Unable to reset phy
> [ =A0129.322286] Unable to reset phy
> [ =A0132.885863] net eth0: FEC_IEVENT_RFIFO_ERROR
> [ =A0132.893002] Resetting FEC
> [ =A0132.896176] Unable to reset phy
> [ =A0133.322202] Unable to reset phy
> [ =A0135.684793] net eth0: FEC_IEVENT_RFIFO_ERROR
> [ =A0135.691969] Resetting FEC
> [ =A0135.695192] Unable to reset phy
> [ =A0136.322530] Unable to reset phy
> [ =A0138.490805] net eth0: FEC_IEVENT_RFIFO_ERROR
> [ =A0138.497963] Resetting FEC
> [ =A0138.501135] Unable to reset phy
> [ =A0139.334200] Unable to reset phy
>
> I guess I have to spend some quality time with the 5200 manual.
>
>
> _________________________________________________________________________=
________________
>
> This e-mail and the information, including any attachments, it contains a=
re intended to be a confidential communication only to the person or entity=
 to whom it is addressed and may contain information that is privileged. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that any dissemination, distribution or copying of this communicati=
on is strictly prohibited. If you have received this communication in error=
, please immediately notify the sender and destroy the original message.
>
> Thank you.
>
> Please consider the environment before printing this email.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
