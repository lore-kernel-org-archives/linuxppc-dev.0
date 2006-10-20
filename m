Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id B31F167B52
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Oct 2006 05:41:37 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1Gb0FK-0003dS-Jv
	for linuxppc-embedded@ozlabs.org; Fri, 20 Oct 2006 21:41:34 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	<87ac40vgeo.fsf@sleipner.barco.com>
	<609d5c8e0610151648x41b0c49cj4d0cda0e3b5bf1e@mail.gmail.com>
Date: Fri, 20 Oct 2006 21:41:34 +0200
In-Reply-To: <609d5c8e0610151648x41b0c49cj4d0cda0e3b5bf1e@mail.gmail.com>
	(David Bolcsfoldi's message of "Sun, 15 Oct 2006 16:48:41 -0700")
Message-ID: <87lknadbbl.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David Bolcsfoldi <dbolcsfoldi@gmail.com> writes:

Hi - sorry for the slow response, this week has been crazy :/

>> Could you make it relative to my driver so the changes are easier
>> to see?

David> Done and done. Look at the end of this e-mail.

Thanks.

>> The PPC is big endian - Did you remember to add 3 to your base
>> address?

David> I don't see how reading a single byte would be affected by the
David> endianess of the platform.  I think it has more to do with the
David> fact that the status and control registers are both 4 byte wide
David> and when you add 3 to your offset you read only the LSB. I also
David> suspect that the RX and TX registers are 4 byte wide too, even
David> though this is not stated explicitly in the documentation I
David> think it would be prudent to access these two as 4-byte wide
David> registers as well.

Well, the end result is the same. I guess the only reason for the
4-byte spacing between the registers is the 32bit width of the OPB
bus. The logical contents of the registers are all 8bit or less, and
sticking to 8bit access makes things easier (no endianness issues, no
issues with alternative implementations with another physical width).

E.G. the driver might be useful for other architectures
(E.G. microblaze) and for other implementations of the uartlite. We
are using another uart with a uartlite compatible interface in a
non-virtex fpga.

The exact same thing is done my 8250.c for the 16550 opb core.

David> I guess it is OK to read and write bytes as long as the
David> bitflags don't change location. But I believe it is stated in
David> the documentation that the OPB UART Lite device is a big endian
David> device, in my opinion it would better to honor this and do big
David> endian access of register width.

The driver has to be updated If the hardware interface changes no
matter what. The documentation clearly states (bottom of page 3) that
you can access the registers using 8, 16 or 32bit accesses.

I'll test and take a closer look at your patch when I have access to
hw again on Monday.

-- 
Bye, Peter Korsgaard
