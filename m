From: Ruedi.Hofer@ascom.ch
Date: Thu, 28 Sep 2000 15:04:01 +0100 (CED)
Subject: Re: Re: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel
To: vanbaren_gerald@si.com
Cc: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Message-id: <0G1L0034YLMTKZ@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_+eT6BP1FRz0jVAbzdUuoag)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_+eT6BP1FRz0jVAbzdUuoag)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Jerry

I did as you mentioned:

# ppc_82xx-objdump -x zvmlinux | grep _end
00406000 g     O *ABS*  00000000 __pmac_end
00406000 g     O *ABS*  00000000 __setup_end
00406000 g     O *ABS*  00000000 __prep_end
00406000 g     O *ABS*  00000000 __initcall_end
00406000 g     O .data.init     00000000 __ptov_table_end
004052f0 g     O .data  00000004 initrd_end
00406000 g     O *ABS*  00000000 __apus_end
00406000 g     O *ABS*  00000000 __init_end
00406000 g     O *ABS*  00000000 __openfirmware_end
0040b274 g     O *ABS*  00000000 _end
00406000 g     O *ABS*  00000000 __chrp_end
00406000 g     O .data.init     00000000 __vtop_table_end
#
# ppc_82xx-objcopy --set-section-flags=image=contents,alloc,load,readonly,data \
>  --adjust-section-vma=image=0x0040b274 zvmlinux zvmlinux2
BFD: zvmlinux2: warning: allocated section `image' not in segment
#
#

.. but I get this strange warning!

Therefore, the section image somehow doesn't become loadable:

# ppc_82xx-objdump -x zvmlinux2 | more

zvmlinux2:     file format elf32-powerpc
zvmlinux2
architecture: powerpc:common, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x00400000

Program Header:
    LOAD off    0x00010000 vaddr 0x00400000 paddr 0x00400000 align 2**16
         filesz 0x0000530c memsz 0x0000b274 flags rwx

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         000041ac  00400000  00400000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       00000470  004041b0  004041b0  000141b0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         0000030c  00405000  00405000  00015000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .data.init    00000000  00406000  00406000  00016000  2**0
                  CONTENTS
  4 .bss          00005274  00406000  00406000  00016000  2**2
                  ALLOC
  5 image         0007110b  0040b274  0040b274  0001b274  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
SYMBOL TABLE:
00400000 l    d  .text  00000000

What's wrong with my image? Do you have an idea?

Thank you

Ruedi


--Boundary_(ID_+eT6BP1FRz0jVAbzdUuoag)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
