Subject: Re: GLIBC wont compile for MPC860
To: linuxppc-embedded@lists.linuxppc.org
Date: Fri, 3 Sep 1999 12:15:34 +1000 (EST)
Cc: scott@broadlink.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37CE6D23.86AFDFC6@switchboard.ericsson.se> from "Marcus Sundberg" at Sep 2, 99 02:27:15 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19990903021534.8F50974A@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Marcus,

Thanks for your great tips on building glibc for the '860. It would be great if
we could get some mods into the next glibc release so that it would configure
out-of-the-box without patching...

Marcus Sundberg writes:
> Configuring gcc with --with-cpu=860 and --nfp will make the
> _compiler_ default to -msoft-float. It will however _not_ make the 
> pre-processor define -D_SOFT_FLOAT by default, which will cause
> all variable arguments functions taking floating point arguments
> (like the *print[fs] family) to be mis-compiled.
> 
> The fix is to add this code to your gcc's 'specs' file under the
> section '*cpp_sysv':
> %{!mhard-float: -D_SOFT_FLOAT}

Is this a general fix though; won't it cause _SOFT_FLOAT to be defined by
default for all other cpu types as well?

The specs file from gcc 2.95.1 includes '%{mcpu=403: -D_SOFT_FLOAT}' in the
cpp_sysv rule, and adding '%{mcpu=860: -D_SOFT_FLOAT}' has the advantage of not
affecting other cpu types. Problem is, it only kicks in when I pass -mcpu=860
explicitly, even though I configured gcc --with-cpu=860. I'm confused...

> First you must remove the assumption that cachelines are 32 bytes:
> Apply this diff, and simply move sysdeps/powerpc/memset.S out of the
> way for now:

Perhaps the gcc specs file could have a #define for the cache line size, so
this is also automatically set via the -mcpu option. Alternatively, a #define
giving the -mcpu= value would allow the code to work this out, kind of like the
__i386, __i486, __i586 family for x86 architectures. There doesn't seem to be
an equivalent for PowerPC's at present.

> My vote is to have a special sysctl entry for the cacheline size,
> for fast and easy access (one syscall compared to the open()/read()/close()
> triplet for normal /proc entries, and you also don't have to have the
> /proc fs mounted), and then cache the result in a static variable.)

I'd be happy with a compile-time option, but I don't mind either way.

> Secondly you will want to remove the floating point assembler.

Cool! It would be nice to get the fpu code re-arranged in the official glibc
too...

Thanks!
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
