To: David Jander <david.jander@protonic.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling glibc-2.3.2 (debian) on mpc8xx ;-) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Mar 2004 12:40:40 +0100."
             <200403091240.40660.david.jander@protonic.nl>
Date: Tue, 09 Mar 2004 13:09:19 +0100
Message-Id: <20040309120924.6AAA5C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200403091240.40660.david.jander@protonic.nl> you wrote:
> >
> > You have just created a bunch of incompatibilities here.  You  cannot
> > use binaries and shared libraries that don't fit to each other.
>
> I know. Strange thing is: it kinda works fine... until you hit code with
> calles to FP-related functions in the library. For example the following does

No. it does not work at all fine. It just does not crash immediately,
and some errors my be subtle and go through unnoticed.

> The math works fine, but printf screws up.

You re just lucky and working on a slightly  loaded  system  if  this
appears to be fine.

> Another observation: while "ps aux" shows correct percentage numbers (FP I
> assume), "top" shows only "nan" values for CPU and memory. Any explanation to
> why "ps" works fine?  I haven't looked at the sources yet.

I don't care. What you see is undefined behaviour, and you know that.

> > floating  point. Oh yes, there is the FP emulation in the kernel. But
> > this has never been working reliably.
>
> Wow! That sounds strong! How comes that? What are we waiting to get it working
> better? I assume the emulation on this processor works similar to the 386
> through exception handling, am I right?

You are right.

Simply: it does  not  make  sense  to  spend  effort  in  fixing  the
remainingproblems   since   this   is  so  awafully  slow  and  using
-msoft-float on bianries and libraries is a mauch better way to  deal
with the FP problem.

> Can I leave the patches involving FP-stuff out and rely on emulation? I guess

IMHO you cannot rely  on  the  emulation  at  all.  It  never  wroked
reliably in our tests.

> not for what you said earlier, but if the emulation worked well enough,
> whouldn't that be enough? Of course it will be slow as hell, but speed is not
> as important as actually running the code.

If "running" the code includes a certain level of reliability I would
not try to do that.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Winners never talk about glorious victories. That's  because  they're
the  ones  who  see  what the battlefield looks like afterwards. It's
only the losers who have glorious victories.
                                      - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
