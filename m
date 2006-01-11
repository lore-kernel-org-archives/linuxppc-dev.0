Return-Path: <powerpc440@googlemail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.206])
	by ozlabs.org (Postfix) with ESMTP id 2973C68A40
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jan 2006 00:41:09 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id s1so161791nze
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jan 2006 05:41:08 -0800 (PST)
Message-ID: <43C50B97.3060504@googlemail.com>
Date: Wed, 11 Jan 2006 14:43:51 +0100
From: powerpc440 <powerpc440@googlemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Memory and register adresses on PCI graphic chip.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have custom board based on Ocotea - PPC440GX with Graphic chip (Radeon 
M6) on it. I need to initialise the registers and the memory of the chip 
upon booting. Now I comunicate with the board thru serial interface, and 
u-boot 1.1.2 + linux 2.6.12 both working wery well up to the video.
The PCI memory is mapped on 0x80000000 in u-boot configuration. How can 
I understand where are the memory and register base adresses of the 
graphic chip?

This is part from u-boot splash screen:

Board: HIMA 440GX Board
        VCO: 1000 MHz
        CPU: 500 MHz
        PLB: 166 MHz
        OPB: 83 MHz
        EPB: 83 MHz
I2C:   ready
DRAM:  512 MB
FLASH: portwidth=4 chipwidth=2
found 1 erase regions
64 MB
*** Warning - bad CRC, using default environment

PCI:   Bus Dev VenId DevId Class Int
        00  01  1131  1561  0c03  00
        00  01  1131  1561  0c03  00
        00  01  1131  1562  0c03  00
        00  02  1002  4c59  0300  ff                   < --------------  
The Radeon M6 chip
        00  03  1013  6005  0401  00
        00  04  1095  3114  0180  00
In:    serial
Out:   serial
Err:   serial
Net:   pfc1: 4
Konfiguration 4
---------------------------------------------
This information i can obtain from the /proc after linux loading: :

#lspci -vv
............................
00:02.0 Class 0300: 1002:4c59
        Subsystem: 1002:4c59
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 25
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at ff00 [size=256]
        Region 2: Memory at efff0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Thanks a lot!
Zhivko
