Message-ID: <3ED61379.10401@cfl.rr.com>
Date: Thu, 29 May 2003 10:04:41 -0400
From: C <sorex@cfl.rr.com>
MIME-Version: 1.0
To: C <sorex@cfl.rr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8266ADS missing every other character on the console port;
 u-boot 0.3.0, eldk, kernel 2.4.4
References: <3ED3C82F.30402@cfl.rr.com>
In-Reply-To: <3ED3C82F.30402@cfl.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have solved the problem.  In accordance with proper netiquette I am posting my
solution.

> I've checked for a solution to this problem here, the ppcboot-user's
> mailing list, and Google but I haven't found my answer yet.
>
> The following link chronicles the same behavior but the answers don't
> seem to apply.
>
> http://lists.linuxppc.org/linuxppc-embedded/200203/msg00238.html

The answers are out there but they may not be exactly what you're looking for.
The following post to the linuxppc-embedded list didn't address my problem
directly but it does hold the answer:

    http://lists.linuxppc.org/linuxppc-embedded/200304/msg00103.html

Form my MPC8266ADS board the answer is to not use the 2.4.4 kernel but to use
the development branch (2.4.devel) of the kernel.

The reset of this email tells you how to download the development kernel,
configure, compile, and generate a u-boot image.  If you're not a newbie like me
and know how to do all this don't waste your time by reading on.

This link will tell you how to download the kernel via BitKeeper:

    http://www.penguinppc.org/dev/kernel.shtml

"cd" to the directory you downloaded the source tree to and then copy the source
files from the SCCS repository.
    # cd <download_dir>
    # bk -r get

Edit the makefile in the base directory so that:
    ARCH := ppc
    CROSS_COMPILE = ppc_82xx-

Next get the default configuration for the MPC8266ADS
    # make ads8266_config

Prune things from the configuration that don't make sense for your application:
    # make menuconfig

Now it's time to compile:
    # make oldconfig
    # make dep
    # make bzImage

Create a U-boot (ppcboot) image from the bzImage with mkimage:
    # cd arch/ppc/boot/images/
    # mkimage -A ppc \
              -O linux \
              -T kernel \
              -C gzip \
              -a 0 \
              -e 0 \
              -n "<a descriptive name>" \
              -d vmlinux.gz \
              pImage

Place your pImage on your tftpserver and download it to your board:

    U-Boot 0.3.0 (May 21 2003 - 12:15:52)
    MPC8260 Reset Status: External Soft, External Hard
    MPC8260 Clock Configuration
     - Bus-to-Core Mult 3x, VCO Div 2, 60x Bus Freq  33-100, Core Freq 100-300
     - dfbrg 0, corecnf 0x08, busdf 3, cpmdf 1, plldf 0, pllmf 1
     - vco_out  266666664, scc_clk   66666666, brg_clk   66666666
     - cpu_clk  199999998, cpm_clk  133333332, bus_clk   66666666

    CPU:   MPC8260 (Rev 14, Mask A.0(A) 2K25A) at 199.999 MHz
    Board: Motorola MPC8266ADS
    I2C:   ready
    DRAM:  SDRAM configuration read from SPD
    	Size per side = 16MB
    	Organization: 1 sides, 2 banks, 9 Columns, 11 Rows, Data width = 64 bits
    	Refresh rate = 16, CAS latency = 3
    	Total size: 16 MB
    Top of RAM usable for U-Boot at: 01000000
    Reserving 256k for U-Boot at: 00fc0000
    Reserving 384k for malloc() at: 00f60000
    Reserving 76 Bytes for Board Info at: 00f5ffb4
    Reserving 68 Bytes for Global Data at: 00f5ff70
    Stack Pointer at: 00f5ff58
    New Stack Pointer is: 00f5ff58
    FLASH:  8 MB
    In:    serial
    Out:   serial
    Err:   serial
    Reset Ethernet PHY
    U-Boot relocated to 00fc0000
    Net:   FCC2 ETHERNET
    ### main_loop entered: bootdelay=5
    ### main_loop: bootcmd="tftpboot; bootm"
    Hit any key to stop autoboot:  5

Hit a key to stop the autoboot process.  Then command u-boot to download the pImage.

    => tftp 0x100000 pImage
    Trying FCC2 ETHERNET
    ARP broadcast 1
    Got good ARP - start TFTP
    TFTP from server 216.132.201.40; our IP address is 216.132.201.68
    Filename 'pImage'.
    Load address: 0x100000
    Loading: *#################################################################
    	     ########################################
    done
    Bytes transferred = 536001 (82dc1 hex)

Now make sure that clocks_in_mhz is NOT DEFINED!  I know that you will find at
least one post from Wolfgang Denx on this list that refers to this.  Undefine
clocks_in_mhz this way:

    => setenv clocks_in_mhz
    => saveenv

Now all you have to do is boot the kernel and watch the characters stream by:
    => bootm
    ## Booting image at 00100000 ...
       Image Name:   foo
       Image Type:   PowerPC Linux Kernel Image (gzip compressed)
       Data Size:    535937 Bytes = 523.4 kB
       Load Address: 00000000
       Entry Point:  00000000
       Verifying Checksum ... OK
       Uncompressing Kernel Image ... OK
    ## Current stack ends at 0x00F5FBE8 => set upper limit to 0x00800000
    ## cmdline at 0x007FFF00 ... 0x007FFF10
    bd address  = 0x00F5FFB4
    memstart    = 0x00000000
    memsize     = 0x01000000
    flashstart  = 0xFF800000
    flashsize   = 0x00800000
    flashoffset = 0x00000000
    sramstart   = 0x00000000
    sramsize    = 0x00000000
    immr_base   = 0xF0000000
    bootflags   = 0x00000001
    vco         = 266.666 MHz
    sccfreq     = 66.666 MHz
    brgfreq     = 66.666 MHz
    intfreq     = 199.999 MHz
    cpmfreq     = 133.333 MHz
    busfreq     = 66.666 MHz
    ethaddr     = AE:CF:02:00:00:00
    IP addr     = 216.132.201.68
    baudrate    =   9600 bps
    No initrd
    ## Transferring control to Linux (at address 00000000) ...
    Memory BAT mapping: BAT2=16Mb, BAT3=0Mb, residual: 0M
    Linux version 2.4.21-rc5 (root@yyz) (gcc version 2.95.3 20010111
(prerelease/franzo/20010111)) #28 Wed May 28 17:58:36 EDT 200
    On node 0 totalpages: 409
    zone(0): 4096 pages
    zone(1): 0 pages
    zone(2): 0 pages
    Kernel command line: root=/dev/ram r
       .
       .
       .


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
