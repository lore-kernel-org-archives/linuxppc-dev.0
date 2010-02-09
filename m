Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE001.bigfish.com (sg2ehsobe001.messaging.microsoft.com
	[207.46.51.75]) by ozlabs.org (Postfix) with ESMTP id 9044EB7D4D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 10:01:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH] [V3] net: emaclite: adding MDIO and phy lib support
Date: Tue, 9 Feb 2010 16:00:04 -0700
In-Reply-To: <1d3f23371002091430hb550153u602c8e7c010381b9@mail.gmail.com>
References: <2ea396ca-3014-40f4-86ac-0e9f1aa82b5b@SG2EHSMHS005.ehs.local>
	<1d3f23371002091430hb550153u602c8e7c010381b9@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "John Williams" <john.williams@petalogix.com>
Message-ID: <ad1b9321-b7ad-47a6-93ca-ca260ff2a66d@SG2EHSMHS011.ehs.local>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Sadanand Mutyala <sadanan@xilinx.com>, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: John Williams [mailto:john.williams@petalogix.com]
> Sent: Tuesday, February 09, 2010 3:30 PM
> To: John Linn
> Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org; jgarzik@pobox.com; g=
rant.likely@secretlab.ca;
> jwboyer@linux.vnet.ibm.com; Sadanand Mutyala
> Subject: Re: [PATCH] [V3] net: emaclite: adding MDIO and phy lib support
> =

> Hi John,
> =

> Sorry If I'm painting bike-sheds here, just one tiny tweak might be in
> order to standardise your mutex_unlock exit path:
> =

> > +static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int re=
g)
> > +{
> > + =A0 =A0 =A0 struct net_local *lp =3D bus->priv;
> > + =A0 =A0 =A0 u32 ctrl_reg;
> > + =A0 =A0 =A0 u32 rc;
> > +
> > + =A0 =A0 =A0 mutex_lock(&lp->mdio_mutex);
> > +
> > + =A0 =A0 =A0 if (xemaclite_mdio_wait(lp)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&lp->mdio_mutex);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> > + =A0 =A0 =A0 }
> =

> [snip]
> =

> =

> > + =A0 =A0 =A0 if (xemaclite_mdio_wait(lp)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&lp->mdio_mutex);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> > + =A0 =A0 =A0 }
> =

> [snip]
> =

> =

> > + =A0 =A0 =A0 dev_dbg(&lp->ndev->dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "xemaclite_mdio_read(phy_id=3D%i, reg=3D%=
x) =3D=3D %x\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_id, reg, rc);
> > +
> > + =A0 =A0 =A0 return rc;
> =

> Can this be better expressed like this:
> =

> my_func() {
>   mutex_lock()
> ..
> =

>   if(some error) {
>     rc=3D-ETIMEDOUT;
>     goto out_unlock;
>   }
>   ...
> =

>   /* success path */
>   rc=3D0;
> ..
> out_unlock:
>   mutex_unlock()
>   return rc;
> }
> =

> =

> Is this style still favoured in driver exit paths?

It looks to me like the mutex is not needed in the driver mdio functions as=
 there's a mutex in the mdiobus functions already.

Am I wrong about that?

Thanks,
John

>From phy/mdio_bus.c

int mdiobus_read(struct mii_bus *bus, int addr, u16 regnum)
{
	int retval;

	BUG_ON(in_interrupt());

	mutex_lock(&bus->mdio_lock);
	retval =3D bus->read(bus, addr, regnum);
	mutex_unlock(&bus->mdio_lock);

	return retval;
}
EXPORT_SYMBOL(mdiobus_read);

int mdiobus_write(struct mii_bus *bus, int addr, u16 regnum, u16 val)
{
	int err;

	BUG_ON(in_interrupt());

	mutex_lock(&bus->mdio_lock);
	err =3D bus->write(bus, addr, regnum, val);
	mutex_unlock(&bus->mdio_lock);

	return err;
}
EXPORT_SYMBOL(mdiobus_write);

> =

> Thanks,
> =

> John
> --
> John Williams, PhD, B.Eng, B.IT
> PetaLogix - Linux Solutions for a Reconfigurable World
> w: www.petalogix.com  p: +61-7-30090663  f: +61-7-30090663


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
