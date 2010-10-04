Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 06CA0B70CE
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2010 18:42:17 +1100 (EST)
Date: Mon, 04 Oct 2010 09:32:26 +0200
From: Heiko Schocher <hs@denx.de>
Subject: powerpc, fs_enet: scanning PHY after Linux is up
To: linuxppc-dev@ozlabs.org
Message-id: <4CA9830A.2030605@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Holger Brunck <holger.brunck@keymile.com>, Detlev Zundel <dzu@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,

we have on the mgcoge arch/powerpc/boot/dts/mgcoge.dts 3 fs_enet
devices. The first is accessible on boot, and so get correct
probed and works fine. For the other two fs_enet devices the PHYs
are on startup in reset, and gets later, through userapplikations,
out of reset ... so, on bootup, this 2 fs_enet devices could
not detect the PHY in drivers/of/of_mdio.c of_mdiobus_register(),
and if we want to use them later, we get for example:

-bash-3.2# ifconfig eth2 172.31.31.33
net eth2: Could not attach to PHY
SIOCSIFFLAGS: No such device

So the problem is, that we cannot rescan the PHYs, if they are
accessible. Also we could not load the fs_enet driver as a module,
because the first port is used fix.

So, first question which comes in my mind, is:

Is detecting the phy in drivers/of/of_mdio.c of_mdiobus_register()
the right place, or should it not better be done, when really
using the port?

But we found another way to solve this issue:

After the PHYs are out of reset, we just have to rescan the PHYs
with (for example PHY with addr 1)

err = mdiobus_scan(bus, 1);

and

of_find_node_by_path("/soc@f0000000/cpm@119c0/mdio@10d40/ethernet-phy@1");
of_node_get(np);
dev_archdata_set_node(&err->dev.archdata, np);

but thats just a hack ...

So, the question is, is there a possibility to solve this problem?

If there is no standard option, what would be with adding a
"scan_phy" file in

/proc/device-tree/soc\@f0000000/cpm\@119c0/mdio\@10d40
(or better destination?)

which with we could rescan a PHY with
"echo addr > /proc/device-tree/soc\@f0000000/cpm\@119c0/mdio\@10d40/scan_phy"
(so there is no need for using of_find_node_by_path(), as we should
 have the associated device node here, and can step through the child
 nodes with "for_each_child_of_node(np, child)" and check if reg == addr)

or shouldn;t be at least, if the phy couldn;t be found when opening
the port, retrigger a scanning, if the phy now is accessible?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
