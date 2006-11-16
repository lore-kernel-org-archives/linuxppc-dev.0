Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: 2.6.19-rc6-arnd1 release
Date: Fri, 17 Nov 2006 00:34:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611170034.09865.arnd@arndb.de>
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	James K Lewis <jklewis@us.ibm.com>, Kevin Corry <kevcorry@us.ibm.com>,
	Jeremy Kerr <jeremy@au1.ibm.com>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>,
	Dwayne Grant McConnell <decimal@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've uploaded a new kernel tree to the usual location at
http://www.kernel.org/pub/linux/kernel/people/arnd/patches/.

It now contains oprofile support, as well as the updated xmon
patches. Both of these were sent in the last few days.

Changes that are in there for a little longer include
saving SPU contexts in core dumps, and support for the
Playstation 3. The Playstation patches are still last week's
version, I expect an update soon, which can probably go
right into powerpc.git for the most part.

I also tried merging the patches for the Toshiba celleb
platform, but they are still based on an older powerpc.git
version, so I gave up when it got too complicated. I hope
this patch set helps Toshiba do a new version.

Most of what I have in here should eventually make it into
2.6.20, and I'll submit them to Paul Mackerras soon, after
some final cleanup.

	Arnd <><

---

Arnd Bergmann <arnd@arndb.de>
  cell: update defconfig for ps3 and axon support
  clean up spu core dump patch
  [RFC] convert idle_loop to use hard_irq_disable()
  spidernet: Revert 808999c9a4749dc67c39bf52f712d0c27aa00e67
  spufs: add a FIXME
  spufs: always map local store non-guarded
  spufs: replace recycle file with automated method
  spufs: return correct event for data storage interrupt
  spufs: use SPU master control to prevent wild SPU execution

Christian Krafft <krafft@de.ibm.com>
  mm: enables booting a NUMA system where some nodes have no memory
  mm: fix call to alloc_bootmem after bootmem has been freed

Christoph Hellwig <hch@infradead.org>
  spufs: avoid user-triggered oops in ptrace

Dwayne Grant McConnell <decimal@us.ibm.com>
  coredump: Add SPU elf notes to coredump.
  spufs: Remove /spu_tag_mask file
  spufs: add /lslr, /dma_info and /proxydma files
  spufs: Change %llx to 0x%llx.
  spufs: implement /mbox_info, /ibox_info, and /wbox_info.
  spufs: read from signal files only if data is there

Geoff Levand <geoffrey.levand@am.sony.com>
  cell: replace spu.nid with spu.node
  powerpc: abstract spu management routines
  powerpc: add virq_to_hw accessor routine
  powerpc: change ppc_rtas declaration to weak
  ps3: add basic platform support
  ps3: add firmware feature bits
  ps3: add OS area support
  ps3: add repository support
  ps3: add spufs support
  ps3: Adds routines to interface with the ps3pf interrupt services
  ps3: Adds the ps3pf hvcalls.
  ps3: add system bus driver
  ps3: Pagetable management routines
  ps3: use lpar address space

James K Lewis <jklewis@us.ibm.com>
  Spidernet - add net_ratelimit to suppress long output

Jeremy Kerr <jeremy@au1.ibm.com>
  spufs: Add runcntrl read accessors
  spufs: Setup isolated-mode loader in

Kevin Corry <kevcorry@us.ibm.com>
  cell: add routines for managing PMU interrupts
  cell: Move PMU-related stuff to include/asm-powerpc/cell-pmu.h
  cell: PMU register macros
  Oprofile-on-Cell prereqs: Export hrtimer_forward

Masato Noguchi <Masato.Noguchi@jp.sony.com>
  spufs: fix missing stop-and-signal

Maynard Johnson <maynardj@us.ibm.com>
  cell: add oprofile support

Michael Ellerman <michael@ellerman.id.au>
  Add a 'sd' command (spu dump) to xmon to dump spu
  Add spu disassembly to xmon
  Fix sparse warning in xmon Cell code
  Import spu disassembly code into xmon
  Import updated version of ppc disassembly code for
  Make 64-bit cpu features defined on 32-bit
  Make xmon disassembly optional
  Prepare for spu disassembly in xmon
  Show state of spus as they're stopped in Cell xmon
