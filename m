Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 13DBE1007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 00:17:12 +1000 (EST)
Message-ID: <4C10EFE0.6030106@harris.com>
Date: Thu, 10 Jun 2010 10:00:00 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH][RFC] ibm_newemac and SIOCGMIIREG
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SIOCGMIIREG and SIOCSMIIREG access a user data structure via a void
pointer to user space.  So, we need copy_from_user and copy_to_user
to move the data.

Signed-off-by: Steven A. Falco <sfalco@harris.com>

---

I believe there is a bug in the way the ibm_newemac driver handles the
SIOCGMIIREG (and SIOCSMIIREG) ioctl.  The problem is that emac_ioctl
is handed a "struct ifreq *rq" which contains a user-land pointer to
an array of 16-bit integers.

However, emac_ioctl directly accesses the data, which doesn't work.
I added the following patch to copy the data in and out.

Please note that this patch was tested in an older kernel (2.6.30)
because that is what we are using on our custom hardware.  I think
this is still a problem in the current code, but I'd like reviewers
to take a look, to be sure.

--- drivers/net/ibm_newemac/core.c	2010-06-09 19:57:26.000000000 -0400
+++ /home/sfalco/core.c	2010-06-10 09:38:22.000000000 -0400
@@ -2218,6 +2218,7 @@
 {
 	struct emac_instance *dev = netdev_priv(ndev);
 	struct mii_ioctl_data *data = if_mii(rq);
+	struct mii_ioctl_data user_data;
 
 	DBG(dev, "ioctl %08x" NL, cmd);
 
@@ -2229,13 +2230,19 @@
 		data->phy_id = dev->phy.address;
 		/* Fall through */
 	case SIOCGMIIREG:
-		data->val_out = emac_mdio_read(ndev, dev->phy.address,
-					       data->reg_num);
+		if (copy_from_user(user_data, (char __user *)data, sizeof(user_data)))
+			return -EFAULT;
+		user_data->val_out = emac_mdio_read(ndev, dev->phy.address,
+					       user_data->reg_num);
+		if (copy_to_user((char __user *)rq->ifr_data, user_data, sizeof(user_data)))
+			return -EFAULT;
 		return 0;
 
 	case SIOCSMIIREG:
-		emac_mdio_write(ndev, dev->phy.address, data->reg_num,
-				data->val_in);
+		if (copy_from_user(user_data, (char __user *)data, sizeof(user_data)))
+			return -EFAULT;
+		emac_mdio_write(ndev, dev->phy.address, user_data->reg_num,
+				user_data->val_in);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
