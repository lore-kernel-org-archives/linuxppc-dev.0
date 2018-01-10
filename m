Return-Path: <jamie@bitbybitsoftwaregroup.com>
Received: from leaf101.mfilter.dimenoc.com (apple.mfilter.dimenoc.com
 [72.29.89.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGv2f2MLPzDqwr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 03:04:10 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
 by leaf101.mfilter.dimenoc.com (Postfix) with ESMTP id 0FA61226E94
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 10:56:57 -0500 (EST)
Received: from leaf101.mfilter.dimenoc.com ([127.0.0.1])
 by localhost (leaf101.mfilter.dimenoc.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id liBUU4MwlkAA for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 10 Jan 2018 10:56:55 -0500 (EST)
Received: from dime155.dizinc.com (unknown [72.29.89.7])
 by leaf101.mfilter.dimenoc.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 10:56:55 -0500 (EST)
To: linuxppc-dev@lists.ozlabs.org
From: Jamie Krueger <jamie@bitbybitsoftwaregroup.com>
Subject: DPAA Ethernet problems with mainstream Linux kernels
Message-ID: <ccafbcca-172b-11ae-7916-8bcd4bfa419c@bitbybitsoftwaregroup.com>
Date: Wed, 10 Jan 2018 09:56:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all @ linuxppc-dev,

I have been working with a team of people maintaining PowerPC
Linux for the new AmigaONE X5000/20 (a Freescale p5020 SoC based
machine).

We are trying to determine why the submitted Data Path Acceleration
Architecture (DPAA) Ethernet Driver is not fully functional with
the mainstream Linux kernels.

Here is the results from my latest tests. They were performed using
the linux-4.10.17 ppc64, since that represents when the DPAA Ethernet
code was introduced.

Similar tests, with similar results, were also performed
using the latest Linux kernels:

linux-4.15-rc5
linux-4.15-rc6
linux-4.15-rc7

(Hence the reason for falling back to test the kernel right
  after the introduction of the DPAA Ethernet driver sources)

---

All Kernel builds had the DPAA Ethernet enabled in the kernel,
and are using the correct cyrus_p5020.eth.dtb device tree file
(for use on the X5000/20).

The results are quite similar for all kernels in regards to the DPAA 
Ethernet.

All tested kernels setup the two Ethernet interfaces correctly
as eth0 and eth1, and pull the correct MAC addresses from U-Boot
environment variables ethaddr and eth1addr respectively.

So at this point Linux has what it believes is fully configured
hardware, waiting to have an IP Address/Netmask/Gateway
to be set and to bring the interface online.

However, all attempts to communicate with the outside world
do not make it out the physical (PHY) hardware - or do they?

** The following results were captured under linux-4.10.17 **

When I bring the interface up using a static address, in this case
192.168.1.21, I see the following (NOTE TX bytes says 154.0 KB,
while RX bytes says 0.0 B):

jamie@X5000-Linux:$ ifconfig
eth0      Link encap:Ethernet  HWaddr 00:80:10:11:11:11
           inet addr:192.168.1.21  Bcast:192.168.1.255 Mask:255.255.255.0
           inet6 addr: fe80::280:10ff:fe11:1111/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:1428 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:154066 (154.0 KB)
           Memory:fe4e6000-fe4e6fff

eth1      Link encap:Ethernet  HWaddr 00:80:10:22:22:22
           UP BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
           Memory:fe4e8000-fe4e8fff

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           inet6 addr: ::1/128 Scope:Host
           UP LOOPBACK RUNNING  MTU:65536  Metric:1
           RX packets:1869 errors:0 dropped:0 overruns:0 frame:0
           TX packets:1869 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:156932 (156.9 KB)  TX bytes:156932 (156.9 KB)

Checking the routing table, everything looks fine there:

jamie@X5000-Linux:$ netstat -r
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt 
Iface
default         192.168.1.1     0.0.0.0         UG        0 0          0 
eth0
link-local      *               255.255.0.0     U         0 0          0 
eth0
192.168.1.0     *               255.255.255.0   U         0 0          0 
eth0

Attempting to PING the interface itself works:

jamie@X5000-Linux:$ ping 192.168.1.21
PING 192.168.1.21 (192.168.1.21) 56(84) bytes of data.
64 bytes from 192.168.1.21: icmp_seq=1 ttl=64 time=0.037 ms
64 bytes from 192.168.1.21: icmp_seq=2 ttl=64 time=0.045 ms
64 bytes from 192.168.1.21: icmp_seq=3 ttl=64 time=0.033 ms
^C
--- 192.168.1.21 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2043ms

However, attempts to PING the gateway (192.168.1.1) fail as unreachable:

jamie@X5000-Linux:$ ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
 From 192.168.1.21 icmp_seq=1 Destination Host Unreachable
 From 192.168.1.21 icmp_seq=2 Destination Host Unreachable
 From 192.168.1.21 icmp_seq=3 Destination Host Unreachable
^C
--- 192.168.1.1 ping statistics ---
7 packets transmitted, 0 received, +3 errors, 100% packet loss, time 6077ms

In order to take a closer look at what is going on I installed Wireshark
both on my test X5000/20 Linux install (Ubuntu 16.04.3 LTS), and on
another Linux box connected to the same network switch (in this case
at IP address 192.168.1.210)

In this test I start the capture on eth0 (X5000/20) before it is put online,
and attempt to bring it up using DHCP to obtain it's address.

What I found was that network traffic *was* being attempted over eth0.
Here is a plain text export of the transmit side (the X5000/20) that
was captured using Wireshark.

(There were more network packets being sent from the X5000/20,
  however, I am only showing DHCP traffic to save space in this post):

---
No.     Time           Source                Destination Protocol Length 
Info
       2 0.042259843    0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 2: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      16 3.830001152    0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 16: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      21 9.308914533    0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 21: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      23 18.906405343   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 23: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      25 36.390926450   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 25: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      26 44.048328412   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 26: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      30 44.889049203   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 30: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      44 48.254495304   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 44: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      49 54.299052732   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 49: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      51 62.672007482   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 51: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      52 77.485896202   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 52: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      56 89.895304152   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x5df47c84

Frame 56: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      71 93.828837008   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x5df47c84

Frame 71: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      74 97.948453158   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x5df47c84

Frame 74: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)
---

Now, over on the external Linux machine (192.168.1.210), I setup a 
Wireshark capture
which filtered for any traffic to/from the MAC address of the X5000/20's 
eth0, in this case
shown as Commodor_11:11:11 (00:80:10:11:11:11) below:

This export shows only the DHCP traffic seen from outside the X5000/20,
and as you can see, a matching set of DHCP requests *do in fact* make
it to the outside network.

---
No.     Time           Source                Destination Protocol Length 
Info
      39 5.671762509    0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 39: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
      73 9.451895404    0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 73: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
     154 14.919944480   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 154: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
     269 24.498335996   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 269: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
     630 41.948018648   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 630: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
     701 49.590211264   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x655d91e8

Frame 701: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
     706 50.429265938   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 706: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
     744 53.788035317   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 744: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
     797 59.820568614   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 797: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
     852 68.176833686   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 852: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
     990 82.961224895   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x421bade3

Frame 990: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits) 
on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
    3827 95.345964418   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x5df47c84

Frame 3827: 342 bytes on wire (2736 bits), 342 bytes captured (2736 
bits) on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
    3887 99.271668572   0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x5df47c84

Frame 3887: 342 bytes on wire (2736 bits), 342 bytes captured (2736 
bits) on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)

No.     Time           Source                Destination Protocol Length 
Info
    3943 103.383072429  0.0.0.0               255.255.255.255 DHCP     
342    DHCP Discover - Transaction ID 0x5df47c84

Frame 3943: 342 bytes on wire (2736 bits), 342 bytes captured (2736 
bits) on interface 0
Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast 
(ff:ff:ff:ff:ff:ff)
     Destination: Broadcast (ff:ff:ff:ff:ff:ff)
     Source: Commodor_11:11:11 (00:80:10:11:11:11)
     Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
User Datagram Protocol, Src Port: 68, Dst Port: 67
Bootstrap Protocol (Discover)
---

The odd thing here is that while the DHCP requests were broadcast to the
outside network (confirming that at least the transmit to the PHY is 
working),
I could see no responses from my network's DHCP server to answer these
requests.

It is not a physical networking or routing issue, as I always get a 
successful
DHCP response to the X5000/20 when I enable the Realtek 8169 interface (also
installed [PCIe card] in the X5000/20).

Since initial outgoing traffic *appears* to be working from the DPAA 
Ethernet
on the X5000/20, is it possible we are missing an interrupt mapping from the
Frame Manager to catch the received data?

Any help would be appreciated. Thanks.

-- 
Best Regards,

Jamie Krueger
BITbyBIT Software Group LLC
