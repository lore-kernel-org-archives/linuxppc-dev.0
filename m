Message-ID: <001d01c0d5c8$27ae8c60$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Wolfgang Denk" <wd@denx.de>, "Dan Malek" <dan@mvista.com>,
	"Cort Dougan" <cort@fsmlabs.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Uncompress Ok, but cannot run linux kernel...
Date: Sun, 6 May 2001 09:01:59 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001A_01C0D60B.357DE000"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_001A_01C0D60B.357DE000
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello:

    I have a 750-based custom board. I want to port linux-2.4.2 on it. The
bootrom code which initialized the hardware is working OK. I want to
download the linux kernel via TFTP(and it is OK now) and run it. But I met
some urgent problems ...
    I modified the bootloader codes according to arch/ppc/mbxboot/head.S and
other "printf" functions to suit my cases. And it runs like the following:

################################
Loading... 611056
Starting at 0x400000...

loaded at:     00400000 004952F0
zimage at:     004062C8 0048F994
avail ram:     004952F0 10000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
###################################

Then nothing happens(I have added a serial output code at the very begining
of arch/ppc/kernel/head.S and  have nothing output.). By printing the code
from 0x0 to 0x400000 I find the uncompressed code is right. After
uncompressing it jumps to 0x0(arch/ppc/mbxboot/head.S), but it cannot run .
Why?
Then I write a simple HelloWorld program  and compile it with -Ttext=0x0
compiling options, then use it to replace /usr/src/linux/vmlinux and
recompile the kernel.This time it works OK like the following:
################################
Loading... 4326
Starting at 0x400000...

loaded at:     ..........
zimage at:     ..........
avail ram:     ..........

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel

Hello world
###################################

Here I attach my .config and arch/ppc/mbxboot/head.S. Hope you can help me
if you are free.

Thank you very much.

machael thailer



------=_NextPart_000_001A_01C0D60B.357DE000
Content-Type: application/octet-stream;
	name="config"
Content-Disposition: attachment;
	filename="config"
Content-Transfer-Encoding: quoted-printable

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
# CONFIG_UID16 is not set=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
# CONFIG_EXPERIMENTAL is not set=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
# CONFIG_KMOD is not set=0A=
=0A=
#=0A=
# Platform support=0A=
#=0A=
CONFIG_PPC=3Dy=0A=
CONFIG_6xx=3Dy=0A=
# CONFIG_4xx is not set=0A=
# CONFIG_POWER3 is not set=0A=
# CONFIG_POWER4 is not set=0A=
# CONFIG_8xx is not set=0A=
# CONFIG_8260 is not set=0A=
CONFIG_ALL_PPC=3Dy=0A=
# CONFIG_APUS is not set=0A=
# CONFIG_PPC601_SYNC_FIX is not set=0A=
# CONFIG_SMP is not set=0A=
# CONFIG_ALTIVEC is not set=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
# CONFIG_HIGHMEM is not set=0A=
# CONFIG_MOL is not set=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_SBUS is not set=0A=
# CONFIG_MCA is not set=0A=
CONFIG_PCI=3Dy=0A=
CONFIG_NET=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_KCORE_ELF=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_KERNEL_ELF=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
CONFIG_PCI_NAMES=3Dy=0A=
# CONFIG_HOTPLUG is not set=0A=
# CONFIG_PCMCIA is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
# CONFIG_PPC_RTC is not set=0A=
CONFIG_PROC_DEVICETREE=3Dy=0A=
CONFIG_PPC_RTAS=3Dy=0A=
# CONFIG_BOOTX_TEXT is not set=0A=
# CONFIG_PREP_RESIDUAL is not set=0A=
# CONFIG_CMDLINE_BOOL is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
# CONFIG_PNP is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_LOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
# CONFIG_BLK_DEV_INITRD is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
# CONFIG_PACKET is not set=0A=
# CONFIG_NETLINK is not set=0A=
# CONFIG_NETFILTER is not set=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
# CONFIG_IP_MULTICAST is not set=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
CONFIG_IP_PNP=3Dy=0A=
# CONFIG_IP_PNP_BOOTP is not set=0A=
# CONFIG_IP_PNP_RARP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_INET_ECN is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
=0A=
#=0A=
#  =0A=
#=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# ATA/IDE/MFM/RLL support=0A=
#=0A=
# CONFIG_IDE is not set=0A=
# CONFIG_BLK_DEV_IDE_MODES is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
# CONFIG_DUMMY is not set=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_MACE is not set=0A=
# CONFIG_BMAC is not set=0A=
# CONFIG_GMAC is not set=0A=
# CONFIG_NCR885E is not set=0A=
# CONFIG_OAKNET is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_HP100 is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_APRICOT is not set=0A=
# CONFIG_TULIP is not set=0A=
# CONFIG_DE4X5 is not set=0A=
# CONFIG_DGRS is not set=0A=
CONFIG_EEPRO100=3Dy=0A=
# CONFIG_NATSEMI is not set=0A=
# CONFIG_NE2K_PCI is not set=0A=
# CONFIG_8139TOO is not set=0A=
# CONFIG_SIS900 is not set=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_SUNDANCE is not set=0A=
# CONFIG_TLAN is not set=0A=
# CONFIG_VIA_RHINE is not set=0A=
# CONFIG_WINBOND_840 is not set=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
# CONFIG_VGA_CONSOLE is not set=0A=
=0A=
#=0A=
# Frame-buffer support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Input core support=0A=
#=0A=
# CONFIG_INPUT is not set=0A=
=0A=
#=0A=
# Macintosh device drivers=0A=
#=0A=
# CONFIG_ADB_CUDA is not set=0A=
# CONFIG_ADB_PMU is not set=0A=
# CONFIG_MAC_FLOPPY is not set=0A=
# CONFIG_MAC_SERIAL is not set=0A=
# CONFIG_ADB is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
# CONFIG_VT is not set=0A=
CONFIG_SERIAL=3Dy=0A=
CONFIG_SERIAL_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_EXTENDED is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
# CONFIG_UNIX98_PTYS is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
# CONFIG_MOUSE is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
=0A=
#=0A=
# Game port support=0A=
#=0A=
=0A=
#=0A=
# Gameport joysticks=0A=
#=0A=
=0A=
#=0A=
# Serial port support=0A=
#=0A=
=0A=
#=0A=
# Serial port joysticks=0A=
#=0A=
=0A=
#=0A=
# Parallel port joysticks=0A=
#=0A=
=0A=
#=0A=
#   Parport support is needed for parallel port joysticks=0A=
#=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_INTEL_RNG is not set=0A=
# CONFIG_NVRAM is not set=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
# CONFIG_FAT_FS is not set=0A=
CONFIG_JFFS_FS_VERBOSE=3D0=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_RAMFS is not set=0A=
# CONFIG_ISO9660_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
CONFIG_NFS_FS=3Dy=0A=
# CONFIG_NFS_V3 is not set=0A=
CONFIG_ROOT_NFS=3Dy=0A=
# CONFIG_NFSD is not set=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
# CONFIG_SMB_NLS is not set=0A=
# CONFIG_NLS is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_KGDB is not set=0A=
# CONFIG_XMON is not set=0A=

------=_NextPart_000_001A_01C0D60B.357DE000
Content-Type: application/octet-stream;
	name="head.S"
Content-Disposition: attachment;
	filename="head.S"
Content-Transfer-Encoding: quoted-printable

#include "../kernel/ppc_defs.h"=0A=
#include "../kernel/ppc_asm.tmpl"=0A=
#include <asm/processor.h>=0A=
#include <asm/cache.h>=0A=
=0A=
	.text=0A=
=0A=
/*=0A=
 * $Id: head_750.S,v 1.1 2001/04/27 01:27:32 gujianxin Exp $=0A=
 *	=0A=
 * Boot loader philosophy:=0A=
 *=0A=
 *      ROM loads us to some arbitrary location=0A=
 *      ROM loads these registers:=0A=
 *	=0A=
 *          R3 =3D Pointer to the board configuration data=0A=
 *          R5 =3D Pointer to Open Firmware data 	=0A=
 *		 	=0A=
 *      ROM jumps to start/start_=0A=
 *      Move the boot code to the link address (4 MB)=0A=
 *      Call decompress_kernel()=0A=
 *         Relocate the initrd, zimage and residual data to 4 MB=0A=
 *         Decompress the kernel to 0=0A=
 *      Jump to the kernel entry=0A=
 *            -- Cort=0A=
 */=0A=
	.globl	start=0A=
start:=0A=
=0A=
	bl	start_=0A=
start_:=0A=
=0A=
	li 	r3,0x0=0A=
	li 	r5,0x0=0A=
=0A=
	mr	r11,r3		/* Save pointer to residual/board data */=0A=
	mr      r25,r5          /* Save OFW pointer */=0A=
	li	r3,MSR_IP	/* Establish default MSR value */=0A=
	mtmsr	r3=0A=
=0A=
/* check if we need to relocate ourselves to the link addr or were we=0A=
   loaded there to begin with -- Cort */=0A=
	lis	r4,start@h=0A=
	ori	r4,r4,start@l=0A=
	mflr	r3=0A=
	subi	r3,r3,4		/* we get the nip, not the ip of the branch */=0A=
	mr	r8,r3=0A=
	cmp	0,r3,r4=0A=
	bne	1010f=0A=
/* compute size of whole image in words.  this should be moved to=0A=
 * start_ldr() -- Cort=0A=
 */=0A=
	lis	r4,start@h=0A=
	ori	r4,r4,start@l=0A=
	lis	r5,end@h=0A=
	ori	r5,r5,end@l=0A=
	addi	r5,r5,3		/* round up */=0A=
	sub	r5,r5,r4=0A=
	srwi	r5,r5,2=0A=
	mr	r7,r5=0A=
	b	start_ldr=0A=
1010:=0A=
/* =0A=
 * no matter where we're loaded, move ourselves to -Ttext address=0A=
 */=0A=
relocate:=0A=
	mflr	r3		/* Compute code bias */=0A=
	subi	r3,r3,4=0A=
	mr	r8,r3=0A=
	lis	r4,start@h=0A=
	ori	r4,r4,start@l=0A=
	lis	r5,end@h=0A=
	ori	r5,r5,end@l=0A=
	addi	r5,r5,3			/* Round up - just in case */=0A=
	sub	r5,r5,r4		/* Compute # longwords to move */=0A=
	srwi	r5,r5,2=0A=
	mtctr	r5=0A=
	mr	r7,r5=0A=
	li	r6,0=0A=
	subi	r3,r3,4			/* Set up for loop */=0A=
	subi	r4,r4,4=0A=
00:	lwzu	r5,4(r3)=0A=
	stwu	r5,4(r4)=0A=
	xor	r6,r6,r5=0A=
	bdnz	00b=0A=
  	lis	r3,start_ldr@h=0A=
	ori	r3,r3,start_ldr@l=0A=
	mtlr	r3			/* Easiest way to do an absolute jump */=0A=
	blr=0A=
start_ldr:=0A=
/* Clear all of BSS */=0A=
	lis	r3,edata@h=0A=
	ori	r3,r3,edata@l=0A=
	lis	r4,end@h=0A=
	ori	r4,r4,end@l=0A=
	subi	r3,r3,4=0A=
	subi	r4,r4,4=0A=
	li	r0,0=0A=
50:	stwu	r0,4(r3)=0A=
	cmp	0,r3,r4=0A=
	bne	50b=0A=
90:	mr	r9,r1			/* Save old stack pointer (in case it matters) */=0A=
	lis	r1,.stack@h=0A=
	ori	r1,r1,.stack@l=0A=
	addi	r1,r1,4096*2=0A=
	subi	r1,r1,256=0A=
	li	r2,0x000F		/* Mask pointer to 16-byte boundary */=0A=
	andc	r1,r1,r2=0A=
=0A=
	/* Speed us up a little.=0A=
	*/=0A=
	bl	flush_instruction_cache=0A=
=0A=
/* Run loader */=0A=
	mr	r3,r8			/* Load point */=0A=
	mr	r4,r7			/* Program length */=0A=
	mr	r5,r6			/* Checksum */=0A=
	mr	r6,r11			/* Residual data */=0A=
	mr      r7,r25                  /* OFW interfaces */=0A=
	bl	decompress_kernel=0A=
=0A=
	=0A=
	=0A=
	/* changed to use r3 (as firmware does) for kernel=0A=
	   as ptr to residual -- Cort*/=0A=
	lis	r6,cmd_line@h=0A=
	ori	r6,r6,cmd_line@l=0A=
	lwz	r6, 0(r6)=0A=
	subi	r7,r6,1=0A=
00:	lbzu	r2,1(r7)=0A=
	cmpi	0,r2,0=0A=
	bne	00b=0A=
=0A=
	/* r4,r5 have initrd_start, size */=0A=
	lis	r2,initrd_start@h=0A=
	ori	r2,r2,initrd_start@l=0A=
	lwz	r4,0(r2)=0A=
	lis	r2,initrd_end@h=0A=
	ori	r2,r2,initrd_end@l=0A=
	lwz	r5,0(r2)=0A=
	=0A=
	/* tell kernel we're prep */=0A=
	/* =0A=
	 * get start address of kernel code which is stored as a coff=0A=
	 * entry.  see boot/head.S -- Cort =0A=
	 */=0A=
	li	r9,0x4=0A=
	mtlr	r9=0A=
	lis	r10,0xdeadc0de@h=0A=
	ori	r10,r10,0xdeadc0de@l=0A=
	li	r9,0=0A=
	stw	r10,0(r9)=0A=
=0A=
=0A=
#if 1	 =0A=
/*=0A=
 * The Radstone firmware maps PCI memory at 0xc0000000 using BAT2=0A=
 * so disable BATs before setting this to avoid a clash=0A=
 */=0A=
	li      r8,0=0A=
	mtspr   DBAT0U,r8=0A=
	isync=0A=
	mtspr   DBAT0L,r8=0A=
	isync=0A=
	mtspr   DBAT1U,r8=0A=
	isync=0A=
	mtspr   DBAT1L,r8=0A=
	isync=0A=
	mtspr   DBAT2U,r8=0A=
	isync=0A=
	mtspr   DBAT2L,r8=0A=
	isync=0A=
	mtspr   DBAT3U,r8=0A=
	isync=0A=
	mtspr   DBAT3L,r8=0A=
	isync=0A=
	mtspr   IBAT0U,r8=0A=
	isync=0A=
	mtspr   IBAT0L,r8=0A=
	isync=0A=
	mtspr   IBAT1U,r8=0A=
	isync=0A=
	mtspr   IBAT1L,r8=0A=
	isync=0A=
	mtspr   IBAT2U,r8=0A=
	isync=0A=
	mtspr   IBAT2L,r8=0A=
	isync=0A=
	mtspr   IBAT3U,r8=0A=
	isync=0A=
	mtspr   IBAT3L,r8=0A=
	isync=0A=
=0A=
    xor	    r0,r0,r0		=0A=
    mfspr   r8,HID0=0A=
    sync=0A=
    addi    r9,r0,0x0800=0A=
    or      r8,r9,r8=0A=
    mtspr   HID0,r8         /* set ICFI (bit 20) */=0A=
    sync=0A=
=0A=
    andc    r8,r8,r9=0A=
    mtspr   HID0,r8         /* clear ICFI (bit 20) */=0A=
    sync=0A=
=0A=
    addi    r9,r0,0x2000    /* Clear ILOCK (bit 18) (instr sign extends) =
*/=0A=
    andc     r8,r8,r9 =0A=
    mtspr   HID0,r8=0A=
    sync=0A=
=0A=
    addi    r9,r0,0x7fff   =0A=
    and     r8,r8,r9    /* CLear ICE (bit 16) */=0A=
    mtspr   HID0,r8=0A=
    sync=0A=
#endif    =0A=
=0A=
=0A=
	blr=0A=
hang:=0A=
	b	hang	=0A=
=0A=
/*=0A=
 * Delay for a number of microseconds=0A=
 * -- Use the BUS timer (assumes 66MHz)=0A=
 */=0A=
	.globl	udelay=0A=
udelay:		=0A=
	mfspr	r4,PVR=0A=
	srwi	r4,r4,16=0A=
	cmpi	0,r4,1		/* 601 ? */=0A=
	bne	.udelay_not_601=0A=
00:	li	r0,86	/* Instructions / microsecond? */=0A=
	mtctr	r0=0A=
10:	addi	r0,r0,0 /* NOP */=0A=
	bdnz	10b=0A=
	subic.	r3,r3,1=0A=
	bne	00b=0A=
	blr=0A=
=0A=
.udelay_not_601:		=0A=
	mulli	r4,r3,1000	/* nanoseconds */=0A=
	addi	r4,r4,59=0A=
	li	r5,60=0A=
	divw	r4,r4,r5	/* BUS ticks */=0A=
1:	mftbu	r5=0A=
	mftb	r6=0A=
	mftbu	r7=0A=
	cmp	0,r5,r7=0A=
	bne	1b		/* Get [synced] base time */=0A=
	addc	r9,r6,r4	/* Compute end time */=0A=
	addze	r8,r5=0A=
2:	mftbu	r5=0A=
	cmp	0,r5,r8=0A=
	blt	2b=0A=
	bgt	3f=0A=
	mftb	r6=0A=
	cmp	0,r6,r9=0A=
	blt	2b=0A=
3:	blr		=0A=
=0A=
.globl _get_HID0=0A=
_get_HID0:		=0A=
	mfspr	r3,HID0=0A=
	blr=0A=
=0A=
.globl _put_HID0=0A=
_put_HID0:		=0A=
	mtspr	HID0,r3=0A=
	blr=0A=
		=0A=
.globl _get_MSR=0A=
_get_MSR:		=0A=
	mfmsr	r3=0A=
	blr=0A=
	=0A=
.globl _put_MSR=0A=
_put_MSR:		=0A=
	mtmsr	r3=0A=
	blr=0A=
=0A=
/*=0A=
 * Flush instruction cache=0A=
 * *** I'm really paranoid here!=0A=
 */=0A=
_GLOBAL(flush_instruction_cache)=0A=
	mflr	r5=0A=
	bl	flush_data_cache=0A=
	mfspr	r3,HID0	/* Caches are controlled by this register */=0A=
	li	r4,0=0A=
	ori	r4,r4,(HID0_ICE|HID0_ICFI)=0A=
	or	r3,r3,r4	/* Need to enable+invalidate to clear */=0A=
	mtspr	HID0,r3=0A=
	andc	r3,r3,r4=0A=
	ori	r3,r3,HID0_ICE	/* Enable cache */=0A=
	mtspr	HID0,r3=0A=
	mtlr	r5=0A=
	blr=0A=
	=0A=
#define NUM_CACHE_LINES 128*8=0A=
#define CACHE_LINE_SIZE 32 =0A=
#define cache_flush_buffer 0x1000=0A=
=0A=
/*=0A=
 * Flush data cache=0A=
 * *** I'm really paranoid here!=0A=
 */=0A=
_GLOBAL(flush_data_cache)=0A=
	lis	r3,cache_flush_buffer@h=0A=
	ori	r3,r3,cache_flush_buffer@l=0A=
	li	r4,NUM_CACHE_LINES=0A=
	mtctr	r4=0A=
00:	lwz	r4,0(r3)=0A=
	addi	r3,r3,CACHE_LINE_SIZE	/* Next line, please */=0A=
	bdnz	00b	=0A=
10:	blr=0A=
	.comm	.stack,4096*2,4=0A=

------=_NextPart_000_001A_01C0D60B.357DE000--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
