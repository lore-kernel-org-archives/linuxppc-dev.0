Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 927D1DDF77
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 20:04:27 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m3HA4J7L032156
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 12:04:19 +0200
Message-ID: <03fc01c8a072$67280110$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Xilinx network trouble
Date: Thu, 17 Apr 2008 12:04:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Our network guru is out on vacation, so I'll ask here...
I now have a working Xilinx ML405 board... except the network is flaky to 
say the least.

I have tried both with the Emac Lite and the LLTemac IPs.

They both work during the DHCP state of the kernel boot, my target board 
gets its IP and network parameters alright from the host DHCP server.

The Emac Lite can ping both ways, but with 500ms and 30% packet loss when 
pinging from the host PC and 300ms and 70% packet loss the other way. And it 
goes in hiccups: 30s or so with no pings, and then 30s or so with 90% 
success... RX/TX LEDs also are dark when there's nothing going on.

When using the LLTemac, ping just doesn't work.

ifconfig shows no drops and no collisions in both cases.

I'm no network specialist so I don't know what kind of tools I can use for 
further diagnosis.

Here are some of the relevant kernel options I've set for both 
configurations:

$ egrep "EMAC|NET|XILINX|NFS" .config | egrep -v "^#|^$"
CONFIG_XILINX_ML405=y
CONFIG_XILINX_MLxxx=y
CONFIG_XILINX_VIRTEX_4_FX=y
CONFIG_XILINX_VIRTEX=y
CONFIG_XILINX_EMBED_CONFIG=y
CONFIG_NET=y
CONFIG_INET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_XILINX_SYSACE=y
CONFIG_XILINX_DRIVERS=y
CONFIG_NEED_XILINX_IPIF=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_XILINX_EMACLITE=y
CONFIG_XILINX_GPIO=y
CONFIG_XILINX_HWICAP=y
CONFIG_XILINX_IIC=y
CONFIG_XILINX_EDK=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_NFS_COMMON=y

or:

CONFIG_XILINX_ML405=y
CONFIG_XILINX_MLxxx=y
CONFIG_XILINX_VIRTEX_4_FX=y
CONFIG_XILINX_VIRTEX=y
CONFIG_XILINX_EMBED_CONFIG=y
CONFIG_NET=y
CONFIG_INET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_XILINX_SYSACE=y
CONFIG_XILINX_DRIVERS=y
CONFIG_NEED_XILINX_LLDMA=y
CONFIG_NETDEVICES=y
CONFIG_NETDEV_1000=y
CONFIG_XILINX_LLTEMAC=y
CONFIG_XILINX_LLTEMAC_MARVELL_88E1111_GMII=y
CONFIG_XILINX_GPIO=y
CONFIG_XILINX_HWICAP=y
CONFIG_XILINX_IIC=y
CONFIG_XILINX_EDK=y
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_NFS_COMMON=y

Thanks for any hint.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
