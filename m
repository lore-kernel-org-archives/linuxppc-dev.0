To: David Jander <david.jander@protonic.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory map with "holes"... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 12 Aug 2003 17:00:11 +0200."
             <200308121700.11708.david.jander@protonic.nl>
Date: Tue, 12 Aug 2003 17:41:44 +0200
Message-Id: <20030812154149.40702C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200308121700.11708.david.jander@protonic.nl> you wrote:
>
> I wanted to connect the bank select lines BA0 and BA1 of the SDRAM
> chips to A6 and A5 respectively, and use only one CS (Chip-Select).

Arghhhh... don't do that.

> What I pretend to do is something like this:
> Memory mapped on CS0:
> Region                  What
> --------------------------------
> 0x00000000-0x007fffff   RAM
> 0x00800000-0x01ffffff   invalid
> 0x02000000-0x027fffff   RAM
> 0x02800000-0x03ffffff   invalid
> 0x04000000-0x047fffff   RAM
> 0x04800000-0x05ffffff   invalid
> 0x06000000-0x067fffff   RAM

You will not get lucky with such a design, for several reasons.

CS0 is the boot device. RAM will not work on CS0.

Second, you make your design unecessarily  complicated.  Attach  each
bank  of  RAM  to  nother CS, and let the memory controller map it as
needed.

> marked as "invalid" to be, well, invalid. With a MMU this should not
> matter, only the kernel must know what to do.
>
> For example I found in /arch/ppc/init.c, in the function
> set_phys_avail(), this piece of code:
>
> phys_avail.regions[0].address = PPC_MEMSTART; regions[0].size =
> phys_avail.total_memory; n_regions = 1;
>
> This looks fairly easy to modify, but I wonder why nobody seems to use
> more than one region in linux-ppc??

Why make a design more complicated than necessary?

> What's the policy? To not use this?
> Am I the only one who wants something like this?

>From what I've seen so far: yes. All boards I've seen allowed to  map
the system RAM as one contiguous area.

> Should I start implementing this myself on u-boot and linux-ppc ('cause I

Note that U-Boot does not use the MMU.

> should I better restrict my design to contiguous blocks of RAM only
> (this would make me waste 4 CS lines, and unnecessarily complex
> hardware)?

I would prefer such a design, but hey, I'm a software  developer  and
I'm  supposed  to  bring  up  requirements  that  make  life  it more
difficult to the hardware guys :-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It is easier to port a shell than a shell script."      - Larry Wall

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
