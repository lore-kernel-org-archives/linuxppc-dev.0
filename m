Mime-Version: 1.0
Message-Id: <v04220801b652547c23e8@[10.0.0.42]>
In-Reply-To: <p04330100b650e03a5dcb@[192.168.0.1]>
References: <Pine.GSO.4.10.10012032140410.7958-100000@rose.sonytel.be>
 <p04330100b650e03a5dcb@[192.168.0.1]>
Date: Tue, 5 Dec 2000 00:39:22 -0800
To: Stefan Jeglinski <jeglin@4pi.com>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: arguing IRQ (was Re: dual IRQ 23)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:09 AM -0500 12/4/00, Stefan Jeglinski wrote:

>So, is Geert right (PCI ok at least in this aspect, drivers are
>buggy)? Or are Ben/Michel right (drivers OK, PCI/IRQ buggy)?

PCI is in fact designed to share interrupts gracefully, as Geert
said.  However, sharing doesn't look like the problem here: what
Michel and Ben are talking about is that the kernel fails to
correctly identify your card's true IRQ number.  On these Macs there
is a fixed mapping between PCI slots and interrupt numbers,
determined by hardware.  If software gets this mapping wrong, drivers
will hook into the wrong IRQ numbers and fail to work correctly.

According to Ben, this appears to be a problem in the kernel code
which discovers information about PCI devices (including interrupt
mappings) from an Open Firmware data structure, the OF device tree.
Apparently the interrupt assignment information in the device tree is
structured somewhat differently in Old World Macs such as yours when
devices are behind a PCI to PCI bridge.  (Your combo card consists of
such a bridge plus two PCI devices.)

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
