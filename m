Date: Tue, 27 Jul 2004 13:29:29 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440GX: mapping PCI address
Message-ID: <20040727132929.A12403@home.com>
References: <45ABD2373C33C4459D42B40EC4F346F2026215B0@FTWMLVEM03.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45ABD2373C33C4459D42B40EC4F346F2026215B0@FTWMLVEM03.e2k.ad.ge.com>; from Renaud.Barbier@ge.com on Tue, Jul 27, 2004 at 01:20:27PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 27, 2004 at 01:20:27PM -0500, Barbier, Renaud (GE Infrastructure) wrote:
>
> ok. I am lost here.
> I have checked the linux source code and can see
> comments regarding fix for the 36-bit address.
> So I would think the current BSP I have can support what I need.

Did you get the patch I mentioned? It hacks remap_page_range() to
call the 36-bit fixups and handle a u64 phys addr. What "BSP"
are you talking about?  Are you running a stock kernel tree?

> Still even though I am getting an address from mmap access, to the location freezes my machine.
> Here is the code.
> fd=open("/dev/mem", O_RDWR);
>
> /* test fd for error */
> ptr=(unsigned int *)mmap(0, 4096, PROT_READ | PROT_WRITE,
>                              MAP_SHARED, fd, 0xec00000); or /* 0x80002000 */
> printf("ptr = 0x%x\n", (unsigned int)ptr);
>
> the returned address is 0x30019000.
>
> If I understand correctly 0x0ec00000 should be translated by the kernel
> to 0x20ec00000 to map the PCI configuration register.

Only if the patch is applied.

> I can see the remapping being done when using ioremap in the drivers but not
> when doing mmap at user level. So could be wrong in my system?
>
>
> Actually, what do you do if you have 512MB of memory? I guess change the "trap" area.

I don't follow, how does 512MB of memory change things in your
case? The hack does make some assumptions but it works for most
peoples needs.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
