Return-Path: <John.Linn@xilinx.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8D9E4DE1E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 06:50:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Xilinx Temac Timer ?
Date: Wed, 26 Mar 2008 13:48:34 -0600
In-Reply-To: <16306218.post@talk.nabble.com>
References: <16306218.post@talk.nabble.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "khollan" <khollan@daktronics.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080326194837.096A66A80EE@mail125-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kevin,

I didn't write the code but I know the driver somewhat.

I think the intention of stopping the timer is to prevent the reentrancy
as the comment says because there is a function, gmii_poll, that is
setup on the timer to go read the phy registers to see if anything
changed in the phy.=20

Stopping the timer prevents a phy read from happening in gmii_poll in
the middle of the ioctl phy read which could hose things up.

I don't see why you couldn't change that timer stop to some other form
of synchronization/mutual exclusion so that the phy reads don't collide.

As I look at it, it appears to me the spinlock should provide the
synchronization needed without stopping the timer, but maybe I'm missing
something. I CCed John Bonesio as he's the guy that developed this code
I believe and maybe he'll have more insight here.

Thanks,
John

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of khollan
Sent: Wednesday, March 26, 2008 11:03 AM
To: linuxppc-embedded@ozlabs.org
Subject: Xilinx Temac Timer ?


Hi

What is the purpose of stopping the timer in the ioctl call to read a
PHY
register?  This is the code:

    case SIOCGMIIREG:   /* Read GMII PHY register. */
    case SIOCDEVPRIVATE + 1:    /* for binary compat, remove in 2.5 */
        if (data->phy_id > 31 || data->reg_num > 31)
            return -ENXIO;

        /* Stop the PHY timer to prevent reentrancy. */
        spin_lock_irqsave(&XTE_spinlock, flags);
        del_timer_sync(&lp->phy_timer);

        ret =3D XTemac_PhyRead(&lp->Emac, data->phy_id,
                       data->reg_num, &data->val_out);

        /* Start the PHY timer up again. */
        lp->phy_timer.expires =3D jiffies + 2 * HZ;
        add_timer(&lp->phy_timer);
        spin_unlock_irqrestore(&XTE_spinlock, flags);
        if (ret !=3D XST_SUCCESS) {
            printk(KERN_ERR
                   "%s: XTemac: could not read from PHY, error=3D%d.\n",
                   dev->name, ret);
            return -EBUSY;
        }
        return 0;

I ask because I have an application that needs to read a Phy register
before
the timer has started to see if a link is present.  This causes a kernel
bug
when trying to run the del_timer_sync function because there is not a
running timer.  I would like to know if it is safe to remove the timer
del
and add but keep the spin lock.

Thanks for your help

Kevin
--=20
View this message in context:
http://www.nabble.com/Xilinx-Temac-Timer---tp16306218p16306218.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
