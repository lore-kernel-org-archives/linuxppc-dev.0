Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "wang cheng" <wangcheng@rails.com.cn>
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <3498237a46.37a4634982@rails.com.cn>
Date: Mon, 13 Oct 2003 13:15:32 +0800
MIME-Version: 1.0
Subject: I cann't initialize the OR/BR registers in cpu_init.c??
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello !
   all
   I'm porting u-boot-0.4.0 to my WindRiver MDP PRO board now,some
addressing specifications are listed below.I choose the

fads823 as the model.I have vision ICE ii & vision CLICK to program
flash and debug the code.
   I compile the code in the vmware linux environment.After "make
myboard_config" and  "make",I copy the u-boot(ELF) to the

vision CLICK path in windows environment£¬then Convert to .BIN file,
program to  flash,run,use the hyperterminal  as the

console.
   Now in the cpu_init.c ,I masked all the OR/BR initialization
clause,for when I released them there's nothing displayed on

the hyperterminal ;but when masked them ,the program can run to
the "=>"(after main_loop();)with the vision ICE II and to the

relocate_code()(in the board_init_f();)without the visionICE II ,some
register value are listed below in the vision CLICK BKM

mode.

**1.why I cann't initialize the OR/BR registers in the cpu_init.c
**2.how to modify the dram initialization to pass the relocate_code()
3.can you tell me something details about the BCSR register in the
FADS823 model.
4.are there any better model for WindRiver MDPRRO board ?

Any suggests are very appreciated!

specifications:
Addressing:
Total address range	4GB (on and off board)
Flash Memory 		1.0MB on board
			16MB SIMM (4MB Std.)
SRAM Memory 		2MB (512K Std.)
DRAM Memory 		32MB SIMM (16MB Std.)
EEPROM 			8K

>BKM>sc
****************** SIU              *****************
IMMR             xxxxxxxx  FF000000      SIUMCR           FF000000
00610000
SYPCR            FF000004  FFFFFF88      SWSR             FF00000E
0000
SIPEND           FF000010  00000000      SIMASK           FF000014
00400000
SIEL             FF000018  00000000      SIVEC            FF00001C
3C000000
TESR             FF000020  00000000      SDCR             FF000030
00004001

****************** UPM_A            *****************
UPMA_T0          FF00017C  0FF3FC00      UPMA_T1          FF00017C
1FF7FC07
UPMA_T2          FF00017C  FFFFFFFF      UPMA_T3          FF00017C
FFFFFFFF
 ......

****************** UPM_B            *****************
UPMB_T0          FF00017C  0FF3CC24      UPMB_T1          FF00017C
0FF3CC04
UPMB_T2          FF00017C  0CF3CC04      UPMB_T3          FF00017C
00F3CC04
UPMB_T4          FF00017C  00F3CC00      UPMB_T5          FF00017C
37F7CC47
UPMB_T6          FF00017C  FFFFFFFF      UPMB_T7          FF00017C
FFFFFFFF
U .....

****************** MEMC             *****************
BR0              FF000100  FFF00801      OR0              FF000104
FFF00760
BR1              FF000108  00000000      OR1              FF00010C
00000000
BR2              FF000110  000000C1      OR2              FF000114
FF000800
BR3              FF000118  00000000      OR3              FF00011C
00000000
BR4              FF000120  03000081      OR4              FF000124
FBF80010
BR5              FF000128  10000401      OR5              FF00012C
FFC00760
BR6              FF000130  00000000      OR6              FF000134
00000000
BR7              FF000138  00000000      OR7              FF00013C
00000000
MAR              FF000164  00000000      MCR              FF000168
0000001B
MAMR             FF000170  0C120111      MBMR             FF000174
2FB20111
MSTAT            FF000178  0000          MPTPR            FF00017A
0800
MDR              FF00017C  FF0C0027

****************** CLOCKS           *****************
SCCRK            FF000380  55CCAA33      SCCR             FF000280
01800000
PLPRCRK          FF000384  55CCAA33      PLPRCR           FF000284
00400000
RSRK             FF000388  55CCAA33      RSR              FF000288
D0000000

****************** SI               *****************
SIMODE           FF000AE0  00000000      SIGMR            FF000AE4
00
SISTR            FF000AE6  00            SICMR            FF000AE7
00
SICR             FF000AEC  00000000      SIRP             FF000AF0
00000000

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
