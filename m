Date: Wed, 31 Oct 2001 08:42:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: small cleanup
Message-ID: <20011031084233.A18493@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011030190809.F16202@cpe-24-221-152-185.az.sprintbbd.net> <Pine.LNX.4.33.0110311113100.31795-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0110311113100.31795-100000@serv>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 31, 2001 at 11:22:20AM +0100, Roman Zippel wrote:
> Hi,
>
> On Tue, 30 Oct 2001, Tom Rini wrote:
>
> > > - pcibios_make_OF_bus_map depends on CONFIG_ALL_PPC
> >
> > This should just be a warning, since gcc will optmize it out (it'll
> > always be false on !CONFIG_ALL_PPC.  It'd almost be preferable to do
> > something like:
> > #define pcibios_make_OF_bus_map do { } while(0)
> >
> > Someplace...
>
> That function is in the same file...

Yes, and compiled only on CONFIG_ALL_PPC.  But the if statement will
always be false on !CONFIG_ALL_PPC, so while the compiler will warn
about an implicit declaration, it won't cause a link error.  Eg:
--- 1.34/arch/ppc/kernel/pci.c  Sat Oct  6 11:16:41 2001
+++ edited/pci.c        Wed Oct 31 08:40:26 2001
@@ -743,6 +743,9 @@
                ranges += np;
        }
 }
+#else
+/* Kill a warning */
+#define pcibios_make_OF_bus_map do { } while(0)
 #endif /* CONFIG_ALL_PPC */

 void __init

> > > - removed duplicate definition of isa_io_base/isa_mem_base/pci_dram_offset
> > > (note: these variables are protected with CONFIG_PCI in ppc_ksyms.c, but
> > > not in the include files, so there are unconditional now)
> >
> > This will break 4xx I think...  Can you try doing a
> > walnut+CONFIG_405_DMA=y compile (in _devel..)
>
> I can try it (when I get home).

Thanks.

> > > - removed nested __KERNEL__ ifdefs in io.h, one even outside of the
> > > recursive protection (bad style).
> >
> > Correct, but it's usually
> > #ifdef __KERNEL__
> > #ifndef __FILE_H__
> > #define __FILE_H__
> > ...
> > #endif
> > #endif
> >
> > Or so.
>
> I would do it the other way around. gcc looks for a ifndef/define/endif
> sequence to decide whether it needs to rescan that file next time, but I'm
> not sure if gcc finds it in this case.

By and large we do it the way I said anyhow.  Is this in current gcc or
when we get the precompiled headers bits?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
