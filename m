From: "Michael A. Peters" <mpeters@omnilinux.com>
Reply-To: mpeters@omnilinux.com
To: Edwin Tam <edwintam@ieee.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: php compilation fix
Date: Wed, 9 Aug 2000 10:38:42 -0700
Content-Type: text/plain
References: <B5B71115.316A%edwintam@ieee.org>
In-Reply-To: <B5B71115.316A%edwintam@ieee.org>
Cc: ProjectQ2@unitek.com
MIME-Version: 1.0
Message-Id: <00080910462800.26506@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks! That patch worked beautifully on PowerPC, and mod_php-gd builds and the
gd.so module loads.

What we decided to do (until an official patch comes from zend) is only apply
that patch when the src rpm builds for PowerPC, even though the patch may
benefit i386 as well.

But the nice thing is that I now have the RPM's, all of them including
mod_php-gd, working on both platforms. linux-Sparc64 is next (hopefully it will
at most just need the ppc patch, hopefully...)

Once again, Thanks!

On Tue, 08 Aug 2000, Edwin Tam wrote:
> Marco Pratesi (Bcc'ed) suggested a much neater fix than mine:
> > I have solved the problem simply by commenting out
> > the lines 370 and 435 and using orig_args
> > instead of args.
> > I have made this thing because orig_args is never
> > overwritten in the functions related to lines 370
> > and 435 and it is used only to copy it in args.
> > Do you think my correction can be dangerous ?
> > My diff:
> > 370,372c370,372
> > <                       args = orig_args;
> > <                       size = vsnprintf(buffer, sizeof(buffer) - 1, format,
> args);
> > <                       va_end(args);
> > ---
> >> //                    args = orig_args;
> >> size = vsnprintf(buffer, sizeof(buffer) - 1, format, orig_args);
> >> va_end(orig_args);
> > 435,437c435,437
> > <               args = orig_args;
> > <               size = vsnprintf(buffer, sizeof(buffer) - 1, format, args);
> > <               va_end(args);
> > ---
> >> //            args = orig_args;
> >> size = vsnprintf(buffer, sizeof(buffer) - 1, format, orig_args);
> >> va_end(orig_args);

*SNIP*

> > I created a patch that makes the changes suggest to php-4.0.1pl2/main/main.c
> >
> > replace
> > args = orig_args;
> > by:
> > memcpy(args, orig_args, sizeof(orig_args));
> >
> > in lines 370 & 435
> >

*snip*


--
Michael A. Peters
http://www.omnilinux.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
