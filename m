Message-ID: <38460186.8CEC249C@eecs.lehigh.edu>
Date: Thu, 02 Dec 1999 00:20:06 -0500
From: Jason Kim <jwk2@eecs.lehigh.edu>
MIME-Version: 1.0
To: khendricks@ivey.uwo.ca,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: patch for problem with va-ppc.h included with egcs and gcc-2.95.2
References: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com> <4.2.2.19991201162019.03c111b0@mail.lauterbach.com> <384574A2.A003F5F6@eecs.lehigh.edu> <99120114490800.04790@localhost.localdomain>
Content-Type: text/plain; charset=iso-2022-kr
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin Hendricks wrote:

> If there is any way to change this without beaking backward compatibility with
> pre-compiled shared libs and things, I would vote for it.
> 

Well, xemacs-21.1.8, Mesa-3.0, gcc-2.95.2, xscreensaver-3.21, gle-2.3 and
ssh-2.0.13 all compile and link against the older dynamic libraries, but use the
va_list definition from my patch. All seem to work fine. They were all compiled
from gcc-2.95.2 and binutils-2.95.?? on an otheriwise standard LinuxPPC 1999 Q3
install on my Apple B&W  G3. 

It seems that the va_list is more or less isolated from the library interface
issues, as user code that I've seen don't ever pass back va_list to library
code, so having the patch seems to be safe, at least for above packages.

Anybody have any examples of where there IS va_list passage from user code to
existing dynlib code (or vice versa)? I tried a bit, and couldn't find any, and
am thinking that there isn't any. If that is the case, then applying the patch
en-mass
seems harmless way for getting rid of the array based va_list once and for all.

Feedback please.

thanks.

-jason.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
