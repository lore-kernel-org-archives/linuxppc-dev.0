Message-Id: <m12pEA0-001SyZC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: Getting the image section of the ELF file to load w/ VxWorks boot
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 9 May 2000 13:51:08 -0400 (EDT)
In-Reply-To: <391834D3.9E57B710@Zentropix.com> from "Daniel G. Clemmensen" at May 09, 2000 11:54:59 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The approach that I settled upon was identified in my initial post,
however I didn't actually do all the steps.  I have attached the the
files that are needed to make it work.

Note: The Linux_2_3 BitKeeper repository at FMS Labs contains
      these changes.

#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.2).
# To extract the files from this archive, save it to some FILE, remove
# everything before the `!/bin/sh' line above, then type `sh FILE'.
#
# Made on 2000-05-09 13:39 EDT by <diekema@bucks>.
# Source directory was `/home/bucks/users/diekema'.
#
# Existing files will *not* be overwritten unless `-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#   3708 -rw-r--r-- arch/ppc/mbxboot/Makefile
#    156 -rw-r--r-- arch/ppc/mbxboot/gzimage.c
#    156 -rw-r--r-- arch/ppc/mbxboot/rdimage.c
#   3415 -rw-r--r-- arch/ppc/mbxboot/vmlinux.lds
#
save_IFS="${IFS}"
IFS="${IFS}:"
gettext_dir=FAILED
locale_dir=FAILED
first_param="$1"
for dir in $PATH
do
  if test "$gettext_dir" = FAILED && test -f $dir/gettext \
     && ($dir/gettext --version >/dev/null 2>&1)
  then
    set `$dir/gettext --version 2>&1`
    if test "$3" = GNU
    then
      gettext_dir=$dir
    fi
  fi
  if test "$locale_dir" = FAILED && test -f $dir/shar \
     && ($dir/shar --print-text-domain-dir >/dev/null 2>&1)
  then
    locale_dir=`$dir/shar --print-text-domain-dir`
  fi
done
IFS="$save_IFS"
if test "$locale_dir" = FAILED || test "$gettext_dir" = FAILED
then
  echo=echo
else
  TEXTDOMAINDIR=$locale_dir
  export TEXTDOMAINDIR
  TEXTDOMAIN=sharutils
  export TEXTDOMAIN
  echo="$gettext_dir/gettext -s"
fi
touch -am 1231235999 $$.touch >/dev/null 2>&1
if test ! -f 1231235999 && test -f $$.touch; then
  shar_touch=touch
else
  shar_touch=:
  echo
  $echo 'WARNING: not restoring timestamps.  Consider getting and'
  $echo "installing GNU \`touch', distributed in GNU File Utilities..."
  echo
fi
rm -f 1231235999 $$.touch
#
if mkdir _sh04766; then
  $echo 'x -' 'creating lock directory'
else
  $echo 'failed to create lock directory'
  exit 1
fi
# ============= arch/ppc/mbxboot/Makefile ==============
if test ! -d 'arch'; then
  $echo 'x -' 'creating directory' 'arch'
  mkdir 'arch'
fi
if test ! -d 'arch/ppc'; then
  $echo 'x -' 'creating directory' 'arch/ppc'
  mkdir 'arch/ppc'
fi
if test ! -d 'arch/ppc/mbxboot'; then
  $echo 'x -' 'creating directory' 'arch/ppc/mbxboot'
  mkdir 'arch/ppc/mbxboot'
fi
if test -f 'arch/ppc/mbxboot/Makefile' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'arch/ppc/mbxboot/Makefile' '(file already exists)'
else
  $echo 'x -' extracting 'arch/ppc/mbxboot/Makefile' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'arch/ppc/mbxboot/Makefile' &&
#
# arch/ppc/mbxboot/Makefile
#
# This file is subject to the terms and conditions of the GNU General Public
# License.  See the file "COPYING" in the main directory of this archive
# for more details.
#
# Copyright (C) 1994 by Linus Torvalds
# Adapted for PowerPC by Gary Thomas
# modified by Cort (cort@cs.nmt.edu)
#
X.c.s:
X	$(CC) $(CFLAGS) -S -o $*.s $<
X.s.o:
X	$(AS) -o $*.o $<
X.c.o:
X	$(CC) $(CFLAGS)  -DINITRD_OFFSET=$(IOFF) -DINITRD_SIZE=$(ISZ) -DZIMAGE_OFFSET=$(ZOFF) -DZIMAGE_SIZE=$(ZSZ) -c -o $*.o $<
X.S.s:
X	$(CPP) $(AFLAGS) -traditional -o $*.o $<
X.S.o:
X	$(CC) $(AFLAGS) -traditional -c -o $*.o $<
X
ZOFF = 0
ZSZ = 0
IOFF = 0
ISZ = 0
X
TFTPIMAGE=/tftpboot/zImage.embedded
X
ifdef CONFIG_8xx
ZLINKFLAGS = -T vmlinux.lds -Ttext 0x00180000
OBJECTS := head.o misc.o ../coffboot/zlib.o m8xx_tty.o gzimage.o rdimage.o
CFLAGS = $(CPPFLAGS) -O2 -DSTDC_HEADERS -fno-builtin -DCONFIG_8xx
endif
X
ifdef CONFIG_8260
ZLINKFLAGS = -T vmlinux.lds -Ttext 0x00400000
OBJECTS := head_8260.o misc.o ../coffboot/zlib.o m8260_tty.o embed_config.o gzimage.o rdimage.o
CFLAGS = $(CPPFLAGS) -O2 -DSTDC_HEADERS -fno-builtin -DCONFIG_8260
endif
X
OBJCOPY_ARGS = -O elf32-powerpc
X
ifeq ($(CONFIG_MBX),y)
OBJECTS += pci.o qspan_pci.o
CFLAGS += -DCONFIG_MBX
endif
ifeq ($(CONFIG_RPXLITE),y)
CFLAGS += -DCONFIG_RPXLITE
OBJECTS += iic.o embed_config.o
endif
ifeq ($(CONFIG_RPXCLASSIC),y)
CFLAGS += -DCONFIG_RPXCLASSIC
OBJECTS += iic.o embed_config.o pci.o qspan_pci.o
endif
ifeq ($(CONFIG_BSEIP),y)
CFLAGS += -DCONFIG_BSEIP
OBJECTS += iic.o embed_config.o
endif
X
all:	zImage
X
zvmlinux.initrd: zvmlinux
#
# Build the boot loader images
#
X	$(OBJCOPY) $(OBJCOPY_ARGS) -R .gzimage gzimage.o
X	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment \
X		--add-section=.gzimage=../coffboot/vmlinux.gz \
X		--set-section-flags=.gzimage=alloc,load,readonly,data \
X		gzimage.o
X	$(OBJCOPY) $(OBJCOPY_ARGS) -R .rdimage rdimage.o
X	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment \
X		--add-section=.rdimage=ramdisk.image.gz \
X		--set-section-flags=.rdimage=alloc,load,readonly,data \
X		rdimage.o
X	$(LD) $(ZLINKFLAGS) -o $@ $(OBJECTS)
#
# Compute the sizes/offsets for the final image, and rebuild with these values.
#
X	$(CC) $(CFLAGS) \
X		-DINITRD_OFFSET=`sh offset $(OBJDUMP) zvmlinux.initrd .rdimage` \
X		-DINITRD_SIZE=`sh size $(OBJDUMP) zvmlinux.initrd .rdimage` \
X		-DZIMAGE_OFFSET=`sh offset $(OBJDUMP) zvmlinux.initrd .gzimage` \
X		-DZIMAGE_SIZE=`sh size $(OBJDUMP) zvmlinux.initrd .gzimage` \
X		-c -o misc.o misc.c
X	$(LD) $(ZLINKFLAGS) -o $@ $(OBJECTS)
X	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment $@
X	$(OBJDUMP) -h $@
X
zImage: zvmlinux
X	ln -sf zvmlinux zImage
X
zImage.initrd: zvmlinux.initrd
X	ln -sf zvmlinux.initrd zImage.initrd
X
zvmlinux: $(OBJECTS) ../coffboot/vmlinux.gz
#
# Build the boot loader images
#
#
X	$(OBJCOPY) $(OBJCOPY_ARGS) -R .gzimage gzimage.o
X	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment \
X		--add-section=.gzimage=../coffboot/vmlinux.gz \
X		--set-section-flags=.gzimage=alloc,load,readonly,data \
X		gzimage.o
X	$(LD) $(ZLINKFLAGS) -o $@ $(OBJECTS)
#
# Compute the sizes/offsets for the final image, and rebuild with these values.
#
X	$(CC) $(CFLAGS) \
X		-DINITRD_OFFSET=0 \
X		-DINITRD_SIZE=0 \
X		-DZIMAGE_OFFSET=`sh offset $(OBJDUMP) zvmlinux .gzimage` \
X		-DZIMAGE_SIZE=`sh size $(OBJDUMP) zvmlinux .gzimage` \
X		-c -o misc.o misc.c
X	$(LD) $(ZLINKFLAGS) -o $@ $(OBJECTS)
X	$(OBJCOPY) $(OBJCOPY_ARGS) -R .comment $@
X	$(OBJDUMP) -h $@
X
znetboot : zImage
X	cp zImage $(TFTPIMAGE)
X
znetboot.initrd : zImage.initrd
X	cp zImage.initrd $(TFTPIMAGE)
X
clean:
X	rm -f vmlinux* zvmlinux* zImage*
X
fastdep:
X	$(TOPDIR)/scripts/mkdep *.[Sch] > .depend
X
dep:
X	$(CPP) $(CPPFLAGS) -M *.S *.c > .depend
X
# just here to match coffboot/Makefile
vmlinux.coff:
X
vmlinux.coff.initrd:
SHAR_EOF
  $shar_touch -am 05060231100 'arch/ppc/mbxboot/Makefile' &&
  chmod 0644 'arch/ppc/mbxboot/Makefile' ||
  $echo 'restore of' 'arch/ppc/mbxboot/Makefile' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'arch/ppc/mbxboot/Makefile:' 'MD5 check failed'
4ef1fd04948006dccd8474e4e7479ba0  arch/ppc/mbxboot/Makefile
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'arch/ppc/mbxboot/Makefile'`"
    test 3708 -eq "$shar_count" ||
    $echo 'arch/ppc/mbxboot/Makefile:' 'original size' '3708,' 'current size' "$shar_count!"
  fi
fi
# ============= arch/ppc/mbxboot/gzimage.c ==============
if test -f 'arch/ppc/mbxboot/gzimage.c' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'arch/ppc/mbxboot/gzimage.c' '(file already exists)'
else
  $echo 'x -' extracting 'arch/ppc/mbxboot/gzimage.c' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'arch/ppc/mbxboot/gzimage.c' &&
/*
X * gzimage.c
X *
X * Dummy file to allow a compressed zImage to be added
X * into a linker section, accessed by the boot coode
X */
X
char dummy_for_gzimage;
SHAR_EOF
  $shar_touch -am 05040233100 'arch/ppc/mbxboot/gzimage.c' &&
  chmod 0644 'arch/ppc/mbxboot/gzimage.c' ||
  $echo 'restore of' 'arch/ppc/mbxboot/gzimage.c' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'arch/ppc/mbxboot/gzimage.c:' 'MD5 check failed'
111ba05ecf9b8794b789b9b649d7401f  arch/ppc/mbxboot/gzimage.c
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'arch/ppc/mbxboot/gzimage.c'`"
    test 156 -eq "$shar_count" ||
    $echo 'arch/ppc/mbxboot/gzimage.c:' 'original size' '156,' 'current size' "$shar_count!"
  fi
fi
# ============= arch/ppc/mbxboot/rdimage.c ==============
if test -f 'arch/ppc/mbxboot/rdimage.c' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'arch/ppc/mbxboot/rdimage.c' '(file already exists)'
else
  $echo 'x -' extracting 'arch/ppc/mbxboot/rdimage.c' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'arch/ppc/mbxboot/rdimage.c' &&
/*
X * rdimage.c
X *
X * Dummy file to allow a compressed initrd to be added
X * into a linker section, accessed by the boot coode
X */
X
char dummy_for_rdimage;
SHAR_EOF
  $shar_touch -am 05040233100 'arch/ppc/mbxboot/rdimage.c' &&
  chmod 0644 'arch/ppc/mbxboot/rdimage.c' ||
  $echo 'restore of' 'arch/ppc/mbxboot/rdimage.c' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'arch/ppc/mbxboot/rdimage.c:' 'MD5 check failed'
de5a391cc4ccd1516ca4486eeeb2ff30  arch/ppc/mbxboot/rdimage.c
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'arch/ppc/mbxboot/rdimage.c'`"
    test 156 -eq "$shar_count" ||
    $echo 'arch/ppc/mbxboot/rdimage.c:' 'original size' '156,' 'current size' "$shar_count!"
  fi
fi
# ============= arch/ppc/mbxboot/vmlinux.lds ==============
if test -f 'arch/ppc/mbxboot/vmlinux.lds' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'arch/ppc/mbxboot/vmlinux.lds' '(file already exists)'
else
  $echo 'x -' extracting 'arch/ppc/mbxboot/vmlinux.lds' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'arch/ppc/mbxboot/vmlinux.lds' &&
OUTPUT_ARCH(powerpc)
SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); SEARCH_DIR(/usr/local/powerpc-any-elf/lib);
/* Do we need any of these for elf?
X   __DYNAMIC = 0;    */
SECTIONS
{
X  /* Read-only sections, merged into text segment: */
X  . = + SIZEOF_HEADERS;
X  .interp : { *(.interp) }
X  .hash          : { *(.hash)		}
X  .dynsym        : { *(.dynsym)		}
X  .dynstr        : { *(.dynstr)		}
X  .rel.text      : { *(.rel.text)		}
X  .rela.text     : { *(.rela.text) 	}
X  .rel.data      : { *(.rel.data)		}
X  .rela.data     : { *(.rela.data) 	}
X  .rel.rodata    : { *(.rel.rodata) 	}
X  .rela.rodata   : { *(.rela.rodata) 	}
X  .rel.got       : { *(.rel.got)		}
X  .rela.got      : { *(.rela.got)		}
X  .rel.ctors     : { *(.rel.ctors)	}
X  .rela.ctors    : { *(.rela.ctors)	}
X  .rel.dtors     : { *(.rel.dtors)	}
X  .rela.dtors    : { *(.rela.dtors)	}
X  .rel.bss       : { *(.rel.bss)		}
X  .rela.bss      : { *(.rela.bss)		}
X  .rel.plt       : { *(.rel.plt)		}
X  .rela.plt      : { *(.rela.plt)		}
/*  .init          : { *(.init)	} =0*/
X  .plt : { *(.plt) }
X  .text      :
X  {
X    *(.text)
X    *(.fixup)
X    *(.got1)
X  }
X  _etext = .;
X  PROVIDE (etext = .);
X  .rodata    :
X  {
X    *(.rodata)
X    *(.rodata1)
X  }
X  .fini      : { *(.fini)    } =0
X  .ctors     : { *(.ctors)   }
X  .dtors     : { *(.dtors)   }
X  /* Read-write section, merged into data segment: */
X  . = (. + 0x0FFF) & 0xFFFFF000;
X  .data    :
X  {
X    *(.data)
X    *(.data1)
X    *(.sdata)
X    *(.sdata2)
X    *(.got.plt) *(.got)
X    *(.dynamic)
X    CONSTRUCTORS
X  }
X  _edata  =  .;
X  PROVIDE (edata = .);
X
X  .fixup   : { *(.fixup) }
X  __start___ex_table = .;
X  __ex_table : { *(__ex_table) }
X  __stop___ex_table = .;
X
X  . = ALIGN(32);
X  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
X
X  . = ALIGN(4096);
X  __init_begin = .;
X  .text.init : { *(.text.init) }
X  .data.init : {
X    *(.data.init);
X    __vtop_table_begin = .;
X    *(.vtop_fixup);
X    __vtop_table_end = .;
X    __ptov_table_begin = .;
X    *(.ptov_fixup);
X    __ptov_table_end = .;
X  }
X  . = ALIGN(16);
X  __setup_start = .;
X  .setup.init : { *(.setup.init) }
X  __setup_end = .;
X  __initcall_start = .;
X  .initcall.init : { *(.initcall.init) }
X  __initcall_end = .;
X  . = ALIGN(4096);
X  __init_end = .;
X
X  . = ALIGN(4096);
X  __pmac_begin = .;
X  .text.pmac : { *(.text.pmac) }
X  .data.pmac : { *(.data.pmac) }
X  . = ALIGN(4096);
X  __pmac_end = .;
X
X  . = ALIGN(4096);
X  __prep_begin = .;
X  .text.prep : { *(.text.prep) }
X  .data.prep : { *(.data.prep) }
X  . = ALIGN(4096);
X  __prep_end = .;
X
X  . = ALIGN(4096);
X  __apus_begin = .;
X  .text.apus : { *(.text.apus) }
X  .data.apus : { *(.data.apus) }
X  . = ALIGN(4096);
X  __apus_end = .;
X
X  . = ALIGN(4096);
X  __apus_begin = .;
X  .text.apus : { *(.text.apus) }
X  .data.apus : { *(.data.apus) }
X  . = ALIGN(4096);
X  __apus_end = .;
X
X  . = ALIGN(4096);
X  __openfirmware_begin = .;
X  .text.openfirmware : { *(.text.openfirmware) }
X  .data.openfirmware : { *(.data.openfirmware) }
X  . = ALIGN(4096);
X  __openfirmware_end = .;
X
X  __bss_start = .;
X  .bss       :
X  {
X   *(.sbss) *(.scommon)
X   *(.dynbss)
X   *(.bss)
X   *(COMMON)
X  }
X  _end = . ;
X  PROVIDE (end = .);
X
X  /*
X   * For loader only: Put the zImage after everything else
X   */
X  _gzstart = . ;
X  .gzimage : { *(.gzimage) }
X  _gzend   = . ;
X
X  /*
X   * For loader only: Put the initrd after zImage
X   */
X  _rdstart = . ;
X  .rdimage : { *(.rdimage) }
X  _rdend   = . ;
X
}
SHAR_EOF
  $shar_touch -am 05060231100 'arch/ppc/mbxboot/vmlinux.lds' &&
  chmod 0644 'arch/ppc/mbxboot/vmlinux.lds' ||
  $echo 'restore of' 'arch/ppc/mbxboot/vmlinux.lds' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'arch/ppc/mbxboot/vmlinux.lds:' 'MD5 check failed'
5dfe86d647b2e619ecd80dc9b32c7c65  arch/ppc/mbxboot/vmlinux.lds
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'arch/ppc/mbxboot/vmlinux.lds'`"
    test 3415 -eq "$shar_count" ||
    $echo 'arch/ppc/mbxboot/vmlinux.lds:' 'original size' '3415,' 'current size' "$shar_count!"
  fi
fi
rm -fr _sh04766
exit 0


--
------------------\\----------------------\\----------------------------
Jon Diekema        |                       | Smiths Industries
(616) 241-8310     |                       | 3290 Patterson Avenue, SE
diekema_jon@si.com \\                      \\  Grand Rapids, MI 49512-1991

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
