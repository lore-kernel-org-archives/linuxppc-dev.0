To: Dan Malek <dan@mvista.com>
Cc: Wolfgang Denk <wd@denx.de>, jtm@smoothsmoothie.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 console problems 
In-reply-to: Your message of "Thu, 22 Feb 2001 18:51:20 -0500"
             <3A95A5F8.DF6FB60B@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 23 Feb 2001 23:10:11 +1100
Message-ID: <27883.982930211@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 22 Feb 2001 18:51:20 -0500, Dan Malek <dan@mvista.com> writes:
>...the bd_info stuff
>is going to disappear and follow the new boot record method used by
>other PPC booters.  That is the first major step to removing the whole
>variety of different boot loaders.

I support this, as long as the "new boot record method" is documented
somewhere so that we can make ppcboot conform to it.

>...The serial port goes through no less than three
>different initializations (on the 8xx/8260) as new "layers" of software
>are brought up.  In order for KGDB to work early in the kernel code,
>the mbxboot/*tty.c functions create deep fifos and initialize the serial
>port in a way that the early kernel functions understand.

Isn't the "deep fifos" stuff done by "kgdb_map_scc()" as well?

>You will
>have to do the same thing in PPCBoot before calling the kernel for
>this to work.

This appears to work fine with ppcboot already, at least with my 8260
based system and the changes to the 8260 serial driver that I posted
not that long ago (which adds support for kgdb, among other things).
ppcboot uses single byte fifos. kgdb_map_scc() replaces these with
"deep fifos".

>Regardless of how a board and boot rom store
>and provide information, the code in the "boot" directory collects
>this into a standard format and presents it to the kernel.

OK, this is fine, I support this - as long as this "standard format" is
clearly defined somewhere (I suppose it will be simple enough to read the
code) so that ppcboot can implement it and do the same "presentation" to
the kernel, thus by-passing the "boot" directory code. If it is a well
known standard, then maybe over time all ppc boot code from all manufacturers
will implement it ("We support Linux"). And if it is the same as a lot of
existing boot loaders use (as you suggest above), all the better because
this will mean they support Linux without any work.

One thing that concerns me... Will the "new boot record method" be flexible
and allow any sort of information to be passed through to Linux, for any part
of Linux, not just the boot phase? For example, I might have a loadable module
which requires information from the low level boot code, information which the
boot phase of Linux doesn't care about. i.e. the structure and content of this
"new boot record method" should not be fixed. It should be "extensible".

Real life example required... Our boards will all have an i2c serial eeprom,
the contents of which will be read by the boot rom code, and possibly
changed and/or re-formatted. I want to pass this information via the "new
boot record method" up to Linux, which saves it somewhere for use by a
loadable module (or modules). I currently place the info into the board
information struct that ppcboot passes to Linux (it is, after all, board
information :-). If I don't do it this way, then I will have to write code
for Linux to do it (either at boot time, or in the init of the loadable
module(s)) which is a duplication.

It boils down to this: some things belong in the boot code, and some things
belong in Linux (a good example is configuring the memory controller for
accessing SDRAM, vs configuring the MMU for accessing virtual memory). Once
you decide that something belongs in the boot code, then a mechanism is
required to communicate information about that "thing" up to Linux (another
good example is the location of the Internal Memory Map - I am currently
running my 8260 kernel with IMAP_ADDR defined as ((bd_t *)__res)->bi_immr_base).

I see the stuff in the "boot" directory in Linux as simply "glue" between the
real boot code and Linux. It should be kept as small and as simple as possible.
And boot code that conforms to the "standard boot record method", won't
need the "glue".

Is anything I've said above in conflict with what you had in mind? Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
