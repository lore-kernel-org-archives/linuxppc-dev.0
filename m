Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.131.34]) by ozlabs.org (Postfix) with ESMTP id F415067AA4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 00:08:37 +1100 (EST)
Message-ID: <002001c50ddf$d849a3e0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Martin Krause" <Martin.Krause@tqs.de>
References: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B6E@TQ-MAILSRV-1>
Date: Tue, 8 Feb 2005 08:12:28 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Microwindows on Icecube/CoralP 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> > This will not work. Microwindows can only  use  a  plain framebuffer
>> > interface,  but  the Coral-P does not allow for such a driver
>> > because of the fact that it has a little-endian register interface.
>> 
>> Or is it because 5200 swaps bytes around on PCI.  

>I have similar problems with an MPC5200 board and a Silicon Motion
>SM501 (Voyager) grafic controller. The controller has a PCI and a
>local bus interface. We use the local bus interface to connect it
>with the 5200. In 32 bit truecolor mode everything works fine, but
>in 16 bit mode bytes are swapped: 0x12345678 => 0x34127856.
>I'm not sure, if this problem has something to do with the CoralP
>problem, but it is likely too similar to be completely independent.

Two questions:  Is your local bus set up as 32 bits wide, and are
you writing 32 bits at a time?  The little/big endian issue only 
shows up when writing smaller values than the width of the 
interface.  In other words, an x86 and a PPC will write a 32bit
word to 32bit memory in exactly the same way.  The difference
comes in how they address bytes or words within that 32bit data
lane.  So if you, for instance, are writing longs in truecolor mode
and bytes in 16 bit mode that could explain what you are seeing.

On the 5200 you've got two issues to deal with:  You've got 
the byte/short addressing mismatches that might show up, then
you've also got to take into account that 5200 swaps the
byte lanes around.

Mark
