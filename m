Date: Thu, 14 Nov 2002 11:06:09 +0500 (GMT+0500)
From: Atm account <linux2@cdotd.ernet.in>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem in booting PPC with kernel 2.5.44 
Message-ID: <Pine.OSF.4.10.10211141105320.4936-100000@moon.cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,
  We are porting Linux 2.5.44 for our custom board which has
 603e processor..
    We are using the arch/ppc/boot/simple bootloader with minor
modifications. At the end of boot-code relocation to 8 Mb, the code jumps
to the relocated code and thereafter
does the decompression (decompress_kernel)of the vmlinux image to physical
address 0 and jumps to the 0th location (3 nops followed by code). It is
from here that early_init is called.
    Now the problem is ... the kernel has been linked at 3GB and a call in
kernel/head.S which says ---
       bl early_init
translates to sth like =>    bl 0Xc000xxxx
   I dont have the MMU on at this point nor any dual mapping being done
thru the BATs. So how is the above code supposed to execute ?????
Our board precisely hangs after this jump.

Also, later in the same file (kernel/head.S) i have a piece of code which
goes like ...

        bl      mmu_off
__after_mmu_off:
        bl      clear_bats
        bl      flush_tlbs

        bl      initial_bats

after doing a mmu_off (disabling translations) we again do branches which
actually translate to the 3Gb addresses. How r they supposed to execute ?

  Can somebody pls explain ..

thanx in advance :)

Nishant


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
