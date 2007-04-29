Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s1.bay0.hotmail.com (bay0-omc2-s1.bay0.hotmail.com
	[65.54.246.137]) by ozlabs.org (Postfix) with ESMTP id 800A3DDF8D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 07:31:42 +1000 (EST)
Message-ID: <BAY115-W165FAC9CE3C0CB258DAF3AB24D0@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Virtex-4 PPC405 first instruction after reset - ultracontroller vs
	regular designs
Date: Sun, 29 Apr 2007 21:31:40 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all

may be not really related to linux but I hope some body can help me with th=
is

As you know PPC405 runs the instruction at 0xfffffffc address as it's first=
 instruction

when generating a base system for ML403 using XPS, one should certainly add=
 PLB BRAM controller , this module will reside on PLB and contains some BRA=
M instances. A Code called boot loop is located in these block memories. PP=
C405 runs boot loop until sysace makes linux elf ready.=20

Looking in the generated xparameters.h you see that the base address for PL=
B BRAM IF is 0xffff0000 and since the first instruction should be located a=
t 0xfffffffc , you have to define the size of this PLB BRAM IF equal to 64k=
 when generating your system in XPS.

Now looking at ultracontroller reference design one can see that PPC405 loo=
ks for 0xfffffffc address on its IS OCM bus , but in regular designs as you=
 see PPC405 looks for this address on PLB Instruction bus, I'm wondering ho=
w PPC understands to do so in each of these designs? Does PPC have a specia=
l input port which is assigned a fix value and indicates where should PPC l=
ook for 0xfffffffc address ( ISOCM or IS PLB )?

thanks.

_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=
