From: "Rick Hunnicutt" <rhunnicu@getntds.com>
To: "'zhongqx'" <zhongqx@guoguang.com.cn>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Why FEC and SCC1 can not work at the same time? 
Date: Wed, 18 Sep 2002 09:02:29 -0700
Message-ID: <000001c25f2c$cafeef60$cdf859c7@get.com>
In-Reply-To: <000a01c25eaa$c6263840$7301a8c0@zhongqx>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This looks like it may be a simple network issue. You have eth0 on the
192.168.1.X subnet. The subnet mask is set to 255.255.255.0 meaning it can
see all other 192.168.1.X IP's. eth1 is set to 192.168.2.X subnet with the
same subnet  mask so he only sees other IP's on the 192.168.2.X subnet. Your
gateway is 192.168.2.1 for eth1. Is this gateway able to reach both
networks? Have you tried making these on the same network (192.168.1.X) and
trying to ping them?

Rick Hunnicutt


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
> Of zhongqx
> Sent: Tuesday, September 17, 2002 5:32 PM
> To: Wolfgang Denk
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Why FEC and SCC1 can not work at the same time?
>
>
>
> ----- Original Message -----
> From: "Wolfgang Denk" <wd@denx.de>
> To: "zhongqx" <zhongqx@guoguang.com.cn>
> Cc: <linuxppc-embedded@lists.linuxppc.org>
> Sent: Wednesday, September 18, 2002 4:10 AM
> Subject: Re: Why FEC and SCC1 can not work at the same time?
> Sir ,
> Thank you for your help,but I disagree with your in some point.
>
> First, I did not use the same MAC address, eth0 is
> 00:d0:93:00:12:34 and eth1 is 00:d0:93:80:12:34  ,one is
> 00:12::34 and one is 80:12:34,are they in the same?
>
> Second , I did not use both ethernet port to connect the same
> network ,one is 192.168.1.X and other is 192.168.2.X ,netmask
> is 255.255.255.0.
>
> The third, I  ifconfiged my interface in /etc/inid.d/rcS
> file,my rcS file is:
>
>
> #!/bin/sh
>
> mount -t proc proc /proc
> ifconfig lo 127.0.0.1 netmask 255.0.0.0
> ifconfig eth0 192.168.2.221 netmask 255.255.255.0
> ifconfig eth1 192.168.1.198 netmask 255.255.255.0
>
> route add default gw 192.168.2.1 eth1
>
>
> while [ 1 ]
> do
>         /bin/sh
> done
>
> My inittab file is:
>
> # /etc/inittab: init configuration.
>
> # The default runlevel.
> #hw id:3:initdefault:
>
> # Boot-time system configuration/initialization script.
> #si::sysinit:/etc/init.d/rcS
> ::sysinit:/etc/init.d/rcS
>
>
>
> Route information is here:
>
> # route
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric
> Ref    Use Iface
> 192.168.2.0     *               255.255.255.0   U     0
> 0        0 eth0
> 192.168.1.0     *               255.255.255.0   U     0
> 0        0 eth1
> # ifconfig -a
> eth0      Link encap:Ethernet  HWaddr 00:D0:93:00:12:34
>           inet addr:192.168.2.221  Bcast:192.168.2.255
> Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:41 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:3677 (3.5 kb)  TX bytes:0 (0.0 b)
>           Base address:0x3c00
>
> eth1      Link encap:Ethernet  HWaddr 00:D0:93:80:12:34
>           inet addr:192.168.1.198  Bcast:192.168.1.255
> Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>           Base address:0xe00
>
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>
> #
>
> Thank you very much again,hope to hear from you soon!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
