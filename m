Message-ID: <20000814055236.26882.qmail@kunk.jriver.com>
Subject: MORE Mace on 7200 debug output, narrowing it down...
In-Reply-To: <B5B7BC73-243610@192.168.2.21> "from Bruce Anderson at Aug 10, 2000
 01:57:03 am"
To: Bruce Anderson <brucea@spacestar.net>
Date: Mon, 14 Aug 2000 00:52:36 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
CC: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Bruce Anderson says:
> On Wed, Aug 9, 2000 10:40 PM, Robert E Brose II
> >Any ideas on what to look for next??
>
> Same tests but this time use a crossover and no hub between the machines.

Ok, had to wire up a crossover cable.
It works "better" but still drops around 2 in 10 ping packets.

IMPORTANT OBSERVATIONS:

Whenever 7200 fails to reply to a packet, the packet has the P bit set.
22:47:25.180000 > myeth0 > rhlinuxeth0: icmp: echo request
22:47:25.180000 < rhlinuxeth0 > myeth0: icmp: echo reply (DF)
22:47:26.180000 > myeth0 > rhlinuxeth0: icmp: echo request
22:47:26.180000 P rhlinuxeth0 > myeth0: icmp: echo reply (DF)

In the dump above, the first was successful, the second was not.

Packet size makes very little difference (tried 64 to 1400 bytes)

The problem isn't a hub, I have tried a hub and a switch (which is
just like connecting with a crossover because the switch has a
normal ethernet chip in it, in my case 21140's).

Here is another with ftp.... Again, the 7200 drops every packet with the
P flag set.
23:21:25.810000 M 0:20:4c:1:63:d6 1:0:0:0:0:0 ip 84: rhlinuxeth0.ftp > myeth0.2347: P 1320814795:1320814824(29) ack 1220753521 win 32696 (DF) [tos 0x10]

Performance is VERY bad for tcp. Once the 7200 starts receiving lots of
large packets in a short time it drops packets like crazy.

Finally, I did another test, just 3 pings from the redhatbox to the
7200 and had a tcpdump running on both machines. The first 2 packets
were received on the 7200 with the P flag set and were not replied to,
the 3rd didn't have the P flag set and the 7200 replied which was
received properly by the rhlinux box.

Here are 2 detailed reply packets as received on the 7200.
The first worked, the second didn't:

23:57:18.480000 M 0:20:4c:1:63:d6 1:0:0:0:0:0 ip 98: rhlinuxeth0 > myeth0: icmp:
 echo reply (DF)
4500 0054 0000 4000 ff01 f853 c0a8 0103
c0a8 0101 0000 a48b 6710 0006 3997 7c2e
0007 538e 0809 0a0b 0c0d 0e0f 1011 1213
1415 1617 1819 1a1b 1c1d 1e1f 2021 2223
2425 2627 2829 2a2b 2c2d 2e2f 3031 3233
3435 3637

23:57:19.480000 P 0:20:4c:1:63:d6 0:0:0:0:0:1 ip 98: rhlinuxeth0 > myeth0: icmp:
 echo reply (DF)
4500 0054 0000 4000 ff01 f853 c0a8 0103
c0a8 0101 0000 a487 6710 0007 3997 7c2f
0007 5390 0809 0a0b 0c0d 0e0f 1011 1213
1415 1617 1819 1a1b 1c1d 1e1f 2021 2223
2425 2627 2829 2a2b 2c2d 2e2f 3031 3233
3435 3637

THINGS TO ASK...

Why is this P flag set on all failed packets? Does it mean the packet is
being received corrupted or is really receiving a set P flag.

What is the significance of the destination ethernet address of
1:0:0:0:0:0 which is on the good received packet vs the 0:0:0:0:0:1
which is on the bad received packet? Is this what the
P flag means in icmp packets? What causes this?

Not to be boringly repetitious but this works fine in MacOS.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
