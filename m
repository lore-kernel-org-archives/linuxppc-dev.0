Return-Path: <Shengping.Liu@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 0BFFFDDE11
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Sep 2007 13:57:09 +1000 (EST)
Message-ID: <46FF1CE5.7000705@windriver.com>
Date: Sun, 30 Sep 2007 11:49:57 +0800
From: Andrew Liu <shengping.liu@windriver.com>
MIME-Version: 1.0
To: jrigby@freescale.com, linuxppc-embedded@ozlabs.org
Subject: A FEC problem  on fsl_mpc5121e_ads board.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All,

When I boot from NFS, it  doesn't work,  so I  boot system from NOR flash.
I found FEC hasn't produced any interrupts ( of course, I have plugged
in cable, and make sure the cable works on other  boards, what's more, I
can see FEC light blinks)
when system boot up:

-sh-2.05b# cat /proc/interrupts
           CPU0      
 16:          0   IPIC   Level     fs_enet-mac
 17:         36   IPIC   Level     i2c-mpc
 18:          1   IPIC   Level     i2c-mpc
 19:          1   IPIC   Level     i2c-mpc
 40:       1117   IPIC   Level     mpc512x_psc_uart
BAD:          0

-sh-2.05b# ethtool eth0
Settings for eth0:
        Supported ports: [ TP AUI BNC MII FIBRE ]
        Supported link modes:  
        Supports auto-negotiation: No
        Advertised link modes:  Not reported
        Advertised auto-negotiation: No
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 1
        Transceiver: external
        Auto-negotiation: on
        Current message level: 0x00000000 (0)
     *   Link detected: n*

it seems very strange that link detected is no,  I have tried the kernel
uImage  from Freescale ISO, the thing is same to above.
 The part  of DTS  as bellow:
 mdio@2840 {
                        device_type = "mdio";
                        compatible = "fs_nocpm_enet";
                        reg = <2840 4>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                        phy: ethernet-phy@0 {
                //              interrupt-parent = < &cpld_pic >;
                //              interrupts = <b 8>;
                                reg = <1>;
                                device_type = "ethernet-phy";
                        };
                };     

                ethernet@2800 {
                        device_type = "network";
                        model = "FEC";
                        compatible = "fs_nocpm_enet";
                        device-id = <1>;
                        reg = <2800 800>;
                        address = [ 00 E0 0C BC E5 40 ];
                        local-mac-address = [ 00 E0 0C BC E5 40 ];
                        interrupts = <4 8 >;
                        interrupt-parent = < &ipic >;
                        // NOTE: for 7-wire, remove phy-handle
                        // and add seven-wire
                         phy-handle = < &phy >;
                        //seven-wire;
                };     

when  boot from NFS, some information as belows:

011400.serial: ttyPSC1 at MMIO 0x80011400 (irq = 40) is a MPC52xx PSC
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: module loaded
*fs_enet.c:v1.0 (Aug 8, 2005)
FEC MII Bus: probed
...............................
*Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17*
IP-Config: Complete:
      device=eth0, addr=128.224.162.57, mask=255.255.254.0,
gw=128.224.162.1,
     host=mpc5121e_ads, domain=, nis-domain=(none),
     bootserver=128.224.162.142, rootserver=128.224.162.142, rootpath=
*md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.*
Looking up port of RPC 100003/2 on 128.224.162.142
rpcbind: server 128.224.162.142 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 128.224.162.142
rpcbind: server 128.224.162.142 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 128.224.162.142 not responding, timed out
Root-NFS: Server returned error -5 while mounting


Who can give me some advice ?
Thanks  in adance.

BRs,
Andrew
