Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (sg2ehsobe005.messaging.microsoft.com
	[207.46.51.79]) by ozlabs.org (Postfix) with ESMTP id CF46CB7D83
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 09:39:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH] [V3] net: emaclite: adding MDIO and phy lib support
Date: Tue, 9 Feb 2010 15:38:14 -0700
In-Reply-To: <1d3f23371002091430hb550153u602c8e7c010381b9@mail.gmail.com>
References: <2ea396ca-3014-40f4-86ac-0e9f1aa82b5b@SG2EHSMHS005.ehs.local>
	<1d3f23371002091430hb550153u602c8e7c010381b9@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "John Williams" <john.williams@petalogix.com>
Message-ID: <b0b2b534-8219-46a5-b76e-196836d0d195@SG2EHSMHS004.ehs.local>
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

Hey John, I prefer burning down bike-sheds myself, fire and explosions are =
always more fun than painting :)

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

I considered that and then blew it off (maybe shouldn't have).  =


If we think it's a more std way to do it then no big deal.  I'll see if the=
re are any other comments before spinning another maybe final patch.

Thanks for the input,
John


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
