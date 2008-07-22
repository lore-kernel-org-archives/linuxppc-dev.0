Return-Path: <chris8661@gmail.com>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.247])
	by ozlabs.org (Postfix) with ESMTP id 8BFE7DDED1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 07:59:01 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so13301564agc.0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 14:58:59 -0700 (PDT)
Message-ID: <c2ce83410807221458p5e5efd1t1bfe158b61a22eb6@mail.gmail.com>
Date: Tue, 22 Jul 2008 17:58:58 -0400
From: "Chris Collins" <chris8661@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problems loading Linux 2.6 using PPCBug
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a Motorola (now Emerson) Prpmc800 board. I have a working
2.4.25 kernel that I can load from flash or TFTP, but I can't seem to
get a 2.6 kernel to load. I've tried 2.6.24 and an older ~2.6.16
kernel with no success.

I'm trying to use ELDK 4.2 with 2.6.24 kernel and building with the
default .config (with a new CONFIG_CMDLINE defined for my console):
make ARCH=ppc CROSS_COMPILE=ppc_74xx- prpmc800_defconfig

When I try to load the zImage.pplus file using the PPCBug boot loader
I get the following error:

PPC7-Bug>nbo 11 0,,, zImage.pplus
Network Booting from: I82559, Controller 11, Device 0
Device Name: /pci@fe000000/pci8086,1209@11,0:0,0
Loading: zImage.pplus

Client IP Address      = 10.10.1.10
Server IP Address      = 10.101.1.101
Gateway IP Address     = 10.10.1.254
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = zImage.pplus
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>
Bytes Received =&1479208, Bytes Loaded =&1479208
Bytes/Second   =&739604, Elapsed Time =2 Second(s)

Residual-Data Located at: $1FE569FC

Exception: Program (Illegal Instruction)
SRR0 =00005400 SRR1 =00083040 Vector-Offset =00700
IP     =00005400 MSR    =00003040 CR     =00000000 FPSCR  =00000000
R0     =00000000 R1     =1FE00000 R2     =00000000 R3     =1FE569FC
R4     =00005000 R5     =00000000 R6     =00000000 R7     =00000000
R8     =00000000 R9     =00000000 R10    =00000000 R11    =00000000
R12    =00000000 R13    =00000000 R14    =00000000 R15    =00000000
R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
R28    =00000000 R29    =00000000 R30    =00000000 R31    =00000000
SPR0   =00000000 SPR1   =00000000 SPR8   =00000000 SPR9   =00000000
00005400 00000000  WORD        $00000000


I have the 'env' variable for PReP enabled... which seems to be the
usual suspect:

PPC7-Bug>env
Bug or System environment [B/S] = B?
Maximum Memory Usage (Mb, 0=AUTO) =   2?
Field Service Menu Enable [Y/N] = N?
Probe System for Supported I/O Controllers [Y/N] = Y?
Auto-Initialize of NVRAM Header Enable [Y/N] = Y?
Network PReP-Boot Mode Enable [Y/N] = Y?
SCSI Bus Reset on Debugger Startup [Y/N]   = N?
Primary SCSI Bus Negotiations Type [A/S/N] = A?
Primary SCSI Data Bus Width [W/N]          = N?
Secondary SCSI Identifier                  = "07"?
NVRAM Boot List (GEV.fw-boot-path) Boot Enable [Y/N]           = N?
NVRAM Boot List (GEV.fw-boot-path) Boot at power-up only [Y/N] = N?
NVRAM Boot List (GEV.fw-boot-path) Boot Abort Delay            = 5?
Auto Boot Enable [Y/N]           = N?
Auto Boot at power-up only [Y/N] = N?
Auto Boot Scan Enable [Y/N]      = Y?
Auto Boot Scan Device Type List  = FDISK/CDROM/TAPE/HDISK/?
Auto Boot Controller LUN   = 00?
Auto Boot Device LUN       = 00?
Auto Boot Partition Number = 00?
Auto Boot Abort Delay      = 7?
Auto Boot Default String [NULL for an empty string] = ?
ROM Boot Enable [Y/N]            = Y?
ROM Boot at power-up only [Y/N]  = Y?
ROM Boot Abort Delay             = 5?
ROM Boot Direct Starting Address = F0110000?
ROM Boot Direct Ending Address   = FFFFFFFC?
Network Auto Boot Enable [Y/N]           = N?
Network Auto Boot at power-up only [Y/N] = N?
Network Auto Boot Controller LUN = 11?
Network Auto Boot Device LUN     = 00?
Network Auto Boot Abort Delay    = 5?
Network Auto Boot Configuration Parameters Offset (NVRAM) = 00001000?
Memory Size Enable [Y/N]         = Y?
Memory Size Starting Address     = 00000000?
Memory Size Ending Address       = 08000000?
DRAM Speed in NANO Seconds       = 10?
ROM Bank A Access Speed (ns) = 150?
ROM Bank B Access Speed (ns) = 120?
DRAM Parity Enable [On-Detection/Always/Never - O/A/N]    = O?
L2Cache Parity Enable [On-Detection/Always/Never - O/A/N] = O?
PCI Interrupts Route Control Registers (PIRQ0/1/2/3) = 0A0B0E0F?
Serial Startup Code Master Enable [Y/N] = N?
Serial Startup Code LF Enable [Y/N] =     N?
Firmware Command Buffer Enable [Y/N] = N?
Firmware Command Buffer Delay  = 5?
Firmware Command Buffer :
['NULL' terminates entry]?
PPC7-Bug>

Is this a problem with PPCBug and the 2.6 kernel? Has anyone else had
success loading the 2.6 kernel using PPCBug? Does anyone have a port
of U-Boot for the Prpmc800?

Thanks in advance for your help.
Chris
