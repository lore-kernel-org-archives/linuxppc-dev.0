From: Subodh Nijsure <subodh@best.com>
Message-Id: <200101032042.MAA17739@shell9.ba.best.com>
Subject: Booting linux kernel.
To: linuxppc-embedded@lists.linuxppc.org
Date: Wed, 3 Jan 2001 12:42:19 -0800 (PST)
Cc: subodh@best.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a custom 860T based board for which I have ppcboot 0.7,  register
values for BRx and ORx are at the end of the e-mail.

I have built montavista 2.4-test2 kernel and ramdisk that I downloaded from
Wolfgan Denk's ftp site, a loaded them using tftp at 0x00100000 and 0x00190000.


CXE-BOOTROM=>bootm 00100000 00190000
## Booting Linux kernel at 00100000 ...
   Image Name:   2.4.0-test2 @ Wed Jan  3 09:59:1
   Image Type:   PowerPC Linux Kernel Image (uncompressed)
   Data Size:    430976 Bytes = 420 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
## Loading RAMDisk Image at 00190000 ...
   Image Name:   Simple Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    507630 Bytes = 495 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 03ec3000, end 03f3eeee ... OK
## Transferring control to Linux (at address 00000000) ...
My board's config file used when building ppcboot has following SMC and FEC
configuration.

#define CONFIG_8xx_CONS_SMC1    1 /* Console is on SMC1     */
#undef  CONFIG_8xx_CONS_SMC2
#undef  CONFIG_8xx_CONS_NONE
#define CONFIG_BAUDRATE     9600
#define CONFIG_LOADS_ECHO   1   /* echo on for serial download  */

/* choose SCC1 ethernet (10BASET on motherboard)
 * or FEC ethernet (10/100 on daughterboard)
 */
#undef  CONFIG_SCC1_ENET    0   /* use SCC1 ethernet */
#define CONFIG_FEC_ENET     1   /* disable FEC ethernet  */
#define CFG_DISCOVER_PHY


When I boot the kernel don't see anything on the console, I have the
boardinfo structure below.

I guess simple question is how do I go about debugging this problem?

My System.map has log_buf address as 0xc010f314 and memory dump at
0x0010f314 is shown below.

System.map dump -->
	c010eb14 b buf.498
	c010ef14 b buf
	c010f314 b log_buf

CXE-BOOTROM=>md 0x0010f314
00000000: 1f8b0808 5068533a 0203766d 6c696e75    ....PhS:..vmlinu
00000010: 7800e45b 0b705465 963efd00 3bd0436e    x..[.pTe.>..;.Cn
00000020: 206020c0 a804298e f6a43220 3bb749a7     ` ...)...2 ;.I.
00000030: d321bdbb 2d896ec4 0e618091 8e093b60    .!..-.n..a....;`
00000040: a21311d6 eb72bbfb 76929965 5777a693    .....r..v..eWw..
00000050: 0e2ea541 3a84f4c2 0c33131e 7115c8d0    ...A:....3..q...
00000060: 809382d2 aa45475c c7f10185 16b8ee23    .....EG\.......#
00000070: 2a2cac3c 7abf73fb 36344800 775787aa    *,.<z.s.64H.wW..
00000080: a4eaafff ffcf3dff 39e73be7 fccf2472    ......=.9.;...$r
00000090: 3057925f b85d92fb ef96e477 6748f2d9    0W._.].....wgH..
000000a0: 62a99888 64d27f68 47ed17f6 c74ac848    b...d..hG....J.H
000000b0: 4b4c02f9 73b81da7 5a939efc e3f6c7fc    KL..s...Z.......
000000c0: b9fb63e0 31d79a48 e71f8ffe 14eeebce    ..c.1..H........
000000d0: fb27a03d 95795de4 1f8bf624 14e773b1    .'.=.y]....$..s.
000000e0: 950509c5 6fad90d4 f1e96331 2e49d725    ....o.....c1.I.%
000000f0: 92e3ccd0 fb74cc9f f334da7a b55d423a    .....t...4.z.]B:



Only tools I have is ppc_8xx-gdb and the Macraigor wiggler to which I
can connect using rproxy. Is there a better tool that I should acquire
that will help me in debugging this?

Any help will be much appreciated!

Thanks.
/Subodh Nijsure



------------------Boardinfo-----------
typedef void (interrupt_handler_t)(void *);
typedef struct monitor_functions
{
  int (*getc) (void);
  int (*tstc) (void);
  void (*putc) (const char c);
  void (*puts) (const char *s);
  void (*printf) (const char *fmt, ...);
  void (*install_hdlr) (int, interrupt_handler_t *, void *);
  void (*free_hdlr) (int);
  void *(*malloc) (size_t);
  void (*free) (void *);
} mon_fnc_t;

/* A Board Information structure that is given to a program when
 * prom starts it up.
 */
typedef struct bd_info
{
  unsigned long bi_memstart;    /* start of  DRAM memory        */
  unsigned long bi_memsize; /* size  of  DRAM memory in bytes   */
  unsigned long bi_flashstart;  /* start of FLASH memory        */
  unsigned long bi_flashsize;   /* size  of FLASH memory        */
  unsigned long bi_flashoffset; /* reserved area for startup monitor    */
  unsigned long bi_sramstart;   /* start of  SRAM memory        */
  unsigned long bi_sramsize;    /* size  of  SRAM memory        */
  unsigned long bi_immr_base;   /* base of IMMR register        */
  unsigned long bi_bootflags;   /* boot / reboot flag (for LynxOS)  */
  unsigned long bi_ip_addr; /* IP Address               */
  unsigned char bi_enetaddr[6]; /* Ethernet adress          */
  unsigned short bi_ethspeed;   /* Ethernet speed in Mbps       */
  unsigned long bi_intfreq; /* Internal Freq, in MHz        */
  unsigned long bi_busfreq; /* Bus Freq, in MHz         */
  unsigned long bi_baudrate;    /* Console Baudrate         */
  mon_fnc_t *bi_mon_fnc;    /* Pointer to monitor functions     */
} bd_t;
----------------------------------------------------------------------

-----ppcbootinfo------------------------------------------------
ppcboot 0.7.1 (Dec 29 2000 - 15:42:45)
Initializing...
  CPU:   XPC860xxZPnnD3 at 48 MHz: 16 kB I-Cache 8 kB D-Cache FEC present
  Board:   SRAM:  64 MB
  Relocating to: 03fa0000, 393216 bytes for malloc()
  Board Info at: 03f3ffc0
  Chip is post RevD
  New Stack Pointer is: 03f3ff40
  Now running in RAM - dest_addr = 0x03fa0000
  FLASH:  4 MB
*** Warning - bad CRC, using default environment

  Monitor relocated to 0x03fa0000
  Input:  serial
  Output: serial
CXE-BOOTROM=>reginfo

System Configuration registers
        IMMR    0XFF000501
        SIUMCR  0X1600400       SYPCR   0XFFFFFF89
        SWT     0XFFFF0000      SWSR    0X0
        SIPEND  0X20000 SIMASK  0X4000000
        SIEL    0X0     SIVEC   0X3C000000
        TESR    0X0     SDCR    0X1
Memory Controller Registers
        BR0     0X28000001      OR0     0XFFC00742
        BR1     0X40020001      OR1     0XFFFF07F2
        BR2     0X40040001      OR2     0XFFFC07F2
        BR3     0X40000C1       OR3     0XFC000A00
        BR4     0X0     OR4     0X0
        BR5     0XC1    OR5     0XFC000A00
        BR6     0X0     OR6     0X0
        BR7     0X40000801      OR7     0XFFFF8750

        mamr    0X67001000      mbmr    0X18964114
        mstat   0X0     mptpr   0X400
        mdr     0XFFFFFFFF

System Integration Timers
        TBSCR   0X1     RTCSC   0X11
        PISCR   0X2

CXE-BOOTROM=>bdinfo
  memstart    = 0x00000000
  memsize     = 0x04000000
  flashstart  = 0x02800000
  flashsize   = 0x00400000
  flashoffset = 0x00060000
  sramstart   = 0x00000000
  sramsize    = 0x00000000
  immr_base   = 0xff000000
  bootflags   = 0x00000001
  intfreq     =     48 MHz
  busfreq     =     48 MHz
  ethaddr     = 00:C1:4F:1E:BF:80
  IP addr     =192.168.4.41
  baudrate    =   9600 bps
  getc        = 0x03fae2b0
  tstc        = 0x03fae2e8
  putc        = 0x03fae220
  puts        = 0x03fae308
  printf      = 0x03fa9d3c
  install_hdlr= 0x03faebcc
  free_hdlr   = 0x03faec54
  malloc      = 0x03fa8708
  free        = 0x03fa8c70

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
