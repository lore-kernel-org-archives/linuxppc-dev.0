From: Benjamin Herrenschmidt <bh40@calva.net>
To: <linuxppc-dev@lists.linuxppc.org>,
        Geert Uytterhoeven
 <geert@linux-m68k.org>, <paulus@linuxcare.com.au>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Date: Thu, 28 Sep 2000 23:33:01 +0000
Message-Id: <19340823170445.20040@192.168.1.10>
In-Reply-To: <19340823125112.7591@mailhost.mipsys.com>
References: <19340823125112.7591@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Earlier today, I wrote:
>
>Then, we can have separate:
> - isa_io_remap(range),
> - isa_mem_remap(range),
> - pci_io_remap(pci_bus, resource_addr)
> - pci_mem_remap(pci_bus, resource_addr)
>
> .../...
>

Obviously this would be a long term plan and need more thinking and then
endless discussions on the linux-kernel list...

That's why I liked, as a temporary workaround, what Paul proposed which
was basically to have the kernel hack a MMU mapping that puts all IO
busses together, the first one beeing the default for legacy devices
(eventually selected via a kernel arg).

This way, inb/outb would work for legacy devices on this bus and for
normal PCI IO "apertures" by using resource[x]->start as a base (like all
PCI drivers currently do AFAIK)

We would have to fixup IO resources of all other IO busses, but I think
it's the less painful solution for 2.4.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
