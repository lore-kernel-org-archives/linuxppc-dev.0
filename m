Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id B666DDDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Mar 2007 16:56:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Badness in local_bh_enable when calling phy_read
Date: Tue, 27 Mar 2007 08:56:09 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E71CD37@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm using DENX linux-2.6.19.2, trying to send a SIOCGMIIREG to a socket
causes the following message:

Badness in local_bh_enable at kernel/softirq.c:137

The call trace shows the phy_read function that has the following body:

int phy_read(struct phy_device *phydev, u16 regnum)
{
        int retval;
        struct mii_bus *bus =3D phydev->bus;

        spin_lock_bh(&bus->mdio_lock);
        retval =3D bus->read(bus, phydev->addr, regnum);
        spin_unlock_bh(&bus->mdio_lock);

        return retval;
}

Bye,
Antonio.
=20
