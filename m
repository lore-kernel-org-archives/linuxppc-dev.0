Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF7101A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 18:51:25 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 24 Feb 2016 13:21:20 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1O7pGnc65339452
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 13:21:17 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1O7pExq025429
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 13:21:15 +0530
Date: Wed, 24 Feb 2016 13:21:04 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>,
 Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace location
 during build
Message-ID: <20160224075103.GA21618@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <20160210174517.8347D692C8@newverein.lst.de>
 <1455293609.16012.9.camel@gmail.com>
 <20160212164517.GO12548@pathway.suse.cz>
 <20160216054701.GA20570@linux.vnet.ibm.com>
 <20160216082302.GA20522@lst.de>
 <20160216103028.GA10730@linux.vnet.ibm.com>
 <20160216103907.GB25103@lst.de>
 <20160216135742.GT12548@pathway.suse.cz>
 <1455678521.2956.4.camel@ellerman.id.au>
 <20160223170017.GB21932@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160223170017.GB21932@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Torsten Duwe <duwe@lst.de> [2016-02-23 18:00:17]:

> On Wed, Feb 17, 2016 at 02:08:41PM +1100, Michael Ellerman wrote:
> > 
> > That stub uses r2 to find the location of itself, but it only works if r2 holds
> > the TOC for scsi_mod.ko. In this case r2 still contains ibmvscsi.ko's TOC.
> 
> Here's my solution, a bit rough still. This replaces the module_64.c change
> from patch 2/8:
> 
> I shuffle the trampoline instructions so the R2-save-to-stack comes first.
> This allows me to construct a profiling trampoline code that
> looks very similar. The first instruction, harmful to -mprofile-kernel
> can now be replaced with a load of the *kernel* TOC value via paca.
> Arithmetic is done in r11, to keep it bitwise identical where possible.
> Likewise the result is "moved" to r12 via an addi.
> 
> What do you think?
> 

Hi Torsten,

 I hit build failure, after replacing this patch with patch 2/8 module_64.c
hunk.

  CC      arch/powerpc/kernel/module.o
  CC      arch/powerpc/kernel/module_64.o
In file included from ./arch/powerpc/include/asm/asm-offsets.h:1:0,
                 from arch/powerpc/kernel/module_64.c:30:
include/generated/asm-offsets.h:14:0: error: "NMI_MASK" redefined [-Werror]
 #define NMI_MASK 1048576 /* NMI_MASK  # */
 ^
In file included from include/linux/spinlock.h:50:0,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from arch/powerpc/kernel/module_64.c:21:
include/linux/preempt.h:46:0: note: this is the location of the previous definition
 #define NMI_MASK (__IRQ_MASK(NMI_BITS)     << NMI_SHIFT)
 ^
In file included from ./arch/powerpc/include/asm/asm-offsets.h:1:0,
                 from arch/powerpc/kernel/module_64.c:30:
include/generated/asm-offsets.h:148:0: error: "CLONE_VM" redefined [-Werror]
 #define CLONE_VM 256 /* CLONE_VM  # */
 ^
In file included from include/linux/sched.h:4:0,
                 from ./arch/powerpc/include/asm/elf.h:12,
                 from include/linux/elf.h:4,
                 from include/linux/module.h:15,
                 from arch/powerpc/kernel/module_64.c:21:
include/uapi/linux/sched.h:8:0: note: this is the location of the previous definition
 #define CLONE_VM 0x00000100 /* set if VM shared between processes */
 ^
In file included from ./arch/powerpc/include/asm/asm-offsets.h:1:0,
                 from arch/powerpc/kernel/module_64.c:30:
include/generated/asm-offsets.h:149:0: error: "CLONE_UNTRACED" redefined [-Werror]
 #define CLONE_UNTRACED 8388608 /* CLONE_UNTRACED  # */
 ^
In file included from include/linux/sched.h:4:0,
                 from ./arch/powerpc/include/asm/elf.h:12,
                 from include/linux/elf.h:4,
                 from include/linux/module.h:15,
                 from arch/powerpc/kernel/module_64.c:21:
include/uapi/linux/sched.h:22:0: note: this is the location of the previous definition
 #define CLONE_UNTRACED  0x00800000 /* set if the tracing process can't force CLONE_PTRACE on this clone */
 ^
In file included from ./arch/powerpc/include/asm/asm-offsets.h:1:0,
                 from arch/powerpc/kernel/module_64.c:30:
include/generated/asm-offsets.h:185:0: error: "NSEC_PER_SEC" redefined [-Werror]
 #define NSEC_PER_SEC 1000000000 /* NSEC_PER_SEC  # */
 ^
In file included from include/linux/time.h:7:0,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from arch/powerpc/kernel/module_64.c:21:
include/linux/time64.h:35:0: note: this is the location of the previous definition
 #define NSEC_PER_SEC 1000000000L
 ^
In file included from ./arch/powerpc/include/asm/asm-offsets.h:1:0,
                 from arch/powerpc/kernel/module_64.c:30:
include/generated/asm-offsets.h:188:0: error: "PGD_TABLE_SIZE" redefined [-Werror]
 #define PGD_TABLE_SIZE 32768 /* PGD_TABLE_SIZE  # */
 ^
In file included from ./arch/powerpc/include/asm/book3s/64/hash.h:58:0,
                 from ./arch/powerpc/include/asm/book3s/64/pgtable.h:8,
                 from ./arch/powerpc/include/asm/mmu-hash64.h:24,
                 from ./arch/powerpc/include/asm/mmu.h:185,
                 from ./arch/powerpc/include/asm/lppaca.h:36,
                 from ./arch/powerpc/include/asm/paca.h:21,
                 from ./arch/powerpc/include/asm/hw_irq.h:42,
                 from ./arch/powerpc/include/asm/irqflags.h:11,
                 from include/linux/irqflags.h:15,
                 from include/linux/spinlock.h:53,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from arch/powerpc/kernel/module_64.c:21:
./arch/powerpc/include/asm/book3s/64/hash-64k.h:133:0: note: this is the location of the previous definition
 #define PGD_TABLE_SIZE (sizeof(pgd_t) << PGD_INDEX_SIZE)
 ^
cc1: all warnings being treated as errors
scripts/Makefile.build:258: recipe for target 'arch/powerpc/kernel/module_64.o' failed
make[1]: *** [arch/powerpc/kernel/module_64.o] Error 1
Makefile:950: recipe for target 'arch/powerpc/kernel' failed
make: *** [arch/powerpc/kernel] Error 2

Thanks,
Kamalesh.
