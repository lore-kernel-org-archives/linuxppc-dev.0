Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id E1544DE0DE
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Oct 2008 06:25:21 +1000 (EST)
Message-ID: <48E67CDD.8080002@consentry.com>
Date: Fri, 03 Oct 2008 13:13:17 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: unit name for /soc in device tree
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm starting a scratch port of Linux 2.6 to an MPC8272 board that currently
runs 2.4 (MontaVista).

Documentation/powerpc/booting-without-of.txt says:
    The name of an soc
    node should start with "soc", and the remainder of the name should
    represent the part number for the soc.  For example, the MPC8540's
    soc node would be called "soc8540".

So I used the unit name "soc8272@f0000000" in my .dts file.

But arch/powerpc/boot/cpm-serial.c does:
	muram = finddevice("/soc/cpm/muram/data");

And that doesn't work if I follow the naming convention suggested.
I changed the .dts file to use the name "soc" instead of "soc8272" and
now the boot serial driver works.  Is that the right way to go?  Or
will this lead to problems in the kernel later (I'm not that far yet)?

					-=] Mike [=-
