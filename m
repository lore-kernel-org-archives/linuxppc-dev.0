Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 012B6DDD01
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 22:00:53 +1100 (EST)
Message-ID: <474E9AE1.109@dlasys.net>
Date: Thu, 29 Nov 2007 05:56:33 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: John Williams <jwilliams@itee.uq.edu.au>
Subject: Re: Xilinx devicetrees
References: <47480CF0.7090105@dlasys.net>
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
	<20071125052459.DA8B1EE805F@mail70-blu.bigfish.com>
	<4749425C.5060207@dlasys.net>
	<20071125181506.EE2041BA004F@mail141-cpk.bigfish.com>
	<474CAE70.3030005@itee.uq.edu.au>
	<20071128002835.068BE16A005D@mail198-sin.bigfish.com>
	<474CBBDE.9010007@itee.uq.edu.au>
In-Reply-To: <474CBBDE.9010007@itee.uq.edu.au>
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Michal Simek <simekm2@fel.cvut.cz>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John Williams wrote:
>
> I'm not sure I agree, here, given that most people building MicroBlaze
> systems are doing so with uClinux-dist (or PetaLinux), you can do a
> full rebuilt, kernel libs apps, in a couple of minutes. Much shorter
> than sythnesis and P&R, that's for sure (and runtime is linear in
> size, unlike P&R :)
I am mostly a lurker in this debate. Pico has V5 cards that we intend to
run MicroBlaze Linux on, but as I would end up with the Linux work and I
have spent most of the past 6 months getting our host software working
under Linux, OpenBSd, and OS X, the time to play with the MicroBlaze
just was not there - but might be soon.

I did take note that Xilinx purportedly has an MMU for the MB now. This
is particularly intriguing.
To cast in my .02 - Pico is likely to either not run the MB on our V5's
or run a fairly bloated one.
uClinux only interests us - because the MB would not run full blown
Linux. Given the possibility that it might, we become less and less
interested, in the smallest MB posible. I know this contradicts many
things I have said about our position on Our PPC Linux, but our clients
who want Linux really want the whole thing. At this moment I do not have
a full appreciation of all the MB instruction options and emulating them
through exception handlers. But my guess is that we would turn
everything on that has any significant impact on linux kernel performance.

I am glad that John mentioned MB/PPC convergence. Particularly with an
MMU it is our hope that our PPC BSP for our V4FX boards ddifferes as
little as possible from our MB BSP for V4/V5 LX boards.

I am not looking to tell someone else how to spend their time - but Pico
would have little interest in dynamically mangling a kernel to adapt to
different CPU parameters. It sounds like alot of work, and alot of
grief. We would design our own CPU first.



>
> My experience tells me that if the microblaze can be configured in a
> particular way, *someone* will want to do it (and still boot linux on
> it!) We still have people building MicroBlaze 3.00 in Spartan2E, with
> EDK 6.3. And autoconfig works! Exceptions on/off, MMU on/off (runtime
> configurable on that?).
I would still venture that with very few exception people are going to
gravitate to the extremes, mostly all off, and mostly all on.
Mostly on would probably run full blown MMU Linux, and mostly off would
either run uClinux or nothing at all. Frankly I am not sure that with
everything mostly off, you wouldn't just pick a much smaller less
powerful core - something 8 or 16 bit that is a fraction of the size,
then the CPU become a logic element, rather than something to run an OS
- I.E. I can build a graphics processor in an FPGA implimenting most
things in hardware, but ploping a cheap (small) CPU in to do general
purpose low performance administrative tasks, that might take more space
in hardware.

Other things that would be higher on my hitlist would be seeing the GCC
MicroBlaze CPU support find its way into distribution GCC's.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
