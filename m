Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 251C0DDE03
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 14:06:25 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: Doug Maxey <dwm@enoyolf.org>
Subject: Re: Building ppc/powerpc kernel to run under QEMU.
Date: Sat, 12 May 2007 00:05:58 -0400
References: <200705092203.26042.rob@landley.net>
	<200705112146.35495.rob@landley.net>
	<14699.1178938857@bebe.enoyolf.org>
In-Reply-To: <14699.1178938857@bebe.enoyolf.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_m0TRGpAe05/ihpg"
Message-Id: <200705120005.58489.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_m0TRGpAe05/ihpg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 11 May 2007 11:00 pm, Doug Maxey wrote:
> > I'm told they've got that part working.  I once managed to get a powerpc 
> > Ubuntu ISO image to boot under qemu, I just can't _build_ a kernel that 
does.  
> > (I have no idea how to create the specially partitioned hard drive image 
it 
> > wants, and since I got 5 other architectures working without needing to do 
> > that, I'm looking for a way to make a prep kernel work so I won't have 
to.)
> 
> Have you tried to use parted (or fdisk) to set the first partition table
> entry as type 0x41?   I personally have no experience with qemu, but do
> fiddle with loading images with the real IBM firmware (a lot).  

Ok, backstory.

I have a cross-compile build system called Firmware Linux 
(http://landley.net/code/firmware).  It's a shell script that you run to 
build a system, entirely from source, for a given target platform.  
Cross-compile toolchain and all.

First it builds a cross compiler from source code (gcc, binutils, uClibc, and 
make headers_install from Linux), and then it does just enough 
cross-compiling with that to get you a minimal native build environment (a 
root filesystem containing uClibc, linux, busybox, gcc, binutils, make, and 
bash), so you can build natively under emulation from thereon in.  (MUCH 
easier than cross compiling.  Slower, but throwing hardware at the problem is 
easier than throwing engineers at it. I wrote a "why cross-compiling sucks" 
at http://landley.net/writing/docs/cross-compiling.html not that I have 
strong opinions on the topic or anything. :)

Anyway, I have this thing building a half-dozen archtectures already, and the 
ones I regularly test under are i686, x86-64, armv4l, and mipsel.  (Sparc's 
uClibc support is broken, and powerpc just DOESN'T LIKE ME.  I'm tackling the 
second first because I don't really care about sparc.)

All the other architectures (except sparc and powerpc) run under qemu.  I run 
the appropriate qemu variant with the "-kernel" command line option to use 
the built-in bootloader, and feed them an unpartitioned ext2 image containing 
the root filesystem, and all of 'em (except sparc and ppc) boot up to a shell 
prompt within the emulator and are capable of building and running "hello 
world".

There are idiosyncrasies.  (For example I have to feed arm a scsi hard drive 
instead of IDE, but that's just a different qemu command line.  And for some 
reason 2.6.21 broke arm's scsi support, this but worked in 2.6.20.)  But 
mostly, all the architectures work the same way.

Unfortunately, open hackware requires a partitioned hard drive image or it 
refuses to boot.  PREP looks enough like a paritioned image to fool the 
firmware into letting the built-in "-kernel" bootloader of qemu work.  None 
of the macintosh variants do.

> What I usually end up doing is dd'ing a bootloader into the appropriate
> sized 0x41 partition.  Am pretty sure no GPL stuff groks PREP partitions
> per se, other than seeing the part type.

With qemu I can go:

  qemu -kernel vmlinuzfile -hda walrus.img -nographic

And it'll load that kernel into memory and boot it, without it actually being 
anywhere in walrus.img.  On most platforms this bypasses the bios/firmware 
entirely, but apparently powerpc can't do this (due to the need to set up a 
fake hardware tree and pass it off to the kernel, or some such).  And the 
firmware is chock-full of built-in assumptions, and sits down and throws a 
tantrum if any of them are violated.

It's kind of annoying, really.  But if I could build a prep kernel, I could 
work around this.  Unfortunately, ARCH=ppc builds a prep kernel, but won't do 
a headers_install.  With ARCH=powerpc I can do a headers_installbuild a CHRP 
kernel that won't boot, but not a PREP kernel.

I could teach my build script to use one ARCH for headers_install and one for 
building the kernel, but that's amazingly ugly and I dont have to do it for 
any of the other architectures.

I could also write a wrapper to turn CHRP into a partitioned hard drive image, 
which looks like what I'm going to have to do.

> AIX stores its kernel in the PREP part, and boots from that partition
> (no bootloader, loads kernel directly).

That's what I'm trying to use, yeah.  ARCH=ppc does that, ARCH=powerpc does 
not.

The current mercurial version of Firmware Linux builds a CHRP kernel I can't 
boot.  One of my users donated a config that sort of builds a PREP kernel 
(attached), but you have to patch the ./cross-compiler.sh 
and ./mini-native.sh build scripts to feed in "powerpc" instead of $KARCH to 
headers_install.

Rob

--Boundary-00=_m0TRGpAe05/ihpg
Content-Type: text/plain;
  charset="iso-8859-1";
  name="powerpc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="powerpc"

KARCH=ppc
KERNEL_PATH=arch/ppc/boot/images/zImage.prep
GCC_FLAGS=
BINUTILS_FLAGS=
QEMU_TEST= #ppc
emulator_command()
{
  echo qemu-system-ppc -M prep -nographic -hda "$1" \
	-kernel "$2"
}

# Write out Linux kernel .config file

cat > "${WORK}"/miniconfig-linux << 'EOF'
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_SYSFS_DEPRECATED=y
CONFIG_RELAY=y
CONFIG_EMBEDDED=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_KMOD=y
CONFIG_BLOCK=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_ALTIVEC=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_BINFMT_ELF=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="rw init=/tools/bin/sh panic=1 PATH=/tools/bin root=/dev/hda console=ttyS0"
CONFIG_SECCOMP=y
CONFIG_ISA=y
CONFIG_ADVANCED_OPTIONS=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_LOGGING=y
CONFIG_ATA=y
CONFIG_SATA_AHCI=y
CONFIG_MD=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
CONFIG_SERIO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_HWMON=y
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TRIDENT=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_DNOTIFY=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_CONFIGFS_FS=y
CONFIG_SQUASHFS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_UTF8=y
EOF

# Write out uClibc .config file.
cat > "${WORK}"/miniconfig-uClibc << 'EOF'
TARGET_powerpc=y
ARCH_USE_MMU=y
UCLIBC_HAS_FLOATS=y
UCLIBC_HAS_FPU=y
DOPIC=y
HAVE_SHARED=y
LDSO_LDD_SUPPORT=y
LDSO_CACHE_SUPPORT=y
UCLIBC_STATIC_LDCONFIG=y
LDSO_RUNPATH=y
UCLIBC_CTOR_DTOR=y
UCLIBC_HAS_THREADS=y
LINUXTHREADS_OLD=y
UCLIBC_HAS_LFS=y
MALLOC_GLIBC_COMPAT=y
UCLIBC_DYNAMIC_ATEXIT=y
UCLIBC_SUSV3_LEGACY=y
UCLIBC_HAS_SHADOW=y
UCLIBC_HAS___PROGNAME=y
UNIX98PTY_ONLY=y
ASSUME_DEVPTS=y
UCLIBC_HAS_TM_EXTENSIONS=y
UCLIBC_HAS_TZ_CACHING=y
UCLIBC_HAS_TZ_FILE=y
UCLIBC_HAS_TZ_FILE_READ_MANY=y
UCLIBC_HAS_RPC=y
UCLIBC_HAS_STRING_GENERIC_OPT=y
UCLIBC_HAS_STRING_ARCH_OPT=y
UCLIBC_HAS_CTYPE_TABLES=y
UCLIBC_HAS_CTYPE_SIGNED=y
UCLIBC_HAS_STDIO_GETC_MACRO=y
UCLIBC_HAS_STDIO_PUTC_MACRO=y
UCLIBC_HAS_STDIO_AUTO_RW_TRANSITION=y
UCLIBC_HAS_ERRNO_MESSAGES=y
UCLIBC_HAS_SIGNUM_MESSAGES=y
UCLIBC_HAS_GNU_GETOPT=y
UCLIBC_HAS_GNU_GETSUBOPT=y
UCLIBC_HAS_REGEX=y
UCLIBC_HAS_REGEX_OLD=y
UCLIBC_HAS_FNMATCH=y
UCLIBC_HAS_FNMATCH_OLD=y
UCLIBC_HAS_GLOB=y
UCLIBC_HAS_GNU_GLOB=y
UCLIBC_BUILD_RELRO=y
UCLIBC_BUILD_NOEXECSTACK=y
DOSTRIP=y
EOF

--Boundary-00=_m0TRGpAe05/ihpg--
