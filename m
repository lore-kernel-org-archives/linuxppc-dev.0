To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can I run linux without a file system? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Jun 2002 16:13:01 CDT."
             <45B36A38D959B44CB032DA427A6E10640167CFE3@cceexc18.americas.cpqcorp.net>
Date: Fri, 21 Jun 2002 23:23:54 +0200
Message-Id: <20020621212359.BCA0D1030A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <45B36A38D959B44CB032DA427A6E10640167CFE3@cceexc18.americas.cpqcorp.net> you wrote:
>
> Hmm, my minimal rootfs is (so far) 7 Mb, (as reported by du -s).
> Or, is this 4Mb you cite compressed?  I wonder because my
> libc.so is over 5 Mb. (which I got from DENX eldk-1.0)

Have a look at the SELF Makefile... you should run

$(CROSS_PREFIX)strip --remove-section=.note --remove-section=.comment *.so

on all libraries on the trarget filesystem.

> Any hints or links to into on crunching down the
> individual libraries would be helpful.

And for really limited cases there is ulibc, the  library  optimizer,
etc.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Ill-chosen abstraction is particularly evident in the design  of  the
ADA  runtime  system.  The  interface to the ADA runtime system is so
opaque that it is impossible to model  or  predict  its  performance,
making it effectively useless for real-time systems.
- Marc D.  Donner and David H. Jameson.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
