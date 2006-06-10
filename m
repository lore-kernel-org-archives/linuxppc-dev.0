Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id E248C67C3E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Jun 2006 10:57:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Jumbo ethernet frames on MVME6100
Date: Fri, 9 Jun 2006 17:57:11 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487105550413@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
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

I'm using Linux 2.6.6 with the Motorola Computer Group patch for the
MVME6100 available at

https://mcg.motorola.com/cfm/templates/swDetails.cfm?PageID=3D704&Softwar=
e
ID=3D6&ProductID=3D202

and compiling with GCC from ELDK 3.1.1, although using the userspace
module utils (e.g. insmod) from ELDK 4.0.

The patch includes support for the Marvel gigabit ethernet part on the
board (MV64360?) which works for non-jumbo ethernet frames, but doesn't
receive (or even generate errors) if I send jumbo-ethernet frames.  I
haven't debugged this issue very long, but a cursory look through the
driver hints that jumbo frame support should be on (the port config
serial register PCSR has what I imagine to be okay bits).

I'm ifconfiging the 2nd ethernet device with the command
ifconfig eth1 mtu 9000 192.168.1.1

I'm wondering if anyone else using an MVME6100 has gotten jumbo frame
support to work?

Also, at what point did the Linux 2.6 kernel embedded PPC support start
working with GCC 4.x (e.g. GCC in ELDK 4.0).  I'm getting compiler
errors when I use GCC 4.x with this version of the kernel.

Tim
