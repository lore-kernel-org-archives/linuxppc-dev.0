From: "Brian Padalino" <bpadalino@perigee.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: More on Ebony and Ethernet
Date: Fri, 18 Jul 2003 14:25:11 -0400
Message-ID: <DGEEIPOFGGPOACEFBGGCCEIBCAAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am able to give a bit more information about my ethernet experience with
the Ebony board.  I am still having a lot of trouble getting the IBM OCP
ethernet drivers to work correctly.  It appears that it will transmit
packets just fine, but it does not recieve them properly at all.

I see this by configuring my Ebony board with the IP 192.168.0.238 and ping
a development machine at 192.168.0.130.  On the development machine, I have
tcpdump running sniffing for packets coming from or going to the Ebony
board.

I find that after about 8 packets are sent from pings, the driver just stops
sending packets out at all!!

Here is my ifconfig eth0:

# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:04:AC:E3:22:DA
          inet addr:192.168.0.238  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:27 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:1134 (1.1 kb)
          Interrupt:60

The rx packets for the lo device will increase as I keep doing the pings,
but after 8 pings out -- the driver for eth0 comes up with nothing.

14:25:26.413840 arp who-has 192.168.0.130 tell 192.168.0.238
14:25:26.413876 arp reply 192.168.0.130 is-at 0:3:47:b7:54:0
14:25:27.397956 arp who-has 192.168.0.130 tell 192.168.0.238
14:25:27.397981 arp reply 192.168.0.130 is-at 0:3:47:b7:54:0
14:25:28.397962 arp who-has 192.168.0.130 tell 192.168.0.238
14:25:28.397988 arp reply 192.168.0.130 is-at 0:3:47:b7:54:0
14:25:37.547904 arp who-has 192.168.0.130 tell 192.168.0.238
14:25:37.547931 arp reply 192.168.0.130 is-at 0:3:47:b7:54:0
14:25:38.538544 arp who-has 192.168.0.130 tell 192.168.0.238
14:25:38.538576 arp reply 192.168.0.130 is-at 0:3:47:b7:54:0
14:25:39.538543 arp who-has 192.168.0.130 tell 192.168.0.238
14:25:39.538573 arp reply 192.168.0.130 is-at 0:3:47:b7:54:0
14:25:43.487944 arp who-has 192.168.0.130 tell 192.168.0.238
14:25:43.487971 arp reply 192.168.0.130 is-at 0:3:47:b7:54:0
14:25:44.477924 arp who-has 192.168.0.130 tell 192.168.0.238
14:25:44.477947 arp reply 192.168.0.130 is-at 0:3:47:b7:54:0

I am working off of the linuxppc_2_4_devel tree, my next step is to go for
strictly the linuxppc_2_4 standard tree and see if that works out.

Does anyone else have ANY ideas?

Thanks,
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
