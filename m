Date: Wed, 7 Aug 2002 15:34:01 -0700
From: Matt Porter <porter@cox.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mlan@cpu.lu, acurtis@onz.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI enlightenment follow-up
Message-ID: <20020807153401.A20123@home.com>
References: <E17cK7s-000080-00@piglet.grunz.lu> <20020806210917.13103@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020806210917.13103@192.168.4.1>; from benh@kernel.crashing.org on Tue, Aug 06, 2002 at 11:09:17PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 06, 2002 at 11:09:17PM +0200, Benjamin Herrenschmidt wrote:
>
> >sym should _not_ play with these bus-view addresses. Have a look at the
> >driver where it gets these from.
>
> I think it has to. From what I remember the author of the driver told
> me, the card need to be programmed to point to it's own memory
> or something like that.

I can confirm that this is true from first-hand experience on embedded
PReP memory map systems (the same non 1:1 CPU<->PCI situation).  In
order to load the scripts the driver must write the PCI address of
the on-chip SRAM to the 53c8xx chip.  In addition, the chip is provided
the bus address of the scripts in system memory and then is commanded to
bus master the load of the scripts into it's on-chip SRAM.  That is
why the PCI bus address is necessary...a long time ago this was all
hacked because most systems (x86, CHRP, etc.) had the simplified world
of having 1:1 mapped CPU<->PCI addresses.  In the past, the pcivtobus
macro was loaded with an architecture specific function to convert
a resource to a PCI bus address...in the current scheme we seem to
have gone backwards (though still functional) to where the driver
get his base address cookie but also directly reads the BAR to get
his PCI base address.  Looks like all is well and good from my
understanding of the world.

> >> sym53c8xx: np->base2_ba = 0x07ffc000
> >> /* 1-to-1 BAT mapping */
> >> sym53c8xx: 0x4fffc000 = remap_pci_mem(0x4fffc000, 0x00002000)
> >
> >This looks good indeed.

Except he's got the 1:1 BAT in the middle of default user task space.
Unless he's used an advanced kernel option tweak to shrink TASK_SIZE,
this will cause problems.

> >> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
> >> sym53c8xx: ncr_script_copy_and_bind(src 0xc04f7ce0, dst 0xc04be054)
> >> sym53c8xx: 0xf0ccff07 = cpu_to_scr(0x07ffccf0)
> >             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >Nope, reversed address. That will not work. Don't touch the address,
> >touch the data if necessary. What needs to be swapped is data going
> >_over_ the little-endian PCI bus. Addreses don't go _over_ the bus, they
> >address resources _on_ the bus.
>
> Sure of that ? First let's look at what the driver actually does in that
> routine. I know that the NCR chips are have bus-masterers ;)

This is definitely correct. The script engine expects everything little
endian and so on a BE system you see it defined as cpu_to_le32.

It still feels like an address translation issue despite things
looking good from the data we have.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
