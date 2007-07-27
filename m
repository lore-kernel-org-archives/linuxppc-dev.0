Return-Path: <poorbeyond@163.com>
Received: from m5-86.163.com (m5-86.163.com [202.108.5.86])
	by ozlabs.org (Postfix) with SMTP id B9814DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jul 2007 23:11:12 +1000 (EST)
Date: Fri, 27 Jul 2007 21:11:19 +0800
From: "poorbeyond" <poorbeyond@163.com>
To: "Linux-ppc mail list" <linuxppc-embedded@ozlabs.org>
Subject: a question about mpc8xx linux
Message-ID: <200707272111187341027@163.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon708234805082_====="
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

--=====003_Dragon708234805082_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

my cpu is MPC860, use u-boot-1.1.4, linux-2.6.20.14

i use the "tftp 300000 uImage" command download kernel image,

then use the "bootm 300000" command boot the image.


i found the bootm cmd entered the /arch/ppc/kernel/head_8xx.s, stop at the instruction "rfi".
is it right? after the instruction, where does the code go normally ? what should i do now?

thanks

 .globl __start
__start:
 mr r31,r3   /* save parameters */
 mr r30,r4
 mr r29,r5
 mr r28,r6
 mr r27,r7

 /* We have to turn on the MMU right away so we get cache modes
  * set correctly.
  */
 bl initial_mmu

/* We now have the lower 8 Meg mapped into TLB entries, and the caches
 * ready to work.
 */

turn_on_mmu:
 mfmsr r0
 ori r0,r0,MSR_DR|MSR_IR
 mtspr SPRN_SRR1,r0
 lis r0,start_here@h
 ori r0,r0,start_here@l
 mtspr SPRN_SRR0,r0
 SYNC
 rfi    /* enables MMU */







poorbeyond
2007-07-27

--=====003_Dragon708234805082_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3132" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Verdana><FONT size=2>my cpu is MPC860, use u-boot-1.1.4, 
linux-2.6.20.14</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>i use the "tftp 300000 uImage" command 
download kernel image,</FONT></FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana size=2>then use the "bootm 300000" command boot the 
image.</FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana size=2>i found the bootm cmd entered the 
/arch/ppc/kernel/head_8xx.s, stop at the instruction "rfi".</FONT></DIV>
<DIV><FONT face=Verdana size=2>is it right? after the instruction, where does 
the code go&nbsp;normally ? what should i do now?</FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana size=2>thanks</FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV>&nbsp;.globl&nbsp;__start<BR>__start:<BR>&nbsp;mr&nbsp;r31,r3&nbsp;&nbsp;&nbsp;/* 
save parameters 
*/<BR>&nbsp;mr&nbsp;r30,r4<BR>&nbsp;mr&nbsp;r29,r5<BR>&nbsp;mr&nbsp;r28,r6<BR>&nbsp;mr&nbsp;r27,r7</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;/* We have to turn on the MMU right away so we get cache 
modes<BR>&nbsp; * set correctly.<BR>&nbsp; */<BR>&nbsp;bl&nbsp;initial_mmu</DIV>
<DIV>&nbsp;</DIV>
<DIV>/* We now have the lower 8 Meg mapped into TLB entries, and the 
caches<BR>&nbsp;* ready to work.<BR>&nbsp;*/</DIV>
<DIV>&nbsp;</DIV>
<DIV>turn_on_mmu:<BR>&nbsp;mfmsr&nbsp;r0<BR>&nbsp;ori&nbsp;r0,r0,MSR_DR|MSR_IR<BR>&nbsp;mtspr&nbsp;SPRN_SRR1,r0<BR>&nbsp;lis&nbsp;r0,start_here@h<BR>&nbsp;ori&nbsp;r0,r0,start_here@l<BR>&nbsp;mtspr&nbsp;SPRN_SRR0,r0<BR>&nbsp;SYNC<BR>&nbsp;rfi&nbsp;&nbsp;&nbsp;&nbsp;/* 
enables MMU */</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV align=left><FONT size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" SIZE=2>
</FONT></DIV>
<DIV><FONT color=#c0c0c0><FONT size=2>poorbeyond</FONT></DIV>
<DIV><FONT size=2>2007-07-27</FONT></FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon708234805082_=====--
