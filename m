Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (unknown [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 76B97DDDA2
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 04:46:51 +1100 (EST)
Message-ID: <49A97878.6060308@mlbassoc.com>
Date: Sat, 28 Feb 2009 10:46:32 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: OF device mappings
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Still looking for some help...  I need to be able to locate
the kernel platform_device which corresponds to an instance
from my OF tree.  Basically, I have a [somewhat] unrelated
driver which needs to know these things, so the drivers in
question should not have to be affected.

In particular, I'm working with the net/dsa drivers (Distributed
Switch Architecture) which need access to the network driver as
well as the MII/MDIO bus driver.  It doesn't make sense to tie
those drivers back to DSA, but rather let the DSA driver find
its way to them.

I've defined this in by DTS tree:
	lan1 {
		cell-index = <0x01>;
		compatible = "marvell,m88e609x";
		net_dev = "fsl-gianfar.0";
		mii_bus = "fsl-gianfar_mdio.14";
		net_devX = <&eth0>;
		mii_busX = <&mii_bus>;
	};
... two ways to find the same node.

Using 'net_dev' (which I admit is pretty hokey), I can look
up the corresponding platform device, which does work for
the DSA layer.  What I want is to be able to get to this
from the 'net_devX' pointer, but I don't seem to be able
to get out of the OF tree and into the actual platform
device tree to find the appropriate instance.

Any pointers?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
