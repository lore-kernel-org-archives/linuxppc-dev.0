To: Pantelis Antoniou <panto@intracom.gr>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 2004 16:23:21 +0300."
             <40C9B249.4070905@intracom.gr>
Date: Fri, 11 Jun 2004 16:09:14 +0200
Message-Id: <20040611140919.84651C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Pantelis,

in message <40C9B249.4070905@intracom.gr> you wrote:
>
> >No, this is IMHO not a good idea. Some of the information that  needs
> >to  be  passed to the kernel is not contained in the envrionment, and
> >does not belong there.
> >
> I'm just talking about augmenting the information provided by bd_t.

Again, no. It makes no sense to implement two  (or  more)  interfaces
for  the  same  purpose.  Let's  do it once, and right. It has become
clear that the bd_t stuff is not flexible enough, so let's get rid of
it and replace it, instead of adding more crap^H^H^H^H stuff  on  top
of it.

> And it's not just things that the kernel needs, it can be used to
> pass information to the user-space applications.

But this is nothing now. You have always been able to read and  write
the  U-Boot  environment  from applications. But this is a completely
unrelated topic.

Similarly it's trivial to parse /proc/cmdline by a script or  program
to  extract any information you might be looking for. But again, this
has nothing to do with  the  way  how  the  boot  loader  passes  the
required information to the kernel.

> Reading the environment from flash is not correct because the
> variables might be modified by the boot sequence but not commited.

This depends  on  what  you  are  doing.  Of  course  it  is  in  the
responsibility  of  the user to define which data to use, and when or
where to place a "setenv" in the boot script (if really needed). "Not
correct" is just your opinion for a very specuific mode  of  usage  -
which  just  indicates the problem: the U-Boot environment is NOT the
right place to look for the information you are after.

> When I get some breathing time, I'll sent you the patch.

Be prepared that I might ignore it.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It all seemed, he thought, to be rather a lot of  trouble  to  go  to
just sharpen a razor blade.  - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
