Date: Wed, 25 Jul 2001 14:42:39 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Sven Dickert <Sven.Dickert@planb.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 601 BAT's
Message-ID: <20010725144239.A11885@austin.ibm.com>
References: <20010724105114.A17706@remote.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010724105114.A17706@remote.org>; from Sven.Dickert@planb.de on Tue, Jul 24, 2001 at 10:51:14AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 24, 2001 at 10:51:14AM +0200, Sven Dickert wrote:
>
>   At the moment I'm working on sound support. I changed
> -#define CAROLINA_IRQ_EDGE_MASK_HI   0xA4  /* IRQ's 8-15 [10,13,15] */
> +#define CAROLINA_IRQ_EDGE_MASK_HI   0xA0  /* IRQ's 8-15 [10,13,15] */
> in arch/ppc/kernel/prep_pci.c
> I found this 'patch' at http://penguinppc.org/dev/prep/tp850.diff

Neither the 40P nor the Thinkpad 850 are Carolina systems, so those constants
should remain how they are and new ones for other systems introduced. That
will mean slight changes to the IBM section of prep_route_pci_interrupts(),
but nothing major.

In your patch you're using a segment register because 601 BAT's are only 8MB
(and we need more for IO space). Someone suggested using ioremap in the driver
(the one causing the page fault), but I suspect the whole reason those BAT
regions are there is to support legacy IO and not have to get everything to
ioremap? Is there an equivalent to ioremap that allows the virtual address to
be specified (want to map 0x80000000 physical to 0x80000000 virtual [NOT
n+io_base] for IO ports)?

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
