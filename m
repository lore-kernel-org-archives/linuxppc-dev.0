Return-Path: <rlefevre@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 8664BDE374
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 01:32:36 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so1400960wag.13
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 08:32:35 -0700 (PDT)
Message-ID: <4e0b9cb00809230832r47904417xc4eb5b3159f4f21f@mail.gmail.com>
Date: Tue, 23 Sep 2008 17:32:35 +0200
From: "Remi Lefevre" <rlefevre@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem with flush_icache_range, linux-2.6.27-rc7-denx & mpc8270
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I'm new to PowerPC and encounter some problems booting Linux on a custom
MPC8270 board.

The boot sequence goes wrong at the begining of the MMU init, in MMU_init_h=
w().

[arch/powerpc/mm/ppc_mmu_32.c]
...
    if (!cpu_has_feature(CPU_FTR_HPTE_TABLE)) {
        /*
         * Put a blr (procedure return) instruction at the
         * start of hash_page, since we can still get DSI
         * exceptions on a 603.
         */
        hash_page[0] =3D 0x4e800020;
        flush_icache_range((unsigned long) &hash_page[0],      <- Never ret=
urns
                   (unsigned long) &hash_page[1]);
        return;
    }
...

the problem in flush_icache_range occurs when the first cache block is copi=
ed
to memory, at dcbst instruction:

[arch/powerpc/kernel/misc_32.S]
...
_KPROBE(__flush_icache_range)
BEGIN_FTR_SECTION
    blr             /* for 601, do nothing */
END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
    li  r5,L1_CACHE_BYTES-1
    andc    r3,r3,r5
    subf    r4,r3,r4
    add r4,r4,r5
    srwi.   r4,r4,L1_CACHE_SHIFT
    beqlr
    mtctr   r4
    mr  r6,r3
1:  dcbst   0,r3                                  <- Control is lost here
    addi    r3,r3,L1_CACHE_BYTES
    bdnz    1b
    sync
...

By stepping, I lose debugger control at this point. No exception seems to
occur.  No more log is stored in the log buffer. The instruction seems to
never end.

L1_CACHE_BYTES has the value (1 << 5), corresponding the CONFIG_PPC32
config.

R0    00030040
R1    C0311FC0
R2    C02F7578
R3    C0014B20
R4           1
R5          1F
R6    C031B456
R7    C0320000


Any idea on possible causes or ways to improve my investigations would be
greatly appreciated.

Best regards,
R=E9mi Lefevre

---

Versions:

(U-Boot 1.3.4)
linux-2.6-denx.git from today
(linux-2.6-denx-63646fc60b177cfc511d8d35a9134902f41f9898)

Kernel configuration is identical to pq2fads:

CONFIG_6xx=3Dy
CONFIG_PPC_FPU=3Dy
CONFIG_PPC_STD_MMU=3Dy
CONFIG_PPC_STD_MMU_32=3Dy
CONFIG_PPC32=3Dy
CONFIG_WORD_SIZE=3D32
CONFIG_PPC_MERGE=3Dy
CONFIG_MMU=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy
CONFIG_GENERIC_TIME=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_IRQ_PER_CPU=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_ARCH_HAS_ILOG2_U32=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
CONFIG_PPC=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_GENERIC_NVRAM=3Dy
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_PPC_OF=3Dy
CONFIG_OF=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_DEFAULT_UIMAGE=3Dy
