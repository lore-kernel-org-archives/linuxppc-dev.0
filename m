Return-Path: <jsurf@heckheck.com>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [204.127.200.84])
	by ozlabs.org (Postfix) with ESMTP id 1850467C56
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Nov 2006 09:08:36 +1100 (EST)
Message-ID: <45525367.10502@heckheck.com>
Date: Wed, 08 Nov 2006 17:00:07 -0500
From: Jim Heck <jsurf@heckheck.com>
MIME-Version: 1.0
To: robin.gilks@tait.co.nz
Subject: Re: Freescale combined ethernet driver
References: <45515913.3080206@tait.co.nz>
In-Reply-To: <45515913.3080206@tait.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Assuming you have a filesystem and can get some software onto it (with 
the network not up...), the package 'iproute' contains the 'ip' tool 
that would quickly show you the name of the device using the command.

ip link show

# ip link show
1: lo: <LOOPBACK,UP,10000> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,10000> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:0b:cd:01:d0:6b brd ff:ff:ff:ff:ff:ff
3: eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast 
qlen 1000    link/ether 00:01:02:48:4d:41 brd ff:ff:ff:ff:ff:ff
4: sit0: <NOARP> mtu 1480 qdisc noop
    link/sit 0.0.0.0 brd 0.0.0.0

-Jim

Robin Gilks wrote:
> OK - I give up - whats the name of the device?
>
> I've tried eth0, fsl-cpm-fec0 (and other combinations) with a 
> commandline of the form:
>
>    ip=172.25.206.113:172.25.140.15::255.255.0.0:unset:fsl-cpm-fec0:off \ 
> panic=1 console=ttyCPM0
>
> and I get the following errors:
> [   37.249708] TCP bic registered
> [   37.255389] Initializing IPsec netlink socket
> [   37.264134] NET: Registered protocol family 1
> [   37.272673] NET: Registered protocol family 17
> [   37.281436] NET: Registered protocol family 15
> [   37.796233] IP-Config: Device `fsl-cpm-fec0' not found.
> [   37.807814] Looking up port of RPC 100003/2 on 172.25.140.15
> [   37.819328] portmap: RPC call returned error 101
>
> This is on an 859T CPU so its a CPM1 and I'm using the single SCC 
> channel as a serial UART.
>
>   
