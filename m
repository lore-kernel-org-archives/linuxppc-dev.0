Return-Path: <pdfdoc15@yahoo.com>
Received: from web37105.mail.mud.yahoo.com (web37105.mail.mud.yahoo.com
	[209.191.85.107]) by ozlabs.org (Postfix) with SMTP id 4D12E679F2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 06:13:30 +1000 (EST)
Message-ID: <20060511201329.23866.qmail@web37105.mail.mud.yahoo.com>
Date: Thu, 11 May 2006 13:13:29 -0700 (PDT)
From: Om Vadlapatla <pdfdoc15@yahoo.com>
Subject: Failure of 2 BAT schemes to enable D-cache
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>,
	"U-Boot-Users@lists.sourceforge.net" <U-Boot-Users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-559561004-1147378409=:23616"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-559561004-1147378409=:23616
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hello,

Processor:                           MPC8270
Debugger:                            Abatron BDI 2000
Board & processor Initialization by: Uboot 1.1.2

Aim: 
I try to enable d-cache at the Register level with out
having any exceptions. I will write my own code to
compile into the kernel that is no longer supported by
Montavista (3.0) provided it works when I manipulate
the registers.

Proceedure:
~in window 1 (DIP window) I reset the processor then
the flash mem loads the U-boot version 1.1.2. I do not
load the OS so the system is running at the U-boot
prompt.

=>

~In window 2 (BDI debugger window) I use the Abarton
BDI to force the PPC to enter debug mode by issuing -
"halt" instruction.
//this is the BDI window for both tests when "halt"
MPC8270>halt
 Target CPU        : MPC8280/MGT5200 (Zeppo)
    Target state      : debug mode
    Debug entry cause : COP halt
    Current PC        : 0x0ffe935c
    Current CR        : 0x44004044
    Current MSR       : 0x0000b002
    Current LR        : 0x0ffe13a8

~now by issueing commands from the BDI I try to set
the BATs and the MMU as follows:

I tried two BAT schemes on the abatron that are
attached in BAT_register_setting_table.txt &
8280_InitMMU.cmm :
-------------------------------------------------------
Test 1:- 

For seting DBAT regs by BDI commands ccording to
(BAT_register_setting_table.txt)or:

// initialize bats  
MPC8270>rm dbat0u 0xffe0003f
MPC8270>rm dbat0l 0xffe00022
MPC8270>rm dbat1u 0x00001fff
MPC8270>rm dbat1l 0x00000002
MPC8270>rm dbat2u 0x300007ff
MPC8270>rm dbat2l 0x30000002
MPC8270>rm dbat3u 0x400003FF
MPC8270>rm dbat3l 0x40000022
MPC8270>rm dbat4u 0xFB0001FF
MPC8270>rm dbat4l 0xFB000022
MPC8270>rm dbat5u 0xFE400003
MPC8270>rm dbat5l 0xFE400022
MPC8270>rm dbat6u 0xF0000003
MPC8270>rm dbat6l 0xF0000022
MPC8270>rm dbat7u 0xFF000003
MPC8270>rm dbat7l 0xFF000022

MPC8270>rm hid0 0x8000c088 // set HID0 to enable 
                           // I & D Cache

MPC8270>go // to let the processor run

I check the PC and it is at 0x200 the Machine check
exception. 
Please post suggestions to avoid the Exception!!
-------------------------------------------------------
Test 2:-
commands I issued throught Abatron BDI window:

// initialization of BATs refer to (8280_InitMMU.cmm)
// please keep in mind that even though these BAT 
// initialization are for a Stand alone systems I only
// plan to test if I am able to initialize the data 
// cache without the 0x200 (Machine check exception) 
// exception.

// 60-x SDRAM IBAT
MPC8270>rm ibat0u 0x000003fe // IBAT0U 32MB
MPC8270>rm ibat0l 0x00000002 // IBAT0L R/W

//IMMR IBAT
MPC8270>rm ibat1u 0x04700002 // IBAT1U 128KB
MPC8270>rm ibat1l 0x04700022 // IBAT0L I R/W

//Flash IBAT
MPC8270>rm ibat3u 0xff0000fe // IBAT3U 8MB
MPC8270>rm ibat3l 0xff000001 // IBAT3L R/O

//60-x SDRAM DBAT
MPC8270>rm dbat0u 0x000007fe // DBAT0U 16MB
MPC8270>rm dbat0l 0x00000002 // DBAT0L R/W

//Local SDRAM DBAT
MPC8270>rm dbat1u 0x0400007e //DBAT1U
MPC8270>rm dbat1l 0x0400002a //DBAT1L I,G R/W

//BCSR DBAT
MPC8270>rm dbat2u 0x0450007e //DBAT2U BCSR + IMMR
space
MPC8270>rm dbat2l 0x0450002a //DBAT2L I,G R/W

//Flash DBAT
MPC8270>rm dbat3u 0xff0000fe //DBAT3U 8MB
MPC8270>rm dbat3l 0xff000022 //DBAT3L I R/W

// the Bats initialize fine no problem till here 

// enable MMU (EE + ME + DR +IR)
MPC8270>rm msr 0x9030

// I feel I may be messing it up here (can some one
// please correct me?)

MPC8270>go // this is to let the processor run 
           // however ends up restarting the system 

// I dont issue the foll command coz of reset
MPC8270>rm hid0 0x8000c088  // this is to set and
                            // enable the I & D Caches
                            
This is how the DIP window where the boot prompt is
looks after this test 2:-
See attached file: DIP_outPut_test2_BATs.txt

Have I wrongly inilialized the MSR?
-------------------------------------------------------

Please post comments and suggestions of how I can
initialized MMU for d-cache performance. I am  new
to this.

Thanky you,
Best regards,

Om Vadlapatla

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-559561004-1147378409=:23616
Content-Type: application/octet-stream; name="8280_InitMMU.cmm"
Content-Transfer-Encoding: base64
Content-Description: 790078158-8280_InitMMU.cmm
Content-Disposition: attachment; filename="8280_InitMMU.cmm"

OyAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KOyBJbml0aWFs
aXplIEJBVHMNCjsgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioN
Cg0KSU5JVF9NTVU6DQoNCjsgKioqIEludmFsaWRhdGUgVExCcw0KDQpkLmEg
MHgxMDAwMAlhZGRpCXIyLDAsMzINCmQuYSAweDEwMDA0CW10Y3RyCXIyCQk7
IExvYWQgQ1RSIHdpdGggMzIuDQpkLmEgMHgxMDAwOAlhZGRpCXIzLDAsMAk7
IFVzZSByMyBhcyB0aGUgdGxiIGluZGV4DQpkLmEgMHgxMDAwQwl0bGJpZQly
MyAgICAgICAgICAgICAgICA7IGludmFsaWRhdGUgdGhlIHRsYiBlbnRyeQ0K
ZC5hIDB4MTAwMTAJc3luYw0KZC5hIDB4MTAwMTQJYWRkaQlyMyxyMywweDEw
MDAgICAgICA7IGluY3JlbWVudCB0aGUgaW5kZXgNCmQuYSAweDEwMDE4CWJk
bnoJMHgxMDAwQw0KZC5hIDB4MTAwMUMJYgkweDEwMDFDDQoNCnIucyBJUCAw
eDEwMDAwDQpnbw0Kd2FpdCAxbXMNCmJyZWFrDQoNCg0KOyAqKiogQ2xlYXIg
YWxsIFVwcGVyIEJBVHMNCmQucyBTUFI6MHgyMTggJWwgMAk7IERCQVQwVQ0K
ZC5zIFNQUjoweDIxQSAlbCAwCTsgREJBVDFVDQpkLnMgU1BSOjB4MjFDICVs
IDAJOyBEQkFUMlUNCmQucyBTUFI6MHgyMUUgJWwgMAk7IERCQVQzVQ0KZC5z
IFNQUjoweDIzOCAlbCAwCTsgREJBVDRVDQpkLnMgU1BSOjB4MjNBICVsIDAJ
OyBEQkFUNVUNCmQucyBTUFI6MHgyM0MgJWwgMAk7IERCQVQ2VQ0KZC5zIFNQ
UjoweDIzRSAlbCAwCTsgREJBVDdVDQoNCmQucyBTUFI6MHgyMTAgJWwgMAk7
IElCQVQwVQ0KZC5zIFNQUjoweDIxMiAlbCAwCTsgSUJBVDFVDQpkLnMgU1BS
OjB4MjE0ICVsIDAJOyBJQkFUMlUNCmQucyBTUFI6MHgyMTYgJWwgMAk7IElC
QVQzVQ0KZC5zIFNQUjoweDIzMCAlbCAwCTsgSUJBVDRVDQpkLnMgU1BSOjB4
MjMyICVsIDAJOyBJQkFUNVUNCmQucyBTUFI6MHgyMzQgJWwgMAk7IElCQVQ2
VQ0KZC5zIFNQUjoweDIzNiAlbCAwCTsgSUJBVDdVDQoNCjsgNjAteCBTRFJB
TSBJQkFUDQpkLnMgU1BSOjB4MjEwICVsIDB4MDAwMDAzRkUgCTsgSUJBVDBV
IDMyTUINCmQucyBTUFI6MHgyMTEgJWwgMHgwMDAwMDAwMiAJOyBJQkFUMEwg
Ui9XDQoNCjsgSU1NUiBJQkFUDQpkLnMgU1BSOjB4MjEyICVsIDB4MDQ3MDAw
MDIJOyBJQkFUMVUgMTI4S0INCmQucyBTUFI6MHgyMTMgJWwgMHgwNDcwMDAy
Mgk7IElCQVQwTCBJIFIvVw0KDQo7IEZsYXNoIElCQVQNCmQucyBTUFI6MHgy
MTYgJWwgMHhGRjAwMDBGRQk7IElCQVQzVSA4TUINCmQucyBTUFI6MHgyMTcg
JWwgMHhGRjAwMDAwMQk7IElCQVQzTCBSL08NCg0KOyA2MC14IFNEUkFNIERC
QVQNCmQucyBTUFI6MHgyMTggJWwgMHgwMDAwMDdGRQk7IERCQVQwVSAxNk1C
DQpkLnMgU1BSOjB4MjE5ICVsIDB4MDAwMDAwMDIJOyBEQkFUMEwgUi9XDQoN
CjsgTG9jYWwgU0RSQU0gREJBVA0KZC5zIFNQUjoweDIxQSAlbCAweDA0MDAw
MDdFCTsgREJBVDFVDQpkLnMgU1BSOjB4MjFCICVsIDB4MDQwMDAwMkEJOyBE
QkFUMUwgSSxHIFIvVw0KDQo7IEJDU1IgREJBVA0KZC5zIFNQUjoweDIxQyAl
bCAweDA0NTAwMDdFCTsgREJBVDJVIEJDU1IgKyBJTU1SIHNwYWNlDQpkLnMg
U1BSOjB4MjFEICVsIDB4MDQ1MDAwMkEJOyBEQkFUMkwgSSxHIFIvVw0KDQo7
IEZsYXNoIERCQVQNCmQucyBTUFI6MHgyMUUgJWwgMHhGRjAwMDBGRQk7IERC
QVQzVSA4TUINCmQucyBTUFI6MHgyMUYgJWwgMHhGRjAwMDAyMgk7IERCQVQz
TCBJIFIvVw0KDQo7IEVuYWJsZSBNTVUNCjtyLnMgTVNSICAweDkwMzAgICA7
IEVFICsgTUUgKyBEUiArIElSDQo=

--0-559561004-1147378409=:23616
Content-Type: text/plain; name="BAT_register_setting_table.txt"
Content-Description: 79201750-BAT_register_setting_table.txt
Content-Disposition: inline; filename="BAT_register_setting_table.txt"

BAT register setting table
I&D-BAT register setting (I-BAT register can not write W and G bit)

|---------------------------------------------------------------------------------------------|
|BAT-No |Base address	|Memory Size    |WIMG	  | BAT U	|BAT L	        |Remark       |
|-------|---------------|---------------|---------|-------------|---------------|-------------|
|0	|0xFFE00000	|2Mbyte		|0100     | FFE0003F	|FFE00022       |BOOT Memory  |
|-------|---------------|---------------|---------|-------------|---------------|-------------|
|1	|0x00000000	|256Mbyte	|0000	  | 00001FFF	|00000002	|60x-SDRAM    |
|-------|---------------|---------------|---------|-------------|---------------|-------------|
|2	|0x30000000	|64Mbyte	|0000	  | 300007FF	|30000002	|Local-SDRAM  |
|-------|---------------|---------------|---------|-------------|---------------|-------------|
|3	|0x40000000	|20Mbyte	|0100	  | 400003FF	|40000022	|SDH-I/O      |
|-------|---------------|---------------|---------|-------------|---------------|-------------|
|4	|0xFB000000	|12Mbyte	|0100	  | FB0001FF	|FB000022	|RTC and FPGA |
|-------|---------------|---------------|---------|-------------|---------------|-------------|
|5	|0xFE400000	|1Kbyte		|0100     | FE400003	|FE400022       |Compact-Flash|
|-------|---------------|---------------|---------|-------------|---------------|-------------|
|6	|0xF0000000	|128Kbyte	|0100	  | F0000003	|F0000022	|CPU(Master)  |
|-------|---------------|---------------|---------|-------------|---------------|-------------|
|7	|0xFF000000	|128Kbyte	|0100	  | FF000003	|FF000022	|CPU(Slave)** |
|---------------------------------------------------------------------------------------------|


    **No.7 of BAT register should be setting for FW4160

--0-559561004-1147378409=:23616
Content-Type: text/plain; name="DIP_outPut_Test1_BATs.txt"
Content-Description: 2552527863-DIP_outPut_Test1_BATs.txt
Content-Disposition: inline; filename="DIP_outPut_Test1_BATs.txt"

$ telnet 100.0.4.26 5003                                             
Trying 100.0.4.26...
Connected to 100.0.4.26.
Escape character is '^]'.


U-Boot 1.1.2 (Jan 27 2006 - 14:27:57) ### Release 1.1.5 ### 

MPC8260 Reset Status: Bus Monitor, External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 1, corecnf 0x1a, busdf 5, cpmdf 1, plldf 0, pllmf 5
 - vco_out  400000002, scc_clk  100000000, brg_clk   25000000
 - cpu_clk  266666668, cpm_clk  200000001, bus_clk   66666667

CPU:   MPC8260 (HiP7 Rev 14, Mask 1.0 1K49M) at 266.666 MHz
Board: Fujitsu FW4060
I2C:   ready
DRAM:  256 MB
FLASH:  2 MB
In:    serial
Out:   serial
Err:   serial
Net:   FCC2 ETHERNET
IDE:   Bus 0: OK 
  Device 0: Model: Hitachi XXM2.3.0 Firm: Rev 3.00 Ser#: X0405 20050304185152
            Type: Removable Hard Disk
            Capacity: 61.1 MB = 0.0 GB (125184 x 512)
Hit any key to stop autoboot:  0 
=> Bad trap at PC: fffffffc, SR: 1000, vector=800
NIP: FFFFFFFC XER: 20000000 LR: 00001088 REGS: 0ffa7dc0 TRAP: 0800 DAR: 0FFE55FC
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: 0000A000 0FFA7EB0 00000004 00000000 0FFF0E80 0000000A FFFFFFFD FFFFFFFF 
GPR08: 0FFA7C18 F0000080 00008000 F0000090 00000000 0403FF80 0FFF6000 101C8000 
GPR16: 00000000 00000000 00000000 0100FFE0 00000000 00000001 00000000 00000000 
GPR24: 00000000 FFFFFFFF 00000001 00000003 0FFFEFC8 0FFA7F64 0FFF74AC 0FFF0E80 
Call backtrace: 
Exception in kernel pc fffffffc signal 0

U-Boÿ

U-Boot 1.1.2 (Jan 27 2006 - 14:27:57) ### Release 1.1.5 ### 

MPC8260 Reset Status: External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 1, corecnf 0x1a, busdf 5, cpmdf 1, plldf 0, pllmf 5
 - vco_out  400000002, scc_clk  100000000, brg_clk   25000000
 - cpu_clk  266666668, cpm_clk  200000001, bus_clk   66666667

CPU:   MPC8260 (HiP7 Rev 14, Mask 1.0 1K49M) at 266.666 MHz
Board: Fujitsu FW4060
I2C:   ready
DRAM:  256 MB
FLASH:  2 MB
In:    serial
Out:   serial
Err:   serial
Net:   FCC2 ETHERNET
IDE:   Bus 0: OK 
  Device 0: Model: Hitachi XXM2.3.0 Firm: Rev 3.00 Ser#: X0405 20050304185152
            Type: Removable Hard Disk
            Capacity: 61.1 MB = 0.0 GB (125184 x 512)
Hit any key to stop autoboot:  0 
=> Bad trap at PC: fffffffc, SR: 1000, vector=800
NIP: FFFFFFFC XER: 00000000 LR: 00001088 REGS: 0ffa7dc0 TRAP: 0800 DAR: 0FFE55FC
MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: 0000A000 0FFA7EB0 00000004 00000000 0FFF0E80 0000000A FFFFFFFD 00000000 
GPR08: 00000002 F0000080 00008000 F0000090 00000000 0403FF80 0FFF6000 101C8000 
GPR16: 00000000 00000000 00000000 0100FFE0 00003002 00000001 00000000 0FFCB098 
GPR24: 0FFCE410 00000001 00000001 00000003 0FFFEFC8 0FFA7F64 0FFF74AC 0FFF0E80 
Call backtrace: 
Exception in kernel pc fffffffc signal 0


U-Boot 1.1.2 (Jan 27 2006 - 14:ò



--0-559561004-1147378409=:23616--
