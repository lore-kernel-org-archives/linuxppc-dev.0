To: Paul Ruhland <pruhland@rochester.rr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: powerpc cross tools question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Mar 2002 17:03:13 EST."
             <200203251703.13296.pruhland@rochester.rr.com>
Date: Mon, 25 Mar 2002 23:18:22 +0100
Message-Id: <20020325221827.B1CBF109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200203251703.13296.pruhland@rochester.rr.com> you wrote:
>
> The only thing I'm not satisfied with at this point is I still need to make a
> link on my target file system with the full path to the CDK lib directory as
> on my host...

This is simple to solve; see "Solution 2" on
http://www.denx.de/tips+tricks-en.html#libpath

You can simply add this to the compiler's "spec" file:

...
*link:
-m elf32ppclinux %{G*} %{shared:-shared} %{!shared: %{!static: -R/lib %{rdynamic:-export-dynamic} %{!dynamic-linker:-dynamic-linker /lib/ld.so.1}} %{static:-static}}
ort-dynamic} %{!dynamic-linker:-dynamic-linker /lib/ld.so.1}} %{static:-static}}
...

> required patch to glibc may be in there...or someone who knows what the fix
> is may chime in here :)

* ** *** Dongggggg *** ** *

> If you still need help I would be happy to send you my scripts ( yes, I did
> the whole thing in bash scripts...as a exercise mostly...would be just as
> easy/easier to modify the denx makefiles.

Don't waste your time on this old stuff any more;  there  will  be  a
replacement soon :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quote from the Boss... "I didn't say it was your fault.  I said I was
going to blame it on you."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
