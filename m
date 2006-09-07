Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 533A267B72
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 18:40:04 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id C436B8780A9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 01:40:03 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r697014003D-00-2
	for linuxppc-embedded@ozlabs.org; Thu, 07 Sep 2006 01:40:03 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 75EEC87806E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 01:40:03 -0700 (PDT)
Message-ID: <44FFDAE8.6020605@gmail.com>
Date: Thu, 07 Sep 2006 14:10:08 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: could not access the address in linux-System ace driver
References: <20060831055304.53524.qmail@web53605.mail.yahoo.com>
	<44F6CB23.3000802@gmail.com>
In-Reply-To: <44F6CB23.3000802@gmail.com>
Content-Type: multipart/alternative;
	boundary="------------030908060607070103020307"
Cc: Raja Chidambaram <raja_chidambaram82@yahoo.com>
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
--------------030908060607070103020307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi
>
> Raja Chidambaram wrote:
>> Hello Sudheer,
>>
>>  Sorry for the Late reply.since we faced some
>> complexity in this kind of system Ace setup we have
>> dropped it & moved to different setup.
>>
>> As of now in your case trace the xilinx code which is
>> bascially on adapter.c as for as the xilinix code is
>> concerned the hardware initialization code are done
>> by xilinux, And only the kernel integration code
>> developed by open source developers.So u might to
>> track 
>> this cahnges
>>
>> As u said your xilinx is connected to EBC make sure
>> the power on cycles is perfomed with no errrors.
>>
>> As for as your base register for xilinux is concerned 
>> the u-boot handle same as linux but the AMCC 440SPe
>> processor have differnet TLB type so please make
>> sure u understand TLB for 440SPe. 
>>  
>>
>>     
I got solved the issue by changing the ioremap function usage. The 
PPC440 implements a 36 bit memory map. So i changed my ioremap to 
ioremap64 and gave the 36-bit physical address which includes EPN and is 
0x5d0000000ULL  and it returns a 32-bit virtual pointer with which  am 
able to access the device registers.

Thanks Raja and all for your kindly help.

Thanks
Sudheer


>>   
> Can you please send some links if available that tells about the TLBs 
> in 440SPe. I have googled but could not get much information.
>
> Thanks
> Sudheer
>>   
>>
>>
>>
>>
>> --- sudheer <urwithsudheer@gmail.com> wrote:
>>
>>   
>>> Hello All
>>>
>>> I'm really desperate for some help , I've been
>>> struggling with this 
>>> system since few days.
>>>
>>> sudheer wrote:
>>>     
>>>> Hello Raja,
>>>>
>>>> We too are working on customized board with amcc
>>>>       
>>> 440SPe processor , 
>>>     
>>>> xilinx System Ace controller.  Compact flash  is
>>>>       
>>> connected to system 
>>>     
>>>> ace controller. 
>>>> We use u-boot 1.1.2 as bootloader & linux kernel -
>>>>       
>>> 2.6.16-2.
>>>     
>>>> System ace is connected to amcc440SPE processor
>>>>       
>>> via GPIO and External 
>>>     
>>>> Peripheral Bus Controller(EBC).
>>>>       
>>> I am still facing the issue in accessing the address
>>> in linux.
>>>
>>> The physical address given in u-boot  init.S
>>> tlbentry for 'system ace'  
>>> is 0xE0000000
>>> I am able to access the address in u-boot  and
>>> everything is fine in u-boot.
>>> But in linux , I am able to ioremap the the address
>>> 0xE0000000 but the 
>>> kernel crashes when i try to access the address .
>>> physical address=0xe0000000
>>> address_after_ioremap = 0xe1000000.
>>> I am trying to read with
>>> readw(address_after_ioremap)
>>> The kernel gives an exception error saying Oops:
>>> machine check, sig: 7 
>>> [#2] .
>>> The error dump is as below:
>>>
>>> Instruction dump:
>>> Data machine check in kernel mode.
>>> PLB0: BEAR=0x00000000e0000000 ACR=  0xdb000000 BESR=
>>> 0x0000000000008000
>>> PLB1: BEAR=0xe98d7ad33716ee7e ACR=  0xdb000000 BESR=
>>> 0x0000000000000000
>>> POB0: BEAR=0x0000000fffaebbcd BESR0=0x00000000
>>> BESR1=0x00000000
>>> OPB0: BEAR=0x0000000000000000 BSTAT=0x00000000
>>> Oops: machine check, sig: 7 [#2]
>>> NIP: 00000000 LR: C0002200 CTR: 00000000
>>> REGS: c0241f50 TRAP: 0202   Not tainted  (2.6.16.2)
>>> MSR: 00000000 <>  CR: 84CA4124  XER: 00000000
>>> TASK = dff6cb70[1] 'swapper' THREAD: c0740000
>>> GPR00: 00000000 C0241E40 DFF6CB70 00000001 FFFFFFD0
>>> 00000000 C0240000 
>>> C01F3C0C
>>> GPR08: C01F0000 C0002200 00021002 C0001FF4 DFF6CD38
>>> 802823E0 1FFB9600 
>>> 00000000
>>> GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3540
>>> 1FF63CE0 1FFCEE78 
>>> C01C0000
>>> GPR24: C01C0000 C01C0000 C01F0000 C01C0000 BFFFFFFF
>>> FFFFFFD0 00000000 
>>> C0241F50
>>> NIP [00000000] 0x0
>>> LR [C0002200] ret_from_except+0x0/0x18
>>> Call Trace:
>>> Instruction dump:
>>> Data machine check in kernel mode.
>>> PLB0: BEAR=0x00000000e0000000 ACR=  0xdb000000 BESR=
>>> 0x0000000000008000
>>> .........and this dump gets print continously.
>>>
>>>
>>> I have checked with TLB entries in u-boot and linux
>>> using BDI:
>>>
>>> BDI_AMCC440SPe>tlb 0 10
>>> IDX TID      EPN  SIZE VTS          RPN   USER WIMGE
>>> USRSVC
>>>  0 : 00 ff000000  16MB V0 -> 4_ff000000 U:0000 WI-G-
>>> XWRXWR
>>>  1 : 00 00000000 256MB V0 -> 0_00000000 U:0000 -I-G-
>>> XWRXWR
>>>  2 : 00 10000000 256MB V0 -> 0_10000000 U:0000 -I-G-
>>> XWRXWR
>>>  3 : 00 20000000 256MB V0 -> 0_20000000 U:0000 -I-G-
>>> XWRXWR
>>>  4 : 00 30000000 256MB V0 -> 0_30000000 U:0000 -I-G-
>>> XWRXWR
>>>  5 : 00 90000000 256KB V0 -> 4_00000000 U:0000 -I---
>>> XWRXWR
>>>  6 : 00 e0000000   1KB V0 -> 4_e0000000 U:0000 -I-G-
>>> -WR-WR
>>>  7 : 00 a0000000   4KB V0 -> 4_f0000000 U:0000 -I-G-
>>> -WR-WR
>>>  8 : 00 d0000000 256MB V0 -> c_00000000 U:0000 -I-G-
>>> -WR-WR
>>>  9 : 00 80000000 256MB V0 -> c_10000000 U:0000 -I-G-
>>> -WR-WR
>>> 10 : 00 01080000   1KB -0 -> 0_00000000 U:0000 -----
>>> ------
>>> BDI_AMCC440SPe>
>>>
>>> In Linux the tlb entries are as below.......
>>>
>>> BDI_AMCC440SPe>tlb 0 63
>>> IDX TID      EPN  SIZE VTS          RPN   USER WIMGE
>>> USRSVC
>>>  0 : 0e 0ff1a000   4KB V0 -> 0_007ce000 U:0000 --MG-
>>> --R--R
>>>  1 : 0e 0fe94000   4KB V0 -> 0_1ff96000 U:0000 ---G-
>>> X-RX-R
>>>  2 : 0e 30017000   4KB V0 -> 0_007cd000 U:0000 --MG-
>>> --R-WR
>>>  3 : 0e 10039000   4KB V0 -> 0_1ffb8000 U:0000 ---G-
>>> X-RX-R
>>>  4 : 0e 30009000   4KB V0 -> 0_00758000 U:0000 ---G-
>>> X-RX-R
>>>  5 : 0e 30010000   4KB V0 -> 0_0078b000 U:0000 ---G-
>>> X-RX-R
>>>  6 : 0e 00000000   1KB -0 -> 0_1f4e2000 U:0000 ---G-
>>> --R--R
>>>  7 : 0e 0fe3e000   4KB V0 -> 0_1f4e2000 U:0000 ---G-
>>> X-RX-R
>>>  8 : 0e 0ff1c000   4KB V0 -> 0_007ed000 U:0000 --MG-
>>> XWRXWR
>>>  9 : 0e 0ff1e000   4KB V0 -> 0_007ee000 U:0000 --MG-
>>> -WR-WR
>>> 10 : 0e 0ff1f000   4KB V0 -> 0_007ea000 U:0000 --MG-
>>> XWRXWR
>>> 11 : 0e 0fe39000   4KB V0 -> 0_1ff8e000 U:0000 ---G-
>>> X-RX-R
>>> 12 : 0e 0ff21000   4KB V0 -> 0_007a8000 U:0000 --MG-
>>> --R-WR
>>> 13 : 0e 0fe47000   4KB V0 -> 0_1ffa9000 U:0000 ---G-
>>> X-RX-R
>>> 14 : 0e 0fe46000   4KB V0 -> 0_1ffb2000 U:0000 ---G-
>>> X-RX-R
>>> 15 : 0e 30019000   4KB V0 -> 0_007c5000 U:0000 --MG-
>>> -WR-WR
>>> 16 : 0e 0fe45000   4KB V0 -> 0_1ffa8000 U:0000 ---G-
>>> X-RX-R
>>> 17 : 00 fdfff000   4KB V0 -> 4_f0000000 U:0000 -IMG-
>>> ----WR
>>> 18 : 0e 0fe9a000   4KB V0 -> 0_1ff98000 U:0000 ---G-
>>> X-RX-R
>>> 19 : 0e 10067000   4KB V0 -> 0_0078e000 U:0000 --MG-
>>> -WR-WR
>>> 20 : 0e 00000000   4KB -0 -> 0_1f4e5000 U:0000 ---G-
>>> --R--R
>>> 21 : 0e 10030000   4KB V0 -> 0_1f4e5000 U:0000 ---G-
>>> X-RX-R
>>> 22 : 0e 10063000   4KB V0 -> 0_007b7000 U:0000 --MG-
>>> -WR-WR
>>> 23 : 0e 0fe4c000   4KB V0 -> 0_1ff9b000 U:0000 ---G-
>>> X-RX-R
>>> 24 : 0e 1007f000   4KB V0 -> 0_007e0000 U:0000 --MG-
>>> -WR-WR
>>> 25 : 0e 0ff1d000   4KB V0 -> 0_007c6000 U:0000 --MG-
>>> --R-WR
>>> 26 : 0e 0fe4e000   4KB V0 -> 0_1ffa1000 U:0000 ---G-
>>> X-RX-R
>>> 27 : 0e 0fe0f000   4KB V0 -> 0_0077e000 U:0000 ---G-
>>> X-RX-R
>>> 28 : 0e 0fe52000   4KB V0 -> 0_0077f000 U:0000 ---G-
>>> X-RX-R
>>> 29 : 0e 0fe53000   4KB V0 -> 0_1ff80000 U:0000 ---G-
>>> X-RX-R
>>> 30 : 0e 0fef9000   4KB V0 -> 0_1ff81000 U:0000 ---G-
>>> --R--R
>>> 31 : 0e 0fe3b000   4KB V0 -> 0_1ffa7000 U:0000 ---G-
>>> X-RX-R
>>> 32 : 0e 7f901000   4KB V0 -> 0_007db000 U:0000 --MG-
>>> -WR-WR
>>> 33 : 0e 10027000   4KB V0 -> 0_1ffd0000 U:0000 ---G-
>>> X-RX-R
>>> 34 : 0e 1003a000   4KB V0 -> 0_1ffb6000 U:0000 ---G-
>>> X-RX-R
>>> 35 : 0e 0fe51000   4KB V0 -> 0_00775000 U:0000 ---G-
>>> X-RX-R
>>> 36 : 0e 1003b000   4KB V0 -> 0_1ffb7000 U:0000 ---G-
>>> X-RX-R
>>> 37 : 0e 1002a000   4KB V0 -> 0_1ffcf000 U:0000 ---G-
>>> X-RX-R
>>> 38 : 0e 10066000   4KB V0 -> 0_007de000 U:0000 --MG-
>>> -WR-WR
>>> 39 : 0e 1002b000   4KB V0 -> 0_1ffd3000 U:0000 ---G-
>>> X-RX-R
>>> 40 : 0e 1002c000   4KB V0 -> 0_1ffd2000 U:0000 ---G-
>>> X-RX-R
>>> 41 : 0e 1005d000   4KB V0 -> 0_007f4000 U:0000 --MG-
>>> XWRXWR
>>> 42 : 0e 1002d000   4KB V0 -> 0_1ffc2000 U:0000 ---G-
>>> X-RX-R
>>> 43 : 0e 10028000   4KB V0 -> 0_1ffc8000 U:0000 ---G-
>>> X-RX-R
>>> 44 : 0e 10069000   4KB V0 -> 0_0078d000 U:0000 --MG-
>>> -WR-WR
>>>
>>>     
>> === message truncated ===
>>
>>
>> __________________________________________________
>> Do You Yahoo!?
>> Tired of spam?  Yahoo! Mail has the best spam protection around 
>> http://mail.yahoo.com 
>>
>>   
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


--------------030908060607070103020307
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi<br>
<blockquote cite="mid44F6CB23.3000802@gmail.com" type="cite"><br>
Raja Chidambaram wrote:
  <blockquote
 cite="mid20060831055304.53524.qmail@web53605.mail.yahoo.com"
 type="cite">
    <pre wrap="">Hello Sudheer,

 Sorry for the Late reply.since we faced some
complexity in this kind of system Ace setup we have
dropped it &amp; moved to different setup.

As of now in your case trace the xilinx code which is
bascially on adapter.c as for as the xilinix code is
concerned the hardware initialization code are done
by xilinux, And only the kernel integration code
developed by open source developers.So u might to
track 
this cahnges

As u said your xilinx is connected to EBC make sure
the power on cycles is perfomed with no errrors.

As for as your base register for xilinux is concerned 
the u-boot handle same as linux but the AMCC 440SPe
processor have differnet TLB type so please make
sure u understand TLB for 440SPe. 
 

    </pre>
  </blockquote>
</blockquote>
I got solved the issue by changing the ioremap function usage. The
PPC440 implements a 36 bit memory map. So i changed my ioremap to
ioremap64 and gave the 36-bit physical address which includes EPN and
is 0x5d0000000ULL&nbsp; and it returns a 32-bit virtual pointer with which&nbsp;
am able to access the device registers. <br>
<br>
Thanks Raja and all for your kindly help. <br>
<br>
Thanks<br>
Sudheer<br>
<br>
<br>
<blockquote cite="mid44F6CB23.3000802@gmail.com" type="cite">
  <blockquote
 cite="mid20060831055304.53524.qmail@web53605.mail.yahoo.com"
 type="cite">
    <pre wrap="">  </pre>
  </blockquote>
Can you please send some links if available that tells about the TLBs
in 440SPe. I have googled but could not get much information.<br>
  <br>
Thanks<br>
Sudheer<br>
  <blockquote
 cite="mid20060831055304.53524.qmail@web53605.mail.yahoo.com"
 type="cite">
    <pre wrap="">  




--- sudheer <a class="moz-txt-link-rfc2396E"
 href="mailto:urwithsudheer@gmail.com">&lt;urwithsudheer@gmail.com&gt;</a> wrote:

  </pre>
    <blockquote type="cite">
      <pre wrap="">Hello All

I'm really desperate for some help , I've been
struggling with this 
system since few days.

sudheer wrote:
    </pre>
      <blockquote type="cite">
        <pre wrap="">Hello Raja,

We too are working on customized board with amcc
      </pre>
      </blockquote>
      <pre wrap="">440SPe processor , 
    </pre>
      <blockquote type="cite">
        <pre wrap="">xilinx System Ace controller.  Compact flash  is
      </pre>
      </blockquote>
      <pre wrap="">connected to system 
    </pre>
      <blockquote type="cite">
        <pre wrap="">ace controller. 
We use u-boot 1.1.2 as bootloader &amp; linux kernel -
      </pre>
      </blockquote>
      <pre wrap="">2.6.16-2.
    </pre>
      <blockquote type="cite">
        <pre wrap="">System ace is connected to amcc440SPE processor
      </pre>
      </blockquote>
      <pre wrap="">via GPIO and External 
    </pre>
      <blockquote type="cite">
        <pre wrap="">Peripheral Bus Controller(EBC).
      </pre>
      </blockquote>
      <pre wrap="">I am still facing the issue in accessing the address
in linux.

The physical address given in u-boot  init.S
tlbentry for 'system ace'  
is 0xE0000000
I am able to access the address in u-boot  and
everything is fine in u-boot.
But in linux , I am able to ioremap the the address
0xE0000000 but the 
kernel crashes when i try to access the address .
physical address=0xe0000000
address_after_ioremap = 0xe1000000.
I am trying to read with
readw(address_after_ioremap)
The kernel gives an exception error saying Oops:
machine check, sig: 7 
[#2] .
The error dump is as below:

Instruction dump:
Data machine check in kernel mode.
PLB0: BEAR=0x00000000e0000000 ACR=  0xdb000000 BESR=
0x0000000000008000
PLB1: BEAR=0xe98d7ad33716ee7e ACR=  0xdb000000 BESR=
0x0000000000000000
POB0: BEAR=0x0000000fffaebbcd BESR0=0x00000000
BESR1=0x00000000
OPB0: BEAR=0x0000000000000000 BSTAT=0x00000000
Oops: machine check, sig: 7 [#2]
NIP: 00000000 LR: C0002200 CTR: 00000000
REGS: c0241f50 TRAP: 0202   Not tainted  (2.6.16.2)
MSR: 00000000 &lt;&gt;  CR: 84CA4124  XER: 00000000
TASK = dff6cb70[1] 'swapper' THREAD: c0740000
GPR00: 00000000 C0241E40 DFF6CB70 00000001 FFFFFFD0
00000000 C0240000 
C01F3C0C
GPR08: C01F0000 C0002200 00021002 C0001FF4 DFF6CD38
802823E0 1FFB9600 
00000000
GPR16: 00000001 FFFFFFFF 00000000 007FFF00 1FFB3540
1FF63CE0 1FFCEE78 
C01C0000
GPR24: C01C0000 C01C0000 C01F0000 C01C0000 BFFFFFFF
FFFFFFD0 00000000 
C0241F50
NIP [00000000] 0x0
LR [C0002200] ret_from_except+0x0/0x18
Call Trace:
Instruction dump:
Data machine check in kernel mode.
PLB0: BEAR=0x00000000e0000000 ACR=  0xdb000000 BESR=
0x0000000000008000
.........and this dump gets print continously.


I have checked with TLB entries in u-boot and linux
using BDI:

BDI_AMCC440SPe&gt;tlb 0 10
IDX TID      EPN  SIZE VTS          RPN   USER WIMGE
USRSVC
 0 : 00 ff000000  16MB V0 -&gt; 4_ff000000 U:0000 WI-G-
XWRXWR
 1 : 00 00000000 256MB V0 -&gt; 0_00000000 U:0000 -I-G-
XWRXWR
 2 : 00 10000000 256MB V0 -&gt; 0_10000000 U:0000 -I-G-
XWRXWR
 3 : 00 20000000 256MB V0 -&gt; 0_20000000 U:0000 -I-G-
XWRXWR
 4 : 00 30000000 256MB V0 -&gt; 0_30000000 U:0000 -I-G-
XWRXWR
 5 : 00 90000000 256KB V0 -&gt; 4_00000000 U:0000 -I---
XWRXWR
 6 : 00 e0000000   1KB V0 -&gt; 4_e0000000 U:0000 -I-G-
-WR-WR
 7 : 00 a0000000   4KB V0 -&gt; 4_f0000000 U:0000 -I-G-
-WR-WR
 8 : 00 d0000000 256MB V0 -&gt; c_00000000 U:0000 -I-G-
-WR-WR
 9 : 00 80000000 256MB V0 -&gt; c_10000000 U:0000 -I-G-
-WR-WR
10 : 00 01080000   1KB -0 -&gt; 0_00000000 U:0000 -----
------
BDI_AMCC440SPe&gt;

In Linux the tlb entries are as below.......

BDI_AMCC440SPe&gt;tlb 0 63
IDX TID      EPN  SIZE VTS          RPN   USER WIMGE
USRSVC
 0 : 0e 0ff1a000   4KB V0 -&gt; 0_007ce000 U:0000 --MG-
--R--R
 1 : 0e 0fe94000   4KB V0 -&gt; 0_1ff96000 U:0000 ---G-
X-RX-R
 2 : 0e 30017000   4KB V0 -&gt; 0_007cd000 U:0000 --MG-
--R-WR
 3 : 0e 10039000   4KB V0 -&gt; 0_1ffb8000 U:0000 ---G-
X-RX-R
 4 : 0e 30009000   4KB V0 -&gt; 0_00758000 U:0000 ---G-
X-RX-R
 5 : 0e 30010000   4KB V0 -&gt; 0_0078b000 U:0000 ---G-
X-RX-R
 6 : 0e 00000000   1KB -0 -&gt; 0_1f4e2000 U:0000 ---G-
--R--R
 7 : 0e 0fe3e000   4KB V0 -&gt; 0_1f4e2000 U:0000 ---G-
X-RX-R
 8 : 0e 0ff1c000   4KB V0 -&gt; 0_007ed000 U:0000 --MG-
XWRXWR
 9 : 0e 0ff1e000   4KB V0 -&gt; 0_007ee000 U:0000 --MG-
-WR-WR
10 : 0e 0ff1f000   4KB V0 -&gt; 0_007ea000 U:0000 --MG-
XWRXWR
11 : 0e 0fe39000   4KB V0 -&gt; 0_1ff8e000 U:0000 ---G-
X-RX-R
12 : 0e 0ff21000   4KB V0 -&gt; 0_007a8000 U:0000 --MG-
--R-WR
13 : 0e 0fe47000   4KB V0 -&gt; 0_1ffa9000 U:0000 ---G-
X-RX-R
14 : 0e 0fe46000   4KB V0 -&gt; 0_1ffb2000 U:0000 ---G-
X-RX-R
15 : 0e 30019000   4KB V0 -&gt; 0_007c5000 U:0000 --MG-
-WR-WR
16 : 0e 0fe45000   4KB V0 -&gt; 0_1ffa8000 U:0000 ---G-
X-RX-R
17 : 00 fdfff000   4KB V0 -&gt; 4_f0000000 U:0000 -IMG-
----WR
18 : 0e 0fe9a000   4KB V0 -&gt; 0_1ff98000 U:0000 ---G-
X-RX-R
19 : 0e 10067000   4KB V0 -&gt; 0_0078e000 U:0000 --MG-
-WR-WR
20 : 0e 00000000   4KB -0 -&gt; 0_1f4e5000 U:0000 ---G-
--R--R
21 : 0e 10030000   4KB V0 -&gt; 0_1f4e5000 U:0000 ---G-
X-RX-R
22 : 0e 10063000   4KB V0 -&gt; 0_007b7000 U:0000 --MG-
-WR-WR
23 : 0e 0fe4c000   4KB V0 -&gt; 0_1ff9b000 U:0000 ---G-
X-RX-R
24 : 0e 1007f000   4KB V0 -&gt; 0_007e0000 U:0000 --MG-
-WR-WR
25 : 0e 0ff1d000   4KB V0 -&gt; 0_007c6000 U:0000 --MG-
--R-WR
26 : 0e 0fe4e000   4KB V0 -&gt; 0_1ffa1000 U:0000 ---G-
X-RX-R
27 : 0e 0fe0f000   4KB V0 -&gt; 0_0077e000 U:0000 ---G-
X-RX-R
28 : 0e 0fe52000   4KB V0 -&gt; 0_0077f000 U:0000 ---G-
X-RX-R
29 : 0e 0fe53000   4KB V0 -&gt; 0_1ff80000 U:0000 ---G-
X-RX-R
30 : 0e 0fef9000   4KB V0 -&gt; 0_1ff81000 U:0000 ---G-
--R--R
31 : 0e 0fe3b000   4KB V0 -&gt; 0_1ffa7000 U:0000 ---G-
X-RX-R
32 : 0e 7f901000   4KB V0 -&gt; 0_007db000 U:0000 --MG-
-WR-WR
33 : 0e 10027000   4KB V0 -&gt; 0_1ffd0000 U:0000 ---G-
X-RX-R
34 : 0e 1003a000   4KB V0 -&gt; 0_1ffb6000 U:0000 ---G-
X-RX-R
35 : 0e 0fe51000   4KB V0 -&gt; 0_00775000 U:0000 ---G-
X-RX-R
36 : 0e 1003b000   4KB V0 -&gt; 0_1ffb7000 U:0000 ---G-
X-RX-R
37 : 0e 1002a000   4KB V0 -&gt; 0_1ffcf000 U:0000 ---G-
X-RX-R
38 : 0e 10066000   4KB V0 -&gt; 0_007de000 U:0000 --MG-
-WR-WR
39 : 0e 1002b000   4KB V0 -&gt; 0_1ffd3000 U:0000 ---G-
X-RX-R
40 : 0e 1002c000   4KB V0 -&gt; 0_1ffd2000 U:0000 ---G-
X-RX-R
41 : 0e 1005d000   4KB V0 -&gt; 0_007f4000 U:0000 --MG-
XWRXWR
42 : 0e 1002d000   4KB V0 -&gt; 0_1ffc2000 U:0000 ---G-
X-RX-R
43 : 0e 10028000   4KB V0 -&gt; 0_1ffc8000 U:0000 ---G-
X-RX-R
44 : 0e 10069000   4KB V0 -&gt; 0_0078d000 U:0000 --MG-
-WR-WR

    </pre>
    </blockquote>
    <pre wrap=""><!---->=== message truncated ===


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
<a class="moz-txt-link-freetext" href="http://mail.yahoo.com">http://mail.yahoo.com</a> 

  </pre>
  </blockquote>
  <br>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
</body>
</html>

--------------030908060607070103020307--
