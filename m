Message-ID: <3BABC303.1674D66E@carts.com>
Date: Fri, 21 Sep 2001 15:45:23 -0700
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: Craig MacDonald <macdonldc@netscape.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem booting linux-2.4.4-2001-07-23 on EST SBC8260 with ppcboot
 1.0.4
References: <3A1B61D1.1F74491E.031B03A1@netscape.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You should have ppcboot remap the IMMR to 0xF0000000 in the start of ppcboot
code. Otherwise it will interfere with Linux memory mapping. See this file for
all the info you need.

http://www.linuxhq.com/kernel/v2.4/doc/powerpc/SBC8260_memory_mapping.txt.html

gl!

Kevin Fry


Craig MacDonald wrote:

> I am trying to get linux 2.4 running on an EST SBC8260.
> It seems others have this board working correctly, so
> I must be doing something wrong.
> It works up to executing the rfi in turn_on_mmu, but
> it doesn't seem to reach start_here.
>
> I have modified linux to use the correct bd_info structure
> in ppcboot.h and the immr_base value. Below is some information
> from ppcboot.
>
> PPCBoot 1.0.4 (Aug 12 2001 - 07:16:41)
>
> MPC8260 Reset Status: External Soft
>
> MPC8260 Clock Configuration
>  - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
>  - dfbrg 0, corecnf 0x0a, busdf 3, cpmdf 1, plldf 0, pllmf 1
>  - vco_out  132000000, cpm_clk   66000000, bus_clk   33000000
>  - scc_clk   33000000, brg_clk   33000000, cpu_clk  132000000
>
> CPU:   MPC8260 (Rev 01, Mask A.1 1K22A-XC) at 132 MHz
> Board: EST SBC8260
> DRAM:  32 MB
> FLASH:  4 MB
> BEDBUG Ready
> In:    serial
> Out:   serial
> Err:   serial
>
> bdinfo
> ------------------------
> memstart    = 0x00000000
> memsize     = 0x02000000
> flashstart  = 0xfff00000
> flashsize   = 0x00400000
> flashoffset = 0x00040000
> sramstart   = 0x00000000
> sramsize    = 0x00000000
> immr_base   = 0x0f000000
> bootflags   = 0x00000001
> intfreq     =    132 MHz
> busfreq     =     33 MHz
> ethaddr     = 00:02:6A:00:00:55
>   IP addr     = 10.0.0.62
>   baudrate    =  19200 bps
> getc        = 0x01fd0ec8
> tstc        = 0x01fd0ef8
> putc        = 0x01fd0e18
> puts        = 0x01fd0e84
> printf      = 0x01fcd57c
> install_hdlr= 0x01fd1a74
> free_hdlr   = 0x01fd1b14
> malloc      = 0x01fcbfe4
>
> TFTP from server 10.0.0.12; our IP address is 10.0.0.62
> Filename 'linux'.
> Load address: 0x100000
> Loading: /
> done
> Bytes transferred = 458355 (6fe73 hex)
> free        = 0x01fcc4d8
> ## Booting image at 00100000 ...
>    Image Name:   linux 2.4
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    458291 Bytes = 447 kB = 0 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>
> Thanks,
> Craig MacDonald
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
