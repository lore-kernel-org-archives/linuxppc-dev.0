Message-Id: <5.1.0.14.2.20020115074131.0216bba8@falcon.si.com>
Date: Tue, 15 Jan 2002 07:50:00 -0500
To: <linuxppc-embedded@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: 8240 booting:bootp time out and hd lost interrupt
In-Reply-To: <3C441AA9.9A982529@lvl7.com>
References: <200201151021.EAA18816@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On the bootp time out, you appear to be sending ARP packets and not getting
a response.  Is your BOOTP server properly configured?  To be specific, is
it configured to be 192.168.10.1?  Your etherdump trace (ARP with no
response and ICMP "unreachable" error packets) implies not.  Ping it to
check, preferably from your custom MPC860P board.

Are you sniffing the ethernet from a different machine than your custom
MPC860P board?  You should be: otherwise you don't know if the packet
actually gets transmitted on the ethernet.  This could also cause the "no
ARP response" symptoms you show.

It probably isn't significant, and could just be my ignorance, but there
also appears to be a missmatch with the MAC address used: your bootp line
shows 0:e0:4c:45:56:af but your ARP request appears to be using
0:e0:4c:3b:f6:ca.

gvb


At 07:03 AM 1/15/2002 -0500, Neil Horman wrote:

>Hello-
>      Not sure if these are going to be you're exact answers, but I've
>recently tackled both problems on a custom MPC860P based board:

[snip]

>2)
> >the other is why the bootp time out. i test the host dhcp configuration
> with >win98 as client.
>         It looks to me as though you don't have your bootp server set up
>properly.  Looking at your tcpdump, I see you sending out bootp requests
>(eth0 B 0.0.0.0 >....), but I see no responsees.  The 192.168.10.13
>address appears multiple times in your tcpdump prior to your bootp
>requests being sent (even on the lo interface which is odd), so it looks
>like that may be a configuration error (perhaps something you passed in
>on the kernel command line?).  The fact that you can boot a Win98 client
>with your DHCP server just means that it serves DHCP requests well,
>which are close to, but not bootp requests.  I use the ISC DHCP server
>here under red hat 7.1, and to use it to serve bootp requires that I add
>a special bootp entry for every address I wish to serve, like this:
>host <name>:
>{
>hardware ethernet <MAC>;
>fixed address <IP>;
>};
>
>Hope that helps!
>Neil Horman
>
>
>
>
>怡摸 wrote:
> >
> > Hello:
> >   I'm a newer to PowerPC. when i port linux to PowerPC 8240,i met some
> problem.anyone give me advices will be appreciate.
> >   i use board sandpoint 3, the cpu board is mpc8240.
> >   I mark the line i wish you pay attention to.i have two questions: one
> is why the hdc lost the interrupt. the other is why the bootp time out. i
> test the host dhcp configuration with win98 as client.
> >   The dip switch on cpu board is set to : sw2 01111,sw3 11011 (1 means ON)
> >   BTW,who could tell me every bit of the two dip switch mean? I
> couldn't find document about it.
> >   The dip switch on main board is set to: sw1 11111010 ,sw2 11111111.
> >   The type of main board is "ppceval-sp3 rev x3". the CPU board is
> > "m98ppmc8240 rev x2" .linux kernel is Mvista Hard Hat Linux 2.0 for
> >  ppc 82xx. My hard disk type is "Quantum fireball 3.5series 30.0GB".
> >   the following is bootup message:
> >

[snip]

> > loop: loaded (max 8 devices)
> > Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI endttyS00 at 0x03f8 (irq = 4) is a 16550A
> > ttyS01 at 0x02f8 (irq = 3) is a 16550A
> > NET4: Linux TCP/IP 1.0 for NET4.0
> > IP Protocols: ICMP, UDP, TCP
> > IP: routing cache hash table of 512 buckets, 4Kbytes
> > TCP: Hash tables configured (established 2048 bind 2048)
> >
> /*******************************************************************************
> > Sending BOOTP requests.......<6>NETDEV WATCHDOG: eth0: transmit timed out
> > ....<6>NETDEV WATCHDOG: eth0: transmit timed out .. timed out!
> >
> ********************************************************************************/
> > IP-Config: No network devices available.
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > Root-NFS: No NFS server available, giving up.
> > VFS: Unable to mount root fs via NFS, trying floppy.
> > request_module[block-major-2]: Root fs not mounted
> > VFS: Cannot open root device "" or 02:00
> > Please append a correct "root=" boot option
> > Kernel panic: VFS: Unable to mount root fs on 02:00
> >
> >     and I use tcpdump to listen to the eth0, and receive something like
> that:
> >
> >           14:34:27.591370 eth0 B 0.0.0.0.bootpc >
> 255.255.255.255.bootps: xid:0xc6c3f016 secs:88 [|bootp] (DF)
> > 14:34:27.591925 eth0 > 192.168.10.13.bootps > 255.255.255.255.bootpc:
> xid:0xc6c3f016 secs:88 Y:192.168.10.100 S:192.168.10.13 ether
> 0:e0:4c:45:56:af [|bootp] (DF)
> > 14:34:27.595609 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:28.591256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:29.591256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:30.591402   lo > 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:30.591402   lo < 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:32.601383 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:33.601256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:34.601256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:35.601276   lo > 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:35.601276   lo < 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:37.612096 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:38.611257 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:39.611257 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:40.611278   lo > 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:40.611278   lo < 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:42.621330 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:43.621256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:44.621256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:45.621277   lo > 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:45.621277   lo < 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:47.633769 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:48.631263 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:49.631256 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:50.631277   lo > 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:50.631277   lo < 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:52.641343 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:53.641271 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:54.641268 eth0 > arp who-has 192.168.10.1 tell 192.168.10.13
> (0:e0:4c:3b:f6:ca)
> > 14:34:55.641289   lo > 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:55.641289   lo < 192.168.10.13 > 192.168.10.13: icmp: host
> 192.168.10.1 unreachable [tos 0xc0]
> > 14:34:55.711924 eth0 B 0.0.0.0.bootpc > 255.255.255.255.bootps:
> xid:0xc6c3f016 secs:117 [|bootp] (DF)
> > 14:34:55.712391 eth0 > 192.168.10.13.bootps > 255.255.255.255.bootpc:
> xid:0xc6c3f016 secs:117 Y:192.168.10.100 S:192.168.10.13 ether
> 0:e0:4c:45:56:af [|bootp] (DF)
> > 14:35:25.712515 eth0 B 0.0.0.0.bootpc > 255.255.255.255.bootps:
> xid:0xc6c3f016 secs:147 [|bootp] (DF)
> > 14:35:25.713052 eth0 > 192.168.10.13.bootps > 255.255.255.255.bootpc:
> xid:0xc6c3f016 secs:147 Y:192.168.10.100 S:192.168.10.13 ether
> 0:e0:4c:45:56:af [|bootp] (DF)
> >
> >      It seems that the host ack the target's require, but target did't
> accept . So the target has no right IP address.
> >
> >      regards.
> >
>                                                                                  stone
> >
> > 　　　　　　　　　　　　　　stone@pocketix.com
> > 　　　　　　　　　　　　　　　　　2002-01-15
> >
>
>--
>/***************************************
>*Neil Horman
>*Master of Software Feng Shui
>*Lvl7 Systems
>*(919)-865-2915
>***************************************/
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
