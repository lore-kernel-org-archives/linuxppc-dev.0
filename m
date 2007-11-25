Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AD5DDDF17
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 09:56:51 +1100 (EST)
Message-ID: <4749FD5E.7000408@dlasys.net>
Date: Sun, 25 Nov 2007 17:55:26 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Xilinx devicetrees
References: <47480CF0.7090105@dlasys.net>	
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	
	<47493D4F.4070605@dlasys.net>
	<fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com>
In-Reply-To: <fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> nope, not at all the same as dynamic detection; just backwards
> compatibility with the way we do it now for arch/ppc.
>   
    Other things being equal a common architecture is preferable to a
collection of independent ones.


>
>
> No, it doesn't make sense to store is in the FPGA fabric; but if the
> design already contains BRAM then it could be placed there and
> reclaimed for other purposes after booting.  Or anywhere in RAM for
> that matter.  I don't know how feasible is to load a device tree into
> SDRAM at FPGA config time.
>   
    I am not expert on this, but at Pico we already store our boot
monitor in the .bit files in BRAM.
    But that is not free.  It is one of the reasons we do not use
u-boot. Our boot monitor must fit into 16K of BRAM.
    Must be able to perform selftests on critical hardware, support a
flash file system, load bit files from flash to the FGA, load and
exectute elf files, allow a small set of user commands, and handle
hosted vs. standalone operation.
    And aparently extract the devicetree from a bit file and pass it to
a linux kernel.


> Ah; I think I see the disconnect we're having.  Device trees are not
> about, *and never have been about*, device detection.  The device tree
> is simply the communication medium used to describe the hardware.  It
> doesn't matter if you choose to use a 100% dynamically generated
> device tree from intelligent firmware or a 100% static device tree
> blob.  All that matters is that the kernel is able to trust the
> information handed to it by firmware.
>
> Device detection is not a problem that the device tree is designed to solve.
>
> It is designed to solve the problem of telling the kernel what the
> platform looks like (which occurs after the detection stage).
>   
    In static or fairly static hardware, that's fine. Even in somewhat
dynamic hardware with large quantities of startup resources - like a PC.
    But in highly dynamic hardware with fairly limited resources it
starts to become an issue.

    Still if xilinx intends to generate the device tree with the bit
file - even better appended to the bit file or embedded in the FPGA if
feasible,
    this could still work.

    I do not see Detection as independent of communication.
    Aside from a very minimal core, If device drivers can do a good job
of validating their hardware (back to my version registers issue in
another post) and I just load them willy nilly and let the ones that
have no hardware fail (Gross over simplification, but still viable) then
a communication scheme is meaningless. Going the opposite direction,  if
I do not have the resources to detect the hardware and build the
devicetree dynamically, AND I have  highly dynamic hardware, AND I do
not have an easy method I can trust of aquiring another source for the
hardware description, devicetree's aren't any help. There are alot of
AND's there but most if not all appear to be present with FPGA based
systems.


> arch/powerpc support for Virtex is now in Linus' mainline tree which
> will become 2.6.24
>   

    Guess it is time to pull Linus again.
> No, unfortunately they don't deal with the problem you're facing
> (which I'm facing also).  But it will be solved if we figure out a
> sane way to bind the device tree up with the FPGA bitstream without
> consuming FPGA resources.
>   
    Note to Xilinx:

       There MUST be some way of binding a device description to a bit file.

    neither building it into the FPGA fabric nor appending it to the end
of the bit file are perfect solutions,
    The former is more powerfull and flexible but wastes precious
resources. The later is more complex and puts more burdens on
    software developers, and may be completely unfeasible in some
environments - not mine fortunately.

    Regardless, something must be done. An odd collection of devicetree
files co-mingled with a collection of bit files, is little better than
xparameter files all over the place.

    And once again a plea to ALWAYS make version/capabilities registers
atleast an optional part of every design.
    Embeddeding a device tree into a design might be fairly expensive. a
pair of read only 32 bit registers is damn near free - basically the
FPGA equivalent of atmost 64 diodes or resistors.
> Cheers,
> g.
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
