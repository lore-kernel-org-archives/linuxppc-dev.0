Date: Mon, 15 Dec 2003 10:01:12 +0100
From: Harald Welte <laforge@gnumonks.org>
To: prism54-devel@prism54.org
Cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org,
	binutils@sources.redhat.com
Subject: 'unknown ADD relocation' in prism54.ko with 2.6.0-test11 on ppc
Message-ID: <20031215090112.GA11929@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I've tried to build the prism54 driver with a 2.6.0-test11 kernel
(linuxppc-25bh tree from source.mvista.com yesterday) in combination
with the http://prism54.org/pub/linux/snapshot/tars/2003-12/prism54-cvs20031214.tar.bz2

The driver compiles fine, but when I try to load the resulting
prism54.ko (http://gnumonks.org/ftp/pub/tmp/prism54-reloc/prism54.ko), I end
up with an error message in dmesg:

prism54: unknown ADD relocation: 0

As it turned out, arch/ppc/kernel/module.c:apply_relocate_add() is
printing that error message.  Judging from the elf.h file, relocation
type 0 is R_PPC_NONE.

further looking at the output of 'objdump -r prism54.ko', I can see
several entries in the [.stab] section, containing R_PPC_NONE
relocations.   The first one is at 00004c44, see the following excerpt:

/lib/modules/2.6.0-test11/kernel/drivers/net/wireless/prism54/prism54.ko: file format elf32-powerpc

RELOCATION RECORDS FOR [.stab]:
OFFSET   TYPE              VALUE
00000014 R_PPC_ADDR32      .text
00000020 R_PPC_ADDR32      .text
00003914 R_PPC_ADDR32      init_wds
00003938 R_PPC_ADDR32      display_buffer
00003a04 R_PPC_ADDR32      print_frame
00003ab8 R_PPC_ADDR32      string_to_macaddress
00003c2c R_PPC_ADDR32      .text+0x000001ac
00003c38 R_PPC_ADDR32      .text+0x000001ac
00003c44 R_PPC_ADDR32      .text+0x000001ac
00003c44 R_PPC_NONE        *ABS*
00005864 R_PPC_ADDR32      islpci_eth_cleanup_transmit

The full output of objdump -r can be found at
http://gnumonks.org/ftp/pub/tmp/prism54-reloc/prism54.ko-broken-objdump_r.txt

Those *ABS* symbols are not present in the two soource files (prism54.o
and prism54.mod.o).

If I strip the debug information by manually executing
ld -s -r -o drivers/net/wireless/prism54/prism54.ko drivers/net/wireless/prism54/prism54.o drivers/net/wireless/prism54/prism54.mod.o

I get a resulting prism54.ko without a [.stab] section and thus without
any R_PPC_NONE relocations.

My system is a G4 TiBook IV, running debian testing with gcc-3.0.4 and
ld from binutils-2.14.90.0.7.

I'm now not rally sure what the real cause of the problem is.  I haven't
found any other module in the kernel that would produce R_PPC_NONE
symbols.  But I also cannot find anything special in the prism54 driver
source that could be the cause.

I suspect it's either a problem in the linker itself, or a problem with
KBUILD using the linker in a wrong way [that would produce undesired
relocations].

Does anybody have any idea where to continue looking for the problem?

Please Cc' me in your replies, since I don't read all of the Cc'ed
mailinglists.

TIA,

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifeti=
me

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
