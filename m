Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: any easy way to force 10/100 nics to 10?
Date: Thu, 25 Oct 2001 09:37:49 -0400
Cc: linuxppc-dev@lists.linuxppc.org
References: <20011023211459.NUPA19597.tomts17-srv.bellnexxia.net@there> <3BD60FF5.24C4B841@mandrakesoft.com>
In-Reply-To: <3BD60FF5.24C4B841@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <20011025133518.SBZQ14703.tomts20-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Jeff,

On October 23, 2001 08:48, Jeff Garzik wrote:
> "Kevin B. Hendricks" wrote:
> > Hi,
> >
> > My new dsl router seems to hate 100 connections from my 10/100 nics.
> >
> > Is there an easy way to force 10mb speed (a /proc setting?)?
>
> The standard way, in this order, is (a) via ethtool, (b) via mii-tool,
> or (c) using a command line option at kernel boot time.

Okay I added an AsanteFast 10/100 card using the tulip driver so that I
would have a card capable of controlling media type (that would still work
when I boot into the MacOSX).

Then I grabbed the net-tools src rpm and hacked the Makefile so that it
would build mii-tool (I could not find a package with ethtool anyplace.)

I then tried all of the following to force the card to only advertise
10baseT-FD or force 10baseT-FD but nothing seems to impact the actual
negotiated speed at all.


Before plugging in the ethernet cable:

[root@localhost rc.d]# /usr/local/bin/mii-tool --advertise=10baseT-FD eth0
restarting autonegotiation...
[root@localhost rc.d]# /usr/local/bin/mii-tool -v eth0
eth0: no link
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: no link
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseT4 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD

The above shows it is still advertising the same thing as before.

[root@localhost rc.d]# /usr/local/bin/mii-tool -v eth0
eth0: no link
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: no link
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseT4 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD

After pluggin in the cable.  The router lights now shows a 100mb link
[root@localhost rc.d]# /usr/local/bin/mii-tool --force=10baseT-FD eth0
[root@localhost rc.d]# mii-tool -v eth0
eth0: autonegotiation failed, link ok
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseT4 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
[root@localhost rc.d]# /usr/local/bin/mii-tool --force=10baseT-FD eth0
[root@localhost rc.d]# /usr/local/bin/mii-tool --restart eth0
restarting autonegotiation...
[root@localhost rc.d]# mii-tool -v eth0
eth0: autonegotiation failed, link ok
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseT4 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
[root@localhost rc.d]# mii-tool -v -v eth0
eth0: autonegotiation failed, link ok
  registers for MII PHY 32:
    1000 786c 0000 0000 03e1 0000 0000 0000
    0000 0000 0000 0000 0000 0000 0000 0000
    0000 0000 0000 0000 0000 0000 0000 0000
    0000 0000 0000 0000 0000 0000 0000 0000
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseT4 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
[root@localhost rc.d]#


If I try to use the nic at 100mb speed all I seem to get is lots of
dropped packets and errors.  If I directly connect the dsl modem to my
machine it forces the card to 10mb mode and all is well.  If I put the
dsl/cable router (with 10/100 capabilities in between) I am hosed.

The same thing holds for my internal nic too.

eth0: Lite-On PNIC-II rev 37 at 0xe2128000, 00:00:94:C6:05:2E, IRQ 24.
eth1: BMAC+ at 00:50:e4:70:2e:08

What kernel params do I have to send to the AsanteFast card (syntax?) to
force it to 10baseT-FD only?

Ideas anyone?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
