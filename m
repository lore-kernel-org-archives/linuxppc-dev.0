Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id A04CBDDDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 00:22:47 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l6PEMjwM010210
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 17:22:45 +0300
Received: from inaccessnetworks.com ([127.0.0.1])
	by localhost (host11.inaccessnetworks.com [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 09678-18 for <linuxppc-dev@ozlabs.org>;
	Wed, 25 Jul 2007 17:22:45 +0300 (EEST)
Received: from phoenix (phoenix.priv.inaccessnetworks.com [192.168.1.7])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id l6PEMjLF010206
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 17:22:45 +0300
Date: Wed, 25 Jul 2007 17:22:40 +0300
To: linuxppc-dev@ozlabs.org
Subject: About mdio_bus for 82xx based board
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
Message-ID: <op.tv0x7yvmnhx3hy@phoenix>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,
I'm trying to make FCC ethernet work with my board, based on an MPC8275  
processor. I'm using kernel 2.6.22.1

I have the following problems:

1) When mdiobus_register() called from mii-bitbang.c (fs_enet_mdio_probe()  
function) attemps to do a device_register for the mdio bus, it actually  
registers the device with a bus_id in the form [0|1|...]:<phy_addr>, that  
is the first part a simple integer. This, of course, happens because  
fs_enet_of_init() (fsl_soc.c) does a  
platform_device_register_simple("fsl-bb-mdio", i,  NULL, 0); with i being  
the first part of the bus, starting from 0. Unfortunately, when  
fs_init_phy() (fs_enet_main.c) calls phy_connect() and therefore  
phy_attach() (phy_device.c), the latter attempts to find the device in the  
mdio bus, but it searches using the bus_id registered in the net_device  
struct, which is in the form of <resource address>:<phy_addr>, eg.  
f0000000:0, and therefore it fails... I don't know if I am doing something  
wrong here, so any hint would be greatly appreciated.

2) Since there are two ethernet@<address> nodes in my device tree,  
fs_of_enet_init() calls platform_device_register_simple("fsl-bb-mdio",...)  
twice, therefore creating two mdio busses, 0 and 1, each having the same  
two devices. For example, if I have two PHYs with addresses 1 and 5, I  
will get two mdio busses and 4 devices, 0:1, 0:5, 1:1 and 1:5. Well, this  
doesn't sound right to me, although I am not sure if this is a fatal  
issue. Any comments?

3) Also, if I don't want to enter the phy interrupt in the device tree  
(there is not one or I want to use PHY_POLL), what should I do? dtc seems  
to not allow -1 as a value in the reg property.

thank you in advance for your responses

Alex
