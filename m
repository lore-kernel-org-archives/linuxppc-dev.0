Return-Path: <dimov@ronetix.at>
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de
	[80.67.31.28]) by ozlabs.org (Postfix) with ESMTP id 569DEB6F0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 09:33:50 +1100 (EST)
Received: from [62.178.142.196] (helo=iserv.ronetix.at)
	by smtprelay01.ispgateway.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <dimov@ronetix.at>) id 1NMqii-0002Xc-6f
	for linuxppc-dev@lists.ozlabs.org; Mon, 21 Dec 2009 23:27:16 +0100
Received: from [192.168.10.226] (tserv_vpn [192.168.22.10])
	by iserv.ronetix.at (8.13.8/8.13.8) with ESMTP id nBLMREF4016461
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2009 23:27:15 +0100
Message-ID: <4B2FF66E.7000209@ronetix.at>
Date: Tue, 22 Dec 2009 00:27:58 +0200
From: RONETIX - Asen Dimov <dimov@ronetix.at>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC8313e RDB rev A4 and rev C network throughput
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
I have made some test on network throughput with MPC8313e RDB revA4 and 
revC.
Some have mentioned that CSB(Coherent System Bus) frequency or untuned 
TCP/IP stack,
could cause decrease of network throughput.

**Test results

-on MPC8313e RDB revA4 with kernel 2.6.20 and u-boot 1.1.6 created with 
ltib-mpc8313erdb-20070824
        iperf -c 172.16.0.1 -l 2m -w 256k
-throughput is 510Mbps


-on MPC8313e RDB revA4 with kernel 2.6.23 and u-boot 1.3.0 generated 
with ltib-mpc8313erdb-20081222
        iperf -c 172.16.0.1 -l 2m -w 256k
-throughput is 510Mbps


-on MPC8313e RDB revC with kernel 2.6.23 (the same u-boot, kernel and 
rootfs as in rev A4, only dtb file differs)
        iperf -c 172.16.0.1 -l 2m -w 256k
-throughput is 360Mbps.


Have someone made such measurements? Any ideas why MPC8313e RDB revC 
gives worser throughput than revA4?

** Notes
*The PC (CPU:Intel(R) Core(TM)2 Duo CPU, E8400 @ 3.00GHz;
         RAM:  2x2G DDR2 @ 800Mhz ;
         NIC: R8168B PCI Express Gigabit Ethernet controller, driver 
8.014.00-NAPI;
         OS: Fedora release 10 (Cambridge) with kernel: 
2.6.27.38-170.2.113.fc10.i686.PAE #1 SMP )
*Commnads to set PC

        ethtool -s eth0 autoneg off speed 1000 duplex full
        ifconfig eth1 172.16.0.1/12 mtu 6000 txqueuelen 10000
        echo 131071 > /proc/sys/net/core/rmem_max
        echo 131071 > /proc/sys/net/core/wmem_max
        echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_rmem
        echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_wmem
        iperf -s -l 2m -w 70k


*The MPC8313e RDB(CPU: 333Mhz; CSB: 166Mhz) revA4 and revC(using PHY not 
switch)
*Commnads to set a board before using iperf

        ifconfig eth1 172.16.0.1/12 mtu 6000 txqueuelen 10000
        #The PC  lan card is set to advertise 1000Mbps only, so the 
board switches to 1000Mbps too.
        echo 131071 > /proc/sys/net/core/rmem_max
        echo 131071 > /proc/sys/net/core/wmem_max
        echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_rmem
        echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_wmem

Regards,
Asen
