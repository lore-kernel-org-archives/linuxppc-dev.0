Return-Path: <suneel.reddy@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id D7AB667C21
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 22:45:50 +1000 (EST)
Received: from il06exr01.mot.com (il06exr01.mot.com [129.188.137.131])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id k7PCjnNE020162
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 05:45:49 -0700 (MST)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by il06exr01.mot.com (8.13.5/8.13.0) with ESMTP id k7PCjmYD004590
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 07:45:48 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6C844.635121B8"
Subject: How to boot powerPC linux-2.6.10 from diifferent address other than
	0x0000
Date: Fri, 25 Aug 2006 20:45:47 +0800
Message-ID: <405ECA8A30557F439A723E52D50838F9D372AB@ZMY16EXM66.ds.mot.com>
From: "Reddy Suneel-ASR125" <suneel.reddy@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C6C844.635121B8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
    We are working on MPC 8540, Linux kernel version is 2.6.10 from
Montavista. The bootloader used in Uboot and currently it loads the
uImage at physical memory address 0x0 and transfers control to it. We
want to load the kernel at a different address say 0x8000 and for this
we made the following changes.
=20
1) Altered the Makefile to linked the kernel at virtual address
0xc0008000 ( the default was 0xc000:0000)
2) Modified Uboot to load kernel at 0x8000 instead of 0x0
The kernel space still starts from 0xc000:0000

=20
When we transferred control to the kernel (loaded at 0x8000) we found
that the execution proceeds only till the mapping and invalidation on
TLBs. We do not know where the control goes after this as the further
instructions does not seems to get executed. Currently we do not have
the provision to connect a debugger and hence we are unable to make out
what is happening.
=20
Can some one give us any clue as to what we might have done wrong? This
is our first experience on PowerPC.
=20
=20
Thanks&regards
Suneel

------_=_NextPart_001_01C6C844.635121B8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1561" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;&nbsp;=20
We are working on MPC 8540, Linux kernel version is 2.6.10 from =
Montavista. The=20
bootloader used in Uboot and currently it loads the uImage at physical =
memory=20
address 0x0 and transfers control to it. We want to load the kernel at a =

different address say 0x8000 and for this we made the following=20
changes.</FONT></SPAN></DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial size=3D2>1) =
Altered the=20
Makefile to linked the kernel at virtual address 0xc0008000 ( the =
default was=20
0xc000:0000)</FONT></SPAN></DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial size=3D2>2) =
Modified Uboot to=20
load kernel at 0x8000 instead of 0x0</FONT></SPAN></DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial size=3D2>
<P><SPAN class=3D625292512-25082006>The kernel space still starts from=20
0xc000:0000</SPAN></P></FONT></SPAN></DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial size=3D2>When =
we transferred=20
control to the kernel (loaded at 0x8000) we found that the execution =
proceeds=20
only till the mapping and invalidation on TLBs.&nbsp;We do not know =
where the=20
control goes after this as the further instructions does not seems to =
get=20
executed. Currently we do not have the provision to connect a debugger =
and hence=20
we are unable to make out what is happening.</FONT></SPAN></DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial><FONT =
size=3D2>Can some one=20
give us any clue as to what we might have done wrong? This is our first=20
experience on PowerPC<SPAN=20
class=3D277244012-25082006>.</SPAN></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial><FONT =
size=3D2><SPAN=20
class=3D277244012-25082006></SPAN></FONT></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial><FONT =
size=3D2><SPAN=20
class=3D277244012-25082006></SPAN></FONT></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial><FONT =
size=3D2><SPAN=20
class=3D277244012-25082006>Thanks&amp;regards</SPAN></FONT></FONT></SPAN>=
</DIV>
<DIV><SPAN class=3D625292512-25082006><FONT face=3DArial><FONT =
size=3D2><SPAN=20
class=3D277244012-25082006>Suneel</SPAN></FONT></FONT></SPAN></DIV></DIV>=
</DIV></BODY></HTML>

------_=_NextPart_001_01C6C844.635121B8--
