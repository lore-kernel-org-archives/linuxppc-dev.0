To: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Porting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 23 Apr 2003 15:54:07 +0200."
             <sea6b726.000@mail.frequentis.com>
Date: Wed, 23 Apr 2003 17:09:05 +0200
Message-Id: <20030423150910.A02F4C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <sea6b726.000@mail.frequentis.com> you wrote:
>
> The last 2 weeks I worked full time on PCMCIA. We have a custom board with a MPC860T 10/100MBit Ethernet one PCMCIA slot 8MB flash and 32MB RAM.

Ummm... may I ask why you re-invented the wheel?

> I linked the pcmcia stuff directly to the kernel (driver/pcmcia), because I think I understand it right Wolfgang, your PCMCIA onyl works if PPCBoot setup the PCMCIA port. But we don't use PPCBoot (shame about that .... ) and it seems to be to complicate

If you use the direct IDE support as implemented in our kernel  tree,
Linux  reads  the  memory map of the PCMCIA port from the pcmc_pbrX /
pcmc_porX registers. That's  all.  Initializing  these  registers  in
Linux  is  trivial.  The  reason  we  avoid it is because this may be
board-dependend.

> d/more work to add the whole stuff into our boot up sequence. I know that we loose the possibilty to mount root from a flash card, but we could live with that. Maybe Wolfgang has another hint for me ... :-)

We include both the direct IDE interface and  the  full  PCMCIA  card
services  package  with  our  ELDK. It has been tested and is working
fine on a couple of differenrt boards. We even  support  both  PCMCIA
slots on MPC860 systems.

> However, I start of course where everyone startet:

I'm sorry, but this is ancient stuff. Why didn't you use more  recent
code for your work?

> We portet also the mvista kernel 2.4.2 to the denx kernel 2.4.4

What exactly do you mean with this statement?

> >From now on it works. I used for the first steps the file system from the eldk and copy then the necessary files (cardctl, cardmgr, scripts) to our filesystem.

All of this (and more) is included and ready for  use  in  the  ELDK.
It's a pity you wasted so much work without asking earlier :-(


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
                                           - Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
