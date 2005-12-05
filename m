Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BEC76887D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 02:35:43 +1100 (EST)
Date: Mon, 5 Dec 2005 13:33:26 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051205153326.GA4978@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Failure to boot v2.6.14+ on PPC8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi,

More details on the problem reported earlier. Some change introduced
after v2.6.14 makes the "relocate_code" relocate section of
arch/ppc/boot/common/util.o disappear. This results in a kernel image
with functions at util.o not being part of the relocate section,
rendering the system unbootable.

Follows relevant output, Debian unstable toolchain (/opt/montavista is 
a link to the default Debian tools).

marcelo@pegasos:~$ gcc -v
Using built-in specs.
Target: powerpc-linux-gnu Configured with: ../src/configure -v
--enable-languages=c,c++,java,f95,objc,ada,treelang --prefix=/usr
--enable-shared --with-system-zlib --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix
--enable-nls --program-suffix=-4.0 --enable-__cxa_atexit
--enable-libstdcxx-allocator=mt --enable-clocale=gnu
--enable-libstdcxx-debug --enable-java-gc=boehm
--enable-java-awt=gtk-default --enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.0-1.4.2.0/jre
--enable-mpfr --disable-softfloat
--enable-targets=powerpc-linux,powerpc64-linux --with-cpu=default32
--disable-werror --enable-checking=release powerpc-linux-gnu Thread
model: posix gcc version 4.0.2 (Debian 4.0.2-2)

marcelo@pegasos:~$ ld -v
GNU ld version 2.16.1 Debian GNU/Linux

marcelo@pegasos:~/8xx/linux-2.6.14$
/opt/montavista/pro/devkit/ppc/8xx/bin/ppc_8xx-gcc -m32
-Wp,-MD,arch/ppc/boot/common/.util.o.d -nostdinc -isystem
/usr/lib/gcc/powerpc-linux-gnu/4.0.2/include -D__KERNEL__ -Iinclude
-include include/linux/autoconf.h -Iarch/ppc -Iarch/ppc/include
-D__ASSEMBLY__ -Iarch/ppc -c -o arch/ppc/boot/common/util.o
arch/ppc/boot/common/util.S

marcelo@pegasos:~/8xx/linux-2.6.14$ readelf -a arch/ppc/boot/common/util.o 
Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        00000000 000034 000150 00  AX  0   0  1
  [ 2] .rela.text        RELA            00000000 00061c 000018 0c     11   1  4
  [ 3] .data             PROGBITS        00000000 000184 000004 00  WA  0   0  1
  [ 4] .bss              NOBITS          00000000 000188 000000 00  WA  0   0  1
  [ 5] .relocate_code    PROGBITS        00000000 000188 000048 00  AX  0   0  1
  [ 6] .rela.relocate_co RELA            00000000 000634 00000c 0c     11   5  4
  [ 7] .stab             PROGBITS        00000000 0001d0 000024 0c      9   0  4
  [ 8] .rela.stab        RELA            00000000 000640 000018 0c     11   7  4
  [ 9] .stabstr          STRTAB          00000000 0001f4 00004e 00      0   0  1
  [10] .shstrtab         STRTAB          00000000 000242 000059 00      0   0  1
  [11] .symtab           SYMTAB          00000000 0004a4 0000f0 10     12   9  4
  [12] .strtab           STRTAB          00000000 000594 000088 00      0   0  1

Relocation section '.rela.text' at offset 0x61c contains 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000102  00000b06 R_PPC_ADDR16_HA   00000000   timebase_period_ns + 0
00000106  00000b04 R_PPC_ADDR16_LO   00000000   timebase_period_ns + 0

Relocation section '.rela.relocate_code' at offset 0x634 contains 1 entries:
 Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000004  00000e0a R_PPC_REL24       00000028   flush_data_cache + 0

Relocation section '.rela.stab' at offset 0x640 contains 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000014  00000d01 R_PPC_ADDR32      00000000   flush_instruction_cach + 0
00000020  00000e01 R_PPC_ADDR32      00000028   flush_data_cache + 0

There are no unwind sections in this file.

Symbol table '.symtab' contains 15 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
     0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND 
     1: 00000000     0 FILE    LOCAL  DEFAULT  ABS arch/ppc/boot/common/util
     2: 00000000     0 SECTION LOCAL  DEFAULT    1 
     3: 00000000     0 SECTION LOCAL  DEFAULT    3 
     4: 00000000     0 SECTION LOCAL  DEFAULT    4 
     5: 000000fc     0 NOTYPE  LOCAL  DEFAULT    1 .udelay_not_601
     6: 00000000     0 SECTION LOCAL  DEFAULT    5 
     7: 00000000     0 SECTION LOCAL  DEFAULT    7 
     8: 00000000     0 SECTION LOCAL  DEFAULT    9 
     9: 00000000     0 NOTYPE  GLOBAL DEFAULT    1 _setup_L2CR
    10: 00000080     0 NOTYPE  GLOBAL DEFAULT    1 _setup_L3CR
    11: 00000000     0 NOTYPE  GLOBAL DEFAULT    3 timebase_period_ns
    12: 000000d0     0 NOTYPE  GLOBAL DEFAULT    1 udelay
    13: 00000000     0 NOTYPE  GLOBAL DEFAULT    5 flush_instruction_cache
    14: 00000028     0 NOTYPE  GLOBAL DEFAULT    5 flush_data_cache

No version information found in this file.

marcelo@pegasos:~/8xx/linux-2.6-git-dec01$
/opt/montavista/pro/devkit/ppc/8xx/bin/ppc_8xx-gcc -m32
-Wp,-MD,arch/ppc/boot/common/.util.o.d -nostdinc -isystem
/usr/lib/gcc/powerpc-linux-gnu/4.0.2/include -D__KERNEL__ -Iinclude
-include include/linux/autoconf.h -Iarch/ppc -Iarch/ppc/include
-D__ASSEMBLY__ -Iarch/ppc -c -o arch/ppc/boot/common/util.o
arch/ppc/boot/common/util.S

marcelo@pegasos:~/8xx/linux-2.6-git-dec01$ readelf -a arch/ppc/boot/common/util.o 

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        00000000 000034 000198 00  AX  0   0  1
  [ 2] .rela.text        RELA            00000000 0005f0 000024 0c     10   1  4
  [ 3] .data             PROGBITS        00000000 0001cc 000004 00  WA  0   0  1
  [ 4] .bss              NOBITS          00000000 0001d0 000000 00  WA  0   0  1
  [ 5] .relocate_code    PROGBITS        00000000 0001d0 000000 00  AX  0   0  1
  [ 6] .stab             PROGBITS        00000000 0001d0 000024 0c      8   0  4
  [ 7] .rela.stab        RELA            00000000 000614 000018 0c     10   6  4
  [ 8] .stabstr          STRTAB          00000000 0001f4 00004e 00      0   0  1
  [ 9] .shstrtab         STRTAB          00000000 000242 000054 00      0   0  1
  [10] .symtab           SYMTAB          00000000 000478 0000f0 10     11   9  4
  [11] .strtab           STRTAB          00000000 000568 000088 00      0   0  1

Relocation section '.rela.text' at offset 0x5f0 contains 3 entries:
 Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000102  00000b06 R_PPC_ADDR16_HA   00000000   timebase_period_ns + 0
00000106  00000b04 R_PPC_ADDR16_LO   00000000   timebase_period_ns + 0
00000154  00000e0a R_PPC_REL24       00000178   flush_data_cache + 0

Relocation section '.rela.stab' at offset 0x614 contains 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000014  00000d01 R_PPC_ADDR32      00000150   flush_instruction_cach + 0
00000020  00000e01 R_PPC_ADDR32      00000178   flush_data_cache + 0

There are no unwind sections in this file.

Symbol table '.symtab' contains 15 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
     0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND 
     1: 00000000     0 FILE    LOCAL  DEFAULT  ABS arch/ppc/boot/common/util
     2: 00000000     0 SECTION LOCAL  DEFAULT    1 
     3: 00000000     0 SECTION LOCAL  DEFAULT    3 
     4: 00000000     0 SECTION LOCAL  DEFAULT    4 
     5: 000000fc     0 NOTYPE  LOCAL  DEFAULT    1 .udelay_not_601
     6: 00000000     0 SECTION LOCAL  DEFAULT    5 
     7: 00000000     0 SECTION LOCAL  DEFAULT    6 
     8: 00000000     0 SECTION LOCAL  DEFAULT    8 
     9: 00000000     0 NOTYPE  GLOBAL DEFAULT    1 _setup_L2CR
    10: 00000080     0 NOTYPE  GLOBAL DEFAULT    1 _setup_L3CR
    11: 00000000     0 NOTYPE  GLOBAL DEFAULT    3 timebase_period_ns
    12: 000000d0     0 NOTYPE  GLOBAL DEFAULT    1 udelay
    13: 00000150     0 NOTYPE  GLOBAL DEFAULT    1 flush_instruction_cache
    14: 00000178     0 NOTYPE  GLOBAL DEFAULT    1 flush_data_cache

No version information found in this file.
