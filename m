Date: Fri, 24 Mar 2000 11:19:42 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "William H. Schultz" <whschult@uncc.edu>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86 4.0 Generic VGA
In-Reply-To: <B5002664.69%whschult@uncc.edu>
Message-ID: <Pine.LNX.4.21.0003241106550.866-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 23 Mar 2000, William H. Schultz wrote:

>
> on 3/23/00 3:52 PM, Michel Dänzer at michdaen@iiic.ethz.ch wrote:
>
> > "William H. Schultz" wrote:
> >
> >>> Have you tried the tdfx driver? IIRC Kostas has it working.
> >>>
> >> Forgive me for being slow, but where can I get it?  I was
> >> under the impression that the tdfx driver, unlike most of
> >> the others, was compiled straight into the kernel.  I know
> >> I haven't gotten that to work.
> >
> > No, it's part of the XFree86 4.0 sources. Do you mean the DRM kernel module
> > (for DRI hardware accelerated 3D) for it? You don't need that for 2D, but if
> > you'd like it to work, contact Kostas.
> >

  The default tdfx driver in the XFree sources isn't going to work :(
it depends on PIO to drive the card and that isn't working under ppc
we need to find the correct io_base and mmap it for the driver to work
(other drivers need it as well, not only tdfx)

 Finding the io_base from userland without the kernel giving us a hand
isn't easy i am adding code this days that tries to get the correct
values depending on the host bridge (thanks Ryuichi for the help here)
this is something that i would have prefer not to do, but until
the kernel people do something about this problem this is the only
way :(.

> >
> >> XFree86 -configure definately doesn't work.  I know I should
> >> be paying more attention to the errors, but I get fewer by
> >> running xf86configure instead of the other way.
> >
> > What does it do?
> >
> >
> > Michel
>
> On a fresh install, typeing  XFree86 -configure brings up the following
> (note that for some reason, the tdfx driver is not installed.  Like I asked
> before:  where can I get it?  Also note that I'm running on a 2.2.14
> kernel):
>
>
...
> Fatal server error:
> Caught signal 11.  Server aborting
>

  A sigsegv is probably because one of the drivers tried to do PIO

>
> Apparently it was compiled on 2.2.15, but I'm running 2.2.14.  Oh yeah, the
> tdfx driver that is in there, I copied from a 3.9.16 install that actually
> had the driver.  It gives the same error whether it's there or not.

  The 3.9.16 driver is unlikely to work under 4.0 many things changed
since then.

> Hank
>

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
