Date: Fri, 14 Jan 2000 04:18:09 +0100
Message-Id: <200001140318.EAA16881@dumburk.cendio.se>
From: Christer Weinigel <wingel@cendio.se>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 16kb pages on MPC850
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm having a bit of a performance problem with Linux on a MPC850 based
system, and among other things I have found out that TLB misses
account for a large part of this.  I've done a rather ugly hack that
hardcodes the kernel to be mapped with a couple of 8 MB pages and this
doubled the performance of some parts of the lmbench suite. 

Right now I'm trying to move to 16 kByte pages to reduce the TLB
pressure.  I've implemented a software TLB handler (without using the
hardware assist) and have gotten so far that the system is able to
boot and mount its root filesystem over NFS.

Unfortunately, things are somewhat broken after this, the tty settings
are strange and trying to run a large application such as bash crashes
the system.  

Has anybody else been trying to do this?  Or do you know of any
pitfalls I should look out for when trying to use 16 kB pages? 

I've modified the following header files, and have changed a lot in
head.s, but is there anything else I should do or something below that
you thing I shouldn't do?

Or does anybody have better ideas on how to improve the performance of
Linux on a MPC850?  One idea I have is to try to map a shared libc
continuously in physical memory and then try to merge a lot of 4 kB
pages into one large 512 kB page so that most library calls will only
require one TLB entry.

Regards,
  Christer

include/asm-ppc/elf.h:

#define ELF_EXEC_PAGESIZE       16384

include/asm-ppc/param.h:

#define EXEC_PAGESIZE 16384

include/asm-ppc/page.h:

#define PAGE_SHIFT     14      /* 16 k pages */

include/asm-ppc/pgtable.h:

#define PMD_SHIFT   26
#define PGDIR_SHIFT 22
#define PTRS_PER_PTE        4096
#define PTRS_PER_PMD        1
#define PTRS_PER_PGD        64

-- 
Christer Weinigel		Cendio Systems AB
Email:	wingel@cendio.se	Teknikringen 8
Phone:	+46-13-21 46 00		583 30  Linköping
Fax:	+46-13-21 47 00		Sweden
[please note that Signum Support has changed its name to Cendio Systems]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
