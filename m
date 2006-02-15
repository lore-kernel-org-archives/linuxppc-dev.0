Return-Path: <x.xiao@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 2AE2A679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 09:06:47 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k1FMMqIG021802 for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 15:22:52 -0700 (MST)
Received: from R6AADS01 ([10.82.124.176])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k1FMFggh001380
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 16:15:47 -0600 (CST)
From: "Xianghua Xiao" <x.xiao@freescale.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Cache-inhibited region for certain exception handler(e500 chips,
	2.4 kernel)?
Date: Wed, 15 Feb 2006 16:06:41 -0600
Message-ID: <000201c6327c$1a2b80f0$b07c520a@fsl.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01C63249.CF9110F0"
Reply-To: risc10@freescale.com
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

------=_NextPart_000_0003_01C63249.CF9110F0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Is there a way to put certain exception handler(e.g. machine check) on e500
to a cache-inhibited region? 
 
1. The e500 kernel puts exception handlers at the starting of the physical
memory.
2. All the physical memory are covered by a few TLB1s to do
0xc0000000-0x00000000 translation.
3. We can not add a new TLB1 to map a small piece of memory, because it has
boundary limitation(4K...256M). We can not use two TLB1 to overlap since it
will cause program error.
4. When we tried to move a handler(e.g. machine check) to a different
location, the kernel won't boot.
5. We don't want to map all the exceptional handlers to be cache inhibited,
say, the first 1MB, the performance will be horrible if we do so.
 
Is there a way at all to tweak things like this, i.e., put an exception
handler into a piece of memory that is cache-inhibited?
 
I also thought about use mlock/mmap on /dev/mem, move the specific exception
handler to a high address then use a separate TLB1 to cover it(need change
link script?),etc. 
 
Any suggestion is greatly appreciated.
 
xianghua
 

------=_NextPart_000_0003_01C63249.CF9110F0
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D455115021-15022006>Is =
there a way to=20
put certain exception handler(e.g. machine check) on e500 to a =
cache-inhibited=20
region? </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D455115021-15022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D455115021-15022006>1. The =
e500 kernel=20
puts exception handlers at the starting of the physical=20
memory.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D455115021-15022006>2. All =
the physical=20
memory are covered by a few TLB1s to do 0xc0000000-0x00000000=20
translation.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D455115021-15022006>3. We =
can=20
not&nbsp;add a new&nbsp;TLB1 to map a small piece of memory, because it =
has=20
boundary limitation(4K...256M). We can not use two TLB1 to overlap since =
it will=20
cause program error.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D455115021-15022006>4. =
When we tried to=20
move a handler(e.g. machine check) to a different location, the kernel =
won't=20
boot.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D455115021-15022006>5. We =
don't want to=20
map all the exceptional handlers to be cache inhibited, say, the first =
1MB, the=20
performance will be horrible if we do so.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D455115021-15022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D455115021-15022006>Is =
there a way at=20
all to tweak things like this, i.e., put an exception handler into a =
piece of=20
memory that is cache-inhibited?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D455115021-15022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D455115021-15022006>I also =
thought about=20
use mlock/mmap on /dev/mem, move the specific exception handler to a =
high=20
address then use a separate TLB1 to cover it(need change link =
script?),etc.=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D455115021-15022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D455115021-15022006>Any =
suggestion is=20
greatly appreciated.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D455115021-15022006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D455115021-15022006>xianghua</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D455115021-15022006></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0003_01C63249.CF9110F0--
