To: Kevin Fry <kevin@carts.com>
Cc: Craig MacDonald <macdonldc@netscape.net>,
	linuxppc-embedded@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem booting linux-2.4.4-2001-07-23 on EST SBC8260 with ppcboot 1.0.4 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Sep 2001 15:45:23 PDT."
             <3BABC303.1674D66E@carts.com>
Date: Sun, 23 Sep 2001 20:00:37 +0200
Message-Id: <20010923180042.F1B1E100A2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BABC303.1674D66E@carts.com> you wrote:
>
> You should have ppcboot remap the IMMR to 0xF0000000 in the start of ppcboot
> code. Otherwise it will interfere with Linux memory mapping. See this file for
> all the info you need.

Right!

> > I am trying to get linux 2.4 running on an EST SBC8260.
> > It seems others have this board working correctly, so

Probably these others just use the  PPCBoot  standard  configuration,
and you changed (read: broke) it?

> > It works up to executing the rfi in turn_on_mmu, but
> > it doesn't seem to reach start_here.

I'm not sure what makes you think this is the case. Did  you  by  any
chance   try  to  sngle-step  with  a  JTAG  debugger  over  the  RFI
instruction?

This will not work.

> > bdinfo
> > ------------------------
> > memstart    = 0x00000000
> > memsize     = 0x02000000
> > flashstart  = 0xfff00000
> > flashsize   = 0x00400000
> > flashoffset = 0x00040000
> > sramstart   = 0x00000000
> > sramsize    = 0x00000000
> > immr_base   = 0x0f000000
^^^^^^^^^^^^^

This is wrong. It should be 0xF0000000  as  it  is  in  the  standard
configuration  for  the  SBC8260  board  that  comes with the PPCBoot
sources. Don't change it.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The explanation requiring the fewest assumptions is the  most  likely
to be correct.                                    -- William of Occam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
