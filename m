Subject: Re: glibc........ memory limitations.... ideas?
To: kd@flaga.is
Date: Thu, 21 Oct 1999 13:22:19 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <OFFBA23814.6BE68D05-ON00256810.0052B029@flaga.is> from "kd@flaga.is" at Oct 20, 99 03:16:38 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991021032219.963EF262@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi K.D.,

kd@flaga.is writes:
> A statically linked application (with glibc) is arround 300KB (250KB
> -450KB).  which means that I can stuff maybe 3-4 statically linked
> applications in the flash.

I've also been looking into this. In my case, I'm developing a POSIX threaded
Embedded C++ application in a minimal environment, which makes no use of the
standard C++ library. I do need a C library though, possibly a subset of glibc.
In theory, I should be able to build the entire library, then statically link
to only drag in what I need; however, the most trivial C program ends up at
about 200Kb with glibc 2.1.2. I filed a bug report on this, which you can see
at:
    http://www-gnats.gnu.org:8080/cgi-bin/wwwgnats.pl/full/1399

Looking at the symbol table from the resulting executable, there's _lots_ of
unnecessary baggage. I'd say that given the widespread presence of dynamic
linking, the glibc maintainers have perhaps paid less attention to structuring
the library so that statically linked executables are minimal size. The normal
C runtime startup code to execute main() has not historically required 200kb!

I suspect we can do much, much better than this, by seeing what is causing so
much code to be pulled in unnecessarily. Glibc is not intended to be light
weight, but I think a little work to make it more pay-only-for-what-you-use
could make a big impact.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
