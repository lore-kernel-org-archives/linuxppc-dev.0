Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC455B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Jul 2011 09:24:09 +1000 (EST)
Subject: Re: Linux 3.0 boot failure on the Powerbook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
In-Reply-To: <20110724143729.49c69ce8@maggie>
References: <20110723222034.6757604b@maggie>
	<1311509250.25044.583.camel@pasglop> <20110724141051.771d6492@maggie>
	<1311509614.25044.585.camel@pasglop> <20110724143729.49c69ce8@maggie>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Jul 2011 09:23:38 +1000
Message-ID: <1311549818.25044.587.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-07-24 at 14:37 +0200, Michael Büsch wrote:
> On Sun, 24 Jul 2011 22:13:34 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > I'm booting zImage.pmac.
> > 
> > Ah that might make it easier... I don't remember where it links, can you
> > show me the program headers out of readelf -a of the zImage ?
> 
> As I recompiled stuff, here's the current failure log:
> http://bues.ch/misc/linux-3.0-pbook-2.jpg
> 
> And this is the corresponding readelf output:

Hrm.. the faulting address is outside of the zImage. Odd.

Can you try loading a plain vmlinux instead ? (feel free to strip it).

yaboot 1.3.13 might not be the best one to load a real ELF ...

On my side I'll dig one of my old powerbooks and see if I can reproduce
(I generally tend to netboot the zImage directly, but it needs to be <
4M for that to work due to Apple OF limitations, or use yaboot with plan
vmlinux which exercises a different code path within yaboot).

Cheers,
Ben.

> mb@maggie:~$ readelf -a /boot/linux.a
> ELF Header:
>   Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00 
>   Class:                             ELF32
>   Data:                              2's complement, big endian
>   Version:                           1 (current)
>   OS/ABI:                            UNIX - System V
>   ABI Version:                       0
>   Type:                              EXEC (Executable file)
>   Machine:                           PowerPC
>   Version:                           0x1
>   Entry point address:               0x400230
>   Start of program headers:          52 (bytes into file)
>   Start of section headers:          5769716 (bytes into file)
>   Flags:                             0x8000, relocatable-lib
>   Size of this header:               52 (bytes)
>   Size of program headers:           32 (bytes)
>   Number of program headers:         2
>   Size of section headers:           40 (bytes)
>   Number of section headers:         12
>   Section header string table index: 9
> 
> Section Headers:
>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>   [ 0]                   NULL            00000000 000000 000000 00      0   0  0
>   [ 1] .text             PROGBITS        00400000 010000 0048b0 00  AX  0   0  4
>   [ 2] .data             PROGBITS        00405000 015000 0012f8 00  WA  0   0  4
>   [ 3] .got              PROGBITS        004062f8 0162f8 00000c 04  WA  0   0  4
>   [ 4] __builtin_cmdline PROGBITS        00406304 016304 000200 00  WA  0   0  4
>   [ 5] .kernel:vmlinux.s PROGBITS        00407000 017000 569952 00   A  0   0  1
>   [ 6] .bss              NOBITS          00971000 580952 00bc70 00  WA  0   0  4
>   [ 7] .comment          PROGBITS        00000000 580952 00001c 01  MS  0   0  1
>   [ 8] .gnu.attributes   LOOS+ffffff5    00000000 58096e 000014 00      0   0  1
>   [ 9] .shstrtab         STRTAB          00000000 580982 000072 00      0   0  1
>   [10] .symtab           SYMTAB          00000000 580bd4 000780 10     11  55  4
>   [11] .strtab           STRTAB          00000000 581354 0004f3 00      0   0  1
> Key to Flags:
>   W (write), A (alloc), X (execute), M (merge), S (strings)
>   I (info), L (link order), G (group), x (unknown)
>   O (extra OS processing required) o (OS specific), p (processor specific)
> 
> There are no section groups in this file.
> 
> Program Headers:
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   LOAD           0x010000 0x00400000 0x00400000 0x570952 0x57cc70 RWE 0x10000
>   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RWE 0x4
> 
>  Section to Segment mapping:
>   Segment Sections...
>    00     .text .data .got __builtin_cmdline .kernel:vmlinux.strip .bss 
>    01     
> 
> There is no dynamic section in this file.
> 
> There are no relocations in this file.
> 
> There are no unwind sections in this file.
> 
> Symbol table '.symtab' contains 120 entries:
>    Num:    Value  Size Type    Bind   Vis      Ndx Name
>      0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND 
>      1: 00400000     0 SECTION LOCAL  DEFAULT    1 
>      2: 00405000     0 SECTION LOCAL  DEFAULT    2 
>      3: 004062f8     0 SECTION LOCAL  DEFAULT    3 
>      4: 00406304     0 SECTION LOCAL  DEFAULT    4 
>      5: 00407000     0 SECTION LOCAL  DEFAULT    5 
>      6: 00971000     0 SECTION LOCAL  DEFAULT    6 
>      7: 00000000     0 SECTION LOCAL  DEFAULT    7 
>      8: 00000000     0 SECTION LOCAL  DEFAULT    8 
>      9: 00000000     0 FILE    LOCAL  DEFAULT  ABS of.c
>     10: 00400000    96 FUNC    LOCAL  DEFAULT    1 of_image_hdr
>     11: 00400130   220 FUNC    LOCAL  DEFAULT    1 of_try_claim
>     12: 00971000     4 OBJECT  LOCAL  DEFAULT    6 claim_base
>     13: 00000000     0 FILE    LOCAL  DEFAULT  ABS empty.c
>     14: 0040021c     0 NOTYPE  LOCAL  DEFAULT    1 p_start
>     15: 00400220     0 NOTYPE  LOCAL  DEFAULT    1 p_etext
>     16: 00400224     0 NOTYPE  LOCAL  DEFAULT    1 p_bss_start
>     17: 00400228     0 NOTYPE  LOCAL  DEFAULT    1 p_end
>     18: 0040022c     0 NOTYPE  LOCAL  DEFAULT    1 p_pstack
>     19: 00400234     0 NOTYPE  LOCAL  DEFAULT    1 p_base
>     20: 00000007     0 NOTYPE  LOCAL  DEFAULT  ABS RELA
>     21: 6ffffff9     0 NOTYPE  LOCAL  DEFAULT  ABS RELACOUNT
>     22: 00000000     0 FILE    LOCAL  DEFAULT  ABS main.c
>     23: 0040032c   536 FUNC    LOCAL  DEFAULT    1 prep_kernel
>     24: 00971004 46960 OBJECT  LOCAL  DEFAULT    6 gzstate
>     25: 00406304   512 OBJECT  LOCAL  DEFAULT    4 cmdline
>     26: 00000000     0 FILE    LOCAL  DEFAULT  ABS gunzip_util.c
>     27: 0097c774   128 OBJECT  LOCAL  DEFAULT    6 discard_buf.1439
>     28: 00000000     0 FILE    LOCAL  DEFAULT  ABS elf_util.c
>     29: 00000000     0 FILE    LOCAL  DEFAULT  ABS inflate.c
>     30: 00400ed4   424 FUNC    LOCAL  DEFAULT    1 zlib_adler32
>     31: 004011c4   292 FUNC    LOCAL  DEFAULT    1 zlib_updatewindow
>     32: 00405484  2048 OBJECT  LOCAL  DEFAULT    2 lenfix.1147
>     33: 00405c84   128 OBJECT  LOCAL  DEFAULT    2 distfix.1148
>     34: 00405d04    38 OBJECT  LOCAL  DEFAULT    2 order.1216
>     35: 00000000     0 FILE    LOCAL  DEFAULT  ABS inftrees.c
>     36: 00405e8e    62 OBJECT  LOCAL  DEFAULT    2 lext.1062
>     37: 00405ecc    62 OBJECT  LOCAL  DEFAULT    2 lbase.1061
>     38: 00405f0a    64 OBJECT  LOCAL  DEFAULT    2 dext.1064
>     39: 00405f4a    64 OBJECT  LOCAL  DEFAULT    2 dbase.1063
>     40: 00000000     0 FILE    LOCAL  DEFAULT  ABS oflib.c
>     41: 00402a4c   432 FUNC    LOCAL  DEFAULT    1 of_call_prom_ret
>     42: 0040611c     4 OBJECT  LOCAL  DEFAULT    2 need_map
>     43: 0097c7f4     4 OBJECT  LOCAL  DEFAULT    6 prom
>     44: 0097c7f8     4 OBJECT  LOCAL  DEFAULT    6 chosen_mmu
>     45: 0097c7fc     4 OBJECT  LOCAL  DEFAULT    6 memory
>     46: 00000000     0 FILE    LOCAL  DEFAULT  ABS ofconsole.c
>     47: 004032b0   104 FUNC    LOCAL  DEFAULT    1 of_console_open
>     48: 0040325c    84 FUNC    LOCAL  DEFAULT    1 of_console_write
>     49: 0097c800     4 OBJECT  LOCAL  DEFAULT    6 of_stdout_handle
>     50: 00000000     0 FILE    LOCAL  DEFAULT  ABS stdio.c
>     51: 0040369c   848 FUNC    LOCAL  DEFAULT    1 number
>     52: 0097c804  1024 OBJECT  LOCAL  DEFAULT    6 sprint_buf
>     53: 00000000     0 FILE    LOCAL  DEFAULT  ABS inffast.c
>     54: 004062f8     0 OBJECT  LOCAL  HIDDEN    3 _GLOBAL_OFFSET_TABLE_
>     55: 00400060   208 FUNC    GLOBAL DEFAULT    1 platform_init
>     56: 00403318     0 NOTYPE  GLOBAL DEFAULT    1 strcpy
>     57: 00000000     0 NOTYPE  WEAK   DEFAULT  UND _platform_stack_top
>     58: 00400924   240 FUNC    GLOBAL DEFAULT    1 gunzip_partial
>     59: 0040413c   188 FUNC    GLOBAL DEFAULT    1 printf
>     60: 004039ec  1872 FUNC    GLOBAL DEFAULT    1 vsprintf
>     61: 0040426c     0 NOTYPE  GLOBAL DEFAULT    1 __div64_32
>     62: 00403468     0 NOTYPE  GLOBAL DEFAULT    1 memmove
>     63: 00402a10    60 FUNC    GLOBAL DEFAULT    1 of_init
>     64: 00406508     0 NOTYPE  GLOBAL DEFAULT    4 _dtb_start
>     65: 0040020c     0 NOTYPE  GLOBAL DEFAULT    1 _zimage_start_opd
>     66: 004048b0     0 NOTYPE  GLOBAL DEFAULT    1 _etext
>     67: 00402e04    72 FUNC    GLOBAL DEFAULT    1 of_finddevice
>     68: 00401088   132 FUNC    GLOBAL DEFAULT    1 zlib_inflateReset
>     69: 00403470     0 NOTYPE  GLOBAL DEFAULT    1 memcpy
>     70: 00403624     0 NOTYPE  GLOBAL DEFAULT    1 flush_cache
>     71: 0040430c  1444 FUNC    GLOBAL DEFAULT    1 inflate_fast
>     72: 00407000     0 NOTYPE  GLOBAL DEFAULT    5 _vmlinux_start
>     73: 0040110c   152 FUNC    GLOBAL DEFAULT    1 zlib_inflateInit2
>     74: 00402dac    88 FUNC    GLOBAL DEFAULT    1 of_getprop
>     75: 00400b80   484 FUNC    GLOBAL DEFAULT    1 gunzip_start
>     76: 0097cc04    20 OBJECT  GLOBAL DEFAULT    6 loader_info
>     77: 0097cc18    28 OBJECT  GLOBAL DEFAULT    6 platform_ops
>     78: 00403140   212 FUNC    GLOBAL DEFAULT    1 of_vmlinux_alloc
>     79: 00400a7c   120 FUNC    GLOBAL DEFAULT    1 gunzip_exactly
>     80: 004012e8   240 FUNC    GLOBAL DEFAULT    1 zlib_inflateIncomp
>     81: 00400d64   200 FUNC    GLOBAL DEFAULT    1 parse_elf64
>     82: 0097cc34    20 OBJECT  GLOBAL DEFAULT    6 console_ops
>     83: 00403650    76 FUNC    GLOBAL DEFAULT    1 strnlen
>     84: 00400a14   104 FUNC    GLOBAL DEFAULT    1 gunzip_finish
>     85: 00402e90   688 FUNC    GLOBAL DEFAULT    1 of_claim
>     86: 00402480  1424 FUNC    GLOBAL DEFAULT    1 zlib_inflate_table
>     87: 00400af4   140 FUNC    GLOBAL DEFAULT    1 gunzip_discard
>     88: 004013d8  4264 FUNC    GLOBAL DEFAULT    1 zlib_inflate
>     89: 00400e2c   168 FUNC    GLOBAL DEFAULT    1 parse_elf32
>     90: 0040335c     0 NOTYPE  GLOBAL DEFAULT    1 strcat
>     91: 00402e4c    68 FUNC    GLOBAL DEFAULT    1 of_exit
>     92: 004035cc     0 NOTYPE  GLOBAL DEFAULT    1 memchr
>     93: 00400000     0 NOTYPE  GLOBAL DEFAULT    1 _start
>     94: 004033cc     0 NOTYPE  GLOBAL DEFAULT    1 strncmp
>     95: 00403214    72 FUNC    GLOBAL DEFAULT    1 of_console_init
>     96: 0040107c    12 FUNC    GLOBAL DEFAULT    1 zlib_inflate_workspacesiz
>     97: 00403334     0 NOTYPE  GLOBAL DEFAULT    1 strncpy
>     98: 004035f4     0 NOTYPE  GLOBAL DEFAULT    1 memcmp
>     99: 00971000     0 NOTYPE  GLOBAL DEFAULT    5 _initrd_start
>    100: 00400230     0 NOTYPE  WEAK   DEFAULT    1 _zimage_start
>    101: 00403528     0 NOTYPE  GLOBAL DEFAULT    1 backwards_memcpy
>    102: 00971000     0 NOTYPE  GLOBAL DEFAULT    6 __bss_start
>    103: 0040340c     0 NOTYPE  GLOBAL DEFAULT    1 memset
>    104: 00406508     0 NOTYPE  GLOBAL DEFAULT    4 _dtb_end
>    105: 00971000     0 NOTYPE  GLOBAL DEFAULT    5 _initrd_end
>    106: 0097cc48    40 OBJECT  GLOBAL DEFAULT    6 dt_ops
>    107: 004033a8     0 NOTYPE  GLOBAL DEFAULT    1 strcmp
>    108: 004041f8   116 FUNC    GLOBAL DEFAULT    1 sprintf
>    109: 00971000     0 NOTYPE  GLOBAL DEFAULT    6 _edata
>    110: 0097cc70     0 NOTYPE  GLOBAL DEFAULT    6 _end
>    111: 00400544   992 FUNC    GLOBAL DEFAULT    1 start
>    112: 00970952     0 NOTYPE  GLOBAL DEFAULT    5 _vmlinux_end
>    113: 004033f4     0 NOTYPE  GLOBAL DEFAULT    1 strlen
>    114: 00403388     0 NOTYPE  GLOBAL DEFAULT    1 strchr
>    115: 00400230     0 NOTYPE  GLOBAL DEFAULT    1 _zimage_start_lib
>    116: 00406504     0 NOTYPE  GLOBAL DEFAULT    4 __dynamic_start
>    117: 004011a4    32 FUNC    GLOBAL DEFAULT    1 zlib_inflateEnd
>    118: 00402d54    88 FUNC    GLOBAL DEFAULT    1 of_setprop
>    119: 00402bfc   344 FUNC    GLOBAL DEFAULT    1 of_call_prom
> 
> No version information found in this file.
> Attribute Section: gnu
> File Attributes
>   Tag_GNU_Power_ABI_FP: Soft float
>   Tag_GNU_Power_ABI_Vector: Generic
>   Tag_GNU_Power_ABI_Struct_Return: Memory
> 
> 
