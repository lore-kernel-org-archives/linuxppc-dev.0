To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problems running I2C and/or SPI on 857 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Mar 2002 12:13:18 +0100."
             <FCEAKDJJAPHPLJFINDAJIENECDAA.Stephan.Linke@epygi.de>
Date: Tue, 26 Mar 2002 13:25:14 +0100
Message-Id: <20020326122519.3849C109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <FCEAKDJJAPHPLJFINDAJIENECDAA.Stephan.Linke@epygi.de> you wrote:
> I'm using 1.1.4 at the moment. (Can't update for now.)
> I found the problem with I2C. Looks like I don't need the microcode patch.
> But I need to do the settings as if I would use the microcode patch. I don't
> know why but maybe the 857/862 ERRATA ESAR6 says something like that...
>
> I still think that there are some buggy pathes in the code. But let me
> see...

I'll happily accept patches...

> > I wonder why you use the CPM code at all.  I  always  found  it  much
> > easier to use CONFIG_SOFT_I2C ...
> >
> Well, I don't know the soft I2C. I guess, when we started playing with the
> 8260 there was no soft I2C. Is there a timing difference? Is there a soft
> SPI too?

There has always been a soft-i2c.  The  timing  is  dictated  by  the
external  hardware  (i2c  bus),  so  no,  there  is  not  much  of  a
difference. The main difference is where the CPU burns  it's  cycles:
with  soft-i2c  it's  running  the delay loops, and with the CPM it's
setting up the CPM stuff and waiting for the transfer to be done.

Not much practical difference,  if  you  ask  me.  And  the  soft-i2c
solution is much simpler...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Physician: One upon whom we set our hopes when ill and our dogs  when
well.                                                - Ambrose Bierce

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
