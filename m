From: Benjamin Herrenschmidt <bh40@calva.net>
To: <paulus@linuxcare.com.au>,
        Linux/PPC Development
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Date: Fri, 29 Sep 2000 00:40:53 +0000
Message-Id: <19340823181237.25887@192.168.1.10>
In-Reply-To: <14803.57550.118150.759977@argo.linuxcare.com.au>
References: <14803.57550.118150.759977@argo.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Essentially we have two cases with inb/outb - ISA devices and PCI
>devices.  The ISA devices we handle by making sure that inb(0x3f8)
>hits I/O address 0x3f8 on the first PCI host bridge.  The PCI devices
>we handle by setting the pci_dev->resource[].start values to account
>for any mapping we need to do.
>
>My proposal would simplify inb/outb by making _IO_BASE a constant
>rather than a variable.

Well, the ISA space would be on a fixed bus, but not necessarily bus 0
(please  ;)

On uninorth, with the new bus remap code, the PCI slots will be bus 2 or
something like that. Ideally, the arch would tell you which bus to map
first, possibly overriden by a kernel arg.

ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
