Message-ID: <01b001c3c059$35107840$5100a8c0@davey033ce6193>
From: "DaveyWu" <daveywu@transengines.com>
To: "Stefan Roese" <stefan.roese@esd-electronics.com>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	<benh@kernel.crashing.org>, <akuster@mvista.com>
References: <004901c3b990$b84d2ac0$0212000a@PCSTEFAN>
Subject: Re: PPC4xx enet driver problem (version 2.0)
Date: Fri, 12 Dec 2003 10:39:44 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Stefan,
    I have suffered the same problem when I am trying swtich to 2.4.22 from 2.4.18 on IBM405ep board. Following is the output on my board:

# ifconfig eth0 down
# ifconfig eth1 down
# ifconfig eth0 192.168.1.1
eth0: adjust to link, speed: 100, duplex: 1, opened: 1
eth0: Speed: 100, Full duplex.
# ping 192.168.1.123
PING 192.168.1.123 (192.168.1.123): 56 data bytes
64 bytes from 192.168.1.123: icmp_seq=0 ttl=128 time=5.2 ms
64 bytes from 192.168.1.123: icmp_seq=1 ttl=128 time=2.8 ms
64 bytes from 192.168.1.123: icmp_seq=2 ttl=128 time=2.7 ms
64 bytes from 192.168.1.123: icmp_seq=3 ttl=128 time=2.6 ms
64 bytes from 192.168.1.123: icmp_seq=4 ttl=128 time=2.7 ms
64 bytes from 192.168.1.123: icmp_seq=5 ttl=128 time=2.7 ms

--- 192.168.1.123 ping statistics ---
6 packets transmitted, 6 packets received, 0% packet loss
round-trip min/avg/max = 2.6/3.1/5.2 ms
# ifconfig eth1 192.168.2.1
eth1: adjust to link, speed: 100, duplex: 1, opened: 1
eth1: Speed: 100, Full duplex.
SIOCSIFFLAGS: Device or resource busy
# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:04:AC:E3:15:5E
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:104 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:10027 (9.7 kiB)  TX bytes:630 (630.0 iB)
          Interrupt:15

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 iB)  TX bytes:0 (0.0 iB)

# ping 192.168.1.123
PING 192.168.1.123 (192.168.1.123): 56 data bytes

--- 192.168.1.123 ping statistics ---
25 packets transmitted, 0 packets received, 100% packet loss
# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:04:AC:E3:15:5E
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:104 errors:0 dropped:0 overruns:0 frame:0
          TX packets:15 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:10027 (9.7 kiB)  TX bytes:966 (966.0 iB)
          Interrupt:15

eth1      Link encap:Ethernet  HWaddr 00:00:00:00:00:00
          inet addr:192.168.2.1  Bcast:192.168.2.255  Mask:255.255.255.0
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 iB)  TX bytes:0 (0.0 iB)
          Interrupt:17

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:25 errors:0 dropped:0 overruns:0 frame:0
          TX packets:25 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:2800 (2.7 kiB)  TX bytes:2800 (2.7 kiB)

#
Have you already solved the problem?

----- Original Message -----
From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>; <benh@kernel.crashing.org>; <akuster@mvista.com>
Sent: Wednesday, December 03, 2003 7:29 PM
Subject: PPC4xx enet driver problem (version 2.0)


>
> Hello!
>
> We are trying to switch to the 2.4.23 linuxppc_2_4_devel kernel (from
> 2.4.21) and experience a problem with the "new" ethernet driver for the
> ibm ppc4xx (version 2.0 from Benjamin Herrenschmidt). On our boards with
> only one active enet interface we have no problems. But our PPC405EP
> boards with 2 active enet devices, the traffic stops completely upon
> initializing the 2nd devices (emac_reset_configure).
>
> Has anybody experienced similar problems? Has anybody seen this driver
> working properly with more than one ppc4xx enet devices (especially
> ppc405ep)?
>
> With the previous driver (from linuxppc_2_4_devel 2.4.21 maintained by
> mvista) we had no problems with 2 enet interfaces on the ppc405ep so
> far!
>
> By the way: What is the future of the ppc4xx enet driver. I found that
> the 2.5 kernel  has a newer mvista driver included (modifications for
> 440gx, etc.). Is the driver from 2.4.23 a dead end?
>
> Thanks and best regards,
> Stefan.
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
