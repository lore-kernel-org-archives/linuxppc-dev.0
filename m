Date: Sat, 22 Mar 2003 22:54:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ppc: Makefile tidy-up round 2
Message-ID: <20030322215403.GA15911@mars.ravnborg.org>
References: <20030320222759.GA12267@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030320222759.GA12267@mars.ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


More Makefile tidy-up - made on top of previous patches.

1) fixed a few bugs introduced when cleaning up boot/prep/Makefile
2) cleaned up boot/openfirmware/makefile
3) Got rid of boot/common/dummy.c
	It is now located in three copies but thats OK for a three line file
See cset comments below.

I have skipped "simple" clean up for now. Is it worth the effort?

Please pull from
bk pull bk://linux-sam.bkbits.net/ppc-2.5

Regular patches will follow this mail.

	Sam



ChangeSet@1.875, 2003-03-22 22:45:13+01:00, sam@mars.ravnborg.org
  ppc: boot/common/dummy.c deleted

ChangeSet@1.874, 2003-03-22 22:40:45+01:00, sam@mars.ravnborg.org
  ppc: boot/openfirmware/Makefile rewrite

  Utilises kbuild infrastructure to build the images
  Sample output with "make V=0":
    AS      arch/ppc/boot/openfirmware/coffcrt0.o
    GEN     arch/ppc/boot/openfirmware/image.o
    COFF    arch/ppc/boot/openfirmware/coffboot
    COFF    arch/ppc/boot/images/vmlinux.coff
    AS      arch/ppc/boot/openfirmware/crt0.o
    CC      arch/ppc/boot/openfirmware/newworldmain.o
    ELF     arch/ppc/boot/images/vmlinux.elf-pmac
    CC      arch/ppc/boot/openfirmware/chrpmain.o
    CHRP    arch/ppc/boot/images/zImage.chrp
    ADDNOTE arch/ppc/boot/images/zImage.chrp-rs6k
    GEN     arch/ppc/boot/images/miboot.image
    kernel: zImage is ready (arch/ppc/boot/images/vmlinux.coff)

ChangeSet@1.873, 2003-03-22 22:26:02+01:00, sam@mars.ravnborg.org
  ppc: Fix initrd build for prep


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
