From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Airport in BenH's kernels
Date: Sun, 6 May 2001 22:28:01 +0200
Message-Id: <20010506202801.14354@smtp.wanadoo.fr>
In-Reply-To: <200105062011.WAA00674@piglet.grunz.lu>
References: <200105062011.WAA00674@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi all,
>
>For a few days airport doesn't work in BenH's kernels, due do an
>unresolved symbol in orinoco.o.
>
>Below is a two-line patch that fixes the problem.

Thanks ! The driver have been a pretty quickly moving target lately
as Jean Tourrihles and I were working to finally have a common code
base for airport and orinoco_cs without duplicating the driver.

The new driver is getting close to completion now and things should
finally stabilize.

For those who missed part of the story, here are some tips for the
new driver:

 - it's located in drivers/net/wireless and configured from the
"wireless" sub-menu in the "network drivers" menu.

 - the interface is now always ethx (eth1 most of the time)

 - the card is no longer powered down when the inteface is off, this
caused various troubles. If you want to make sure the interface is
powered off when not used, rmmod airport.

 - typicall setup sequence:

    modprobe airport
    ifconfig eth1 <ip_address> netmask <mask> up
    iwconfig essid <network name>
    iwconfig enc <WEP key>

The driver is made of 3 different modules (hermes.o, orinoco.o and
airport.o). A fourth one (orinoco_cs.o) is used for the PCMCIA cards.
This new driver should work properly with all airport incarnations, not
only PCMCIA capables boxes.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
