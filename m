From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual IRQ 23 (was: USB?; 2.2.18 no boot?; aic7xxx?)
Date: Mon, 4 Dec 2000 15:35:20 +0100
Message-Id: <19341029080704.31331@192.168.1.2>
In-Reply-To: <Pine.GSO.4.10.10012032140410.7958-100000@rose.sonytel.be>
References: <Pine.GSO.4.10.10012032140410.7958-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Shared interrupts are allowed by PCI. If it doesn't work, it means one of the
>drivers (or both) can't cope with shared interrupts. The solution is to
>fix the
>driver(s).

In fact, the problem appears to be in our prom.c code. On "oldworld"
macs, the interrupt informations in the device tree use apple non-
standard "AAPL,interrupts" properties. It appears that when a PCI<->PCI
bridge is present in a slot, Apple's OF will only set this property on
the bridge itself, not on the devices below the bridge. So we must adjust
our prom.c code to detect this case. I'll give it a try later this week.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
