Message-Id: <4.3.2.20010920112423.00b71f00@falcon.si.com>
Date: Thu, 20 Sep 2001 11:27:10 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: [Question] I want to use CSCOPE to port Linux kernel.
In-Reply-To: <20010920143200.79354.qmail@web11002.mail.yahoo.com>
References: <200109201107.UAA15781@ldap.dacom.co.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


You may also want to find a real libncurses.so.4 and install it rather
than symlinking libncurses.so.5 to it.  You probably will be able to
get away with the symlink, but changes in major revs (4->5) tend to
indicate significant changes in parts of the interface (API), which
would cause the caller great consternation if it was unlucky and called
a function whose interface had changed.

gvb


At 07:32 AM 9/20/01 -0700, Dan Bethe wrote:

> > I have already libncurses.so.5.2
> >
> > So I tried as below, but I had the same result.
> > ---------------------------------------------------
> > # ln -s libncurses.so.5.2 libncurses.so.4
> > # rpm -ivh cscope-15.3-1.i386.rpm
> > error: failed dependencies:
> >         libncurses.so.4 is needed by cscope-15.3-1
>
>         Hi there.  RPM's dependancies are based on its database, and
> not on the actual
>filesystem.  So the 'ln' wouldn't make any difference in this
>case.  Try this:
>
># rpm -ivh --nodeps cscope-15.3-1.i386.rpm
>
>         That bypasses RPM's opinion of what is and should be
> installed, so you might
>always have to remember that as a one-off.
>
>=====
>Medium System Administrator and Junior I.T. Manager of 5 yrs
>  -- Now available -- Linux, MacOS, Unix-like systems
>     -- http://mmmgood.net -- dan_bethe@yahoo.com
>
>

******************** Lawyer gibberish: ********************


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
