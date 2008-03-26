Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85C73DE630
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 04:02:47 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JeZ1O-0004O3-TJ
	for linuxppc-embedded@ozlabs.org; Wed, 26 Mar 2008 10:02:42 -0700
Message-ID: <16306218.post@talk.nabble.com>
Date: Wed, 26 Mar 2008 10:02:42 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Xilin Temac Timer ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi

What is the purpose of stopping the timer in the ioctl call to read a PHY
register?  This is the code:

    case SIOCGMIIREG:   /* Read GMII PHY register. */
    case SIOCDEVPRIVATE + 1:    /* for binary compat, remove in 2.5 */
        if (data->phy_id > 31 || data->reg_num > 31)
            return -ENXIO;

        /* Stop the PHY timer to prevent reentrancy. */
        spin_lock_irqsave(&XTE_spinlock, flags);
        del_timer_sync(&lp->phy_timer);

        ret = XTemac_PhyRead(&lp->Emac, data->phy_id,
                       data->reg_num, &data->val_out);

        /* Start the PHY timer up again. */
        lp->phy_timer.expires = jiffies + 2 * HZ;
        add_timer(&lp->phy_timer);
        spin_unlock_irqrestore(&XTE_spinlock, flags);
        if (ret != XST_SUCCESS) {
            printk(KERN_ERR
                   "%s: XTemac: could not read from PHY, error=%d.\n",
                   dev->name, ret);
            return -EBUSY;
        }
        return 0;

I ask because I have an application that needs to read a Phy register before
the timer has started to see if a link is present.  This causes a kernel bug
when trying to run the del_timer_sync function because there is not a
running timer.  I would like to know if it is safe to remove the timer del
and add but keep the spin lock.

Thanks for your help

Kevin
-- 
View this message in context: http://www.nabble.com/Xilin-Temac-Timer---tp16306218p16306218.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
