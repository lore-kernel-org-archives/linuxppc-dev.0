MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Tigon3 driver, broadcom 5307, 440GP, working?
Date: Thu, 25 Jul 2002 15:22:21 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D00A@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Matt Porter" <porter@cox.net>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> On Wed, Jul 24, 2002 at 01:29:23PM -0500, Stephen Cameron wrote:
> >
> > I've been playing around with the tigon3 driver and a broadcom
> > 5307 gigabit NIC in my IBM ebony... No luck so far.  The
> driver compiles
> > and even loads, I can run ifconfig(busybox really) to configure
> > the NIC,  and if I pull the network cable, the driver seems to
> > notice (get log messages about link is down, link is up) but so
> > far, I can't actually transmit or receive any packets.
> >
> > Anyone had any luck with this combination?
>
> I assume you mean a BCM5703?

I guess so... I know it colloquially as a "Broadcom 5703 gigabit NIC"

>
> FWIW, BCM5700/5701 on 440GP works for me with the current tg3 driver.
>

Hmm, I got ahold of a 5701 and tried it.  Same behavior as my 5703.
I can load the driver, ifconfig it, the link status appears correct,
but can't transmit packets.

here's what I get (on the off chance that somebody will see this
and recognized the problem):

Upon loading the driver:

eth2: Tigon3 [partno(284685-001) rev 0105 PHY(5701)] (PCIX:133MHz:64-bit) 10/102

Then,
/sbin/ifconfig eth2 192.168.2.55 netmask 255.255.255.0 broadcast 192.168.2.255
eth2: Link is up at 10 Mbps, half duplex.
eth2: Flow control is off for TX and off for RX.

So far so good.

Then,
ping 192.168.2.55

Now, trouble:
(some debugging output is in here....)
sys_sendto
sock_sendmsg, sock=c3a8a1c0, len=64
scm_send returns 0
sk->prot->sendmsg = c00c1058
a b d g j L b e f g rt_intern_hash
A B C, n = -22z2, err=-22
rt_intern_has returns -22
err = -22
sock->ops->sendmsg = c00c9a50
sock->ops->sendmsg returns -22
err = -22
sendto: Invalid argument

so, it seems that in net/ipv4/arp.c, arp_bind_neighbour(),
__neigh_lookup_errno returns -22.

Don't know why.

Other NICs in the system (on-chip NICs) work fine.

Also, if I try to ping 192.168.2.0 (the network address)
ping doesn't bail, but I still get the -22 from arp_bind_neighbour,
and though ping claims such-and-such many packets transmitted, when
I do ifconfig eth2, I see:

eth2      Link encap:Ethernet  HWaddr 00:02:A5:E7:1C:Dand though ping claims such-and-such many packets transmitted, when
I do ifconfig eth2, I see:

eth2      Link encap:Ethernet  HWaddr 00:02:A5:E7:1C:D2
          inet addr:192.168.2.55  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:1448 (1.4 kb)  TX bytes:0 (0.0 b)
          Interrupt:24

(notice, zero packets transmitted.)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
