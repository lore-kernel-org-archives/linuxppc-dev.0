Message-ID: <006601c35cae$1d869510$960aa8c0@ksshin>
From: =?ks_c_5601-1987?B?vcWw5rz2?= <ksshin@essetel.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel stack overflow
Date: Thu, 7 Aug 2003 15:35:37 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, everyone.
I have a board based with mpc7410 + gt64260
and I try to port linux to that board.
I use ppcboot-2.0.0 and kernel is from
montavista 2.4.18(LSP Name is EVB64260 based on 750)

I commented MMU_init()->MMU_init_hw()->cacheable_memzero()
because the board died when run that function...
after that when run start_kernel()->sti(), then
the message is below.

I don't know why.
do you have any solutions?

> bootm
 [KSSHIN] do_bootm() start
 [KSSHIN] boot progress : 1
## Booting image at 01000000 ...
 [KSSHIN] boot progress : 2
 [KSSHIN] boot progress : 3
   Image Name:   2.4.18 for MPC7410+GT64260 Board
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    836430 Bytes = 816.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
 [KSSHIN] boot progress : 4
 [KSSHIN] boot progress : 5
 [KSSHIN] boot progress : 6
   Uncompressing Kernel Image ... OK
 [KSSHIN] boot progress : 7
 [KSSHIN] boot progress : 8
 [KSSHIN] do_bootm_linux() start
## Current stack ends at 0x07F7FB70 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF0D
memstart    = 0x00000000
memsize     = 0x08000000
flashstart  = 0xFF800000
flashsize   = 0x00800000
flashoffset = 0x00000000
sramstart   = 0x40000000
sramsize    = 0x00010000
bootflags   = 0x00000001
intfreq     =    399 MHz
busfreq     =    133 MHz
ethaddr     = 00:11:22:33:44:55
IP addr     = 192.168.10.198
baudrate    =  38400 bps
 [KSSHIN] boot progress : 14
No initrd
## Transferring control to Linux (at address 00000000) ...
 [KSSHIN] boot progress : 15
 [KSSHIN] do_bootm_linux() end
 kernel : 0x00000000
 kbd : 0x007ffeb0
 initrd_start : 0x00000000, initrd_end : 0x00000000
 cmd_start : 0x007fff00, cmd_end : 0x007fff0d
 cmd : root=/dev/nfs
abcdMd mach(): done
MMU:enter
MMU_setup
ppcboot_bd_valid is valid
MMU:hw init
hash:enter
hash:find piece - 2
hash:find piece - 3
hash:patch
hash:done
MMU:mapin
MMU:setio
MMU:exit
start_kernel
start_kernel ...
start_kernel - 1
setup_arch: enter
setup_arch: bootmem
ev64260_setup_arch: enter
ev64260_setup_arch: Enabling L2 cache - not
ev64260_setup_arch: Initializing bridge
ev64260_setup_arch: bridge init complete
ll_mpsc_init: enter
Esse 7410+64260
MontaVista linux 2.4.18_mvl30
ev64260_setup_arch: exit
arch: exit
paging_init:enter
free_area_init_core:enter
free_area_init_core:run - 1
free_area_init_core:run - 2
paging_init:exit
start_kernel - 2
gt64260_init_irq: enter
gt64260_init_irq: GPP -> levelint
gt64260_init_irq: exit
start_kernel - 3
start_kernel - 4
start_kernel - 5
gt64260_mpsc_console_init: enter
gt_console_setup: enter
gt_console_setup: exit
found bd_t @c07ffeb0
memstart=00000000
memsize=08000000
enetaddr=001122334455
intfreq=399000000
busfreq=133000000
baudrate=38400
found cmdline: 'root=/dev/nfs'
Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
Total memory = 128MB; using 256kB for hash table (at c0240000)
rtsched version <20011203.1609.50>
gt64260_mpsc_console_init: exit
 kmem_cache_init() is end in start_kernel !!
Kernel stack overflow in process c018d420, r1=c018d830
Kernel stack overflow in process c018d420, r1=c018d830
Kernel stack overflow in process c018d420, r1=c018d830
Kernel stack overflow in process c018d420, r1=c018d830
Kernel stack overflow in process c018d420, r1=c018d830
Kernel stack overflow in process c018d420, r1=c018d830
Kernel stack overflow in process c018d420, r1=c018d830
Kernel stack overflow in process c018d420, r1=c018d830
...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
