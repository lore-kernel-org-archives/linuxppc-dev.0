Return-Path: <jamie@bitbybitsoftwaregroup.com>
Received: from leaf101.mfilter.dimenoc.com (banana.mfilter.dimenoc.com
 [72.29.89.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ7fZ4g2jzF0dn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 03:36:05 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
 by leaf101.mfilter.dimenoc.com (Postfix) with ESMTP id 6AEAC2260C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 11:36:01 -0500 (EST)
Received: from leaf101.mfilter.dimenoc.com ([127.0.0.1])
 by localhost (leaf101.mfilter.dimenoc.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id POm2ojgu1wyq for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 12 Jan 2018 11:35:58 -0500 (EST)
Received: from dime155.dizinc.com (unknown [72.29.89.7])
 by leaf101.mfilter.dimenoc.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 11:35:58 -0500 (EST)
Subject: Re: DPAA Ethernet problems with mainstream Linux kernels
To: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ccafbcca-172b-11ae-7916-8bcd4bfa419c@bitbybitsoftwaregroup.com>
 <DB3PR0402MB3849C70D5760C3F21F881074EC170@DB3PR0402MB3849.eurprd04.prod.outlook.com>
From: Jamie Krueger <jamie@bitbybitsoftwaregroup.com>
Message-ID: <d7478110-68ae-34b3-51c5-487bb3e12527@bitbybitsoftwaregroup.com>
Date: Fri, 12 Jan 2018 10:35:56 -0600
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3849C70D5760C3F21F881074EC170@DB3PR0402MB3849.eurprd04.prod.outlook.com>
Content-Type: multipart/mixed; boundary="------------71E075FD0FB696290AFF5A98"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------71E075FD0FB696290AFF5A98
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/12/2018 08:22 AM, Madalin-cristian Bucur wrote:
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-
>> bounces+madalin.bucur=nxp.com@lists.ozlabs.org] On Behalf Of Jamie Krueger
>> Sent: Wednesday, January 10, 2018 5:57 PM
>> To: linuxppc-dev@lists.ozlabs.org
>> Subject: DPAA Ethernet problems with mainstream Linux kernels
>>
>> Hello all @ linuxppc-dev,
>>
>> I have been working with a team of people maintaining PowerPC
>> Linux for the new AmigaONE X5000/20 (a Freescale p5020 SoC based
>> machine).
>>
>> We are trying to determine why the submitted Data Path Acceleration
>> Architecture (DPAA) Ethernet Driver is not fully functional with
>> the mainstream Linux kernels.
> Hi Jamie,
Hi Madalin,
> We are testing the DPAA driver on several DS and RDB platforms and it
> is working properly. The issues you encounter with it on the X5000/20
> are likely caused by some issues specific to that particular platform.
It is good to hear that the DPAA driver is functioning correctly
on the reference platforms. I am positive you are correct that
the issue is the difference in implementation on the X5000/20
(Cyrus) motherboard, as compared to the reference boards.

Can you verify which Linux Kernel sources your tests are being
performed on? We have been testing using the mainstream
Linux sources up to linux-4.15-rc6 thus far.

> The device tree that you mention, cyrus_p5020.eth.dts is not found in
> the Linux kernel sources. The cyrus_p5020.dts file from the fsl ppc
> device tree folder does not include the PHY information for the DPAA
> interfaces. The problems that you experience may be caused by some
> issues with the PHY configuration (i.e. internal delay).
The cyrus_p5020.eth.dts is a modified version of the cyrus_p5020.dts,
which of course was based off the original p5020ds.dts file. As you
noted, the current cyrus_p5020.dts file is incomplete, and does not
map the Ethernet connections properly.

The cyrus_p5020.eth.dts file, along with it's cyrus-pre.dtsi dependent
file, are an attempt to correctly define the Ethernet hardware, as it is
implemented on the X5000/20.

** I have attached both the cyrus_p5020.eth.dts and cyrus-pre.dtsi
      files with this email for comparison. Please let me know if you see
      any corrections that should be made to either file.

I am not sure what PHY hardware/configuration you are using on the
DS and RDB platforms, but I can confirm that AmigaONE X5000/20
(Cyrus Motherboard with p5020 SoC), has dTSEC 4 and dTSEC 5
wired to two Micrel KSZ9021RN Gigabit Ethernet PHYs, using the
RGMII protocol.

>   I suggest
> that you connect the DPAA interface to a traffic analyzer or directly
> to another device on which you can capture the incoming traffic and
> check that the received frames are correct.
I have started testing along that line, using Wireshark to view the
traffic on the X5000/20 itself, and from another machine connected
on the same subnet. So far (as indicated by some details of in my
initial email), I can see outgoing broadcast requests (for DHCP)
being sent out from the X5000/20, and these requests are correctly
constructed and visible outside the X5000/20.

However, no responses to the DHCP broadcasts appear to reach
to X5000/20's DPAA Ethernet. I will need to setup some further
tests to determine if the DHCP server saw the requests and responded
to them. (I assume the DHCP server is getting them, and responding,
as I can always get a successful DHCP response to the X5000/20
when using an add-on Ethernet PICe card on the same subnet).

I will setup some more direct machine-to-machine testing to
see what else I can glean from the network traffic.

Please have a look at the attached dts files, maybe there is something
obvious there we are not seeing.

Also, given that the X5000/20 uses Micrel KSZ9021RN PHYs in RGMII
mode, what changes to the DPAA hardware configuration should we
expect to see so that the DPAA is configured to talk to them?

> Madalin
>
-- 

Best Regards,

Jamie Krueger
BITbyBIT Software Group LLC

>> Here is the results from my latest tests. They were performed using
>> the linux-4.10.17 ppc64, since that represents when the DPAA Ethernet
>> code was introduced.
>>
>> Similar tests, with similar results, were also performed
>> using the latest Linux kernels:
>>
>> linux-4.15-rc5
>> linux-4.15-rc6
>> linux-4.15-rc7
>>
>> (Hence the reason for falling back to test the kernel right
>>    after the introduction of the DPAA Ethernet driver sources)
>>
>> ---
>>
>> All Kernel builds had the DPAA Ethernet enabled in the kernel,
>> and are using the correct cyrus_p5020.eth.dtb device tree file
>> (for use on the X5000/20).
>>
>> The results are quite similar for all kernels in regards to the DPAA
>> Ethernet.
>>
>> All tested kernels setup the two Ethernet interfaces correctly
>> as eth0 and eth1, and pull the correct MAC addresses from U-Boot
>> environment variables ethaddr and eth1addr respectively.
>>
>> So at this point Linux has what it believes is fully configured
>> hardware, waiting to have an IP Address/Netmask/Gateway
>> to be set and to bring the interface online.
>>
>> However, all attempts to communicate with the outside world
>> do not make it out the physical (PHY) hardware - or do they?
>>
>> ** The following results were captured under linux-4.10.17 **
>>
>> When I bring the interface up using a static address, in this case
>> 192.168.1.21, I see the following (NOTE TX bytes says 154.0 KB,
>> while RX bytes says 0.0 B):
>>
>> jamie@X5000-Linux:$ ifconfig
>> eth0      Link encap:Ethernet  HWaddr 00:80:10:11:11:11
>>             inet addr:192.168.1.21  Bcast:192.168.1.255 Mask:255.255.255.0
>>             inet6 addr: fe80::280:10ff:fe11:1111/64 Scope:Link
>>             UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>             RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>             TX packets:1428 errors:0 dropped:0 overruns:0 carrier:0
>>             collisions:0 txqueuelen:1000
>>             RX bytes:0 (0.0 B)  TX bytes:154066 (154.0 KB)
>>             Memory:fe4e6000-fe4e6fff
>>
>> eth1      Link encap:Ethernet  HWaddr 00:80:10:22:22:22
>>             UP BROADCAST MULTICAST  MTU:1500  Metric:1
>>             RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>             TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>             collisions:0 txqueuelen:1000
>>             RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>>             Memory:fe4e8000-fe4e8fff
>>
>> lo        Link encap:Local Loopback
>>             inet addr:127.0.0.1  Mask:255.0.0.0
>>             inet6 addr: ::1/128 Scope:Host
>>             UP LOOPBACK RUNNING  MTU:65536  Metric:1
>>             RX packets:1869 errors:0 dropped:0 overruns:0 frame:0
>>             TX packets:1869 errors:0 dropped:0 overruns:0 carrier:0
>>             collisions:0 txqueuelen:1000
>>             RX bytes:156932 (156.9 KB)  TX bytes:156932 (156.9 KB)
>>
>> Checking the routing table, everything looks fine there:
>>
>> jamie@X5000-Linux:$ netstat -r
>> Kernel IP routing table
>> Destination     Gateway         Genmask         Flags   MSS Window  irtt
>> Iface
>> default         192.168.1.1     0.0.0.0         UG        0 0          0
>> eth0
>> link-local      *               255.255.0.0     U         0 0          0
>> eth0
>> 192.168.1.0     *               255.255.255.0   U         0 0          0
>> eth0
>>
>> Attempting to PING the interface itself works:
>>
>> jamie@X5000-Linux:$ ping 192.168.1.21
>> PING 192.168.1.21 (192.168.1.21) 56(84) bytes of data.
>> 64 bytes from 192.168.1.21: icmp_seq=1 ttl=64 time=0.037 ms
>> 64 bytes from 192.168.1.21: icmp_seq=2 ttl=64 time=0.045 ms
>> 64 bytes from 192.168.1.21: icmp_seq=3 ttl=64 time=0.033 ms
>> ^C
>> --- 192.168.1.21 ping statistics ---
>> 3 packets transmitted, 3 received, 0% packet loss, time 2043ms
>>
>> However, attempts to PING the gateway (192.168.1.1) fail as unreachable:
>>
>> jamie@X5000-Linux:$ ping 192.168.1.1
>> PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
>>   From 192.168.1.21 icmp_seq=1 Destination Host Unreachable
>>   From 192.168.1.21 icmp_seq=2 Destination Host Unreachable
>>   From 192.168.1.21 icmp_seq=3 Destination Host Unreachable
>> ^C
>> --- 192.168.1.1 ping statistics ---
>> 7 packets transmitted, 0 received, +3 errors, 100% packet loss, time
>> 6077ms
>>
>> In order to take a closer look at what is going on I installed Wireshark
>> both on my test X5000/20 Linux install (Ubuntu 16.04.3 LTS), and on
>> another Linux box connected to the same network switch (in this case
>> at IP address 192.168.1.210)
>>
>> In this test I start the capture on eth0 (X5000/20) before it is put
>> online,
>> and attempt to bring it up using DHCP to obtain it's address.
>>
>> What I found was that network traffic *was* being attempted over eth0.
>> Here is a plain text export of the transmit side (the X5000/20) that
>> was captured using Wireshark.
>>
>> (There were more network packets being sent from the X5000/20,
>>    however, I am only showing DHCP traffic to save space in this post):
>>
>> ---
>> No.     Time           Source                Destination Protocol Length
>> Info
>>         2 0.042259843    0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 2: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        16 3.830001152    0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 16: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        21 9.308914533    0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 21: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        23 18.906405343   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 23: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        25 36.390926450   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 25: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        26 44.048328412   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 26: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        30 44.889049203   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 30: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        44 48.254495304   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 44: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        49 54.299052732   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 49: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        51 62.672007482   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 51: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        52 77.485896202   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 52: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        56 89.895304152   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x5df47c84
>>
>> Frame 56: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        71 93.828837008   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x5df47c84
>>
>> Frame 71: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        74 97.948453158   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x5df47c84
>>
>> Frame 74: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>> ---
>>
>> Now, over on the external Linux machine (192.168.1.210), I setup a
>> Wireshark capture
>> which filtered for any traffic to/from the MAC address of the X5000/20's
>> eth0, in this case
>> shown as Commodor_11:11:11 (00:80:10:11:11:11) below:
>>
>> This export shows only the DHCP traffic seen from outside the X5000/20,
>> and as you can see, a matching set of DHCP requests *do in fact* make
>> it to the outside network.
>>
>> ---
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        39 5.671762509    0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 39: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>        73 9.451895404    0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 73: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>       154 14.919944480   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 154: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>       269 24.498335996   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 269: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>       630 41.948018648   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 630: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>       701 49.590211264   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x655d91e8
>>
>> Frame 701: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>       706 50.429265938   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 706: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>       744 53.788035317   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 744: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>       797 59.820568614   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 797: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>       852 68.176833686   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 852: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>       990 82.961224895   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x421bade3
>>
>> Frame 990: 342 bytes on wire (2736 bits), 342 bytes captured (2736 bits)
>> on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>      3827 95.345964418   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x5df47c84
>>
>> Frame 3827: 342 bytes on wire (2736 bits), 342 bytes captured (2736
>> bits) on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>      3887 99.271668572   0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x5df47c84
>>
>> Frame 3887: 342 bytes on wire (2736 bits), 342 bytes captured (2736
>> bits) on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>>
>> No.     Time           Source                Destination Protocol Length
>> Info
>>      3943 103.383072429  0.0.0.0               255.255.255.255 DHCP
>> 342    DHCP Discover - Transaction ID 0x5df47c84
>>
>> Frame 3943: 342 bytes on wire (2736 bits), 342 bytes captured (2736
>> bits) on interface 0
>> Ethernet II, Src: Commodor_11:11:11 (00:80:10:11:11:11), Dst: Broadcast
>> (ff:ff:ff:ff:ff:ff)
>>       Destination: Broadcast (ff:ff:ff:ff:ff:ff)
>>       Source: Commodor_11:11:11 (00:80:10:11:11:11)
>>       Type: IPv4 (0x0800)
>> Internet Protocol Version 4, Src: 0.0.0.0, Dst: 255.255.255.255
>> User Datagram Protocol, Src Port: 68, Dst Port: 67
>> Bootstrap Protocol (Discover)
>> ---
>>
>> The odd thing here is that while the DHCP requests were broadcast to the
>> outside network (confirming that at least the transmit to the PHY is
>> working),
>> I could see no responses from my network's DHCP server to answer these
>> requests.
>>
>> It is not a physical networking or routing issue, as I always get a
>> successful
>> DHCP response to the X5000/20 when I enable the Realtek 8169 interface
>> (also
>> installed [PCIe card] in the X5000/20).
>>
>> Since initial outgoing traffic *appears* to be working from the DPAA
>> Ethernet
>> on the X5000/20, is it possible we are missing an interrupt mapping from
>> the
>> Frame Manager to catch the received data?
>>
>> Any help would be appreciated. Thanks.
>>
>> --
>> Best Regards,
>>
>> Jamie Krueger
>> BITbyBIT Software Group LLC


--------------71E075FD0FB696290AFF5A98
Content-Type: text/plain; charset=UTF-8;
 name="cyrus-pre.dtsi"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cyrus-pre.dtsi"

LyoKICogUDUwMjAvUDUwMTAgU2lsaWNvbi9Tb0MgRGV2aWNlIFRyZWUgU291cmNlIChwcmUg
aW5jbHVkZSkKICoKICogQ29weXJpZ2h0IDIwMTEgLSAyMDE1IEZyZWVzY2FsZSBTZW1pY29u
ZHVjdG9yIEluYy4KICoKICogUmVkaXN0cmlidXRpb24gYW5kIHVzZSBpbiBzb3VyY2UgYW5k
IGJpbmFyeSBmb3Jtcywgd2l0aCBvciB3aXRob3V0CiAqIG1vZGlmaWNhdGlvbiwgYXJlIHBl
cm1pdHRlZCBwcm92aWRlZCB0aGF0IHRoZSBmb2xsb3dpbmcgY29uZGl0aW9ucyBhcmUgbWV0
OgogKiAgICAgKiBSZWRpc3RyaWJ1dGlvbnMgb2Ygc291cmNlIGNvZGUgbXVzdCByZXRhaW4g
dGhlIGFib3ZlIGNvcHlyaWdodAogKiAgICAgICBub3RpY2UsIHRoaXMgbGlzdCBvZiBjb25k
aXRpb25zIGFuZCB0aGUgZm9sbG93aW5nIGRpc2NsYWltZXIuCiAqICAgICAqIFJlZGlzdHJp
YnV0aW9ucyBpbiBiaW5hcnkgZm9ybSBtdXN0IHJlcHJvZHVjZSB0aGUgYWJvdmUgY29weXJp
Z2h0CiAqICAgICAgIG5vdGljZSwgdGhpcyBsaXN0IG9mIGNvbmRpdGlvbnMgYW5kIHRoZSBm
b2xsb3dpbmcgZGlzY2xhaW1lciBpbiB0aGUKICogICAgICAgZG9jdW1lbnRhdGlvbiBhbmQv
b3Igb3RoZXIgbWF0ZXJpYWxzIHByb3ZpZGVkIHdpdGggdGhlIGRpc3RyaWJ1dGlvbi4KICog
ICAgICogTmVpdGhlciB0aGUgbmFtZSBvZiBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciBub3Ig
dGhlCiAqICAgICAgIG5hbWVzIG9mIGl0cyBjb250cmlidXRvcnMgbWF5IGJlIHVzZWQgdG8g
ZW5kb3JzZSBvciBwcm9tb3RlIHByb2R1Y3RzCiAqICAgICAgIGRlcml2ZWQgZnJvbSB0aGlz
IHNvZnR3YXJlIHdpdGhvdXQgc3BlY2lmaWMgcHJpb3Igd3JpdHRlbiBwZXJtaXNzaW9uLgog
KgogKgogKiBBTFRFUk5BVElWRUxZLCB0aGlzIHNvZnR3YXJlIG1heSBiZSBkaXN0cmlidXRl
ZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlCiAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
ICgiR1BMIikgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlCiAqIEZvdW5kYXRp
b24sIGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhhdCBMaWNlbnNlIG9yIChhdCB5b3VyIG9wdGlv
bikgYW55CiAqIGxhdGVyIHZlcnNpb24uCiAqCiAqIFRISVMgU09GVFdBUkUgSVMgUFJPVklE
RUQgQlkgRnJlZXNjYWxlIFNlbWljb25kdWN0b3IgYGBBUyBJUycnIEFORCBBTlkKICogRVhQ
UkVTUyBPUiBJTVBMSUVEIFdBUlJBTlRJRVMsIElOQ0xVRElORywgQlVUIE5PVCBMSU1JVEVE
IFRPLCBUSEUgSU1QTElFRAogKiBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJTElUWSBBTkQg
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQVJFCiAqIERJU0NMQUlNRUQuIElO
IE5PIEVWRU5UIFNIQUxMIEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yIEJFIExJQUJMRSBGT1Ig
QU5ZCiAqIERJUkVDVCwgSU5ESVJFQ1QsIElOQ0lERU5UQUwsIFNQRUNJQUwsIEVYRU1QTEFS
WSwgT1IgQ09OU0VRVUVOVElBTCBEQU1BR0VTCiAqIChJTkNMVURJTkcsIEJVVCBOT1QgTElN
SVRFRCBUTywgUFJPQ1VSRU1FTlQgT0YgU1VCU1RJVFVURSBHT09EUyBPUiBTRVJWSUNFUzsK
ICogTE9TUyBPRiBVU0UsIERBVEEsIE9SIFBST0ZJVFM7IE9SIEJVU0lORVNTIElOVEVSUlVQ
VElPTikgSE9XRVZFUiBDQVVTRUQgQU5ECiAqIE9OIEFOWSBUSEVPUlkgT0YgTElBQklMSVRZ
LCBXSEVUSEVSIElOIENPTlRSQUNULCBTVFJJQ1QgTElBQklMSVRZLCBPUiBUT1JUCiAqIChJ
TkNMVURJTkcgTkVHTElHRU5DRSBPUiBPVEhFUldJU0UpIEFSSVNJTkcgSU4gQU5ZIFdBWSBP
VVQgT0YgVEhFIFVTRSBPRiBUSElTCiAqIFNPRlRXQVJFLCBFVkVOIElGIEFEVklTRUQgT0Yg
VEhFIFBPU1NJQklMSVRZIE9GIFNVQ0ggREFNQUdFLgogKi8KCi9kdHMtdjEvOwoKL2luY2x1
ZGUvICJlNTUwMF9wb3dlcl9pc2EuZHRzaSIKCi8gewoJY29tcGF0aWJsZSA9ICJmc2wsUDUw
MjAiOwoJI2FkZHJlc3MtY2VsbHMgPSA8Mj47Cgkjc2l6ZS1jZWxscyA9IDwyPjsKCWludGVy
cnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoKCWFsaWFzZXMgewoJCWNjc3IgPSAmc29jOwoJCWRj
c3IgPSAmZGNzcjsKCgkJc2VyaWFsMCA9ICZzZXJpYWwwOwoJCXNlcmlhbDEgPSAmc2VyaWFs
MTsKCQlzZXJpYWwyID0gJnNlcmlhbDI7CgkJc2VyaWFsMyA9ICZzZXJpYWwzOwoJCXBjaTAg
PSAmcGNpMDsKCQlwY2kxID0gJnBjaTE7CgkJcGNpMiA9ICZwY2kyOwoJCXBjaTMgPSAmcGNp
MzsKCQl1c2IwID0gJnVzYjA7CgkJdXNiMSA9ICZ1c2IxOwoJCWRtYTAgPSAmZG1hMDsKCQlk
bWExID0gJmRtYTE7CgkJc2RoYyA9ICZzZGhjOwoJCW1zaTAgPSAmbXNpMDsKCQltc2kxID0g
Jm1zaTE7CgkJbXNpMiA9ICZtc2kyOwoKCQljcnlwdG8gPSAmY3J5cHRvOwoJCXNlY19qcjAg
PSAmc2VjX2pyMDsKCQlzZWNfanIxID0gJnNlY19qcjE7CgkJc2VjX2pyMiA9ICZzZWNfanIy
OwoJCXNlY19qcjMgPSAmc2VjX2pyMzsKCQlydGljX2EgPSAmcnRpY19hOwoJCXJ0aWNfYiA9
ICZydGljX2I7CgkJcnRpY19jID0gJnJ0aWNfYzsKCQlydGljX2QgPSAmcnRpY19kOwoJCXNl
Y19tb24gPSAmc2VjX21vbjsKCgkJcmFpZGVuZyA9ICZyYWlkZW5nOwoJCXJhaWRlbmdfanIw
ID0gJnJhaWRlbmdfanIwOwoJCXJhaWRlbmdfanIxID0gJnJhaWRlbmdfanIxOwoJCXJhaWRl
bmdfanIyID0gJnJhaWRlbmdfanIyOwoJCXJhaWRlbmdfanIzID0gJnJhaWRlbmdfanIzOwoK
CQlmbWFuMCA9ICZmbWFuMDsKCQlldGhlcm5ldDAgPSAmZW5ldDM7CgkJZXRoZXJuZXQxID0g
JmVuZXQ0OwoJfTsKCgljcHVzIHsKCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkjc2l6ZS1j
ZWxscyA9IDwwPjsKCgkJY3B1MDogUG93ZXJQQyxlNTUwMEAwIHsKCQkJZGV2aWNlX3R5cGUg
PSAiY3B1IjsKCQkJcmVnID0gPDA+OwoJCQljbG9ja3MgPSA8Jm11eDA+OwoJCQluZXh0LWxl
dmVsLWNhY2hlID0gPCZMMl8wPjsKCQkJZnNsLHBvcnRpZC1tYXBwaW5nID0gPDB4ODAwMDAw
MDA+OwoJCQlMMl8wOiBsMi1jYWNoZSB7CgkJCQluZXh0LWxldmVsLWNhY2hlID0gPCZjcGM+
OwoJCQl9OwoJCX07CgkJY3B1MTogUG93ZXJQQyxlNTUwMEAxIHsKCQkJZGV2aWNlX3R5cGUg
PSAiY3B1IjsKCQkJcmVnID0gPDE+OwoJCQljbG9ja3MgPSA8Jm11eDE+OwoJCQluZXh0LWxl
dmVsLWNhY2hlID0gPCZMMl8xPjsKCQkJZnNsLHBvcnRpZC1tYXBwaW5nID0gPDB4NDAwMDAw
MDA+OwoJCQlMMl8xOiBsMi1jYWNoZSB7CgkJCQluZXh0LWxldmVsLWNhY2hlID0gPCZjcGM+
OwoJCQl9OwoJCX07Cgl9Owp9Owo=
--------------71E075FD0FB696290AFF5A98
Content-Type: text/plain; charset=UTF-8;
 name="cyrus_p5020.eth.dts"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cyrus_p5020.eth.dts"

LyoKICogQ3lydXMgNTAyMCBEZXZpY2UgVHJlZSBTb3VyY2UsIGJhc2VkIG9uIHA1MDIwZHMu
ZHRzCiAqCiAqIENvcHlyaWdodCAyMDE1IEFuZHkgRmxlbWluZwogKgogKiBwNTAyMGRzLmR0
cyBjb3B5cmlnaHQ6CiAqIENvcHlyaWdodCAyMDEwIC0gMjAxNCBGcmVlc2NhbGUgU2VtaWNv
bmR1Y3RvciBJbmMuCiAqCiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSAgaXQgYW5kL29yIG1vZGlmeSBpdAogKiB1bmRlciAgdGhlIHRl
cm1zIG9mICB0aGUgR05VIEdlbmVyYWwgIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBi
eSB0aGUKICogRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyAgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUgIExpY2Vuc2UsIG9yIChhdCB5b3VyCiAqIG9wdGlvbikgYW55IGxhdGVyIHZlcnNp
b24uCiAqLwoKL2luY2x1ZGUvICJjeXJ1cy1wcmUuZHRzaSIKCi8gewoJbW9kZWwgPSAidmFy
aXN5cyxDWVJVUyI7Cgljb21wYXRpYmxlID0gInZhcmlzeXMsQ1lSVVMiOwoJI2FkZHJlc3Mt
Y2VsbHMgPSA8Mj47Cgkjc2l6ZS1jZWxscyA9IDwyPjsKCWludGVycnVwdC1wYXJlbnQgPSA8
Jm1waWM+OwoKCWFsaWFzZXMgewoJCXBoeV9yZ21paV8zID0gJnBoeV9yZ21paV8zOwoJCXBo
eV9yZ21paV83ID0gJnBoeV9yZ21paV83OwoJfTsKCgltZW1vcnkgewoJCWRldmljZV90eXBl
ID0gIm1lbW9yeSI7Cgl9OwoKCXJlc2VydmVkLW1lbW9yeSB7CgkJI2FkZHJlc3MtY2VsbHMg
PSA8Mj47CgkJI3NpemUtY2VsbHMgPSA8Mj47CgkJcmFuZ2VzOwoKCQlibWFuX2ZicHI6IGJt
YW4tZmJwciB7CgkJCXNpemUgPSA8MCAweDEwMDAwMDA+OwoJCQlhbGlnbm1lbnQgPSA8MCAw
eDEwMDAwMDA+OwoJCX07CgkJcW1hbl9mcWQ6IHFtYW4tZnFkIHsKCQkJc2l6ZSA9IDwwIDB4
NDAwMDAwPjsKCQkJYWxpZ25tZW50ID0gPDAgMHg0MDAwMDA+OwoJCX07CgkJcW1hbl9wZmRy
OiBxbWFuLXBmZHIgewoJCQlzaXplID0gPDAgMHgyMDAwMDAwPjsKCQkJYWxpZ25tZW50ID0g
PDAgMHgyMDAwMDAwPjsKCQl9OwoJfTsKCglkY3NyOiBkY3NyQGYwMDAwMDAwMCB7CgkJcmFu
Z2VzID0gPDB4MDAwMDAwMDAgMHhmIDB4MDAwMDAwMDAgMHgwMTAwODAwMD47Cgl9OwoKCWJw
b3J0YWxzOiBibWFuLXBvcnRhbHNAZmY0MDAwMDAwIHsKCQlyYW5nZXMgPSA8MHgwIDB4ZiAw
eGY0MDAwMDAwIDB4MjAwMDAwPjsKCX07CgoJcXBvcnRhbHM6IHFtYW4tcG9ydGFsc0BmZjQy
MDAwMDAgewoJCXJhbmdlcyA9IDwweDAgMHhmIDB4ZjQyMDAwMDAgMHgyMDAwMDA+OwoJfTsK
Cglzb2M6IHNvY0BmZmUwMDAwMDAgewoJCXJhbmdlcyA9IDwweDAwMDAwMDAwIDB4ZiAweGZl
MDAwMDAwIDB4MTAwMDAwMD47CgkJcmVnID0gPDB4ZiAweGZlMDAwMDAwIDAgMHgwMDAwMTAw
MD47CgkJc3BpQDExMDAwMCB7CgkJfTsKCgkJaTJjQDExODEwMCB7CgkJfTsKCgkJaTJjQDEx
OTEwMCB7CgkJCXJ0Y0A2ZiB7CgkJCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtY3A3OTQx
eCI7CgkJCQlyZWcgPSA8MHg2Zj47CgkJCX07CgkJfTsKCQlmbWFuQDQwMDAwMCB7CgoJCQlt
ZGlvQGUxMTIwIHsKCgkJCQlwaHlfcmdtaWlfMzogZXRoZXJuZXQtcGh5QDMgewoJCQkJCXJl
ZyA9IDwweDM+OwoJCQkJfTsKCgkJCQlwaHlfcmdtaWlfNzogZXRoZXJuZXQtcGh5QDcgewoJ
CQkJCXJlZyA9IDwweDc+OwoJCQkJfTsKCQkJfTsKCgkJCWV0aGVybmV0QGU2MDAwIHsKCQkJ
CXBoeS1oYW5kbGUgPSA8JnBoeV9yZ21paV8zPjsKCQkJCXBoeS1jb25uZWN0aW9uLXR5cGUg
PSAicmdtaWkiOwoJCQl9OwoKCQkJZXRoZXJuZXRAZTgwMDAgewoJCQkJcGh5LWhhbmRsZSA9
IDwmcGh5X3JnbWlpXzc+OwoJCQkJcGh5LWNvbm5lY3Rpb24tdHlwZSA9ICJyZ21paSI7CgkJ
CX07CgoJCX07Cgl9OwoKCXJpbzogcmFwaWRpb0BmZmUwYzAwMDAgewoJCXJlZyA9IDwweGYg
MHhmZTBjMDAwMCAwIDB4MTEwMDA+OwoKCQlwb3J0MSB7CgkJCXJhbmdlcyA9IDwwIDAgMHhj
IDB4MjAwMDAwMDAgMCAweDEwMDAwMDAwPjsKCQl9OwoJCXBvcnQyIHsKCQkJcmFuZ2VzID0g
PDAgMCAweGMgMHgzMDAwMDAwMCAwIDB4MTAwMDAwMDA+OwoJCX07Cgl9OwoKCWxiYzogbG9j
YWxidXNAZmZlMTI0MDAwIHsKCQlyZWcgPSA8MHhmIDB4ZmUxMjQwMDAgMCAweDEwMDA+OwoJ
CXJhbmdlcyA9IDwwIDAgMHhmIDB4ZTgwMDAwMDAgMHgwODAwMDAwMAoJCQkgIDIgMCAweGYg
MHhmZmEwMDAwMCAweDAwMDQwMDAwCgkJCSAgMyAwIDB4ZiAweGZmZGYwMDAwIDB4MDAwMDgw
MDA+OwoJfTsKCglwY2kwOiBwY2llQGZmZTIwMDAwMCB7CgkJcmVnID0gPDB4ZiAweGZlMjAw
MDAwIDAgMHgxMDAwPjsKCQlyYW5nZXMgPSA8MHgwMjAwMDAwMCAwIDB4ZTAwMDAwMDAgMHhj
IDB4MDAwMDAwMDAgMHgwIDB4MjAwMDAwMDAKCQkJICAweDAxMDAwMDAwIDAgMHgwMDAwMDAw
MCAweGYgMHhmODAwMDAwMCAweDAgMHgwMDAxMDAwMD47CgkJcGNpZUAwIHsKCQkJcmFuZ2Vz
ID0gPDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwCgkJCQkgIDB4MDIwMDAwMDAgMCAweGUwMDAw
MDAwCgkJCQkgIDAgMHgyMDAwMDAwMAoKCQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAK
CQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAKCQkJCSAgMCAweDAwMDEwMDAwPjsKCQl9
OwoJfTsKCglwY2kxOiBwY2llQGZmZTIwMTAwMCB7CgkJcmVnID0gPDB4ZiAweGZlMjAxMDAw
IDAgMHgxMDAwPjsKCQlyYW5nZXMgPSA8MHgwMjAwMDAwMCAweDAgMHhlMDAwMDAwMCAweGMg
MHgyMDAwMDAwMCAweDAgMHgyMDAwMDAwMAoJCQkgIDB4MDEwMDAwMDAgMHgwIDB4MDAwMDAw
MDAgMHhmIDB4ZjgwMTAwMDAgMHgwIDB4MDAwMTAwMDA+OwoJCXBjaWVAMCB7CgkJCXJhbmdl
cyA9IDwweDAyMDAwMDAwIDAgMHhlMDAwMDAwMAoJCQkJICAweDAyMDAwMDAwIDAgMHhlMDAw
MDAwMAoJCQkJICAwIDB4MjAwMDAwMDAKCgkJCQkgIDB4MDEwMDAwMDAgMCAweDAwMDAwMDAw
CgkJCQkgIDB4MDEwMDAwMDAgMCAweDAwMDAwMDAwCgkJCQkgIDAgMHgwMDAxMDAwMD47CgkJ
fTsKCX07CgoJcGNpMjogcGNpZUBmZmUyMDIwMDAgewoJCXJlZyA9IDwweGYgMHhmZTIwMjAw
MCAwIDB4MTAwMD47CgkJcmFuZ2VzID0gPDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwIDB4YyAw
eDQwMDAwMDAwIDAgMHgyMDAwMDAwMAoJCQkgIDB4MDEwMDAwMDAgMCAweDAwMDAwMDAwIDB4
ZiAweGY4MDIwMDAwIDAgMHgwMDAxMDAwMD47CgkJcGNpZUAwIHsKCQkJcmFuZ2VzID0gPDB4
MDIwMDAwMDAgMCAweGUwMDAwMDAwCgkJCQkgIDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwCgkJ
CQkgIDAgMHgyMDAwMDAwMAoKCQkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAKCQkJCSAg
MHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAKCQkJCSAgMCAweDAwMDEwMDAwPjsKCQl9OwoJfTsK
CglwY2kzOiBwY2llQGZmZTIwMzAwMCB7CgkJcmVnID0gPDB4ZiAweGZlMjAzMDAwIDAgMHgx
MDAwPjsKCQlyYW5nZXMgPSA8MHgwMjAwMDAwMCAwIDB4ZTAwMDAwMDAgMHhjIDB4NjAwMDAw
MDAgMCAweDIwMDAwMDAwCgkJCSAgMHgwMTAwMDAwMCAwIDB4MDAwMDAwMDAgMHhmIDB4Zjgw
MzAwMDAgMCAweDAwMDEwMDAwPjsKCQlwY2llQDAgewoJCQlyYW5nZXMgPSA8MHgwMjAwMDAw
MCAwIDB4ZTAwMDAwMDAKCQkJCSAgMHgwMjAwMDAwMCAwIDB4ZTAwMDAwMDAKCQkJCSAgMCAw
eDIwMDAwMDAwCgoJCQkJICAweDAxMDAwMDAwIDAgMHgwMDAwMDAwMAoJCQkJICAweDAxMDAw
MDAwIDAgMHgwMDAwMDAwMAoJCQkJICAwIDB4MDAwMTAwMDA+OwoJCX07Cgl9Owp9OwoKL2lu
Y2x1ZGUvICJwNTAyMHNpLXBvc3QuZHRzaSIK
--------------71E075FD0FB696290AFF5A98--
