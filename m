Date: Thu, 29 Jul 1999 15:25:08 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: laveren <laveren@ifir.ifir.edu.ar>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerBook '99 ethernet problem.
In-Reply-To: <Pine.BSF.3.96.990728120357.22251A-100000@ifir>
Message-ID: <Pine.LNX.3.96L.990729152402.1897O-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Jul 1999, laveren wrote:
> 
> 	Hi, I'm using R5, it works great, but the ethernet hardware is not
> responding ie:
> 
> 	during the boot precess the eth is recognized as
> 	eth0: BMAC+ at 00:50:e4:7a:37:51
> 	after booting I issue:
> 
> # ifconfig eth0 192.168.3.2 broadcast 192.168.3.255 netmask  255.255.255.0
> # ifconfig eth0
> 	eth0  Link encap: Ethernet  HWaddr 00:50:e4:7a:37:51
>               inet addr: 192.168.3.40 Bcast:192.168.3.255 Mask:255.255.255.0
>               UP BROADCAST RUNNING MULTICAST MTU: 1500 Metric: 1
>               RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>               TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>               collisions:0 txqueuelen:100
>               Interrupt:42 Base address:0xc000
> 
> # route
> Kernel IP routing table
> Destination     GW     GenMask          Flags Metric  Ref Use Iface
> 192.168.3.40    *      255.255.255.255  UH    0       0   0   eth0
> 192.168.3.0     *      255.255.255.0    U     0       0   0   eth0
> 127.0.0.0       *      255.0.0.0        U     0       0   0   lo
> 
> So the net is ok but when i try to ping any box in the net nothing
> happends:
> 
> # ping -c 5 192.168.3.1
> PING 192.168.3.1 (192.168.3.1): 56 data bytes
> 
> --- 192.168.3.1 ping statistics ---
> 5 packets transmited, 0 received, 100% packet loss
> 
> #ifconfig eth0
>   XXX --- Same as before but
>   RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>   TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> 
> Then I guess that no packets were efectively transmited by the kernel eth
> driver. Why?? What wrong?? There is other things yet, after boot
> /dev/interrupts says:
>      CPU0
> XX:  XXX
> 32:     0     PMAC-PIC    BMAC-txdma
> 33:     0     PMAC-PIC    BMAC-rxdma
> 42:     0     PMAC-PIC    BMAC-misc
> 
> after the ping the interrupts remains as before so no interrupts were
> handled by the driver, well if no packets were TX as i guess no intr were
> generated that coherent. but if I issue:
> 
> #ifconfig eth0 down
> #ifconfig eth1 up
> #ifconfig eth0
> XXX --- same as before
> RX packets:0 errors:1 dropped:1 overruns:0 frame:1
> TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
> XXX --- same as before
> 
> why r RX errors? and why i try to TX 1 packet??
> 
> Any ideas why is this appening to me????

You mentioned this is a Lombard in the subject, yes? Have you applied the
ethernet patch at www.terraplex.com/~dburcaw/bmac.patch and recompiled your
kernel?

-Hollis

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
