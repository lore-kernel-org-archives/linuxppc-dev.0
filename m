From: Benjamin Herrenschmidt <bh40@calva.net>
To: Stefan Jeglinski <jeglin@4pi.com>,
        LinuxPPC-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: usb wheel mouse, XF4.0
Date: Wed, 29 Nov 2000 18:14:50 +0100
Message-Id: <19341024104634.3912@192.168.1.2>
In-Reply-To: <p04330100b64abb5a279d@[192.168.0.1]>
References: <p04330100b64abb5a279d@[192.168.0.1]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>In addition, yesterday I speculated that the dual IRQ 23 might help
>explain why I was having 2.2.18preX boot problems with the aic7xxx.
>This can't really be the case because one of the slot summary tests
>was to remove the USB card (and all others). There was no difference,
>so my boot issue remains a separate one with its odd workaround.

Ok, I found the problem, I think, with the interrupt. I'm still
investigating, but what it looks like is that the OF tree puts the
AAPL,interrupt property in the pci-bridge node, not in the sub-nodes.
So we must make sure the routine that gets interrupts from the tree
on oldworld iterates to parent devices when it can't find the
AAPL,interrupt property.

It would be interesting to see how it works with the same card in
a newworld machine booted from Open Firmware (it uses a different
algorithm to parse the interrupt tree on newworld macs and CHRPs).

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
