Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id CBE5567B1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 17:58:39 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k5K9FIDS007879 for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 03:15:18 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5K7wZVM012629
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 02:58:36 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD94F@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: "'Prabhat_Singh'" <Prabhat_Singh@Satyam.com>, linuxppc-embedded@ozlabs.org
Subject: RE: Exceptions during PCI initialization at u-boot
Date: Tue, 20 Jun 2006 15:58:33 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Prabhat,

Did you clear the 'PCI No response' in the error mask register
before you do PCI configuration read? If you didn't, machine check
will arise when PCI scan unpopulated PCI slot.

I notice that the MSR[12] is set, but the trap codes haven't
detect that, what is your toolchain?

Regards,
-Dave


-----Original Message-----
Hi all
I am getting two exceptions, that you will find in log, at the pci_hose_read_config_byte memory is crashing that's I found in System.map. after second exception its boots properly. I have no clue whats happening. And why I am not able to read Configuration space of pci. 
>From where this exception is coming?
Please help me out. What else I can check?
 
 
VPN Router Board
 
 
Vpn Router U-Boot 1.0.0 (Jun 19 2006 - 11:31:37)
 
MPC8260 Reset Status: External Soft, External Hard
 
MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 0, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3
 - vco_out  400000000, scc_clk  100000000, brg_clk  100000000
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000
 
CPU:   8272 (HiP7 Rev 14, Mask A.0 1K50M) at 400 MHz
Board: VPN8248
DRAM:  32 MB
total length of code       216456l   34d88value of sdrambase+ramsize 02000000 
Top of RAM usable for U-Boot at: 02000000
Reserving 211k for U-Boot at: 01fcb000
Reserving 128k for malloc() at: 01faae00
Reserving 76 Bytes for Board Info at: 01faadb4
Reserving 80 Bytes for Global Data at: 01faad64
Stack Pointer at: 01faad48
New Stack Pointer is: 01faad48
value of ret 0 
Entering reloacte
Now running in RAM - U-Boot at: 01fcb000
POST memory POST memory PASSED
PASSED
FLASH: satyam : manufacturor ID = 200020satyam: id1=22df22df
satyam: id2=0
satyam: id3=80008
16 MB
PCI Autoconfig: Memory region: [14000000-1bffffff]
PCI Autoconfig: I/O region: [1c000000-1dffffff]
Bus Fault @ 0x01fd2df8, fixup 0x00000000
Machine check in kernel mode.
Caused by (from msr): regs 01faab60 Unknown values in msr
NIP: 01FD2DF8 XER: 00000000 LR: 01FD2DF0 REGS: 01faab60 TRAP: 0200 DAR: 01FE4DB8
MSR: 00083002 EE: 0 PR: 0 FP: 1 ME: 1 IR/DR: 00
 
GPR00: 01FD3A24 01FAAC50 FFFFFFFF 00000000 8000080C 00000002 01FAAC5E 01C5D1FB 
GPR08: 01FD0084 F0010904 00000000 00000000 00000020 FFFFFFFF 01FF8000 020CB000 
GPR16: FFFFFFFF FFFFFFFF FFFFFEFF FFFFFFFF 00000000 00000000 FFFFFFFF F0010D20 
GPR24: 00000000 00000000 01FFE39C 00000100 01FFE39C 01FAAD64 01FF8400 00000800 
Call backtrace: 
01FD3A24 01FD3BF0 01FE8B84 01FE3E04 01FD3C64 01FCFE30 01FCE48C 
machine check
VPN Router Board
 
 
Vpn Router U-Boot 1.0.0 (Jun 19 2006 - 11:31:37)
 
MPC8260 Reset Status:
 
MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 0, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3
 - vco_out  400000000, scc_clk  100000000, brg_clk  100000000
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000
 
CPU:   8272 (HiP7 Rev 14, Mask A.0 1K50M) at 400 MHz
Board: VPN8248
DRAM:  32 MB
total length of code       216456l   34d88value of sdrambase+ramsize 02000000 
Top of RAM usable for U-Boot at: 02000000
Reserving 211k for U-Boot at: 01fcb000
Reserving 128k for malloc() at: 01faae00
Reserving 76 Bytes for Board Info at: 01faadb4
Reserving 80 Bytes for Global Data at: 01faad64
Stack Pointer at: 01faad48
New Stack Pointer is: 01faad48
Entering reloacte
Now running in RAM - U-Boot at: 01fcb000
FLASH: satyam : manufacturor ID = 200020satyam: id1=22df22df
PCI Autoconfig: Memory region: [14000000-1bffffff]
PCI Autoconfig: I/O region: [1c000000-1dffffff]
vendor=168c
PCI Scan: Found Bus 0, Device 15, Function 0
PCI Autoconfig: BAR 0, Mem, size=0x10000, address=0x14000000
PCI Autoconfig: BAR 1, I/O, size=0xffffb000, No room in resource
PCI:     00  0f  168c  0013  0200  00
value of item =1
In:    serial
Out:   serial
Err:   serial
Chip Name  = 175a
Chip Name  = 175c
phy ID(0x02430d80) = 02430d80
Level One/ICPLUS PHY Identied IC175C Revision 0
Phy operating at 100 MBit/s in full-duplex mode
Phy operating at 100 MBit/s in full-duplex mode
U-Boot relocated to 01fcb000
Net:   value of fec FCC2 ETHERNET 
FCC2 ETHERNET
Hit any key to stop autoboot:  5 satyam=>  
 
