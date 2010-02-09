Return-Path: <john.williams@petalogix.com>
Received: from mail-px0-f199.google.com (mail-px0-f199.google.com
	[209.85.216.199]) by ozlabs.org (Postfix) with ESMTP id 7CB3CB7D87
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 09:30:30 +1100 (EST)
Received: by pxi37 with SMTP id 37so8154477pxi.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 14:30:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2ea396ca-3014-40f4-86ac-0e9f1aa82b5b@SG2EHSMHS005.ehs.local>
References: <2ea396ca-3014-40f4-86ac-0e9f1aa82b5b@SG2EHSMHS005.ehs.local>
Date: Wed, 10 Feb 2010 08:30:24 +1000
Message-ID: <1d3f23371002091430hb550153u602c8e7c010381b9@mail.gmail.com>
Subject: Re: [PATCH] [V3] net: emaclite: adding MDIO and phy lib support
From: John Williams <john.williams@petalogix.com>
To: John Linn <john.linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sadanand Mutyala <Sadanand.Mutyala@xilinx.com>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi John,

Sorry If I'm painting bike-sheds here, just one tiny tweak might be in
order to standardise your mutex_unlock exit path:

> +static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> +{
> + =A0 =A0 =A0 struct net_local *lp =3D bus->priv;
> + =A0 =A0 =A0 u32 ctrl_reg;
> + =A0 =A0 =A0 u32 rc;
> +
> + =A0 =A0 =A0 mutex_lock(&lp->mdio_mutex);
> +
> + =A0 =A0 =A0 if (xemaclite_mdio_wait(lp)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&lp->mdio_mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> + =A0 =A0 =A0 }

[snip]


> + =A0 =A0 =A0 if (xemaclite_mdio_wait(lp)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&lp->mdio_mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> + =A0 =A0 =A0 }

[snip]


> + =A0 =A0 =A0 dev_dbg(&lp->ndev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "xemaclite_mdio_read(phy_id=3D%i, reg=3D%x)=
 =3D=3D %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_id, reg, rc);
> +
> + =A0 =A0 =A0 return rc;

Can this be better expressed like this:

my_func() {
  mutex_lock()
..

  if(some error) {
    rc=3D-ETIMEDOUT;
    goto out_unlock;
  }
  ...

  /* success path */
  rc=3D0;
..
out_unlock:
  mutex_unlock()
  return rc;
}


Is this style still favoured in driver exit paths?

Thanks,

John
--=20
John Williams, PhD, B.Eng, B.IT
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com  p: +61-7-30090663  f: +61-7-30090663
