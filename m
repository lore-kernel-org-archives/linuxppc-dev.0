To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'Geir Frode Raanes'" <geirfrs@invalid.ed.ntnu.no>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: custom mpc8240 student project (long) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 22 Feb 2002 11:33:04 MST."
             <C08678384BE7D311B4D70004ACA371050B7632EA@amer22.avnet.com>
Date: Fri, 22 Feb 2002 21:51:09 +0100
Message-Id: <20020222205114.62E6D109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <C08678384BE7D311B4D70004ACA371050B7632EA@amer22.avnet.com>
John Kerl wrote:
>
> What happens, in the software-only solution, is that those four
> pins are connected to a ribbon cable which plugs into the PC's
> parallel port.  Inside the software on the PC, you just set/clear
> bits, reading and writing a few bits in the byte-wide LPT/parport
> interface.  No auxiliary microcontroller is required (although I

Right, and  this  is  how  simple  /  cheap  BDM  and  JTAG  debugger
("parallel port adapters") work. See for instance the BDM4GDB project
on Sourceforge.

> I don't know what you mean by "trap" logic.  I know that JTAG
> itself is an open standard, in the sense that you can get books
> on it, and if you want the official protocol document, you can
> get that from the IEEE at a nominal fee.  I don't think that the
> JTAG standard can be considered closed.

JTAG defines just HOW to exchange information  over  this  interface,
but  you  need additional information to actually be able to assemble
or understand the information you send or receive.

> As for the PPC debug logic (the kind of stuff a probe plugs
> into), my experience is that that is documented in the Motorola
> 8xx manuals.  (On the other hand, I've never attempted to control
> the debug header in software, so I don't know if the manuals are
> complete.  Perhaps someone can correct me on this.)

*xx is completely different. It uses a BDM  interface,  and  this  is
indeed  well  documented  -  which made it possible to come up with a
free GDB extension and a semi-free (if you  build  it  yourself;  but
it's still < $50 for the ready-to-run box) BDM4GDB design.

> IMHO, I don't think it's the *information* that's so much being
> held closed.  From my experience, I don't see JTAG being in an
> NDA state.  The JTAG protocol is conceptually simple; BSDL files
> are published; we've written bit-bang software to flash our
> boards and it does work (of course the code is time-consuming to
> write, and slow to run).

If you try to control a CPU (say, a MPC82xx) over the JTAG  (or  COP)
debug  port,  you need additional information; the JTAG specification
is not enough.

Motorola will provide this information,  but  only  under  NDA.  They
claim  that  one can learn intimate details about the inner design of
their CPUs from that document, so they need  to  keep  it  closed  to
protect their intellectual property. (Their worrds, not mine!)

That's the reason why BDM4GDB supports only BDM.  The  BDM4GDB  would
also  work  with  a  JTAG  interface  - in fact even the connector is
already there. We would like to provide a JTAG extension for BDM4GDB,
but since it's based on GDB it will be Open Source, and this does not
mix with Moto's NDA.

End of the story. I tried many times, through different channels, but
Moto will not give in.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A direct quote from the Boss: "We passed over a lot of good people to
get the ones we hired."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
