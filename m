From: "Etienne van der Linde" <evdl@ananzi.co.za>
Subject: CPM UART Driver failing with kernel 2.4.20
To: linuxppc-embedded@lists.linuxppc.org
Cc: evdl@ananzi.co.za
Date: Wed, 17 Mar 2004 19:41:52 +0200
Message-ID: <web-19386629@mail01.ananzi.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I used the Denx ELDK with kernel 2.4.2 for a custom MPC8260
board, but ran into some problems during the final stages
of booting. Thus on your recommendation (Wolfgang Denk) I
spent the last few day upgrading to kernel 2.4.20. which
obviously introduced its own issues. Well the major one
that I can't get rid of is the following;
The preliminary UART setup works fine, but when the final
CPM UART driver gets loaded / registered / enabled, my
console dies. Here is the output:

#######################################################
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    591672 Bytes = 577.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x00F79948 => set upper limit to
0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF79
No initrd
## Transferring control to Linux (at address 00000000) ...
Memory BAT mapping: BAT2=16Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.20 (root@infineon.parsec) (gcc version
2.95.4 20010319 (prerelease/franzo/20011204)) #97 Tue Mar
164On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=172.17.5.125:/predator
ip=172.17.5.238:172.17.5.125:172.17.0.1:255.255.1Warning:
real time clock seems stuck!
Calibrating delay loop... 175.71 BogoMIPS
Memory: 14652k available (1076k kernel code, 396k data, 56k
init, 0k highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384
bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG2

#######################################################

 that's it - that is where it stops, where as my old Kernel
2.4.2 (with CPM UART driver version 0.02) worked perfectly
fine. Well in an effort to fix this I spent some time
integrating the old driver into the new kernel, but that
did not fix the problem.

Here are the important configuration parts of my uart.c;

#######################################################

#define CONFIG_SERIAL_CONSOLE_PORT	0

....

#define SCC_NUM_BASE	1	/* SCC base tty "number" */
#define SCC_IDX_BASE	0	/* table index */
static struct serial_state rs_table[] = {
	/* UART CLK   PORT          IRQ      FLAGS  NUM   */
	{ 0,     0, PROFF_SCC1, SIU_INT_SCC1,   0, SCC_NUM_BASE},
   /* SCC1 ttyS0 */
	{ 0,     0, PROFF_SCC2, SIU_INT_SCC2,   0,
SCC_NUM_BASE+1},    /* SCC2 ttyS1 */
};

static int rs_brg_map[] = {0,0};

.....


int __init rs_8xx_init(void)
{

.....

/* TX = PB28 */
	io->iop_pparb |= 0x00000008;
	io->iop_psorb |= 0x00000008;
	io->iop_pdirb |= 0x00000008;
/* RX = PD31 */
	io->iop_ppard |= 0x00000001;
	io->iop_psord &= ~0x00000001;
	io->iop_pdird &= ~0x00000001;

	/* Connect SCC1, SCC2, SCC3 to NMSI.  Connect BRG1 to
SCC1,
	 * BRG2 to SCC2, BRG3 to SCC3.
	 */

	immap->im_cpmux.cmx_scr &= ~0xffffff00;
	immap->im_cpmux.cmx_scr |= 0x00091200;

......

#######################################################

Has anybody ever encountered this / can anyone give me a
hint of what might cause this. Any help will be appreciated
at this stage...

Regards
Etienne


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
