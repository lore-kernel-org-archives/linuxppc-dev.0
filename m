Message-ID: <B0CD235912AED411B69800D0B7C9F60F1DF929@mail>
From: "Francis Yu <francisy@luxn.com>" <francisy@luxn.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem in bringing up Linux 2.4.4. 
Date: Wed, 18 Jun 2003 12:29:21 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am using a PPC860 board which is very much similar to the EST board. I
have successfully ported PPCBOOT 1.2.0 and VMLINUX 2.4.? on it. Now I have
upgraded my host environment to RedHat 8.0 and want to re-build the Linux
kernel. I have downloaded PPCBOOT 2.0 and VMLINUX 2.4.4 from DENX (and also
RAMDISK2048). After I programmed the images into Flash, the PPCBOOT came up
OK, but the console did not display anything else after the statement
"Transferring control to Linux (at address 00000000)...". I looked into the
log_buf and found that there is nothing but zeros. Then I used the BDI2000
to breakpoint it at the printk function, and found out that the log_buf in
the code is at 0xc0166eec whereas the log_buf in the map is at 0xc0186eec.
By comparing the listing files I found that in the new Linux build I have an
extra section called .eh_frame as indicated below (idx 5). I wonder what
this section is for. Could someone please shed some light into this. Thanks.
Francis


/eldk/linux-2.4.4/vmlinux:     file format elf32-powerpc
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00117808  c0000000  c0000000  00010000  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .text.exit    00000588  c0117808  c0117808  00127808  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .rodata       00029a94  c0117d90  c0117d90  00127d90  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .kstrtab      000036c0  c0141824  c0141824  00151824  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .data         00011f84  c0145000  c0145000  00155000  2**4
                  CONTENTS, ALLOC, LOAD, DATA
  5 .eh_frame     0001fcb0  c0156f84  c0156f84  00166f84  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  6 .exitcall.exit 00000060  c0176c34  c0176c34  00186c34  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  7 __ex_table    00000bb0  c0176c94  c0176c94  00186c94  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  8 __ksymtab     00001b58  c0177844  c0177844  00187844  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  9 .data.cacheline_aligned 00000460  c01793a0  c01793a0  001893a0  2**4
                  CONTENTS, ALLOC, LOAD, DATA
 10 .text.init    0000a858  c017a000  c017a000  0018a000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 11 .data.init    00000e74  c0184858  c0184858  00194858  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 12 .setup.init   000000b8  c01856d0  c01856d0  001956d0  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 13 .initcall.init 00000094  c0185788  c0185788  00195788  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 14 .bss          00039070  c0186000  c0186000  00196000  2**4
                  ALLOC
 15 .debug_abbrev 000520c5  00000000  00000000  00196000  2**0
                  CONTENTS, READONLY, DEBUGGING
 16 .debug_info   02015947  00000000  00000000  001e80c5  2**0
                  CONTENTS, READONLY, DEBUGGING
 17 .debug_line   002f7d1c  00000000  00000000  021fda0c  2**0
                  CONTENTS, READONLY, DEBUGGING
 18 .debug_pubnames 0001a91f  00000000  00000000  024f5728  2**0
                  CONTENTS, READONLY, DEBUGGING
 19 .debug_aranges 00003128  00000000  00000000  02510047  2**0
                  CONTENTS, READONLY, DEBUGGING
 20 .comment      00004dee  00000000  00000000  0251316f  2**0
                  CONTENTS, READONLY
Disassembly of section .text:

c0000000 <__start>:
c0000000:	7c 7f 1b 78 	mr	r31,r3
c0000004:	7c 9e 23 78 	mr	r30,r4
c0000008:	7c bd 2b 78 	mr	r29,r5
c000000c:	7c dc 33 78 	mr	r28,r6
c0000010:	7c fb 3b 78 	mr	r27,r7
c0000014:	3b 00 00 00 	li	r24,0


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
