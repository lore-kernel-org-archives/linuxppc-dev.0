Return-Path: <R63238@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC629B6F0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 14:47:47 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBM3lhAR028647 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Dec 2009 20:47:43 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBM3qGug003544
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Dec 2009 21:52:17 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8313e RDB rev A4 and rev C network throughput
Date: Tue, 22 Dec 2009 11:47:38 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208985F8CF@zch01exm21.fsl.freescale.net>
In-Reply-To: <4B2FF66E.7000209@ronetix.at>
References: <4B2FF66E.7000209@ronetix.at>
From: "Liu Dave-R63238" <r63238@freescale.com>
To: "RONETIX - Asen Dimov" <dimov@ronetix.at>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One possible cause is the two board has different RCW.
So that the freq of core/csb/.... Is different.=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+daveliu=3Dfreescale.com@lists.ozlabs.org=20
> [mailto:linuxppc-dev-bounces+daveliu=3Dfreescale.com@lists.ozlab
> s.org] On Behalf Of RONETIX - Asen Dimov
> Sent: Tuesday, December 22, 2009 6:28 AM
> To: linuxppc-dev@lists.ozlabs.org
> Subject: MPC8313e RDB rev A4 and rev C network throughput
>=20
> Hello all,
> I have made some test on network throughput with MPC8313e RDB=20
> revA4 and revC.
> Some have mentioned that CSB(Coherent System Bus) frequency=20
> or untuned TCP/IP stack, could cause decrease of network throughput.
>=20
> **Test results
>=20
> -on MPC8313e RDB revA4 with kernel 2.6.20 and u-boot 1.1.6=20
> created with
> ltib-mpc8313erdb-20070824
>         iperf -c 172.16.0.1 -l 2m -w 256k -throughput is 510Mbps
>=20
>=20
> -on MPC8313e RDB revA4 with kernel 2.6.23 and u-boot 1.3.0 generated=20
> with ltib-mpc8313erdb-20081222
>         iperf -c 172.16.0.1 -l 2m -w 256k
> -throughput is 510Mbps
>=20
>=20
> -on MPC8313e RDB revC with kernel 2.6.23 (the same u-boot, kernel and=20
> rootfs as in rev A4, only dtb file differs)
>         iperf -c 172.16.0.1 -l 2m -w 256k
> -throughput is 360Mbps.
>=20
>=20
> Have someone made such measurements? Any ideas why MPC8313e RDB revC=20
> gives worser throughput than revA4?
>=20
> ** Notes
> *The PC (CPU:Intel(R) Core(TM)2 Duo CPU, E8400 @ 3.00GHz;
>          RAM:  2x2G DDR2 @ 800Mhz ;
>          NIC: R8168B PCI Express Gigabit Ethernet controller, driver=20
> 8.014.00-NAPI;
>          OS: Fedora release 10 (Cambridge) with kernel:=20
> 2.6.27.38-170.2.113.fc10.i686.PAE #1 SMP )
> *Commnads to set PC
>=20
>         ethtool -s eth0 autoneg off speed 1000 duplex full
>         ifconfig eth1 172.16.0.1/12 mtu 6000 txqueuelen 10000
>         echo 131071 > /proc/sys/net/core/rmem_max
>         echo 131071 > /proc/sys/net/core/wmem_max
>         echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_rmem
>         echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_wmem
>         iperf -s -l 2m -w 70k
>=20
>=20
> *The MPC8313e RDB(CPU: 333Mhz; CSB: 166Mhz) revA4 and=20
> revC(using PHY not=20
> switch)
> *Commnads to set a board before using iperf
>=20
>         ifconfig eth1 172.16.0.1/12 mtu 6000 txqueuelen 10000
>         #The PC  lan card is set to advertise 1000Mbps only, so the=20
> board switches to 1000Mbps too.
>         echo 131071 > /proc/sys/net/core/rmem_max
>         echo 131071 > /proc/sys/net/core/wmem_max
>         echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_rmem
>         echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_wmem
>=20
> Regards,
> Asen
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20
