Return-Path: <jacmet@sunsite.dk>
Received: from hoefnix.telenet-ops.be (hoefnix.telenet-ops.be [195.130.132.54])
	by ozlabs.org (Postfix) with ESMTP id 4577267C03
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Oct 2006 07:57:41 +1000 (EST)
Received: from hoboe1bl1.telenet-ops.be (hoboe1bl1.telenet-ops.be
	[195.130.137.72])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id F0B41A9132
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 21:42:15 +0200 (CEST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	<452F3A82.7070803@dlasys.net> <871wpcvfvw.fsf@sleipner.barco.com>
	<45329C42.3030000@dlasys.net>
Date: Mon, 16 Oct 2006 21:42:07 +0200
In-Reply-To: <45329C42.3030000@dlasys.net> (David H. Lynch, Jr.'s message of
	"Sun, 15 Oct 2006 16:38:26 -0400")
Message-ID: <877iz0qc8g.fsf@slug.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

Hi,

 David>     The 8250 is certainly the oldest driver - but it is also
 David> by far the most used. It is also the most heavily maintained,

Yes, because there's so many more-or-less compatible variants of the
hardware. Most drivers don't see a lot of development once they are
past the initial development/testing..

 David> There are complexities to the 8250 that proved to be difficult
 David> and troubling when I based my UartLite driver on it, Those
 David> problems were because the 8250driver suports so many 8250
 David> variants with so many idiosyncracies.

Exactly. Try to compare it to one of the "modern" drivers like
atmel_serial.c - It's almost 3 times as big.

 >> Remove support? I don't remember anything about that.

 David>     I may have misread something there - I thought your
 David> initial driver allowed stting the number of Uarts, and I
 David> beleive your current one does not.  If I am wrong, then I
 David> think support for more Uarts needs to get added to the todo
 David> list.  That is not something important to me. But it probably
 David> will be for others.

There was a discussion about how many device nodes to register with
lanana.org and hence how many devices to support. I went with 4 which
seems to be pretty standard (E.G. virtex.c supports up to 4 8250s). If
more is needed a bigger range can be requested with lanana.org.

Again, let's see a real need before changing anything.

 David> Despite the fact hat you apear to run combined 16550/Uartlite
 David> implimentations, My expectation is that will be rare.  A small
 David> savings in FPGA spare is rarely going to justify more complex
 David> hardware and software.  Multiple port systems are mostly
 David> likely to be all one type or another.

Almost all our designs use both.

P.S.: Would it be possible to fix up your quoting?

-- 
Bye, Peter Korsgaard
