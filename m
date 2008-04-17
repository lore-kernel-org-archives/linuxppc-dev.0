Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 76796DEE72
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:57:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Xilinx network trouble
Date: Thu, 17 Apr 2008 09:56:08 -0600
In-Reply-To: <03fc01c8a072$67280110$ad289e86@LPSC0173W>
References: <03fc01c8a072$67280110$ad289e86@LPSC0173W>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>,
	<linuxppc-dev@ozlabs.org>
Message-Id: <20080417155609.9061E1D000B0@mail147-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Which version of xps_ll_temac are you using, and which version of EDK?
Also, do both designs meet timing?

-Rick

-----Original Message-----
From: linuxppc-dev-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+moleres=3Dxilinx.com@ozlabs.org] On Behalf =
Of
Guillaume Dargaud
Sent: Thursday, April 17, 2008 4:04 AM
To: linuxppc-dev@ozlabs.org
Subject: Xilinx network trouble

Our network guru is out on vacation, so I'll ask here...
I now have a working Xilinx ML405 board... except the network is flaky
to=20
say the least.

I have tried both with the Emac Lite and the LLTemac IPs.

They both work during the DHCP state of the kernel boot, my target board

gets its IP and network parameters alright from the host DHCP server.

The Emac Lite can ping both ways, but with 500ms and 30% packet loss
when=20
pinging from the host PC and 300ms and 70% packet loss the other way.
And it=20
goes in hiccups: 30s or so with no pings, and then 30s or so with 90%=20
success... RX/TX LEDs also are dark when there's nothing going on.

When using the LLTemac, ping just doesn't work.

ifconfig shows no drops and no collisions in both cases.

I'm no network specialist so I don't know what kind of tools I can use
for=20
further diagnosis.

Here are some of the relevant kernel options I've set for both=20
configurations:

$ egrep "EMAC|NET|XILINX|NFS" .config | egrep -v "^#|^$"
CONFIG_XILINX_ML405=3Dy
CONFIG_XILINX_MLxxx=3Dy
CONFIG_XILINX_VIRTEX_4_FX=3Dy
CONFIG_XILINX_VIRTEX=3Dy
CONFIG_XILINX_EMBED_CONFIG=3Dy
CONFIG_NET=3Dy
CONFIG_INET=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
CONFIG_XILINX_SYSACE=3Dy
CONFIG_XILINX_DRIVERS=3Dy
CONFIG_NEED_XILINX_IPIF=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_NET_ETHERNET=3Dy
CONFIG_XILINX_EMACLITE=3Dy
CONFIG_XILINX_GPIO=3Dy
CONFIG_XILINX_HWICAP=3Dy
CONFIG_XILINX_IIC=3Dy
CONFIG_XILINX_EDK=3Dy
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_ROOT_NFS=3Dy
CONFIG_NFS_COMMON=3Dy

or:

CONFIG_XILINX_ML405=3Dy
CONFIG_XILINX_MLxxx=3Dy
CONFIG_XILINX_VIRTEX_4_FX=3Dy
CONFIG_XILINX_VIRTEX=3Dy
CONFIG_XILINX_EMBED_CONFIG=3Dy
CONFIG_NET=3Dy
CONFIG_INET=3Dy
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
CONFIG_XILINX_SYSACE=3Dy
CONFIG_XILINX_DRIVERS=3Dy
CONFIG_NEED_XILINX_LLDMA=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_NETDEV_1000=3Dy
CONFIG_XILINX_LLTEMAC=3Dy
CONFIG_XILINX_LLTEMAC_MARVELL_88E1111_GMII=3Dy
CONFIG_XILINX_GPIO=3Dy
CONFIG_XILINX_HWICAP=3Dy
CONFIG_XILINX_IIC=3Dy
CONFIG_XILINX_EDK=3Dy
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
CONFIG_ROOT_NFS=3Dy
CONFIG_NFS_COMMON=3Dy

Thanks for any hint.
--=20
Guillaume Dargaud
http://www.gdargaud.net/


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
