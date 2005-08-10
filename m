Return-Path: <becky.bruce@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <c237b7e878e0c32f421209fa37b7a156@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
From: Becky Bruce <becky.bruce@freescale.com>
Date: Wed, 10 Aug 2005 11:45:10 -0500
Subject: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

In the name of moving the much-anticipated 32/64 ppc merge along, Kumar 
Gala, Jon Loeliger, and myself have worked out an initial proposal for 
the directory structure of the new merged arch/powerpc.  Listed below 
are the proposed directories, along with a description of the logical 
contents, as well as a description of which existing files will be 
moved into these directories.

There was some discussion on the list recently about whether or not it 
might be better to change things around to be laid out more along the 
lines of functionality with, say, all pci-related code in one place.  
We've stuck with a more traditional model in this proposal, although 
the topic is certainly still up for discussion.

This is just a first pass at a structure - we're really looking for 
input from this list on the best way to proceed, and that discussion 
needs to start somewhere.  BTW, this proposal preempts the previous 
64-bit directory structure reorg proposal that I sent to this list a 
couple of months ago.

So here it is:

include/powerpc/

arch/powerpc/
	configs/
		- Kconfig defaults per buildable board.

	boot/
		- Pre-kernel execution shims and pre-passes.
		- Convert firmware reprensentations (bi_recs, OF Dev-Trees,
		 bootx,bd_t) to flat-dev-trees.
		- Includes merged files from arch/ppc*/boot/ trees, plus
		prom_init.c from arch/ppc64/kernel.

	kernel/
		- CPU-centric core code and generic PPC-specific kernel
		- Main entry point supports r5=0, r3 = flat-dev-tree, etc.
		- Includes all cpu core-specific code, kernel initialization code,
		and other generic kernel foo like smp, ptrace, syscalls, etc from
		arch/ppc*/kernel.  Files not belonging to one of these categories
		will be moved to other directories.


	platforms/
		- platform-specific code laid out in the following directories:
		pSeries/
		iSeries/
		pmac/  (both 32 and 64-bit)
		classic32/  (platforms containing 6xx/7xx/74xx/8240/8241/8245)
		classic64/  (Maple?)
		83xx/ (may collapse into classic 32 at some point)
		86xx/ (may collapse into classic 32 at some point)
		pq2/ (may collapse into classic 32 at some point)
		52xx/ (may collapse into classic 32 at some point)
		85xx/
		4xx/
		8xx/
		- Includes all code from arch/ppc/platforms, all code from
		arch/ppc64/kernel that is specific to a given platform (where a
		platform is a whole computer system or board)
	
		NOTE: there would be no .[chS] files directly under platforms -
		all live in subdirs.

	mm/
		- Memory management, slabs, tlbs, etc.
		- Unify LMB and mem_pieces for early boot memory.
		- Includes all code from arch/ppc*/mm

	sysdev/
		- System Device support and Kitchen Sink
		- Includes all code currently in arch/ppc/syslib, irq and pci code
		that currently lives in arch/ppc/kernel, and all code from
		arch/ppc64/kernel that is generic system code, including pci,
		irq, interrupt control, bridges, rtas(?)

	lib/
		- Library code
		- Includes all code from arch/ppc*/lib

	math-emu/
		- Math Emulation for FPU-less ppc32s.
		- this is 32-bit only, so this directory would just move from
		arch/ppc to arch/powerpc

	oprofile/
		- Support for oprofile.
		- Includes all code from arch/ppc*/oprofile

	xmon/
		- Support for xmon.
		- Includes all code from arch/ppc*xmon


Cheers,
-Becky
