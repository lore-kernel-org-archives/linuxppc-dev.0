Date: Fri, 11 Jun 2004 09:48:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Wolfgang Denk <wd@denx.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6
Message-ID: <20040611164848.GA925@smtp.west.cox.net>
References: <20040611140919.84651C109F@atlas.denx.de> <40C9BED6.3010809@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40C9BED6.3010809@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 11, 2004 at 05:16:54PM +0300, Pantelis Antoniou wrote:
>
> Wolfgang Denk wrote:
>
> >Dear Pantelis,
> >
> >in message <40C9B249.4070905@intracom.gr> you wrote:
> >
> >>>No, this is IMHO not a good idea. Some of the information that  needs
> >>>to  be  passed to the kernel is not contained in the envrionment, and
> >>>does not belong there.
> >>>
> >>>
> >>I'm just talking about augmenting the information provided by bd_t.
> >>
> >
> >Again, no. It makes no sense to implement two  (or  more)  interfaces
> >for  the  same  purpose.  Let's  do it once, and right. It has become
> >clear that the bd_t stuff is not flexible enough, so let's get rid of
> >it and replace it, instead of adding more crap^H^H^H^H stuff  on  top
> >of it.
> >
> >
> >>And it's not just things that the kernel needs, it can be used to
> >>pass information to the user-space applications.
> >>
> >
> >But this is nothing now. You have always been able to read and  write
> >the  U-Boot  environment  from applications. But this is a completely
> >unrelated topic.
> >
> >Similarly it's trivial to parse /proc/cmdline by a script or  program
> >to  extract any information you might be looking for. But again, this
> >has nothing to do with  the  way  how  the  boot  loader  passes  the
> >required information to the kernel.
> >
> >
> >>Reading the environment from flash is not correct because the
> >>variables might be modified by the boot sequence but not commited.
> >>
> >
> >This depends  on  what  you  are  doing.  Of  course  it  is  in  the
> >responsibility  of  the user to define which data to use, and when or
> >where to place a "setenv" in the boot script (if really needed). "Not
> >correct" is just your opinion for a very specuific mode  of  usage  -
> >which  just  indicates the problem: the U-Boot environment is NOT the
> >right place to look for the information you are after.
> >
> >
> OK, lets look at the very simple problem of having two
> ethernet interfaces. From where do I get the ethernet
> mac addresses? Modifying bd_t with defines is gross.
> Putting everything on the kernel command line results in
> an unreadable command line.

The 98%-in-2.6 answer today is to pass in BI_BOARD_INFO, a
board-specific blob of information, which is what boards like the
prpmc260 (only 2_4_devel right now since it's a gt64x60 board that needs
cleaner generic code for 2.6, but anyhow..).

... kicking myself for getting into this thread now, no doubt.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
