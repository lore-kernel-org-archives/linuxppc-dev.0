From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14803.57550.118150.759977@argo.linuxcare.com.au>
Date: Fri, 29 Sep 2000 11:22:38 +1100 (EST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
References: <19340822040932.8760@mailhost.mipsys.com>
	<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven writes:

> But we can find out the IO bus by looking in which region the physical address
> is located, right? Or do we have the same region on different IO busses?
> That would be really weird! Different IO busses should decode different
> regions.
>
> The ioportremap() function would move all overhead from looking up the IO bus
> and physical base from inb() and friends to ioportremap(). So instead of doing
>
>     u8 inb(unsigned int phys_offset)
>     {
> 	if (phys_offset >= region1_start && region1_end)
> 	    return in_8(region1_base+phys_offset));
> 	else if (phys_offset >= region2_start && region2_end)
> 	    return in_8(region2_base+phys_offset));
> 	else
> 	    ...
>     }

Well, we don't do that now anyway, and noone was suggesting we should.
To the extent that anything like that was needed, we would use the MMU
to do the necessary translations by setting up the virt -> phys
mapping appropriately.

My idea in suggesting ioportremap is that it would give you an address
that you can use with readb/writeb (or in_8/out_8 if you like), not
inb/outb.  I personally don't think the ioportremap idea has much
value though.

Essentially we have two cases with inb/outb - ISA devices and PCI
devices.  The ISA devices we handle by making sure that inb(0x3f8)
hits I/O address 0x3f8 on the first PCI host bridge.  The PCI devices
we handle by setting the pci_dev->resource[].start values to account
for any mapping we need to do.

My proposal would simplify inb/outb by making _IO_BASE a constant
rather than a variable.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
