Message-ID: <3802668E.C5A6BAC6@fi.infn.it>
Date: Tue, 12 Oct 1999 00:37:03 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: Matt Porter <mporter@eng.mcd.mot.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: BUGboot 0.2 - Boot Linux from flash on Moto boards
References: <19990930134513.C25664@fwrsl-11.phx.mcd.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Matt,

I'm trying your bugboot but I have some problem. I went through your
readme, and these are the steps that I did.

PPC4-Bug>nbh 0 0 ,,, res_data
Network Booting from: DEC21143, Controller 0, Device 0 
Device Name: /pci@80000000/pci1011,19@e,0:0,0
Loading: res_data 

Client IP Address      = 192.84.146.131
Server IP Address      = 192.84.146.138
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0 
Boot File Name         = res_data
Argument File Name     = 

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&0, Bytes Loaded =&0
Bytes/Second   =&0, Elapsed Time =1 Second(s)

Residual-Data Located at: $01F78000
IP     =00049039 MSR    =00003040 CR     =00000000 FPSCR  =00000000
R0     =00000000 R1     =01F78000 R2     =00000000 R3     =01F78000
R4     =00005000 R5     =00000000 R6     =00000000 R7     =00000000
R8     =00000000 R9     =00000000 R10    =00000000 R11    =00000000
R12    =00000000 R13    =00000000 R14    =00000000 R15    =00000000
R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
R28    =00000000 R29    =00000000 R30    =00000000 R31    =00000000
SPR0   =00000000 SPR1   =00000000 SPR8   =00000000 SPR9   =00000000
00049039 E000013C  WORD        $E000013C
PPC4-Bug>md 
$01F78000                                                          
01F78000  00006A0C 0001012C 20202020 20202020  ..j....,            
01F78010  20202020 20202020 20202020 20202020                      
PPC4-Bug>niop
Controller LUN =00?
Device LUN     =00?
Get/Put        =G? p
File Name      =? res_data
Memory Address =00004000? 01F78000
Length         =00000000? 00006A0C

Bytes Sent     =&27148
Bytes/Second   =&27148, Elapsed Time =1 Second(s)

After this I have:
[root@pcwiz3 /root]# ls -l /tftpboot/
total 2348
-rwxr-xr-x   1 root     root       649562 Oct 11 21:58 bugboot.bin*
-rw-rw-rw-   1 root     root        27148 Oct 11 22:30 res_data
drwxr-xr-x  15 root     root         1024 Oct 11 23:01 root/
-rwxr-xr-x   1 root     root       622156 Sep 14 19:38 zimage*
-rwxr-xr-x   1 root     root       614252 Jul  7 14:33 zimage.old*
-rw-rw-rw-   1 root     root       471244 Jun  7 14:10 zimage.old.old

Then I restart the board (my PC has some hardware problem, then I cannot
use the cross compiler). I put bugboot in a NFS directory, and I copied
the zImage that I'm using to boot to this directory (as kernel_image)
and the res_data file. The compilation seems fine:

[root@vmesez1 bugboot-0.2]# make bugboot.bin
gcc -o mkbugboot mkbugboot.c
gcc -c \
-DZIMAGE_SIZE=`wc -c <kernel_image | sed "s: ::g"` \
-DRESDATA_DEST=RESDATA_DEST \
-DRESDATA_SIZE=RESDATA_SIZE \
-o romboot.o romboot.S 
objcopy --output-target=binary romboot.o romboot.bin
./mkbugboot romboot.bin kernel_image res_data bugboot.bin
Checksum = 0x13c7

and then I copied this back to /tftpboot.

The kernel I'm using is for network booting, but with a SCSI disk root
filesystem; the distribution I'm using is an old linuxPPC pre-R5. Should
this be a problem?

In any case after the compilaton I shutdown the board and I dit the rest
of the work:

PPC4-Bug>niop
Controller LUN =00?
Device LUN     =00?
Get/Put        =G?
File Name      =? bugboot.bin
Memory Address =00004000?
Length         =00000000?
Byte Offset    =00000000?
                                                                                
Bytes Received =&649562, Bytes Loaded =&649562
Bytes/Second   =&324781, Elapsed Time =2 Second(s)
PPC4-Bug>pflash 4000:100000 ff000000 
Source Starting/Ending Addresses      =00004000/00103FFF
Destination Starting/Ending Addresses =FF000000/FF0FFFFF
Number of Effective Bytes             =00100000 (&1048576)

Program FLASH Memory (Y/N)? y
Virtual-Device-Number    =00
Manufacturer-Identifier  =10001
Device-Identifier        =22C422C4
Virtual-Device-Number    =01
Manufacturer-Identifier  =10001
Device-Identifier        =22C422C4
Address-Mask             =FF800000
Erasing sector     =$FF000000
Erasing sector     =$FF040000
Erasing sector     =$FF080000
Erasing sector     =$FF0C0000
Programming sector =$FF000000
Programming sector =$FF040000
Programming sector =$FF080000
Programming sector =$FF0C0000
FLASH Memory Programming Complete
PPC4-Bug>env
Bug or System environment [B/S] = B?
Field Service Menu Enable [Y/N] = N?
Remote Start Method Switch [G/M/B/N] = B?
Probe System for Supported I/O Controllers [Y/N] = Y?
Auto-Initialize of NVRAM Header Enable [Y/N] = Y?
Network PReP-Boot Mode Enable [Y/N] = Y?
Negate VMEbus SYSFAIL* Always [Y/N] = N?
SCSI Bus Reset on Debugger Startup [Y/N]   = Y?
Primary SCSI Bus Negotiations Type [A/S/N] = A?
Primary SCSI Data Bus Width [W/N]          = W?
Secondary SCSI Identifier                  = "07"?
NVRAM Bootlist (GEV.fw-boot-path) Boot Enable [Y/N]           = N?
NVRAM Bootlist (GEV.fw-boot-path) Boot at power-up only [Y/N] = N?
NVRAM Bootlist (GEV.fw-boot-path) Boot Abort Delay            = 5?
Auto Boot Enable [Y/N]           = N?
Auto Boot at power-up only [Y/N] = N?
Auto Boot Scan Enable [Y/N]      = Y?
Auto Boot Scan Device Type List  = FDISK/CDROM/TAPE/HDISK/?
Auto Boot Controller LUN   = 10?
Auto Boot Device LUN       = 50?
Auto Boot Partition Number = 00?
Auto Boot Abort Delay      = 7?
Auto Boot Default String [NULL for an empty string] = ?
ROM Boot Enable [Y/N]            = N?
ROM Boot at power-up only [Y/N]  = Y?
ROM Boot Enable search of VMEbus [Y/N] = N?
ROM Boot Abort Delay             = 5?
ROM Boot Direct Starting Address = FFF00000? ff000000
ROM Boot Direct Ending Address   = FFFFFFFC? ff000100
Network Auto Boot Enable [Y/N]           = N? .

Update Non-Volatile RAM (Y/N)? y

Reset Local System (CPU) (Y/N)? y

PPC4-Bug>rb ;v

ROMBoot about to Begin... Press <ESC> to Bypass, <SPC> to Continue

Direct Adr: FF000000 FF000100: Searching for ROMboot Module at: FF000000
Executing ROMboot Module "LINUXROM" at FF000000

But here everything hangs!

I looked at what i have in memory:

PPC4-Bug>md ff000000:100
FF000000  424F4F54 00000014 0009E95A 4C494E55  BOOT.......ZLINU
FF000010  58524F4D 3D20FF00 61290100 3D600009  XROM= ..a)..=`..
FF000020  616B7E4C 3D800000 618C5000 7D6903A6  ak~L=...a.P.}i..
FF000030  39A00000 85690004 956C0004 7DAD5A78  9....i...l..}.Zx
FF000040  4200FFF4 3D20FF09 61297F4C 3D600000  B...= ..a).L=`..
FF000050  616B0000 3D800000 618C0000 7D6903A6 
ak..=...a...}i..               
FF000060  39A00000 85690004 956C0004 7DAD5A78  9....i...l..}.Zx
FF000070  4200FFF4 3C600000 60630000 3DC00000  B...<`..`c..=...
FF000080  61CE5400 7DC803A6 4E800020 00000000  a.T.}...N.. ....
FF000090  00000000 00000000 00000000 00000000  ................
and then all zero for 0x400 bytes excepted:
FF0002C0  02004101 124F0000 0000C004 00000000 
..A..O..........                 
FF0002D0  00000000 00000000 00000000 00000000 
................                 
FF0002E0  00000000 00000000 00000000 00000000 
................                 
FF0002F0  00000000 00000000 00000000 000055AA 
..............U.                 
FF000300  00040000 4C7E0900 00004C69 6E757800 
....L~....Linux.                 

I hope that this could be sufficient to understand what was going on, I
tried to look at the code, but I don't know the PPC assembler at all,
and I cannot understand if this is something good or not (but it seems
quite strange to me):

PPC4-Bug>md ff000014:100;di
FF000014 3D20FF00  ADDIS       R9,R0,$FF00
FF000018 61290100  ORI         R9,R9,$100
FF00001C 3D600009  ADDIS       R11,R0,$9
FF000020 616B7E4C  ORI         R11,R11,$7E4C
FF000024 3D800000  ADDIS       R12,R0,$0
FF000028 618C5000  ORI         R12,R12,$5000
FF00002C 7D6903A6  MTSPR       9,R11
FF000030 39A00000  ADDI        R13,R0,$0
FF000034 85690004  LWZU        R11,$4(R9) ($00000004)
FF000038 956C0004  STWU        R11,$4(R12) ($00000004)
FF00003C 7DAD5A78  XOR         R13,R13,R11
FF000040 4200FFF4  BC          16,0,$FF000034
FF000044 3D20FF09  ADDIS       R9,R0,$FF09
FF000048 61297F4C  ORI         R9,R9,$7F4C
FF00004C 3D600000  ADDIS       R11,R0,$0
FF000050 616B0000  ORI         R11,R11,$0
FF000054 3D800000  ADDIS       R12,R0,$0
FF000058 618C0000  ORI         R12,R12,$0
FF00005C 7D6903A6  MTSPR       9,R11
FF000060 39A00000  ADDI        R13,R0,$0
FF000064 85690004  LWZU        R11,$4(R9) ($00000004)
FF000068 956C0004  STWU        R11,$4(R12) ($00000004)
FF00006C 7DAD5A78  XOR         R13,R13,R11
FF000070 4200FFF4  BC          16,0,$FF000064
FF000074 3C600000  ADDIS       R3,R0,$0
FF000078 60630000  ORI         R3,R3,$0
FF00007C 3DC00000  ADDIS       R14,R0,$0
FF000080 61CE5400  ORI         R14,R14,$5400
FF000084 7DC803A6  MTSPR       8,R14
FF000088 4E800020  BCLR        20,0

Thank you in advance.

Bye
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
