Date: Fri, 27 Aug 1999 01:46:32 -0400
From: brad allison <jackal@aol.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: "David A. Gatwood" <dgatwood@mvista.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
In-Reply-To: <19990824202152.007307@mail.mipsys.com>
Message-ID: <Pine.SGI.4.00.9908270140580.15145-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well the whole point of this was to get around having to boot into MacOS,
set resolution, call bootX, boot single user, Xautoconfig, init 5, just to
change your resolution.

Solaris2.7 has that nice m64config command that lets you set your
resolution and color depth on the command line, then you kill and restart
X and it takes effect.

It would be really cool if linuxppc had something like that.

Does it?

-b




On Tue, 24 Aug 1999, Benjamin Herrenschmidt wrote:

> 
> On Tue, Aug 24, 1999, David A. Gatwood <dgatwood@mvista.com> wrote:
> 
> >That's not _entirely_ true.  The hardware itself relies on the nvram
> >setting in order to determine the initial startup mode before it starts
> >loading MacOS.  That's why you can do tricks with newer versions of MacOS
> >like have the preferences set to 1024x768 and the pram/nvram set to
> >640x480 and have it switch half-way into booting. (Makes it nice for
> >MkLinux on x100's where you have to be in 8-bit color, but don't want to
> >run MacOS that way.)  The Monitors & Sound CP does set the nvram value, at
> >least on some machines, unless it changed quite recently, but you
> >sometimes have to delete its prefs files to convince it to do so.
> 
> Yes, you are right. But the fact remains that video drivers are free to
> store this in any proprietary format they want and I had some trouble
> getting this to work with iMacs and blue G3s. Also, this nvram setting is
> limited to those "official" mode values, but the driver is free to
> implement completely different modes, and there's also some support for
> DCC slowly appearing in MacOS. I don't think we can rely reliably on this
> nvram value.
> 
> What I could eventually do is to add code to BootX that asks the driver
> about the current mode (the driver should be able to return me all sorts
> of informations, including some, but not all, of the timings) and build a
> kernel command line with those. We should find something generic since
> I'm not sure I can easily find out which kind of driver to use on the
> command line (atyfb, platinumfb, controlfb, ...)
> 
> I have plans to extend BootX so that i can also setup OF environement
> variables for quik-based booting. It would be able to setup those infos
> there too. I'll look into this as soon as I have a new hard drive for my
> 8500 (the old one joined my pile of dead HDs last week, I'll soon be able
> to make some kind of modern art with all those HDs ;-).
> 
> -- 
>            Perso. e-mail: <mailto:bh40@calva.net>
>            Work   e-mail: <mailto:benh@mipsys.com>
> BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>
> 
> 

--
AOL SAPI 		                        703.265.0908     AIM:jackal242
http://jackal.fudge.org        `I was never more certain of how far away I was
from my goal than when I was standing right beside it.' - Ethan Hawke, Gattaca

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
