Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id DBB80DDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Aug 2007 01:56:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Only one phy can be accessed through ioctls to a socket (patch
	available)
Date: Fri, 24 Aug 2007 17:56:03 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EA182E3@aquib01a>
In-Reply-To: <B999A34D-92BD-41D1-852A-45C4E2258712@freescale.com>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Andy Fleming" <afleming@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> I'd certainly be interested in seeing it.

There is not much to see, only few lines in phy_device.c:

/* get_existing_phy_device:
 *
 * description: returns a phy device with the given address
 * if it exists
 */
static int phy_compare_addr(struct device *dev, void *data)
{
        return (*((int*)data) =3D=3D to_phy_device(dev)->addr) ? 1 : 0;
}
struct phy_device * get_existing_phy_device(int addr)
{
        struct bus_type *bus =3D &mdio_bus_type;
        struct phy_device *phydev;

        struct device *d;

        /* Search the list of PHY devices on the mdio bus for the
         * PHY with the requested name */
        d =3D bus_find_device(bus, NULL, (void *) &addr,
phy_compare_addr);

        if (d)
    {
                phydev =3D to_phy_device(d);
        return phydev;
        }

        return NULL;

}
EXPORT_SYMBOL(get_existing_phy_device);


And a small change in fs_enet-main.c :


static int fs_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
{
        struct fs_enet_private *fep =3D netdev_priv(dev);
        struct mii_ioctl_data *mii =3D (struct mii_ioctl_data
*)&rq->ifr_data;
    struct phy_device* phydev =3D fep->phydev;
        unsigned long flags;
        int rc;

        if (!netif_running(dev) && (phydev->addr =3D=3D mii->phy_id))
                return -EINVAL;

    if ((phydev->addr !=3D mii->phy_id))
    {
      struct phy_device* d;

      if ((d =3D get_existing_phy_device(mii->phy_id)) !=3D NULL)
        phydev =3D d;
      else
        return -ENODEV;
    }

        spin_lock_irqsave(&fep->lock, flags);
        rc =3D phy_mii_ioctl(phydev, mii, cmd);
        spin_unlock_irqrestore(&fep->lock, flags);
        return rc;
}
