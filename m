Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 146B42C008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 23:56:23 +1100 (EST)
Received: from [134.158.40.174] (lpsc0174x.in2p3.fr [134.158.40.174])
 by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id q9CCuJ9d030668
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 14:56:19 +0200
Message-ID: <50781373.1000205@lpsc.in2p3.fr>
Date: Fri, 12 Oct 2012 14:56:19 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Xilinx Temac
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
I'm upgrading the kernel on an embedded system and the network driver I 
was using seems to have changed and the new one doesn't seem to work:

My working config, from 2.6.38 (I believe):
$ grep "NET\|MII\|TEMAC\|MARVELL" ../linux-2.6-xlnx-CodalemaC/.config | 
grep -v "^#"
CONFIG_NET=y
CONFIG_INET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_NETDEVICES=y
CONFIG_NETDEV_1000=y
CONFIG_XILINX_LLTEMAC=y
CONFIG_XILINX_LLTEMAC_MARVELL_88E1111_MII=y
CONFIG_NET_DMA=y
CONFIG_NETWORK_FILESYSTEMS=y

And the new one:
$ grep "NET\|MII\|TEMAC\|MARVELL" .config | grep -v "^#"
CONFIG_NET=y
CONFIG_INET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_OF_NET=y
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_NET_VENDOR_XILINX=y
CONFIG_XILINX_LL_TEMAC=y
CONFIG_NET_DMA=y

On boot the device gets probed, but not activated:
# dmesg | grep -i "net\|mac"
[    0.017515] NET: Registered protocol family 16
[    0.102621] device class 'net': registering
[    0.241017] NET: Registered protocol family 2
[    0.249435] NET: Registered protocol family 1
[    5.098813] device: 'xps-ll-temac.1': device_add
[    5.098984] bus: 'platform': add device xps-ll-temac.1
[    5.101050] device: '81880000.ethernet': device_add
[    5.101221] bus: 'platform': add device 81880000.ethernet
[    5.484077] bus: 'platform': add driver xilinx_temac
[    5.484491] bus: 'platform': driver_probe_device: matched device 
81880000.ethernet with driver xilinx_temac
[    5.484726] bus: 'platform': really_probe: probing driver 
xilinx_temac with device 81880000.ethernet
[    5.487175] Xilinx TEMAC MDIO: probed
[    5.495719] driver: '81880000.ethernet': driver_bound: bound to 
device 'xilinx_temac'
[    5.495827] bus: 'platform': really_probe: bound device 
81880000.ethernet to driver xilinx_temac
[    5.530592] NET: Registered protocol family 17

Is there something I'm missing about this LLTEMAC to LL_TEMAC change ?
Thanks
-- 
Guillaume Dargaud
http://www.gdargaud.net/
