Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD45011C475@NTSERVER4>
From: Daren Hayward <darenh@4bridgeworks.com>
To: "'Matt Porter'" <mporter@kernel.crashing.org>,
	"'Ralph Siemsen'" <rsiemsen@rossvideo.com>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: RE: early UART mapping in head_44x.S
Date: Mon, 2 Aug 2004 13:30:10 +0100 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have been having the same problems with the head_44x.S, what does the
patch do just remove the duplicate entries?

Where can I browse the PPC BK tree online?

Daren

> -----Original Message-----
> From: Matt Porter [mailto:mporter@kernel.crashing.org]
> Sent: 23 July 2004 00:56
> To: Ralph Siemsen
> Cc: Linux PPC Dev
> Subject: Re: early UART mapping in head_44x.S
>
>
> On Tue, Jul 13, 2004 at 05:23:34PM -0400, Ralph Siemsen wrote:
> >
> > I've been trying to boot a vanilla 2.6.7 kernel on a board similar to
> > Ocotea (the board boots 2.4.x okay).  I wasn't getting any serial
> > output, despite setting CONFIG_SERIAL_TEXT_DEBUG and doing early
> > registration of a console (as per David Woodhouse's posts on this list).
>
> That's a separate issue. I need to go through and early register
> the console on 4xx when I get a moment.
>
> > After much tracing and a lucky suggestion on IRC, I seem to have
> > stumbled on the cause, although I don't fully understand what is going
> > on.  In arch/ppc/kernel/head_44x.S (from 2.6.7 mainline) there is a
> > block of code that sets up the "early UART mapping".  It does three
> > tlbwe instructions, and then repeats the same a second time but in
> > "Translation state 1".  This second set seems to cause my problems.
> > When I comment out the 5 instructions before the isync, I magically
> > start getting printk outputs.
>
> Yeah, I fat-fingered the last patch to head_44x.S and left the
> duplicate code fragment there. There's a patch submitted to fix
> this in mainline.
>
> -Matt
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
