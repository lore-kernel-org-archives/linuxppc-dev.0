From: "Chris Backas" <cbackas@rcn.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Date: Mon, 07 Aug 2000 18:40:37 -0400 (EDT)
Reply-To: "Chris Backas" <cbackas@bigfoot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: AirPort problem report
Message-Id: <E13Lw9q-0000Hj-00@smtp01.mrf.mail.rcn.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Lately I've been using the Linux Airport driver very heavily on my iBook at work, and I've found a problem with it.  After a few hours, I start getting transmit timeouts every
10-15 minutes, resulting in the card being reset.  Aside from causing annoying latency, this kills exported X Window sessions, and often loses unsaved work as a result.
(For reasons I don't care to go into, we can't just simply use another machine, at least for now.)

This is kernel 2.2.17pre10-ben2, and airport driver 0.93.  I am not roaming at the time, and the basestation is sitting about 10 feet away from the computer.  Other PC clients
experience no disruptions, and it work great all day long under MacOS.

Anyway, I thought it might be helpful, so here's the excerpt from the messages file:

--------snip! messages --------------------
Aug  7 17:16:17 cortland kernel: airport: error 255 setting frag. threshold (harmless)
Aug  7 17:16:17 cortland kernel: airport: MAC address on airport is 00 30 65 10 0c d2
Aug  7 17:16:17 cortland kernel: airport: Tx error, retry: 0
Aug  7 17:16:17 cortland last message repeated 11 times
Aug  7 17:16:17 cortland kernel: airport: Tx error, retry: 1
Aug  7 17:16:17 cortland kernel: airport: Tx error, retry: 2
Aug  7 17:16:17 cortland kernel: airport: Tx error, retry: 3
Aug  7 17:16:17 cortland kernel: airport: Tx error, retry: 0
Aug  7 17:16:17 cortland kernel: airport: Tx error, retry: 1
Aug  7 17:16:17 cortland kernel: airport: Tx error, retry: 2
Aug  7 17:16:17 cortland kernel: airport: Tx error, retry: 3
Aug  7 17:16:27 cortland kernel: airport: airport Tx timed out! Resetting card
Aug  7 17:16:27 cortland kernel: airport: error 255 setting frag. threshold (harmless)
Aug  7 17:16:27 cortland kernel: airport: MAC address on airport is 00 30 65 10 0c d2
Aug  7 17:16:27 cortland kernel: airport: Tx error, retry: 0
Aug  7 17:16:27 cortland kernel: airport: Tx error, retry: 0
Aug  7 17:16:27 cortland kernel: airport: Tx error, retry: 1
Aug  7 17:16:27 cortland kernel: airport: Tx error, retry: 2
Aug  7 17:16:27 cortland kernel: airport: Tx error, retry: 3
Aug  7 17:16:27 cortland kernel: airport: Tx error, retry: 0
Aug  7 17:16:27 cortland kernel: airport: Tx error, retry: 1
Aug  7 17:16:27 cortland kernel: airport: Tx error, retry: 2
Aug  7 17:16:27 cortland kernel: airport: Tx error, retry: 3
Aug  7 17:16:37 cortland kernel: airport: airport Tx timed out! Resetting card
Aug  7 17:16:37 cortland kernel: airport: error 255 setting frag. threshold (harmless)
Aug  7 17:16:37 cortland kernel: airport: MAC address on airport is 00 30 65 10 0c d2
Aug  7 17:16:37 cortland kernel: airport: Tx error, retry: 0
Aug  7 17:16:37 cortland kernel: airport: Tx error, retry: 1
Aug  7 17:16:37 cortland kernel: airport: Tx error, retry: 2
Aug  7 17:16:37 cortland kernel: airport: Tx error, retry: 3
Aug  7 17:16:37 cortland kernel: airport: Tx error, retry: 0
Aug  7 17:16:37 cortland kernel: airport: Tx error, retry: 1
Aug  7 17:16:37 cortland kernel: airport: Tx error, retry: 2
Aug  7 17:16:37 cortland kernel: airport: Tx error, retry: 3
Aug  7 17:16:41 cortland gpm[535]: Error in protocol
Aug  7 17:16:45 cortland PAM_pwdb[2235]: (login) session opened for user root by LOGIN(uid=0)
Aug  7 17:16:46 cortland kernel: airport: airport Tx timed out! Resetting card
Aug  7 17:16:46 cortland kernel: airport: error 255 setting frag. threshold (harmless)
Aug  7 17:16:46 cortland kernel: airport: MAC address on airport is 00 30 65 10 0c d2
--------snip! messages --------------------

Also, here's the ifconfig output after the first occurance.  (Just to illustrate the intermittance)

--------snip! ifconfig.out --------------------
airport   Link encap:Ethernet  HWaddr 00:30:65:10:0C:D2
          inet addr:10.0.1.1  Bcast:10.0.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:147872 errors:0 dropped:0 overruns:0 frame:0
          TX packets:160505 errors:23 dropped:0 overruns:0 carrier:0
          collisions:0
eth0      Link encap:Ethernet  HWaddr 00:0A:27:A8:0A:C2
          inet addr:10.4.185.139  Bcast:10.4.185.255  Mask:255.255.255.128
          EtherTalk Phase 2 addr:65280/138
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:108801 errors:0 dropped:0 overruns:0 frame:0
          TX packets:85454 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          EtherTalk Phase 2 addr:0/0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:238 errors:0 dropped:0 overruns:0 frame:0
          TX packets:238 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0
--------snip! ifconfig.out --------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
