Message-Id: <4.3.2.20001006133423.00b74100@falcon.si.com>
Date: Fri, 06 Oct 2000 13:59:32 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Ethernet Trouble
In-Reply-To: <1.5.4.32.20001006155653.006b24d4@pop.esteem.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Get ethereal (ethernet sniffer) and listen in to your ethernet.  You
can find problems very quickly by watching what packets get sent, what
is in them, and how the server responds.

http://ethereal.zing.org/

The packet filtering interface is pretty funky until you figure it
out.  I generally have one per target machine (i.e. the host being
debugged).  Set the filter name to the host name and the filter string
to "host w.x.y.z" (no quotes, use the proper IP address for w.x.y.z) to
capture all packets going to or from the given host.

Cliff Notes:
* Click "Capture"
* In the capture dialog, click "Filter"
* Fill in the host name and the "host w.x.y.z" strings in the filter dialog
* Click "New"
Now you should be ready to capture.  The "filter" line will be filled
in with "host w.x.y.z" and the filter will be saved for next time you
need to use it.

Incidentally, you have to be root to sniff packets.

gvb


At 08:56 AM 10/6/00 -0700, clark@esteem.com wrote:

>Hello All,
>
>         I am trying to port the networking portion of linux to work
> with our
>board. Our board uses a MPC850 and SCC2 as its ethernet interface ( almost
>identical to the rpxlite ).
>
>  Port A, bit 13 - SCC2 Ethernet Rx
>  Port A, bit 12 - SCC2 Ethernet Tx
>  Port A, bit  6 (CLK2) - Ethernet Tx Clk
>  Port A, bit  4 (CLK4) - Ethernet Rx Clk
>  Port B, bit 18 (RTS2) - Ethernet Tx Enable
>*Port B, bit 17 - Ethernet Loopback Enable
>*Port B, bit 16 - Ethernet Full Duplex Disable
>  Port C, bit  8 (CD2) - Ethernet Rx Enable
>  Port C, bit  9 (CTS2) - SCC Ethernet Collision
>
>* Differs from rpxlite
>
>
>         I am using ppcboot for our boot rom and compile the kernel
> targeting
>a MBX board. I have modified the mbx.h file with a customized board info
>structure to work with ppcboot. I have also stuck a #define ESTEEM192E
>so I
>could stick my mods within the #ifdef CONFIG_MBX contained in the
>kernel as
>needed. The only mods I think I need to make are in commproc.h and
>enet.c. I
>have made them as follows...
>
>from /arch/ppc/m8xx_io/commproc.h
>
>Code was this ........
>
>#ifdef CONFIG_MBX
>/* Bits in parallel I/O port registers that have to be set/cleared
>  * to configure the pins for SCC1 use.  The TCLK and RCLK seem unique
>  * to the MBX860 board.  Any two of the four available clocks could be
>  * used, and the MPC860 cookbook manual has an example using different
>  * clock pins.
>  */
>#define PA_ENET_RXD     ((ushort)0x0001)
>#define PA_ENET_TXD     ((ushort)0x0002)
>#define PA_ENET_TCLK    ((ushort)0x0200)
>#define PA_ENET_RCLK    ((ushort)0x0800)
>#define PC_ENET_TENA    ((ushort)0x0001)
>#define PC_ENET_CLSN    ((ushort)0x0010)
>#define PC_ENET_RENA    ((ushort)0x0020)
>
>/* Control bits in the SICR to route TCLK (CLK2) and RCLK (CLK4) to
>  * SCC1.  Also, make sure GR1 (bit 24) and SC1 (bit 25) are zero.
>  */
>#define SICR_ENET_MASK  ((uint)0x000000ff)
>#define SICR_ENET_CLKRT ((uint)0x0000003d)
>
>#endif
>
>Code is now this ........
>
>#ifdef CONFIG_MBX
>#ifndef ESTEEM192E
>/* Bits in parallel I/O port registers that have to be set/cleared
>  * to configure the pins for SCC1 use.  The TCLK and RCLK seem unique
>  * to the MBX860 board.  Any two of the four available clocks could be
>  * used, and the MPC860 cookbook manual has an example using different
>  * clock pins.
>  */
>#define PA_ENET_RXD     ((ushort)0x0001)
>#define PA_ENET_TXD     ((ushort)0x0002)
>#define PA_ENET_TCLK    ((ushort)0x0200)
>#define PA_ENET_RCLK    ((ushort)0x0800)
>#define PC_ENET_TENA    ((ushort)0x0001)
>#define PC_ENET_CLSN    ((ushort)0x0010)
>#define PC_ENET_RENA    ((ushort)0x0020)
>
>/* Control bits in the SICR to route TCLK (CLK2) and RCLK (CLK4) to
>  * SCC1.  Also, make sure GR1 (bit 24) and SC1 (bit 25) are zero.
>  */
>#define SICR_ENET_MASK  ((uint)0x000000ff)
>#define SICR_ENET_CLKRT ((uint)0x0000003d)
>
>#else
>/* ESTEEM192E
>  * This ENET stuff is for the MPC850 with ethernet on SCC2. This
>  * is very similar to the RPX-Lite configuration.
>  * Note TENA , LOOPBACK , FDPLEX_DIS on Port B.
>  */
>#define PA_ENET_RXD     ((ushort)0x0004)
>#define PA_ENET_TXD     ((ushort)0x0008)
>#define PA_ENET_TCLK    ((ushort)0x0200)
>#define PA_ENET_RCLK    ((ushort)0x0800)
>#define PB_ENET_TENA    ((uint)0x00002000)
>#define PC_ENET_CLSN    ((ushort)0x0040)
>#define PC_ENET_RENA    ((ushort)0x0080)
>
>#define SICR_ENET_MASK  ((uint)0x0000ff00)
>#define SICR_ENET_CLKRT ((uint)0x00003d00)
>
>#define PB_ENET_LOOPBACK ((uint)0x00004000)
>#define PB_ENET_FDPLEX_DIS ((uint)0x00008000)
>
>#endif
>
>
>
>
>
>from /arch/ppc/m8xx_io/enet.c  in function cpm_enet_init
>
>Code was this ........
>
>#ifdef CONFIG_MBX
>         immap->im_ioport.iop_pcpar |= PC_ENET_TENA;
>         immap->im_ioport.iop_pcdir &= ~PC_ENET_TENA;
>#endif
>
>Code is now this ........
>
>#ifdef CONFIG_MBX
>#ifndef ESTEEM192E
>
>/* MBX stuff */
>         immap->im_ioport.iop_pcpar |= PC_ENET_TENA;
>         immap->im_ioport.iop_pcdir &= ~PC_ENET_TENA;
>
>#else
>
>/* ESTEEM192E stuff */
>         cp->cp_pbpar |= PB_ENET_TENA;  /* same as rpxlite */
>         cp->cp_pbdir |= PB_ENET_TENA;  /* same as rpxlite */
>
>/*** Make sure that the loopback and full duplex are disabled
>      just like the rpxlite code. ***/
>         cp->cp_pbpar &= ~(PB_ENET_LOOPBACK | PB_ENET_FDPLEX_DIS);
>         cp->cp_pbdir |= PB_ENET_LOOPBACK | PB_ENET_FDPLEX_DIS;
>         cp->cp_pbdat &= ~PB_ENET_LOOPBACK;
>         cp->cp_pbdat |= PB_ENET_FDPLEX_DIS;
>
>#endif
>#endif
>
>
>This is what it looks like when booting.
>
>
>Initializing...
>   CPU:   XPC850xxZTB at 49 MHz: 2 kB I-Cache 1 kB D-Cache
>   Board: Esteem 192E
>   DRAM:
>bank 0 size 8388608
>bank 1 size 8388608
>16 MB
>Command "go": 0x4000dd28 => 0x00fedd28
>Command "bootm": 0x4000e8dc => 0x00fee8dc
>Command "net": 0x4000f3d4 => 0x00fef3d4
>Command "loads": 0x4000ddd8 => 0x00feddd8
>Command "md": 0x4000cf74 => 0x00fecf74
>Command "mm": 0x4000d1f8 => 0x00fed1f8
>Command "nm": 0x4000d228 => 0x00fed228
>Command "mw": 0x4000d25c => 0x00fed25c
>Command "cp": 0x4000d3e8 => 0x00fed3e8
>Command "crc32": 0x4000dabc => 0x00fedabc
>Command "base": 0x4000d610 => 0x00fed610
>Command "printenv": 0x4000f56c => 0x00fef56c
>Command "setenv": 0x4000f6e4 => 0x00fef6e4
>Command "saveenv": 0x4000f998 => 0x00fef998
>Command "bdinfo": 0x4000db70 => 0x00fedb70
>Command "flinfo": 0x4000e0cc => 0x00fee0cc
>Command "iminfo": 0x4000ee4c => 0x00feee4c
>Command "erase": 0x4000e1a4 => 0x00fee1a4
>Command "protect": 0x4000e4dc => 0x00fee4dc
>Command "loop": 0x4000d674 => 0x00fed674
>Command "mtest": 0x4000d820 => 0x00fed820
>Command "icache": 0x4000cdb8 => 0x00fecdb8
>Command "dcache": 0x4000ce5c => 0x00fece5c
>Command "reset": 0x40013528 => 0x00ff3528
>Command "version": 0x4000cc34 => 0x00fecc34
>Command "help": 0x4000cc80 => 0x00fecc80
>Command "?": 0x4000cc80 => 0x00fecc80
>   FLASH:  4 MB
>Hit any key to stop autoboot:  0
>## Booting Linux kernel at 40020000 ...
>    Image Name:   2.2.14 for EST192E
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    413162 Bytes = 403 kB = 0 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>Linux version 2.2.14 (root@pokey.esteem.com) (gcc version 2.95.2
>19991030 (2.9
>5.3 prerelease/franzo)) #14 Thu Oct 5 13:24:22 PDT 2000
>Boot arguments: root=/dev/nfs rw
>nfsaddrs=100.100.100.21:100.100.100.14 nfsroo
>t=100.100.100.14:/targ
>time_init: decrementer frequency = 183750000/60
>Calibrating delay loop... 48.74 BogoMIPS
>Memory: 15120k available (748k kernel code, 476k data, 40k init)
>[c0000000,c10
>00000]
>Dentry hash table entries: 2048 (order 2, 16k)
>Buffer cache hash table entries: 16384 (order 4, 64k)
>Page cache hash table entries: 4096 (order 2, 16k)
>POSIX conformance testing by UNIFIX
>Linux NET4.0 for Linux 2.2
>Based upon Swansea University Computer Society NET3.039
>NET4: Unix domain sockets 1.0 for Linux NET4.0.
>NET4: Linux TCP/IP 1.0 for NET4.0
>IP Protocols: ICMP, UDP, TCP, IGMP
>TCP: Hash tables configured (ehash 16384 bhash 16384)
>Starting kswapd v 1.5
>CPM UART driver version 0.03
>ttyS00 at 0x0280 is a SMC
>ttyS01 at 0x0380 is a SMC
>pty: 256 Unix98 ptys configured
>RAM disk driver initialized:  16 RAM disks of 4096K size
>loop: registered device at major 7
>NET4: Ethernet Bridge 007 for NET4.0
>early initialization of device brg0 is deferred
>eth0: CPM ENET Version 0.2, 00:10:ec:00:1b:ba
>PPP: version 2.3.7 (demand dialling)
>TCP compression code copyright 1989 Regents of the University of
>California
>PPP line discipline registered.
>brg0: network interface for Ethernet Bridge 007/NET4.0
>brg0: generated MAC address FE:FD:00:30:24:76
>brg0: attached to bridge instance 0
>Sending BOOTP and RARP requests............. timed out!
>IP-Config: Auto-configuration of network failed.
>dev_close: bug eth0 still running
>Looking up port of RPC 100003/2 on 100.100.100.14
>RPC: sendmsg returned error 101
>RPC: sendmsg returned error 101
>RPC: sendmsg returned error 101
>RPC: sendmsg returned error 101
>portmap: server 100.100.100.14 not responding, timed out
>Root-NFS: Unable to get nfsd port number from server, using default
>Looking up port of RPC 100005/1 on 100.100.100.14
>RPC: sendmsg returned error 101
>RPC: sendmsg returned error 101
>RPC: sendmsg returned error 101
>RPC: sendmsg returned error 101
>
>Blah..Blah..Blah..Blah..Blah..Blah..... reboot in 180 seconds
>
>         I know that my BOOTP and NFS server work because I have tested it
>with another machine. I don't know if the BOOTP requests are making it to
>the server okay.
>
>         At least some of the code works because I can see the TENA go
> high
>and bits being sent (may not be the correct bits ;-) on the transmit line
>going to the PHY(I can also see a signal going to the jack from the PHY).
>When a packet (any ethernet activity from the net) comes in through
>the PHY
>I can see the RENA line go high and bits coming in on the receive line.
>
>         I noticed that the rpxlite has a colision test disable line
> in its
>BSCR.  Is this needed to get the transmit to work right?
>
>Note: I have not ruled out the PHY to Jack interface as the problem.
>
>Any help appreciated. Many MAny thanks in advance.
>
>         Conn Clark
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
