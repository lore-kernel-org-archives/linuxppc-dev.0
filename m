Message-ID: <38BC225D.69570BE3@chpc.utah.edu>
Date: Tue, 29 Feb 2000 12:47:41 -0700
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Brad Parker <brad@parker.boston.ma.us>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: problem building 2.3.47: no macintosh.a file
References: <200002291608.LAA16958@p2.parker.boston.ma.us>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Parker wrote:

> I've gotten 2.3.47 from kernel.org to build, doing pretty much what
> Lou did (below).  To get rid of the link errors you need to edit
> arch/ppc/kernel/ppc_ksyms.c and comment out the line with "strspn" in
> it.
>
> It boots on my imac.  I don't have a lot of milage yet, but usb works :-)
> fyi - I plan to switch to an rsync from Paul's tree...
>
> -brad
>
> >. . . Argh! I've gotten now to the point that 2.3.47 builds all the way then
> the linker
> >barfs with two "multiple definition of" errors.  . . .
> >kernel/kernel.o(.kstrtab+0x1f44): multiple definition of `__kstrtab_strspn'
> >arch/ppc/kernel/kernel.o(.kstrtab+0x4a4): first defined here
> >kernel/kernel.o(__ksymtab+0x9e0): multiple definition of `__ksymtab_strspn'
> >arch/ppc/kernel/kernel.o(__ksymtab+0x178): first defined here
> >make: *** [vmlinux] Error 1
> >
> >Can anyone help me with these definition errors? . . .

That was it!!! I'm so excited! I'm running kernel.org's 2.3.47 now on my PowerMac
7500 and haven't encountered a bug yet. Network I/O through my PPP connection even
feels a little snappier now. With any luck -- as people have indicated -- I won't
have anymore PPP freeze ups either.

Rambling BTW (for the linuxppc-dev archives mostly):

I did encounter some trouble  with getting PPP to install properly. First
I reliazed I had to update my pppd (etc) which fortunately I had sources for
already on my system. Then I found I had to set CONFIG_PPP_ASYNC=m in my .config
and run "make modules; make modules_install" to make the kernel happy. Trying to
build it within the kernel (instead of as a module), didn't seem to want to let
PPP work. modprobe kept complaining in my syslog file that it couldn't locate
module "tty-ldisc-3" which the PPP source dist says should be aliased if it's
built as a module to the ppp_async module (in the /etc/modules.conf file). So
after building and installing ppp_async as a module and updating the modules conf
file PPP was able to work. Is this a bug in "make xconfig" where it should limit
the choices to either "m" or "n"? Or maybe something I did wrong? I guess so long
as my system can still reboot I won't loose any more sleep over it :-)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
