Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 16239679FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 00:12:43 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 29DD08780C3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 07:12:42 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r68u071242D-01-2
	for linuxppc-embedded@ozlabs.org; Wed, 30 Aug 2006 07:12:42 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id CC7B58780C1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 07:12:41 -0700 (PDT)
Message-ID: <44F59CDB.7090705@gmail.com>
Date: Wed, 30 Aug 2006 19:42:43 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: could not access the address in linux-System ace driver
References: <20060724121452.55760.qmail@web53608.mail.yahoo.com>	<44C4BE5B.3000002@gmail.com>	<44D9F9DF.5020100@gmail.com>	<44DC4F34.1070308@gmail.com>
	<44DC5F21.8000906@gmail.com> <44EB1DC2.5070307@gmail.com>
In-Reply-To: <44EB1DC2.5070307@gmail.com>
Content-Type: multipart/alternative;
	boundary="------------000809020608010607090004"
Cc: raja_chidambaram82@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000809020608010607090004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello All

I'm really desperate for some help , I've been struggling with this 
system since few days.

sudheer wrote:
> Hello Raja,
>
> We too are working on customized board with amcc 440SPe processor , 
> xilinx System Ace controller.  Compact flash  is connected to system 
> ace controller. 
> We use u-boot 1.1.2 as bootloader & linux kernel - 2.6.16-2.
>
> System ace is connected to amcc440SPE processor via GPIO and External 
> Peripheral Bus Controller(EBC).
I am still facing the issue in accessing the address in linux.

The physical address given in u-boot  init.S tlbentry for 'system ace'  
is 0xE0000000
I am able to access the address in u-boot  and everything is fine in u-boot.
But in linux , I am able to ioremap the the address 0xE0000000 but the 
kernel crashes when i try to access the address .
physical address=0xe0000000
address_after_ioremap = 0xe1000000.
I am trying to read with readw(address_after_ioremap)
The kernel gives an exception error saying Oops: machine check, sig: 7 
[#2] .
The error dump is as below:

Instruction dump:
Data machine check in kernel mode.
PLB0: BEAR=0x00000000e0000000 ACR=  0xdb000000 BESR= 0x0000000000008000
PLB1: BEAR=0xe98d7ad33716ee7e ACR=  0xdb000000 BESR= 0x0000000000000000
POB0: BEAR=0x0000000fffaebbcd BESR0=0x00000000 BESR1=0x00000000
OPB0: BEAR=0x0000000000000000 BSTAT=0x00000000
Oops: machine check, sig: 7 [#2]
NIP: 00000000 LR: C0002200 CTR: 00000000
REGS: c0241f50 TRAP: 0202   Not tainted  (2.6.16.2)
MSR: 00000000 <>  CR: 84CA4124  XER: 00000000
TASK = dff6cb70[1] 'swapper' THREAD: c0740000
GPR00: 00000000 C0241E40 DFF6CB70 00000001 FFFFFFD0 00000000 C0240000 
C01F3C0C
GPR08: C01F0000 C0002200 00021002 C0001FF4 DFF6CD38 802823E0 1FFB9600 
00000000
GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3540 1FF63CE0 1FFCEE78 
C01C0000
GPR24: C01C0000 C01C0000 C01F0000 C01C0000 BFFFFFFF FFFFFFD0 00000000 
C0241F50
NIP [00000000] 0x0
LR [C0002200] ret_from_except+0x0/0x18
Call Trace:
Instruction dump:
Data machine check in kernel mode.
PLB0: BEAR=0x00000000e0000000 ACR=  0xdb000000 BESR= 0x0000000000008000
.........and this dump gets print continously.


I have checked with TLB entries in u-boot and linux using BDI:

BDI_AMCC440SPe>tlb 0 10
IDX TID      EPN  SIZE VTS          RPN   USER WIMGE USRSVC
 0 : 00 ff000000  16MB V0 -> 4_ff000000 U:0000 WI-G- XWRXWR
 1 : 00 00000000 256MB V0 -> 0_00000000 U:0000 -I-G- XWRXWR
 2 : 00 10000000 256MB V0 -> 0_10000000 U:0000 -I-G- XWRXWR
 3 : 00 20000000 256MB V0 -> 0_20000000 U:0000 -I-G- XWRXWR
 4 : 00 30000000 256MB V0 -> 0_30000000 U:0000 -I-G- XWRXWR
 5 : 00 90000000 256KB V0 -> 4_00000000 U:0000 -I--- XWRXWR
 6 : 00 e0000000   1KB V0 -> 4_e0000000 U:0000 -I-G- -WR-WR
 7 : 00 a0000000   4KB V0 -> 4_f0000000 U:0000 -I-G- -WR-WR
 8 : 00 d0000000 256MB V0 -> c_00000000 U:0000 -I-G- -WR-WR
 9 : 00 80000000 256MB V0 -> c_10000000 U:0000 -I-G- -WR-WR
10 : 00 01080000   1KB -0 -> 0_00000000 U:0000 ----- ------
BDI_AMCC440SPe>

In Linux the tlb entries are as below.......

BDI_AMCC440SPe>tlb 0 63
IDX TID      EPN  SIZE VTS          RPN   USER WIMGE USRSVC
 0 : 0e 0ff1a000   4KB V0 -> 0_007ce000 U:0000 --MG- --R--R
 1 : 0e 0fe94000   4KB V0 -> 0_1ff96000 U:0000 ---G- X-RX-R
 2 : 0e 30017000   4KB V0 -> 0_007cd000 U:0000 --MG- --R-WR
 3 : 0e 10039000   4KB V0 -> 0_1ffb8000 U:0000 ---G- X-RX-R
 4 : 0e 30009000   4KB V0 -> 0_00758000 U:0000 ---G- X-RX-R
 5 : 0e 30010000   4KB V0 -> 0_0078b000 U:0000 ---G- X-RX-R
 6 : 0e 00000000   1KB -0 -> 0_1f4e2000 U:0000 ---G- --R--R
 7 : 0e 0fe3e000   4KB V0 -> 0_1f4e2000 U:0000 ---G- X-RX-R
 8 : 0e 0ff1c000   4KB V0 -> 0_007ed000 U:0000 --MG- XWRXWR
 9 : 0e 0ff1e000   4KB V0 -> 0_007ee000 U:0000 --MG- -WR-WR
10 : 0e 0ff1f000   4KB V0 -> 0_007ea000 U:0000 --MG- XWRXWR
11 : 0e 0fe39000   4KB V0 -> 0_1ff8e000 U:0000 ---G- X-RX-R
12 : 0e 0ff21000   4KB V0 -> 0_007a8000 U:0000 --MG- --R-WR
13 : 0e 0fe47000   4KB V0 -> 0_1ffa9000 U:0000 ---G- X-RX-R
14 : 0e 0fe46000   4KB V0 -> 0_1ffb2000 U:0000 ---G- X-RX-R
15 : 0e 30019000   4KB V0 -> 0_007c5000 U:0000 --MG- -WR-WR
16 : 0e 0fe45000   4KB V0 -> 0_1ffa8000 U:0000 ---G- X-RX-R
17 : 00 fdfff000   4KB V0 -> 4_f0000000 U:0000 -IMG- ----WR
18 : 0e 0fe9a000   4KB V0 -> 0_1ff98000 U:0000 ---G- X-RX-R
19 : 0e 10067000   4KB V0 -> 0_0078e000 U:0000 --MG- -WR-WR
20 : 0e 00000000   4KB -0 -> 0_1f4e5000 U:0000 ---G- --R--R
21 : 0e 10030000   4KB V0 -> 0_1f4e5000 U:0000 ---G- X-RX-R
22 : 0e 10063000   4KB V0 -> 0_007b7000 U:0000 --MG- -WR-WR
23 : 0e 0fe4c000   4KB V0 -> 0_1ff9b000 U:0000 ---G- X-RX-R
24 : 0e 1007f000   4KB V0 -> 0_007e0000 U:0000 --MG- -WR-WR
25 : 0e 0ff1d000   4KB V0 -> 0_007c6000 U:0000 --MG- --R-WR
26 : 0e 0fe4e000   4KB V0 -> 0_1ffa1000 U:0000 ---G- X-RX-R
27 : 0e 0fe0f000   4KB V0 -> 0_0077e000 U:0000 ---G- X-RX-R
28 : 0e 0fe52000   4KB V0 -> 0_0077f000 U:0000 ---G- X-RX-R
29 : 0e 0fe53000   4KB V0 -> 0_1ff80000 U:0000 ---G- X-RX-R
30 : 0e 0fef9000   4KB V0 -> 0_1ff81000 U:0000 ---G- --R--R
31 : 0e 0fe3b000   4KB V0 -> 0_1ffa7000 U:0000 ---G- X-RX-R
32 : 0e 7f901000   4KB V0 -> 0_007db000 U:0000 --MG- -WR-WR
33 : 0e 10027000   4KB V0 -> 0_1ffd0000 U:0000 ---G- X-RX-R
34 : 0e 1003a000   4KB V0 -> 0_1ffb6000 U:0000 ---G- X-RX-R
35 : 0e 0fe51000   4KB V0 -> 0_00775000 U:0000 ---G- X-RX-R
36 : 0e 1003b000   4KB V0 -> 0_1ffb7000 U:0000 ---G- X-RX-R
37 : 0e 1002a000   4KB V0 -> 0_1ffcf000 U:0000 ---G- X-RX-R
38 : 0e 10066000   4KB V0 -> 0_007de000 U:0000 --MG- -WR-WR
39 : 0e 1002b000   4KB V0 -> 0_1ffd3000 U:0000 ---G- X-RX-R
40 : 0e 1002c000   4KB V0 -> 0_1ffd2000 U:0000 ---G- X-RX-R
41 : 0e 1005d000   4KB V0 -> 0_007f4000 U:0000 --MG- XWRXWR
42 : 0e 1002d000   4KB V0 -> 0_1ffc2000 U:0000 ---G- X-RX-R
43 : 0e 10028000   4KB V0 -> 0_1ffc8000 U:0000 ---G- X-RX-R
44 : 0e 10069000   4KB V0 -> 0_0078d000 U:0000 --MG- -WR-WR
45 : 0e 1002e000   4KB V0 -> 0_1ffd4000 U:0000 ---G- X-RX-R
46 : 0e 1005e000   4KB V0 -> 0_007a7000 U:0000 --MG- X-RXWR
47 : 0e 0fe11000   4KB V0 -> 0_0077a000 U:0000 ---G- X-RX-R
48 : 0e 10047000   4KB V0 -> 0_1ffcd000 U:0000 ---G- --R--R
49 : 0e 1007e000   4KB V0 -> 0_007d0000 U:0000 --MG- --R-WR
50 : 0e 0fea1000   4KB V0 -> 0_1ffd5000 U:0000 ---G- X-RX-R
51 : 0e 10026000   4KB V0 -> 0_1ffc9000 U:0000 ---G- X-RX-R
52 : 0e 0fe0e000   4KB V0 -> 0_1ffd1000 U:0000 ---G- X-RX-R
53 : 0e 0fe96000   4KB V0 -> 0_1ffce000 U:0000 ---G- X-RX-R
54 : 0e 1002f000   4KB V0 -> 0_1f4c1000 U:0000 ---G- X-RX-R
55 : 0e 7f900000   4KB V0 -> 0_0078f000 U:0000 --MG- -WR-WR
56 : 0e 10036000   4KB V0 -> 0_1f4c0000 U:0000 ---G- X-RX-R
57 : 0e 1004b000   4KB V0 -> 0_1ffcc000 U:0000 ---G- --R--R
58 : 0e 0fe9b000   4KB V0 -> 0_1ff88000 U:0000 ---G- X-RX-R
59 : 0e 0fe4d000   4KB V0 -> 0_1ffa0000 U:0000 ---G- X-RX-R
60 : 0e 10080000   4KB V0 -> 0_00793000 U:0000 --MG- -WR-WR
61 : 0e 0fe95000   4KB V0 -> 0_1ff99000 U:0000 ---G- X-RX-R
62 : 00 d0000000 256MB V0 -> 0_10000000 U:0000 ---G- ---XWR
63 : 00 c0000000 256MB V0 -> 0_00000000 U:0000 ---G- ---XWR
BDI_AMCC440SPe>

I could not see the tlb entry for system ace in the linux level, But in 
the kernel error message, the physical address address can be seen
EBC's BEAR=0x00000000e0000000 saying the ioremap is done properly and 
phys-addr is obtaining from virtual adr given.
I could not understand what is going wrong. When i try to read/write 
using the ioremapped address, the kernel crashes. Even from the 
Error/Status reg(EBC's BESR in the error dump) could not get any 
information.

Can someone please be so kind to help me debug this...what might be 
wrong / what should I do to try and get a better understanding of what 
is going wrong?

please let me if any details required.

Thank you in advance

Regards
Sudheer


>
> While booting the linux, it crashes when i am trying to 
> access(read/write) a system ace register.
> In the u-boot though i have support, as of now  i am not doing 
> anything with system ace as it not required now.
> In u-boot/include/configs/custom_board.h, i could see
> #define CFG_ACE_BASE        0xe0000000          /* Xilinx ACE 
> controller - Compact Flash */
>  So i have used this address in Linux driver to to ioremap to access 
> the  ace registers. Though i could do ioremap,  it crashes while 
> booting exactly when it is trying the access any ace register.
>
> I doubt with the address i have used . But could not get any clue from 
> the docs given.  
>
> I want to know how to access the system ace registers and how to  get 
> the address to ioremap. Please let me know if any details required and 
> also if i am missing any fundamentals.
>
>
> Thanks & Regards
> Sudheer
>
>
>
>
> sudheer wrote:
>> Hi Ameet,
>>
>> Firstly, thanks for the mail.
>>
>> I am able to compile the linux-2.6.16 and got the ace support files with 
>> the patch.
>> While compiling got some errors with  xparameters, but am rectify  them.
>>
>> I need to wait for the hardware to test the source.
>>
>> Thanks & Regards
>> Sudheer
>>
>>
>> Ameet Patil wrote:
>>   
>>> Hi Sudheer,
>>>    Frank has already answered your questions. If you have any problems 
>>> with the SysAce patch... do let me know. I have written a small 
>>> tutorial here if it helps...
>>>
>>> http://linux.get2knowmore.com
>>>
>>>
>>> -Ameet
>>>
>>> sudheer wrote:
>>>     
>>>> Hello Ameet Patil
>>>>
>>>> I am looking for linux kernel source 2.6.16 with system ace 
>>>> controller support. I downloaded the linux-2.6.16 and linux-2.6.17-1 
>>>> source from kernel.org but could not find any files related to system 
>>>> ace controller  ( No xilinx_sysace directory in  drivers/block/) .  I 
>>>> have checked penguinppc.org also but could not get it.
>>>>
>>>> Can you please send to me the link where i could download the 
>>>> linuxppc-2.6.16 source with system ace support.
>>>>
>>>> Thanks & Regards
>>>> Sudheer
>>>>
>>>> Ameet Patil wrote:
>>>>       
>>>>> Hi Raja,
>>>>>     I have ported the Xilinx System ACE driver to 2.6 kernel. Find 
>>>>> the latest one here:
>>>>> http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch 
>>>>>
>>>>>
>>>>> NOTE: this patch wouldn't work if you are using the TEMAC driver. In 
>>>>> which case use the -after-TEMAC patch found in the patches folder 
>>>>> above.
>>>>>
>>>>> Check the following discussions (threads) for more details:
>>>>> 1. "Xilinx SystemACE driver for 2.6"
>>>>> 2. "Xilinx BSP for linux 2.6"
>>>>> 3. "Kernel hangs after "Now booting the kernel"."
>>>>>
>>>>> cheers,
>>>>> -Ameet
>>>>>
>>>>> Raja Chidambaram wrote:
>>>>>  
>>>>>         
>>>>>>  Hi all,
>>>>>>  We are working on customized board with amcc 440SPe
>>>>>> processor & xilinx System Ace controller. The System
>>>>>> Ace controller is connected to compact flash driver.
>>>>>>
>>>>>> We use u-boot 1.2 as bootloader & linux kernel
>>>>>> 2.6.16-2.
>>>>>>
>>>>>> On the process the u-boot is able to detect compact
>>>>>> flash through Xilinx SystemAce controller & able to
>>>>>> load the kernel image into compact flash.But when the
>>>>>> linux boot's up it not able to detect the System Ace
>>>>>> controller or compact flash.
>>>>>>
>>>>>> Note:we need to have the root file system in compact
>>>>>> flash.
>>>>>>
>>>>>> Is their any drivers available for SystemAce
>>>>>> controller on linux 2.6,if their how to get it.please
>>>>>> help me in this
>>>>>>                                     with regards
>>>>>>                                      raja
>>>>>>
>>>>>>
>>>>>>
>>>>>> __________________________________________________
>>>>>> Do You Yahoo!?
>>>>>> Tired of spam?  Yahoo! Mail has the best spam protection around 
>>>>>> http://mail.yahoo.com _______________________________________________
>>>>>> Linuxppc-embedded mailing list
>>>>>> Linuxppc-embedded@ozlabs.org
>>>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>>>
>>>>>>     
>>>>>>           
>>>>> _______________________________________________
>>>>> Linuxppc-embedded mailing list
>>>>> Linuxppc-embedded@ozlabs.org
>>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>>
>>>>>   
>>>>>         
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>   
>


--------------000809020608010607090004
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hello All <br>
<br>
I'm really desperate for some help , I've been struggling with this
system since few days.<br>
<br>
sudheer wrote:
<blockquote cite="mid44EB1DC2.5070307@gmail.com" type="cite">
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
Hello Raja,<br>
  <br>
We too are working on customized board with amcc 440SPe processor ,
xilinx System Ace controller.&nbsp; Compact flash&nbsp; is connected to system
ace controller.&nbsp; <br>
We use u-boot 1.1.2 as bootloader &amp; linux kernel - 2.6.16-2.<br>
  <br>
System ace is connected to amcc440SPE processor via GPIO and External
Peripheral Bus Controller(EBC).<br>
</blockquote>
I am still facing the issue in accessing the address in linux.<br>
<br>
The physical address given in u-boot&nbsp; init.S tlbentry for 'system ace'&nbsp;
is 0xE0000000<br>
I am able to access the address in u-boot&nbsp; and everything is fine in
u-boot.<br>
But in linux , I am able to ioremap the the address 0xE0000000 but the
kernel crashes when i try to access the address .<br>
physical address=0xe0000000<br>
address_after_ioremap = 0xe1000000.<br>
I am trying to read with readw(address_after_ioremap)<br>
The kernel gives an exception error saying Oops: machine check, sig: 7
[#2] .<br>
The error dump is as below:<br>
<br>
Instruction dump:<br>
Data machine check in kernel mode.<br>
PLB0: BEAR=0x00000000e0000000 ACR=&nbsp; 0xdb000000 BESR= 0x0000000000008000<br>
PLB1: BEAR=0xe98d7ad33716ee7e ACR=&nbsp; 0xdb000000 BESR= 0x0000000000000000<br>
POB0: BEAR=0x0000000fffaebbcd BESR0=0x00000000 BESR1=0x00000000<br>
OPB0: BEAR=0x0000000000000000 BSTAT=0x00000000<br>
Oops: machine check, sig: 7 [#2]<br>
NIP: 00000000 LR: C0002200 CTR: 00000000<br>
REGS: c0241f50 TRAP: 0202&nbsp;&nbsp; Not tainted&nbsp; (2.6.16.2)<br>
MSR: 00000000 &lt;&gt;&nbsp; CR: 84CA4124&nbsp; XER: 00000000<br>
TASK = dff6cb70[1] 'swapper' THREAD: c0740000<br>
GPR00: 00000000 C0241E40 DFF6CB70 00000001 FFFFFFD0 00000000 C0240000
C01F3C0C<br>
GPR08: C01F0000 C0002200 00021002 C0001FF4 DFF6CD38 802823E0 1FFB9600
00000000<br>
GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3540 1FF63CE0 1FFCEE78
C01C0000<br>
GPR24: C01C0000 C01C0000 C01F0000 C01C0000 BFFFFFFF FFFFFFD0 00000000
C0241F50<br>
NIP [00000000] 0x0<br>
LR [C0002200] ret_from_except+0x0/0x18<br>
Call Trace:<br>
Instruction dump:<br>
Data machine check in kernel mode.<br>
PLB0: BEAR=0x00000000e0000000 ACR=&nbsp; 0xdb000000 BESR= 0x0000000000008000<br>
.........and this dump gets print continously.<br>
<br>
<br>
I have checked with TLB entries in u-boot and linux using BDI:<br>
<br>
BDI_AMCC440SPe&gt;tlb 0 10<br>
IDX TID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EPN&nbsp; SIZE VTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RPN&nbsp;&nbsp; USER WIMGE USRSVC<br>
&nbsp;0 : 00 ff000000&nbsp; 16MB V0 -&gt; 4_ff000000 U:0000 WI-G- XWRXWR<br>
&nbsp;1 : 00 00000000 256MB V0 -&gt; 0_00000000 U:0000 -I-G- XWRXWR<br>
&nbsp;2 : 00 10000000 256MB V0 -&gt; 0_10000000 U:0000 -I-G- XWRXWR<br>
&nbsp;3 : 00 20000000 256MB V0 -&gt; 0_20000000 U:0000 -I-G- XWRXWR<br>
&nbsp;4 : 00 30000000 256MB V0 -&gt; 0_30000000 U:0000 -I-G- XWRXWR<br>
&nbsp;5 : 00 90000000 256KB V0 -&gt; 4_00000000 U:0000 -I--- XWRXWR<br>
&nbsp;6 : 00 e0000000&nbsp;&nbsp; 1KB V0 -&gt; 4_e0000000 U:0000 -I-G- -WR-WR<br>
&nbsp;7 : 00 a0000000&nbsp;&nbsp; 4KB V0 -&gt; 4_f0000000 U:0000 -I-G- -WR-WR<br>
&nbsp;8 : 00 d0000000 256MB V0 -&gt; c_00000000 U:0000 -I-G- -WR-WR<br>
&nbsp;9 : 00 80000000 256MB V0 -&gt; c_10000000 U:0000 -I-G- -WR-WR<br>
10 : 00 01080000&nbsp;&nbsp; 1KB -0 -&gt; 0_00000000 U:0000 ----- ------<br>
BDI_AMCC440SPe&gt;<br>
<br>
In Linux the tlb entries are as below.......<br>
<br>
BDI_AMCC440SPe&gt;tlb 0 63<br>
IDX TID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EPN&nbsp; SIZE VTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RPN&nbsp;&nbsp; USER WIMGE USRSVC<br>
&nbsp;0 : 0e 0ff1a000&nbsp;&nbsp; 4KB V0 -&gt; 0_007ce000 U:0000 --MG- --R--R<br>
&nbsp;1 : 0e 0fe94000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ff96000 U:0000 ---G- X-RX-R<br>
&nbsp;2 : 0e 30017000&nbsp;&nbsp; 4KB V0 -&gt; 0_007cd000 U:0000 --MG- --R-WR<br>
&nbsp;3 : 0e 10039000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffb8000 U:0000 ---G- X-RX-R<br>
&nbsp;4 : 0e 30009000&nbsp;&nbsp; 4KB V0 -&gt; 0_00758000 U:0000 ---G- X-RX-R<br>
&nbsp;5 : 0e 30010000&nbsp;&nbsp; 4KB V0 -&gt; 0_0078b000 U:0000 ---G- X-RX-R<br>
&nbsp;6 : 0e 00000000&nbsp;&nbsp; 1KB -0 -&gt; 0_1f4e2000 U:0000 ---G- --R--R<br>
&nbsp;7 : 0e 0fe3e000&nbsp;&nbsp; 4KB V0 -&gt; 0_1f4e2000 U:0000 ---G- X-RX-R<br>
&nbsp;8 : 0e 0ff1c000&nbsp;&nbsp; 4KB V0 -&gt; 0_007ed000 U:0000 --MG- XWRXWR<br>
&nbsp;9 : 0e 0ff1e000&nbsp;&nbsp; 4KB V0 -&gt; 0_007ee000 U:0000 --MG- -WR-WR<br>
10 : 0e 0ff1f000&nbsp;&nbsp; 4KB V0 -&gt; 0_007ea000 U:0000 --MG- XWRXWR<br>
11 : 0e 0fe39000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ff8e000 U:0000 ---G- X-RX-R<br>
12 : 0e 0ff21000&nbsp;&nbsp; 4KB V0 -&gt; 0_007a8000 U:0000 --MG- --R-WR<br>
13 : 0e 0fe47000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffa9000 U:0000 ---G- X-RX-R<br>
14 : 0e 0fe46000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffb2000 U:0000 ---G- X-RX-R<br>
15 : 0e 30019000&nbsp;&nbsp; 4KB V0 -&gt; 0_007c5000 U:0000 --MG- -WR-WR<br>
16 : 0e 0fe45000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffa8000 U:0000 ---G- X-RX-R<br>
17 : 00 fdfff000&nbsp;&nbsp; 4KB V0 -&gt; 4_f0000000 U:0000 -IMG- ----WR<br>
18 : 0e 0fe9a000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ff98000 U:0000 ---G- X-RX-R<br>
19 : 0e 10067000&nbsp;&nbsp; 4KB V0 -&gt; 0_0078e000 U:0000 --MG- -WR-WR<br>
20 : 0e 00000000&nbsp;&nbsp; 4KB -0 -&gt; 0_1f4e5000 U:0000 ---G- --R--R<br>
21 : 0e 10030000&nbsp;&nbsp; 4KB V0 -&gt; 0_1f4e5000 U:0000 ---G- X-RX-R<br>
22 : 0e 10063000&nbsp;&nbsp; 4KB V0 -&gt; 0_007b7000 U:0000 --MG- -WR-WR<br>
23 : 0e 0fe4c000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ff9b000 U:0000 ---G- X-RX-R<br>
24 : 0e 1007f000&nbsp;&nbsp; 4KB V0 -&gt; 0_007e0000 U:0000 --MG- -WR-WR<br>
25 : 0e 0ff1d000&nbsp;&nbsp; 4KB V0 -&gt; 0_007c6000 U:0000 --MG- --R-WR<br>
26 : 0e 0fe4e000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffa1000 U:0000 ---G- X-RX-R<br>
27 : 0e 0fe0f000&nbsp;&nbsp; 4KB V0 -&gt; 0_0077e000 U:0000 ---G- X-RX-R<br>
28 : 0e 0fe52000&nbsp;&nbsp; 4KB V0 -&gt; 0_0077f000 U:0000 ---G- X-RX-R<br>
29 : 0e 0fe53000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ff80000 U:0000 ---G- X-RX-R<br>
30 : 0e 0fef9000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ff81000 U:0000 ---G- --R--R<br>
31 : 0e 0fe3b000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffa7000 U:0000 ---G- X-RX-R<br>
32 : 0e 7f901000&nbsp;&nbsp; 4KB V0 -&gt; 0_007db000 U:0000 --MG- -WR-WR<br>
33 : 0e 10027000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffd0000 U:0000 ---G- X-RX-R<br>
34 : 0e 1003a000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffb6000 U:0000 ---G- X-RX-R<br>
35 : 0e 0fe51000&nbsp;&nbsp; 4KB V0 -&gt; 0_00775000 U:0000 ---G- X-RX-R<br>
36 : 0e 1003b000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffb7000 U:0000 ---G- X-RX-R<br>
37 : 0e 1002a000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffcf000 U:0000 ---G- X-RX-R<br>
38 : 0e 10066000&nbsp;&nbsp; 4KB V0 -&gt; 0_007de000 U:0000 --MG- -WR-WR<br>
39 : 0e 1002b000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffd3000 U:0000 ---G- X-RX-R<br>
40 : 0e 1002c000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffd2000 U:0000 ---G- X-RX-R<br>
41 : 0e 1005d000&nbsp;&nbsp; 4KB V0 -&gt; 0_007f4000 U:0000 --MG- XWRXWR<br>
42 : 0e 1002d000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffc2000 U:0000 ---G- X-RX-R<br>
43 : 0e 10028000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffc8000 U:0000 ---G- X-RX-R<br>
44 : 0e 10069000&nbsp;&nbsp; 4KB V0 -&gt; 0_0078d000 U:0000 --MG- -WR-WR<br>
45 : 0e 1002e000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffd4000 U:0000 ---G- X-RX-R<br>
46 : 0e 1005e000&nbsp;&nbsp; 4KB V0 -&gt; 0_007a7000 U:0000 --MG- X-RXWR<br>
47 : 0e 0fe11000&nbsp;&nbsp; 4KB V0 -&gt; 0_0077a000 U:0000 ---G- X-RX-R<br>
48 : 0e 10047000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffcd000 U:0000 ---G- --R--R<br>
49 : 0e 1007e000&nbsp;&nbsp; 4KB V0 -&gt; 0_007d0000 U:0000 --MG- --R-WR<br>
50 : 0e 0fea1000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffd5000 U:0000 ---G- X-RX-R<br>
51 : 0e 10026000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffc9000 U:0000 ---G- X-RX-R<br>
52 : 0e 0fe0e000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffd1000 U:0000 ---G- X-RX-R<br>
53 : 0e 0fe96000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffce000 U:0000 ---G- X-RX-R<br>
54 : 0e 1002f000&nbsp;&nbsp; 4KB V0 -&gt; 0_1f4c1000 U:0000 ---G- X-RX-R<br>
55 : 0e 7f900000&nbsp;&nbsp; 4KB V0 -&gt; 0_0078f000 U:0000 --MG- -WR-WR<br>
56 : 0e 10036000&nbsp;&nbsp; 4KB V0 -&gt; 0_1f4c0000 U:0000 ---G- X-RX-R<br>
57 : 0e 1004b000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffcc000 U:0000 ---G- --R--R<br>
58 : 0e 0fe9b000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ff88000 U:0000 ---G- X-RX-R<br>
59 : 0e 0fe4d000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ffa0000 U:0000 ---G- X-RX-R<br>
60 : 0e 10080000&nbsp;&nbsp; 4KB V0 -&gt; 0_00793000 U:0000 --MG- -WR-WR<br>
61 : 0e 0fe95000&nbsp;&nbsp; 4KB V0 -&gt; 0_1ff99000 U:0000 ---G- X-RX-R<br>
62 : 00 d0000000 256MB V0 -&gt; 0_10000000 U:0000 ---G- ---XWR<br>
63 : 00 c0000000 256MB V0 -&gt; 0_00000000 U:0000 ---G- ---XWR<br>
BDI_AMCC440SPe&gt;<br>
<br>
I could not see the tlb entry for system ace in the linux level, But in
the kernel error message, the physical address address can be seen <br>
EBC's BEAR=0x00000000e0000000 saying the ioremap is done properly and
phys-addr is obtaining from virtual adr given. <br>
I could not understand what is going wrong. When i try to read/write
using the ioremapped address, the kernel crashes. Even from the
Error/Status reg(EBC's BESR in the error dump) could not get any
information.<br>
<br>
Can someone please be so kind to help me debug this...what might be
wrong / what should I do to try and get a better understanding of what
is going wrong?<br>
<br>
please let me if any details required.<br>
<br>
Thank you in advance<br>
<br>
Regards<br>
Sudheer<br>
<br>
<br>
<blockquote cite="mid44EB1DC2.5070307@gmail.com" type="cite"><br>
While booting the linux, it crashes when i am trying to
access(read/write) a system ace register.<br>
In the u-boot though i have support, as of now&nbsp; i am not doing anything
with system ace as it not required now.<br>
In u-boot/include/configs/custom_board.h, i could see <br>
#define CFG_ACE_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xe0000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Xilinx ACE
controller - Compact Flash */<br>
&nbsp;So i have used this address in Linux driver to to ioremap to access
the&nbsp; ace registers. Though i could do ioremap,&nbsp; it crashes while
booting exactly when it is trying the access any ace register. <br>
  <br>
I doubt with the address i have used . But could not get any clue from
the docs given.&nbsp;&nbsp; <br>
  <br>
I want to know how to access the system ace registers and how to&nbsp; get
the address to ioremap. Please let me know if any details required and
also if i am missing any fundamentals.<br>
  <br>
  <br>
Thanks &amp; Regards<br>
Sudheer<br>
  <br>
  <br>
  <br>
  <br>
sudheer wrote:
  <blockquote cite="mid44DC5F21.8000906@gmail.com" type="cite">
    <pre wrap="">Hi Ameet,

Firstly, thanks for the mail.

I am able to compile the linux-2.6.16 and got the ace support files with 
the patch.
While compiling got some errors with  xparameters, but am rectify  them.

I need to wait for the hardware to test the source.

Thanks &amp; Regards
Sudheer


Ameet Patil wrote:
  </pre>
    <blockquote type="cite">
      <pre wrap="">Hi Sudheer,
   Frank has already answered your questions. If you have any problems 
with the SysAce patch... do let me know. I have written a small 
tutorial here if it helps...

<a class="moz-txt-link-freetext" href="http://linux.get2knowmore.com">http://linux.get2knowmore.com</a>


-Ameet

sudheer wrote:
    </pre>
      <blockquote type="cite">
        <pre wrap="">Hello Ameet Patil

I am looking for linux kernel source 2.6.16 with system ace 
controller support. I downloaded the linux-2.6.16 and linux-2.6.17-1 
source from kernel.org but could not find any files related to system 
ace controller  ( No xilinx_sysace directory in  drivers/block/) .  I 
have checked penguinppc.org also but could not get it.

Can you please send to me the link where i could download the 
linuxppc-2.6.16 source with system ace support.

Thanks &amp; Regards
Sudheer

Ameet Patil wrote:
      </pre>
        <blockquote type="cite">
          <pre wrap="">Hi Raja,
    I have ported the Xilinx System ACE driver to 2.6 kernel. Find 
the latest one here:
<a class="moz-txt-link-freetext"
 href="http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch">http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch</a> 


NOTE: this patch wouldn't work if you are using the TEMAC driver. In 
which case use the -after-TEMAC patch found in the patches folder 
above.

Check the following discussions (threads) for more details:
1. "Xilinx SystemACE driver for 2.6"
2. "Xilinx BSP for linux 2.6"
3. "Kernel hangs after "Now booting the kernel"."

cheers,
-Ameet

Raja Chidambaram wrote:
 
        </pre>
          <blockquote type="cite">
            <pre wrap=""> Hi all,
 We are working on customized board with amcc 440SPe
processor &amp; xilinx System Ace controller. The System
Ace controller is connected to compact flash driver.

We use u-boot 1.2 as bootloader &amp; linux kernel
2.6.16-2.

On the process the u-boot is able to detect compact
flash through Xilinx SystemAce controller &amp; able to
load the kernel image into compact flash.But when the
linux boot's up it not able to detect the System Ace
controller or compact flash.

Note:we need to have the root file system in compact
flash.

Is their any drivers available for SystemAce
controller on linux 2.6,if their how to get it.please
help me in this
                                    with regards
                                     raja



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
<a class="moz-txt-link-freetext" href="http://mail.yahoo.com">http://mail.yahoo.com</a> _______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated"
 href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext"
 href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

    
          </pre>
          </blockquote>
          <pre wrap="">_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated"
 href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext"
 href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

  
        </pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <pre wrap=""><!---->_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated"
 href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext"
 href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

  </pre>
  </blockquote>
  <br>
</blockquote>
<br>
</body>
</html>

--------------000809020608010607090004--
