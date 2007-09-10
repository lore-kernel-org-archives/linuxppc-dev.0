Return-Path: <b07421@freescale.com>
Date: Mon, 10 Sep 2007 09:25:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
Message-ID: <20070910142513.GB21670@ld0162-tx32.am.freescale.net>
References: <20070907005803.GJ26079@localhost.localdomain>
	<d16e868937a1f77cbf080754f5742ad9@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d16e868937a1f77cbf080754f5742ad9@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 09, 2007 at 06:29:11PM -0500, Milton Miller wrote:
> >>diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
> >>index ccaedae..ec57ec9 100644
> >>--- a/arch/powerpc/boot/io.h
> >>+++ b/arch/powerpc/boot/io.h
> >>@@ -99,4 +99,11 @@ static inline void barrier(void)
> >>        asm volatile("" : : : "memory");
> >> }
> >>
> >>+static inline void disable_irq(void)
> >>+{
> >>+       int dummy;
> >>+       asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0" 
> >>:
> >>+                    "=r" (dummy) : : "memory");
> >>+}
> 
> This will fail (mtmsr illegal instruction) on 64 bit processors that do 
> not implement the bridge facility (POWER4, 5, 6, PPC970, ...)

Ouch...  And given the One wrapper.a To Rule Them All mandate, we can't
ifdef it here, but instead must make separate platform files. :-P

> >>+       timebase_period_ns = 1000000000 / timebase;
> >>+       simple_alloc_init(_end, memsize64 - (unsigned long)_end, 32, 
> >>64);
> >>+       ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
> >>
> 
> only 64 malloc slots?

That was copied from other platforms; it should probably be higher.

> So the labels are linked against to find the memory size to allocate 
> all above the load address to malloc ...
> 
> We can eliminate the need for the labels by calling simple_alloc_init 
> twice: the first time on a small bss region, read the properties, then 
> call it again with the full memory, and then call ft_init again.  That 
> is the trick I used in the kexec series.  When dtlib merges, we can 
> read the tree without malloc and avoid the extra dance.

OK.

> >>+       serial_console_init();
> 
> I'm not sure I consider serial_console firemware independent: our 
> wrapper IO macros simply do normal loads and stores, and rely on 
> firmware to setup either tlbs, virtural mappings, or other to make the 
> IO cache inhibited ...

The intent wasn't to run without firmware (that's require memory
initialization and other fun stuff that isn't here, and certainly isn't
generic), but to run without caring what the firmware is.  It's assumed
that whatever firmware is there has initialized the serial port to meet
the needs of whatever serial port the device tree points at.

> yea, i realize it doesn't have to find a console, and it all works 
> without it.  But this is why I pulled the call from my kexec patches.

That option is available, by not specifying linux,stdout-path at all.

> Just to clarify: this should go in the Kconfig help:
> This platform requires
> (1) device tree fully filled out, including memory size and timebase 
> frequency
> (2) (currently) labels
> (3) firmware that jumps to start of image (this is like old kernels)
> (4) after its in ram (we must have writable data/bss)
> (5) space below load to decompress vmlinux (no vmlinux_alloc to 
> fallback to malloc)
> (6) all space above load address available to hold malloc region
> (7) for console output (or input) from wrapper, on most cpus, some 
> magic setup

For #5, I really need to get around to implementing setting the load
address at build-time based on the size of vmlinux...

> >>+if [ -n "$binary" ]; then
> >>+    mv "$ofile" "$ofile".elf
> >>+    ${CROSS}objcopy -O binary "$ofile".elf "$ofile"
> >>+fi
> 
> I'm not sure how putting a binary flag test here will help other 
> platforms.  Even those that want a .elf left behind, if they need ohter 
> processing they will done the move already.  I'd say just make this 
> part of the platform case just above, although I could accept it being 
> moved ahead of that case.

Well, it's also used by planetcore platforms...

> Actually, looking at the current case, treeboot, cuboot, and ps3 all 
> (could) start with this rename and objcopy, so lets put it above the 
> final platform fixup case, and update those platforms to use this 
> feature (adjusting the calls to nm, dd, gzip, etc accordingly).

...but moving it earlier and letting other platforms use the result in
this way would be better, yes.

> Bottom line: This looks like a very simple platform, but it has hidden 
> assumptions in its environment (mtmsr, laod in the middle of memory, 
> others?) and takes the wrapper script in directions i'd rather it not 
> go.  I'd like you to look at my kexec platform series, and see if 
> reusing some of that code would give us a more robust "raw" image.  
> (even if you don't need the detached kernel, initramfs parsing, and 
> detached initrd; I was thinking more like memranges and the 
> vmlinuz_alloc.  The policy about not using memory to end can be 
> relaxed, and find_end_of_ram made to search memory).  It's on my short 
> list to rediff and repost those anyways.

Where can I find the existing patches?

-Scott
