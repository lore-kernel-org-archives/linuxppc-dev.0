Return-Path: <rdcorle@yahoo.com>
Received: from web56311.mail.re3.yahoo.com (web56311.mail.re3.yahoo.com
	[216.252.110.235]) by ozlabs.org (Postfix) with SMTP id B913067B5B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 08:32:17 +1000 (EST)
Message-ID: <20061023223215.55404.qmail@web56311.mail.re3.yahoo.com>
Date: Mon, 23 Oct 2006 15:32:15 -0700 (PDT)
From: robert corley <rdcorle@yahoo.com>
Subject: xapp902 with 2.6.17 -- uartlite & ramdisk problems
To: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All;=0A=0AAs the below shows, the ramdisk problem has been circumvented by =
use of the cmdline option ramdisk_size=3D4660000.=0A=0AStill experience ter=
ribly slow uart.  Can anyone quickly point me to the appropriate interrupt =
components for the uartlite et al?=0A=0ASome other questions:=0A=0A1.   Are=
 interrupts obtained via the platform_get_resource() call?=0A2.   Are alloc=
ated interrupts issued starting at 0?=0A3.    Is there a correlation betwee=
n the xparameters_ml403.h entries below and the interrupt issued in 1, abov=
e?=0A=0A#define XPAR_PLB_TEMAC_0_IP2INTC_IRPT_MASK         0X000001=0A#defi=
ne XPAR_OPB_INTC_0_PLB_TEMAC_0_IP2INTC_IRPT_INTR     0=0A#define XPAR_XUL_U=
ART_INTERRUPT_MASK             0X000002=0A#define XPAR_OPB_INTC_0_XUL_UART_=
INTERRUPT_INTR     1=0A=0A#define XPAR_INTC_0_TEMAC_0_VEC_ID     XPAR_OPB_I=
NTC_0_PLB_TEMAC_0_IP2INTC_IRPT_INTR=0A#define XPAR_INTC_0_UARTLITE_0_VEC_ID=
     XPAR_OPB_INTC_0_XUL_UART_INTERRUPT_INTR=0A=0AThanks in advance for any=
ones help.=0A=0A-cy=0A=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0A[    0.000000] Linux version 2.6.17.1 (rdcorle@athena) (gcc version 3.4.=
2) #4 Mon Oct 23 19:47:51 UTC 2006=0A[    0.000000] Xilinx ML403 Reference =
System (Virtex-4 FX)=0A[    0.000000] Built 1 zonelists=0A[    0.000000] Ke=
rnel command line: console=3DttyUL0 single ip=3Doff ramdisk_size=3D4660000 =
root=3D/dev/ram rw=0A[    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to =
0xFDFFFFC0=0A[    0.000000] PID hash table entries: 512 (order: 9, 2048 byt=
es)=0A[    0.000151] Console: colour dummy device 80x25=0A[    0.000560] De=
ntry cache hash table entries: 8192 (order: 3, 32768 bytes)=0A[    0.001270=
] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)=0A[    0.013=
923] Memory: 58572k available (1348k kernel code, 344k data, 80k init, 0k h=
ighmem)=0A[    0.200437] Mount-cache hash table entries: 512=0A[    0.20311=
9] checking if image is initramfs...it isn't (no cpio magic); looks like an=
 initrd=0A[    2.505388] Freeing initrd memory: 4549k freed=0A[    2.509461=
] NET: Registered protocol family 16=0A[    2.518975] NET: Registered proto=
col family 2=0A[    2.583987] IP route cache hash table entries: 512 (order=
: -1, 2048 bytes)=0A[    2.584462] TCP established hash table entries: 2048=
 (order: 3, 32768 bytes)=0A[    2.584931] TCP bind hash table entries: 1024=
 (order: 2, 20480 bytes)=0A[    2.585217] TCP: Hash tables configured (esta=
blished 2048 bind 1024)=0A[    2.585251] TCP reno registered=0A[    2.59163=
8] io scheduler noop registered=0A[    2.591747] io scheduler anticipatory =
registered (default)=0A[    2.591902] io scheduler deadline registered=0A[ =
   2.592039] io scheduler cfq registered=0A[    2.637280] serial irq #1 obt=
ained from platform=0A[    2.637397] uartlite.0: ttyUL0 at MMIO 0xa0000000 =
(irq =3D 1) is a uartlite=0A[   42.667249] RAMDISK driver initialized: 16 R=
AM disks of 4660000K size 1024 blocksize=0A[   44.738763] eth%d: XTemac usi=
ng sgDMA mode.=0A[   45.866885] eth%d: XTemac buffer_descriptor_space: phy:=
 0xbb8000, virt: 0xff100000, size: 0x5000=0A[   48.220095] eth0: Xilinx TEM=
AC #0 at 0x60000000 mapped to 0xC5008000, irq=3D0=0A[   50.084940] mice: PS=
/2 mouse device common for all mice=0A[   51.489111] TCP bic registered=0A[=
   52.319241] RAMDISK: Compressed image found at block 0=0A[   56.598970] V=
FS: Mounted root (ext2 filesystem).=0A[   57.842088] Freeing unused kernel =
memory: 80k init=0A=0A=0ABusyBox v1.00-pre9 (2004.04.18-19s# =0A=0A=0A
