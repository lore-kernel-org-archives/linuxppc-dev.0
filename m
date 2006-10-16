Return-Path: <jacmet@sunsite.dk>
Received: from hoboe1bl1.telenet-ops.be (hoboe1bl1.telenet-ops.be
	[195.130.137.72]) by ozlabs.org (Postfix) with ESMTP id 2814167C3C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Oct 2006 05:49:54 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<452F36AE.6040205@dlasys.net> <8764eovg81.fsf@sleipner.barco.com>
	<4532A1D1.4040006@dlasys.net>
Date: Mon, 16 Oct 2006 21:49:43 +0200
In-Reply-To: <4532A1D1.4040006@dlasys.net> (David H. Lynch, Jr.'s message of
	"Sun, 15 Oct 2006 17:02:09 -0400")
Message-ID: <873b9oqbvs.fsf@slug.be.48ers.dk>
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

 >> I'm still not convinced that DCR access and variable register
 >> offsets are needed - But it can always be added (through a
 >> seperate struct in platform_data) - Patches are welcome.

 David>     It does not matter whether you or I are convinced. It
 David> matters whether there are people that need it.  Xilinx has a
 David> reference design that uses DCR. While I have never tripped
 David> over an actual implimentation that uses DCR there are others
 David> on this list that have.

Those people are welcome to add it then. Benh recently posted some
patches with a dcr abstraction that could probably make it pretty
clean to add.

 David>     Right now I can not get your driver to work. I spent alot
 David> of time trying to fix it and got nowhere.  I can not get it to
 David> receive at all, and I can not get it to send after switching
 David> from the console driver without dropping characters. I am very
 David> busy with other things right now and it is going to be a long
 David> time before I have time to look at your driver again.

Sorry to hear. We are using it in several designs without problems and
it also worked for Oluf. I'm afraid I won't be able to help you
anymore unless you provide more details.

 David>     But what matters is not whether the changes are intrusive,
 David> but whether they produce a better result.

Sorry, I don't agree. Maintainability is very important.

 David>     I am glad somebody is using your driver and finding it
 David> works. But we are all better served by fixing the failure
 David> cases.

Yes, please do or provide enough details for me to reproduce it.

 David>     It is not particularly odd at all. The UartLite despite
 David> its simplicity is worse than a normal driver - different FPGA
 David> implimentations can vary. Normal drivers for fixed inflexible
 David> hardware often do not work accross differing implimentations,
 David> why would you expect something like UartLite to be invariant ?

It's no worse than Xilinx 8250 core. There's only 1 implementation of
the uarlite IP core - Xilinx's.

 David>     I would also ask what data rates you and others with
 David> Working UartLites are using ?  The cases I am dealing with run
 David> at 57600 and 115200 respectively - it is not that odd for
 David> driver problems to manifest themselves only or more frequently
 David> at high baud rates.

We're using 115200 for most designs, but one design is using it at
1mbit.

 David>     Without being difficult - don't hold your breath. It is
 David> something I would like to do, but I do not have infinite time.

Ok.

-- 
Bye, Peter Korsgaard
