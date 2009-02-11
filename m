Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61530DDDAA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 16:03:46 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1B53aQX015108
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 23:03:37 -0600
Subject: test branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 16:03:36 +1100
Message-Id: <1234328616.29851.10.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

The powerpc.git "test" branch has been rebased on top of "next" with the
addition of the following patches:

commit 8d30c14cab30d405a05f2aaceda1e9ad57800f36
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue Feb 10 16:02:37 2009 +0000

    powerpc/mm: Rework I$/D$ coherency (v3)
    
    This patch reworks the way we do I and D cache coherency on PowerPC.
    
    The "old" way was split in 3 different parts depending on the processor type:
    
       - Hash with per-page exec support (64-bit and >= POWER4 only) does it
    at hashing time, by preventing exec on unclean pages and cleaning pages
    on exec faults.
    
       - Everything without per-page exec support (32-bit hash, 8xx, and
    64-bit < POWER4) does it for all page going to user space in update_mmu_cache().
    
       - Embedded with per-page exec support does it from do_page_fault() on
    exec faults, in a way similar to what the hash code does.
    
    That leads to confusion, and bugs. For example, the method using update_mmu_cache()
    is racy on SMP where another processor can see the new PTE and hash it in before
    we have cleaned the cache, and then blow trying to execute. This is hard to hit but
    I think it has bitten us in the past.
    
    Also, it's inefficient for embedded where we always end up having to do at least
    one more page fault.
    
    This reworks the whole thing by moving the cache sync into two main call sites,
    though we keep different behaviours depending on the HW capability. The call
    sites are set_pte_at() which is now made out of line, and ptep_set_access_flags()
    which joins the former in pgtable.c
    
    The base idea for Embedded with per-page exec support, is that we now do the
    flush at set_pte_at() time when coming from an exec fault, which allows us
    to avoid the double fault problem completely (we can even improve the situation
    more by implementing TLB preload in update_mmu_cache() but that's for later).
    
    If for some reason we didn't do it there and we try to execute, we'll hit
    the page fault, which will do a minor fault, which will hit ptep_set_access_flags()
    to do things like update _PAGE_ACCESSED or _PAGE_DIRTY if needed, we just make
    this guys also perform the I/D cache sync for exec faults now. This second path
    is the catch all for things that weren't cleaned at set_pte_at() time.
    
    For cpus without per-pag exec support, we always do the sync at set_pte_at(),
    thus guaranteeing that when the PTE is visible to other processors, the cache
    is clean.
    
    For the 64-bit hash with per-page exec support case, we keep the old mechanism
    for now. I'll look into changing it later, once I've reworked a bit how we
    use _PAGE_EXEC.
    
    This is also a first step for adding _PAGE_EXEC support for embedded platforms
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 4b7ad3593634c593d0e891ea415f9cf1bbcfcbd2
Author: Gerhard Pircher <gerhard_pircher@gmx.net>
Date:   Tue Feb 10 12:26:22 2009 +0000

    powerpc/amigaone: Default config for AmigaOne boards
    
    CONFIG_CC_OPTIMIZE_FOR_SIZE is selected, because otherwise the kernel
    wouldn't boot. The AmigaOne's U-boot firmware seems to have a problem
    loading uImages bigger than 1.8 MB.
    
    Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 8f23735d8f8cfd4d46e3aa336690f52b8b5d3c75
Author: Gerhard Pircher <gerhard_pircher@gmx.net>
Date:   Tue Feb 10 12:26:11 2009 +0000

    powerpc/amigaone: Bootwrapper and serial console support for AmigaOne
    
    This adds the bootwrapper for the cuImage target and a compatible property
    check for "pnpPNP,501" to the generic serial console support code.
    The default link address for the cuImage target is set to 0x800000. This
    allows to boot the kernel with AmigaOS4's second level bootloader, which
    always loads a uImage at 0x500000.
    
    Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 50408b7defa513a9ea1107b42674167e53ba7a4a
Author: Gerhard Pircher <gerhard_pircher@gmx.net>
Date:   Tue Feb 10 12:26:03 2009 +0000

    powerpc/amigaone: Generic device tree for all AmigaOne boards
    
    This device tree does not provide the correct CPU name, as various CPU
    models and revisions are used in AmigaOnes. Also the PCI root node does
    not contain a interrupt mapping property, as all boards have different
    interrupt routing. However the kernel can do a 1:1 mapping of all PCI
    interrupts, as only i8259 legacy interrupts are used.
    
    Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 54b318aa5211ab7bba617a27d9cbd7fd759dcfd0
Author: Gerhard Pircher <gerhard_pircher@gmx.net>
Date:   Tue Feb 10 12:20:49 2009 +0000

    powerpc/amigaone: Add platform support for AmigaOne
    
    This commit adds the setup code for booting Linux on AmigaOne G3SE (G3
    only), AmigaOne XE and uA1 (G3/G4) desktop computers. These boards were
    sold by Eyetech and are based on MAI Logic's Teron boards and its
    Articia S northbridge.
    The AmigaOne uses U-boot as firmware, which doesn't support a flattened
    device tree yet. The northbridge has some design flaws, which makes it
    necessary to use non cacheable memory for DMA operations
    (CONFIG_NOT_COHERENT_CACHE) and to avoid setting the coherence (M) flag
    for memory pages.
    
    Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 8535ef05a6904429ce72671c3035dbf05e6d5edf
Author: Mike Mason <mmlnx@us.ibm.com>
Date:   Tue Feb 10 11:12:21 2009 +0000

    powerpc/eeh: Only disable/enable LSI interrupts in EEH
    
    The EEH code disables and enables interrupts during the
    device recovery process.  This is unnecessary for MSI
    and MSI-X interrupts because they are effectively disabled
    by the DMA Stopped state when an EEH error occurs.  The
    current code is also incorrect for MSI-X interrupts.  It
    doesn't take into account that MSI-X interrupts are tracked
    in a different way than LSI/MSI interrupts.  This patch
    ensures only LSI interrupts are disabled/enabled.
    
    Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
    Acked-by: Linas Vepstas <linasvepstas@gmail.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 10156ceac26b8adfd5d739a3931c8aa9d0d69d53
Author: Gabriel Paubert <paubert@iram.es>
Date:   Tue Feb 10 06:13:50 2009 +0000

    powerpc: Disable mv643xx Ethernet port 0 on Pegasos
    
    After the last changes, the mv643xx_eth driver now detects
    a spurious interface on port 0. Since only port 1 is actually
    connected to a PHY, remove its description.
    
    Signed-off-by: Gabriel Paubert <paubert@iram.es>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 91b0f5ec53336cfc6b2cd894a248dfadab9f34a6
Author: Anton Blanchard <anton@samba.org>
Date:   Mon Feb 9 20:42:17 2009 +0000

    powerpc/mm: Move 64-bit unmapped_area to top of address space
    
    We currently place mmaps just below the stack on 32bit, but leave them
    in the middle of the address space on 64bit:
    
    00100000-00120000 r-xp 00100000 00:00 0                    [vdso]
    10000000-10010000 r-xp 00000000 08:06 179534               /tmp/sleep
    10010000-10020000 rw-p 00000000 08:06 179534               /tmp/sleep
    10020000-10130000 rw-p 10020000 00:00 0                    [heap]
    40000000000-40000030000 r-xp 00000000 08:06 440743         /lib64/ld-2.9.so
    40000030000-40000040000 rw-p 00020000 08:06 440743         /lib64/ld-2.9.so
    40000050000-400001f0000 r-xp 00000000 08:06 440671         /lib64/libc-2.9.so
    400001f0000-40000200000 r--p 00190000 08:06 440671         /lib64/libc-2.9.so
    40000200000-40000220000 rw-p 001a0000 08:06 440671         /lib64/libc-2.9.so
    40000220000-40008230000 rw-p 40000220000 00:00 0
    fffffbc0000-fffffd10000 rw-p fffffeb0000 00:00 0           [stack]
    
    Right now it isn't an issue, but at some stage we will run into mmap or
    hugetlb allocation issues. Using the same layout as 32bit gives us a
    some breathing room. This matches what x86-64 is doing too.
    
    00100000-00103000 r-xp 00100000 00:00 0                    [vdso]
    10000000-10001000 r-xp 00000000 08:06 554894               /tmp/test
    10010000-10011000 r--p 00000000 08:06 554894               /tmp/test
    10011000-10012000 rw-p 00001000 08:06 554894               /tmp/test
    10012000-10113000 rw-p 10012000 00:00 0                    [heap]
    fffefdf7000-ffff7df8000 rw-p fffefdf7000 00:00 0
    ffff7df8000-ffff7f97000 r-xp 00000000 08:06 130591         /lib64/libc-2.9.so
    ffff7f97000-ffff7fa6000 ---p 0019f000 08:06 130591         /lib64/libc-2.9.so
    ffff7fa6000-ffff7faa000 r--p 0019e000 08:06 130591         /lib64/libc-2.9.so
    ffff7faa000-ffff7fc0000 rw-p 001a2000 08:06 130591         /lib64/libc-2.9.so
    ffff7fc0000-ffff7fc4000 rw-p ffff7fc0000 00:00 0
    ffff7fc4000-ffff7fec000 r-xp 00000000 08:06 130663         /lib64/ld-2.9.so
    ffff7fee000-ffff7ff0000 rw-p ffff7fee000 00:00 0
    ffff7ffa000-ffff7ffb000 rw-p ffff7ffa000 00:00 0
    ffff7ffb000-ffff7ffc000 r--p 00027000 08:06 130663         /lib64/ld-2.9.so
    ffff7ffc000-ffff7fff000 rw-p 00028000 08:06 130663         /lib64/ld-2.9.so
    ffff7fff000-ffff8000000 rw-p ffff7fff000 00:00 0
    fffffc59000-fffffc6e000 rw-p ffffffeb000 00:00 0           [stack]
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 2e74778c76521f180516a593fb2b2786d6fffa4e
Author: roel kluin <roel.kluin@gmail.com>
Date:   Sun Jan 18 02:03:47 2009 +0000

    therm_adt746x: Fix signed/unsigned confusion
    
    As suggested, this is used for signed rather than unsigned
    
    Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit c3bd517de67d33c44059656194e316facef181a5
Author: Milton Miller <miltonm@bga.com>
Date:   Thu Jan 8 02:19:46 2009 +0000

    powerpc/pci: Move hose_list and pci_address_to_pio to pci-common
    
    move the definition of hose_list next to its hotplug spinlock.
    
    create pcibios_io_size to encapsulate ifdef in existing pci-common
    function pcibios_vaddr_is_ioport
    
    move pci_address_to_pio to pci-common, using new pcibios_io_size, and
    protect this GPL exported function against concurrent hotplug removal
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
