Return-Path: <poorbeyond@163.com>
Received: from m5-86.163.com (m5-86.163.com [202.108.5.86])
	by ozlabs.org (Postfix) with SMTP id 02725DDF27
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Jul 2007 17:54:29 +1000 (EST)
Date: Sun, 22 Jul 2007 15:39:22 +0800
From: "poorbeyond" <poorbeyond@163.com>
To: "Linux-ppc mail list" <linuxppc-embedded@ozlabs.org>
Subject: ask some questions about u-boot's bootm command
Message-ID: <200707221539215465156@163.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon658405111743_====="
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

--=====003_Dragon658405111743_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

my cpu is 860T, using bootm command boot a linux kernel image, the following message print by smc1:

bootm 300000

## Booting image at 00300000 ...
   Image Name:   Linux-2.6.20.14
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1081591 Bytes =  1 MB
   Load Address: 00100000
   Entry Point:  00100000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x01D5DB10 => set upper limit to 0x00800000
No initrd
## Transferring control to Linux (at address 00100000) ...



then, the program has no response.

i debug it througth BDM, in u-boot function "do_bootm_linux", execute at "kernel = (void (*)(bd_t *, ulong, ulong, ulong, ulong))hdr->ih_ep", the program branch to address "0x00000000", the code is shown as following:
00000000    mr    r31,r3
00000004    mr    r30,r4
00000008    mr    r29,r5
0000000C    mr    r28,r6
00000010    mr    r27,r7
00000014    bl    0x000020C8
00000018    mfmsr    r0
0000001C    ori    r0,r0,0x30
00000020    mtspr    SRR1,r0
00000024    lis    r0,0xC0002004@h
00000028    ori    r0,r0,0xC0002004@l
0000002C    mtspr    SRR0,r0
00000030    rfi


my questions are:

1. Is the code "kernel = (void (*)(bd_t *, ulong, ulong, ulong, ulong))hdr->ih_ep" branch right?

2. What's the expected code after "kernel = (void (*)(bd_t *, ulong, ulong, ulong, ulong))hdr->ih_ep"?

3. When the kernel run to the "boot/simple/head.s"?


thanks a lot





poorbeyond
2007-07-22

--=====003_Dragon658405111743_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3132" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Verdana><FONT size=2>my cpu is 860T, </FONT></FONT><FONT 
face=Verdana><FONT size=2>using bootm command boot a linux kernel image, the 
following message print by smc1:</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana>bootm 300000</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana>## Booting image at 00300000 ...<BR>&nbsp;&nbsp; Image 
Name:&nbsp;&nbsp; Linux-2.6.20.14<BR>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; 
PowerPC Linux Kernel Image (gzip compressed)<BR>&nbsp;&nbsp; Data 
Size:&nbsp;&nbsp;&nbsp; 1081591 Bytes =&nbsp; 1 MB<BR>&nbsp;&nbsp; Load Address: 
00100000<BR>&nbsp;&nbsp; Entry Point:&nbsp; 00100000<BR>&nbsp;&nbsp; Verifying 
Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>## Current 
stack ends at 0x01D5DB10 =&gt; set upper limit to 0x00800000<BR>No initrd<BR>## 
Transferring control to Linux (at address 00100000) ...</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>then, the program has no response.</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>i debug it througth BDM, in u-boot function "do_bootm_linux", 
execute at "kernel = (void (*)(bd_t *, ulong, ulong, ulong, 
ulong))hdr-&gt;ih_ep", the program branch to address "0x00000000", the code is 
shown as following:</FONT></DIV>
<DIV><FONT size=2>00000000&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp; 
r31,r3</FONT></DIV>
<DIV><FONT size=2>00000004&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp; 
r30,r4</FONT></DIV>
<DIV><FONT size=2>00000008&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp; 
r29,r5</FONT></DIV>
<DIV><FONT size=2>0000000C&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp; 
r28,r6</FONT></DIV>
<DIV><FONT size=2>00000010&nbsp;&nbsp;&nbsp; mr&nbsp;&nbsp;&nbsp; 
r27,r7</FONT></DIV>
<DIV><FONT size=2>00000014&nbsp;&nbsp;&nbsp; bl&nbsp;&nbsp;&nbsp; 
0x000020C8</FONT></DIV>
<DIV><FONT size=2>00000018&nbsp;&nbsp;&nbsp; mfmsr&nbsp;&nbsp;&nbsp; 
r0</FONT></DIV>
<DIV><FONT size=2>0000001C&nbsp;&nbsp;&nbsp; ori&nbsp;&nbsp;&nbsp; 
r0,r0,0x30</FONT></DIV>
<DIV><FONT size=2>00000020&nbsp;&nbsp;&nbsp; mtspr&nbsp;&nbsp;&nbsp; 
SRR1,r0</FONT></DIV>
<DIV><FONT size=2>00000024&nbsp;&nbsp;&nbsp; lis&nbsp;&nbsp;&nbsp; 
r0,0xC0002004@h</FONT></DIV>
<DIV><FONT size=2>00000028&nbsp;&nbsp;&nbsp; ori&nbsp;&nbsp;&nbsp; 
r0,r0,0xC0002004@l</FONT></DIV>
<DIV><FONT size=2>0000002C&nbsp;&nbsp;&nbsp; mtspr&nbsp;&nbsp;&nbsp; 
SRR0,r0</FONT></DIV>
<DIV><FONT size=2>00000030&nbsp;&nbsp;&nbsp; rfi</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>my questions are:</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>1. Is the code "kernel = (void (*)(bd_t *, ulong, ulong, 
ulong, ulong))hdr-&gt;ih_ep" branch right?</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>2. What's the expected code after&nbsp;"kernel = (void 
(*)(bd_t *, ulong, ulong, ulong, ulong))hdr-&gt;ih_ep"?</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>3. When the kernel run to the 
"boot/simple/head.s"?</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2>thanks a lot</FONT></DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV align=left><FONT size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" SIZE=2>
</FONT></DIV>
<DIV><FONT color=#c0c0c0><FONT size=2>poorbeyond</FONT></DIV>
<DIV><FONT size=2>2007-07-22</FONT></FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon658405111743_=====--
