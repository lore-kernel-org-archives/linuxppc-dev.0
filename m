Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04f.nortel.com (zcars04f.nortel.com [47.129.242.57])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zcars04f.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D0233DDE00
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 14:50:29 +1000 (EST)
Message-ID: <482527F3.60405@nortel.com>
Date: Fri, 09 May 2008 22:43:31 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Subject: Re: patch to install unstripped vDSO on disk breaks powerpc kernel
	build
References: <482486F7.3090805@nortel.com>
	<20080509194427.3BDB126FA85@magilla.localdomain>
In-Reply-To: <20080509194427.3BDB126FA85@magilla.localdomain>
Content-Type: multipart/mixed; boundary="------------020902030702020300030701"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020902030702020300030701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Roland McGrath wrote:
> I haven't seen that error before.  Can you show the output of {eu-,}readelf -lS
> on vdso64.so.dbg, and also on the vdso64.so successfully built when you
> revert the patch?

I've attached the raw output from the two commands.  The delta between 
the two is as follows:


-There are 14 section headers, starting at offset 0xd58:
+There are 16 section headers, starting at offset 0xd68:

  Section Headers:
    [Nr] Name              Type             Address           Offset
@@ -33,7 +33,11 @@
    [12] .rela.dyn         RELA             0000000000100be8  00000be8
         0000000000000000  0000000000000018   A       2     0     8
    [13] .shstrtab         STRTAB           0000000000000000  00000cd8
-       0000000000000079  0000000000000000           0     0     1
+       0000000000000089  0000000000000000           0     0     1
+  [14] .symtab           SYMTAB           0000000000000000  00001168
+       0000000000000d80  0000000000000018          15   134     8
+  [15] .strtab           STRTAB           0000000000000000  00001ee8
+       00000000000004a3  0000000000000000           0     0     1
  Key to Flags:
    W (write), A (alloc), X (execute), M (merge), S (strings)
    I (info), L (link order), G (group), x (unknown)


Also, I'm going to be away on holidays next week, so I won't be able to 
test this further until the 19th or so.


Chris

--------------020902030702020300030701
Content-Type: text/plain;
 name="good.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="good.txt"

good:

[cfriesen@localhost linux-2.6]$ /home/cfriesen/bin/ppc64-R9a/bin/ppc64-R9a-readelf -lS ../g5/arch/powerpc/kernel/vdso64/vdso64.so
There are 14 section headers, starting at offset 0xd58:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .hash             HASH             0000000000100120  00000120
       000000000000004c  0000000000000004   A       2     0     8
  [ 2] .dynsym           DYNSYM           0000000000100170  00000170
       0000000000000150  0000000000000018   A       3     4     8
  [ 3] .dynstr           STRTAB           00000000001002c0  000002c0
       00000000000000ef  0000000000000000   A       0     0     1
  [ 4] .gnu.version      VERSYM           00000000001003b0  000003b0
       000000000000001c  0000000000000002   A       2     0     2
  [ 5] .gnu.version_d    VERDEF           00000000001003d0  000003d0
       0000000000000038  0000000000000000   A       3     2     8
  [ 6] .note             NOTE             0000000000100408  00000408
       0000000000000018  0000000000000000   A       0     0     4
  [ 7] .text             PROGBITS         0000000000100420  00000420
       00000000000002ec  0000000000000000  AX       0     0     8
  [ 8] .eh_frame_hdr     PROGBITS         0000000000100710  00000710
       0000000000000008  0000000000000000   A       0     0     4
  [ 9] .eh_frame         PROGBITS         0000000000100718  00000718
       00000000000004c4  0000000000000000   A       0     0     8
  [10] .got              PROGBITS         0000000000100be0  00000be0
       0000000000000008  0000000000000008  WA       0     0     8
  [11] .dynamic          DYNAMIC          0000000000100be8  00000be8
       00000000000000f0  0000000000000010  WA       3     0     8
  [12] .rela.dyn         RELA             0000000000100be8  00000be8
       0000000000000000  0000000000000018   A       2     0     8
  [13] .shstrtab         STRTAB           0000000000000000  00000cd8
       0000000000000079  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

Elf file type is DYN (Shared object file)
Entry point 0x0
There are 4 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000000000 0x0000000000100000 0x0000000000100000
                 0x0000000000000cd8 0x0000000000000cd8  R E    10000
  NOTE           0x0000000000000408 0x0000000000100408 0x0000000000100408
                 0x0000000000000018 0x0000000000000018  R      4
  DYNAMIC        0x0000000000000be8 0x0000000000100be8 0x0000000000100be8
                 0x00000000000000f0 0x00000000000000f0  R      8
  GNU_EH_FRAME   0x0000000000000710 0x0000000000100710 0x0000000000100710
                 0x0000000000000008 0x0000000000000008  R      4

 Section to Segment mapping:
  Segment Sections...
   00     .hash .dynsym .dynstr .gnu.version .gnu.version_d .note .text .eh_frame_hdr .eh_frame .got .dynamic
   01     .note
   02     .dynamic
   03     .eh_frame_hdr

--------------020902030702020300030701
Content-Type: text/plain;
 name="bad.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bad.txt"

bad:

[cfriesen@localhost linux-2.6]$ /home/cfriesen/bin/ppc64-R9a/bin/ppc64-R9a-readelf -lS ../g5/arch/powerpc/kernel/vdso64/vdso64.so.dbg
There are 16 section headers, starting at offset 0xd68:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .hash             HASH             0000000000100120  00000120
       000000000000004c  0000000000000004   A       2     0     8
  [ 2] .dynsym           DYNSYM           0000000000100170  00000170
       0000000000000150  0000000000000018   A       3     4     8
  [ 3] .dynstr           STRTAB           00000000001002c0  000002c0
       00000000000000ef  0000000000000000   A       0     0     1
  [ 4] .gnu.version      VERSYM           00000000001003b0  000003b0
       000000000000001c  0000000000000002   A       2     0     2
  [ 5] .gnu.version_d    VERDEF           00000000001003d0  000003d0
       0000000000000038  0000000000000000   A       3     2     8
  [ 6] .note             NOTE             0000000000100408  00000408
       0000000000000018  0000000000000000   A       0     0     4
  [ 7] .text             PROGBITS         0000000000100420  00000420
       00000000000002ec  0000000000000000  AX       0     0     8
  [ 8] .eh_frame_hdr     PROGBITS         0000000000100710  00000710
       0000000000000008  0000000000000000   A       0     0     4
  [ 9] .eh_frame         PROGBITS         0000000000100718  00000718
       00000000000004c4  0000000000000000   A       0     0     8
  [10] .got              PROGBITS         0000000000100be0  00000be0
       0000000000000008  0000000000000008  WA       0     0     8
  [11] .dynamic          DYNAMIC          0000000000100be8  00000be8
       00000000000000f0  0000000000000010  WA       3     0     8
  [12] .rela.dyn         RELA             0000000000100be8  00000be8
       0000000000000000  0000000000000018   A       2     0     8
  [13] .shstrtab         STRTAB           0000000000000000  00000cd8
       0000000000000089  0000000000000000           0     0     1
  [14] .symtab           SYMTAB           0000000000000000  00001168
       0000000000000d80  0000000000000018          15   134     8
  [15] .strtab           STRTAB           0000000000000000  00001ee8
       00000000000004a3  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

Elf file type is DYN (Shared object file)
Entry point 0x0
There are 4 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000000000 0x0000000000100000 0x0000000000100000
                 0x0000000000000cd8 0x0000000000000cd8  R E    10000
  NOTE           0x0000000000000408 0x0000000000100408 0x0000000000100408
                 0x0000000000000018 0x0000000000000018  R      4
  DYNAMIC        0x0000000000000be8 0x0000000000100be8 0x0000000000100be8
                 0x00000000000000f0 0x00000000000000f0  R      8
  GNU_EH_FRAME   0x0000000000000710 0x0000000000100710 0x0000000000100710
                 0x0000000000000008 0x0000000000000008  R      4

 Section to Segment mapping:
  Segment Sections...
   00     .hash .dynsym .dynstr .gnu.version .gnu.version_d .note .text .eh_frame_hdr .eh_frame .got .dynamic
   01     .note
   02     .dynamic
   03     .eh_frame_hdr

--------------020902030702020300030701--
