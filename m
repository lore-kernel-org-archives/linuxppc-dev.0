Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 877DEDDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Nov 2007 20:17:11 +1100 (EST)
Message-ID: <47493D4F.4070605@dlasys.net>
Date: Sun, 25 Nov 2007 04:15:59 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Xilinx devicetrees
References: <47480CF0.7090105@dlasys.net>
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
In-Reply-To: <fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    First;
          I am not deliberately trying to be obstructive. It is apparent
that the ppc kernel is moving towards devicetrees and initially I
thought that sounded like  a good idea.
          Now I am trying to reconcile the positive benefits with my
perception of the negative side effects.

> Yes, you are correct in all of the above.
>
> One more point; it is also possible to bind the device tree up with
> the kernel so you've got a single image just like old times.  :-)
>   
    But that is not actually the same is dynamically detecting
configuration.

    On an ordinary PC where the critical core configuration is somewhat
fixed and the rest can be determined by firmware (code), this makes a
great deal of sense.
    In a system where the hardware itself is actually firmware and there
is little or no startup software to query the device and build a device
tree dynamically for you, it is of more questionable value.
    Maybe if there is some mechanism existed to have the devicetree
stored into the FPGA firmware where there is a natural link between the
implimented hardware and its description. But I am not gathering things
going in that direction and storing the device tree in the FPGA consumes
valuable FPGA resources.

>
> The board description has to live *somewhere*.  
    I have done alot of code for many purposes where the code went to a
great deal of effort to figure out its own environment dynamically.
    Some (relatively minimal) assumptions have to be made. And some
balance has to be struck between code complexity and dynamic flexibility.
    though sometimes dynamic detection can be simpler.
    Part of what bothers me about devicetrees, is that the entire design
seems to presume either standard hardware with minimal permutations, or
fairly complex firmware - like boot roms to dynamically build atleast
parts of the device tree.

>
> That being said, using the device tree does not preclude using
> platform code to setup devices *where it makes sense to do so*.  Many
> things are one-off board specific things that are not well described
> with the device tree.  For example, we've been debating how to handle
> on board sound which use common codec chips, but have custom wireup.
> The codec chip can use a common driver, but the wireup is handled with
> an ALSA 'fabric' driver that is pretty much a one-off for the board.
> It probably makes more sense for the fabric driver to be instantiated
> by the platform code rather than trying to do a full device tree
> representation.
>   
       So I can hard code some relatively simple stripped devicetree
that  may do little more than specify the CPU, major elements of the
memory map (maybe), and say the PIC, and then let the BSP, detect things
like the UART(s), NIC, ...


>   In arch/powerpc
> we're *still* data driven; it's just that the data is no longer
> compiled into a static structure.  Plus, in the transition we've moved
> from needed per-device platform data structures to a more expressive
> format.  Also, per-board platform support code has become much simpler
> (compare ml300.c in arch/ppc with platforms/40x/virtex.c)
>   

    I have not pulled your tree in a while - are devicetree's in your
current git tree ?

    Thanks for the remarks.

    Again, I am just trying to figure out how to keep my Pico code in
sync and hopefully make my life better rather than worse at the same time.
    Unfortunately, I am coming to the conclusion that DeviceTrees are
probably not going to make it that much better,
    but they are probably not going to make it that much worse either.
   

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
