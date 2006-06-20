Return-Path: <Prabhat_Singh@Satyam.com>
Received: from chnmail.satyam.com (chnmail.satyam.com [210.18.90.100])
	by ozlabs.org (Postfix) with ESMTP id 5F3CE67B16
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 19:58:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Exceptions during PCI initialization at u-boot
Date: Tue, 20 Jun 2006 15:28:09 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED104A53AAD@bsdmsg002.corp.satyam.ad>
From: "Prabhat_Singh" <Prabhat_Singh@Satyam.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dave
Thanks for you comments.

I tried clearing 'PCI No response' as follows :
				Unsigned int* EMR=3D( Unsigned
int*)0xf0010888;
				Unsigned int* ESR=3D( Unsigned
int*)0xf0010884;
		Before pci_hose_read_config_byte function I cleared the
the 'PCI No response' bit.
				*EMR &=3D0xFFFFFFF7;
				*ESR |=3D0x00000008;
Now it's getting reset and machine check exception coming all the time
continuously and board is not booting up.

I am clueless please advice what to do?

Regards
Prabhat





=20
-----Original Message-----
From: Liu Dave-r63238 [mailto:DaveLiu@freescale.com]=20
Sent: Tuesday, June 20, 2006 1:29 PM
To: Prabhat_Singh; linuxppc-embedded@ozlabs.org
Subject: RE: Exceptions during PCI initialization at u-boot

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
I am getting two exceptions, that you will find in log, at the
pci_hose_read_config_byte memory is crashing that's I found in
System.map. after second exception its boots properly. I have no clue
whats happening. And why I am not able to read Configuration space of
pci.=20
>From where this exception is coming?
Please help me out. What else I can check?
=20
=20
VPN Router Board
=20
=20
Vpn Router U-Boot 1.0.0 (Jun 19 2006 - 11:31:37)
=20
MPC8260 Reset Status: External Soft, External Hard
=20
MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq
100-300
 - dfbrg 0, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3
 - vco_out  400000000, scc_clk  100000000, brg_clk  100000000
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000
=20
CPU:   8272 (HiP7 Rev 14, Mask A.0 1K50M) at 400 MHz
Board: VPN8248
DRAM:  32 MB
total length of code       216456l   34d88value of sdrambase+ramsize
02000000=20
Top of RAM usable for U-Boot at: 02000000
Reserving 211k for U-Boot at: 01fcb000
Reserving 128k for malloc() at: 01faae00
Reserving 76 Bytes for Board Info at: 01faadb4
Reserving 80 Bytes for Global Data at: 01faad64
Stack Pointer at: 01faad48
New Stack Pointer is: 01faad48
value of ret 0=20
Entering reloacte
Now running in RAM - U-Boot at: 01fcb000
POST memory POST memory PASSED
PASSED
FLASH: satyam : manufacturor ID =3D 200020satyam: id1=3D22df22df
satyam: id2=3D0
satyam: id3=3D80008
16 MB
PCI Autoconfig: Memory region: [14000000-1bffffff]
PCI Autoconfig: I/O region: [1c000000-1dffffff]
Bus Fault @ 0x01fd2df8, fixup 0x00000000
Machine check in kernel mode.
Caused by (from msr): regs 01faab60 Unknown values in msr
NIP: 01FD2DF8 XER: 00000000 LR: 01FD2DF0 REGS: 01faab60 TRAP: 0200 DAR:
01FE4DB8
MSR: 00083002 EE: 0 PR: 0 FP: 1 ME: 1 IR/DR: 00
=20
GPR00: 01FD3A24 01FAAC50 FFFFFFFF 00000000 8000080C 00000002 01FAAC5E
01C5D1FB=20
GPR08: 01FD0084 F0010904 00000000 00000000 00000020 FFFFFFFF 01FF8000
020CB000=20
GPR16: FFFFFFFF FFFFFFFF FFFFFEFF FFFFFFFF 00000000 00000000 FFFFFFFF
F0010D20=20
GPR24: 00000000 00000000 01FFE39C 00000100 01FFE39C 01FAAD64 01FF8400
00000800=20
Call backtrace:=20
01FD3A24 01FD3BF0 01FE8B84 01FE3E04 01FD3C64 01FCFE30 01FCE48C=20
machine check
VPN Router Board
=20
=20
Vpn Router U-Boot 1.0.0 (Jun 19 2006 - 11:31:37)
=20
MPC8260 Reset Status:
=20
MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq
100-300
 - dfbrg 0, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 3
 - vco_out  400000000, scc_clk  100000000, brg_clk  100000000
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000
=20
CPU:   8272 (HiP7 Rev 14, Mask A.0 1K50M) at 400 MHz
Board: VPN8248
DRAM:  32 MB
total length of code       216456l   34d88value of sdrambase+ramsize
02000000=20
Top of RAM usable for U-Boot at: 02000000
Reserving 211k for U-Boot at: 01fcb000
Reserving 128k for malloc() at: 01faae00
Reserving 76 Bytes for Board Info at: 01faadb4
Reserving 80 Bytes for Global Data at: 01faad64
Stack Pointer at: 01faad48
New Stack Pointer is: 01faad48
Entering reloacte
Now running in RAM - U-Boot at: 01fcb000
FLASH: satyam : manufacturor ID =3D 200020satyam: id1=3D22df22df
PCI Autoconfig: Memory region: [14000000-1bffffff]
PCI Autoconfig: I/O region: [1c000000-1dffffff]
vendor=3D168c
PCI Scan: Found Bus 0, Device 15, Function 0
PCI Autoconfig: BAR 0, Mem, size=3D0x10000, address=3D0x14000000
PCI Autoconfig: BAR 1, I/O, size=3D0xffffb000, No room in resource
PCI:     00  0f  168c  0013  0200  00
value of item =3D1
In:    serial
Out:   serial
Err:   serial
Chip Name  =3D 175a
Chip Name  =3D 175c
phy ID(0x02430d80) =3D 02430d80
Level One/ICPLUS PHY Identied IC175C Revision 0
Phy operating at 100 MBit/s in full-duplex mode
Phy operating at 100 MBit/s in full-duplex mode
U-Boot relocated to 01fcb000
Net:   value of fec FCC2 ETHERNET=20
FCC2 ETHERNET
Hit any key to stop autoboot:  5 =08satyam=3D> =20
=20



DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
