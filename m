Message-ID: <000a01c25eaa$c6263840$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20020917201041.09711FA8D@denx.denx.de>
Subject: Re: Why FEC and SCC1 can not work at the same time? 
Date: Wed, 18 Sep 2002 08:31:47 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, September 18, 2002 4:10 AM
Subject: Re: Why FEC and SCC1 can not work at the same time?
Sir ,
Thank you for your help,but I disagree with your in some point.

First, I did not use the same MAC address, eth0 is 00:d0:93:00:12:34 and eth1 is 00:d0:93:80:12:34  ,one is 00:12::34 and one is 80:12:34,are they in the same?

Second , I did not use both ethernet port to connect the same network ,one is 192.168.1.X and other is 192.168.2.X ,netmask is 255.255.255.0.

The third, I  ifconfiged my interface in /etc/inid.d/rcS file,my rcS file is:


#!/bin/sh

mount -t proc proc /proc
ifconfig lo 127.0.0.1 netmask 255.0.0.0
ifconfig eth0 192.168.2.221 netmask 255.255.255.0
ifconfig eth1 192.168.1.198 netmask 255.255.255.0

route add default gw 192.168.2.1 eth1


while [ 1 ]
do
        /bin/sh
done

My inittab file is:

# /etc/inittab: init configuration.

# The default runlevel.
#hw id:3:initdefault:

# Boot-time system configuration/initialization script.
#si::sysinit:/etc/init.d/rcS
::sysinit:/etc/init.d/rcS



Route information is here:

# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.2.0     *               255.255.255.0   U     0      0        0 eth0
192.168.1.0     *               255.255.255.0   U     0      0        0 eth1
# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:D0:93:00:12:34
          inet addr:192.168.2.221  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:41 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:3677 (3.5 kb)  TX bytes:0 (0.0 b)
          Base address:0x3c00

eth1      Link encap:Ethernet  HWaddr 00:D0:93:80:12:34
          inet addr:192.168.1.198  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Base address:0xe00

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

#

Thank you very much again,hope to hear from you soon!

> In message <001001c25e1e$c9c33ac0$7301a8c0@zhongqx> you wrote:
> >
> > I want to use FEC(100M) and SCC1(10M) interface,but they can not work together.
>
> They can.
>
> > eth0: CPM ENET Version 0.2 on SCC1, 00:d0:93:00:12:34
> > eth1: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:d0:93:80:12:34
>
> Please be aware that both interfaces use the same MAC  address.  This
> is ok as long as you don;t try to connect bioth to the same subnet.
>
> > VFS: Mounted root (ext2 filesystem).
> > Freeing unused kernel memory: 40k init
> > init started:  BusyBox v0.60.2 (2002.07.18-17:16+0000) multi-call SIOCADDRT: Net
> > work is unreachable
> >
> >     ******(What reason ? when this message output?)
>
> Well, it  makes  little  sense  to  guess  how  you  ifconfig'ed  the
> interfaces, please provide more information.
>
> My bet is that you tired to run  both  ethernet  ports  in  the  same
> network,  and  that  you're  experiencing  a  conflict  caused by two
> identical MAC addresses.
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> "I find this a nice feature but it is not according to  the  documen-
> tation. Or is it a BUG?"   "Let's call it an accidental feature. :-)"
>                        - Larry Wall in <6909@jpl-devvax.JPL.NASA.GOV>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
