Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 128F8DE191
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 09:42:43 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] dynamic detection of gianfar TPIPA
Date: Thu, 10 Apr 2008 13:51:57 -0400
Message-Id: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
Cc: scottwood@freescale.com, linux-net@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch series consists of some minor cleanups that eventually
allow us to implement a dynamic assignment of the gianfar TBIPA.
This was the implementation that Andy and Scott indicated was
the most desireable solution at the bottom of this discussion:

http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=12902

The lead up patches are as follows:

 -dont allocate a phydev for the "ghost" phy that seems to appear
  on ID 0x1f of all the MDIO bus scans.

 -add in the missing assignment to priv->mii_bus when we assign a
  phy to the device.

 -cleanup of unnecessary externs that the above change allows us.

 -make the mii_bus->priv point to struct gianfar_mdio_data

At this point, we can then actually use the phy_map of the mii_bus
to tell us which MDIO ID we can use for the TBIPA, instead of just
hard coding 0x1f.

Paul.
