Message-ID: <37CFBC84.73A8BCAA@switchboard.ericsson.se>
Date: Fri, 03 Sep 1999 14:18:13 +0200
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Reply-To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: linuxppc-embedded@lists.linuxppc.org, scott@broadlink.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: GLIBC wont compile for MPC860
References: <19990903021534.8F50974A@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:
> Thanks for your great tips on building glibc for the '860. It would be great if
> we could get some mods into the next glibc release so that it would configure
> out-of-the-box without patching...

Yes definitely. I intend to submit some patches as soon as I've had
time to try out glibc 2.1.2pre3 and verified that there are no
problems with that. Don't know if I will have time before they
release the final 2.1.2 though. :(

> Marcus Sundberg writes:
> > Configuring gcc with --with-cpu=860 and --nfp will make the
> > _compiler_ default to -msoft-float. It will however _not_ make the
> > pre-processor define -D_SOFT_FLOAT by default, which will cause
> > all variable arguments functions taking floating point arguments
> > (like the *print[fs] family) to be mis-compiled.
> >
> > The fix is to add this code to your gcc's 'specs' file under the
> > section '*cpp_sysv':
> > %{!mhard-float: -D_SOFT_FLOAT}
> 
> Is this a general fix though; won't it cause _SOFT_FLOAT to be defined by
> default for all other cpu types as well?

Yes, it will cause _SOFT_FLOAT to be defined unless you pass
-mhard-float to gcc, but see below.

> The specs file from gcc 2.95.1 includes '%{mcpu=403: -D_SOFT_FLOAT}' in the
> cpp_sysv rule, and adding '%{mcpu=860: -D_SOFT_FLOAT}' has the advantage of not
> affecting other cpu types. Problem is, it only kicks in when I pass -mcpu=860
> explicitly, even though I configured gcc --with-cpu=860. I'm confused...

I'm not really sure what goes on in gcc. I configured my gcc with
--with-cpu=860 and --nfp, and even if I pass -mcpu=750 -mhard-float
it doesn't generate floating point instructions... This is not a problem
for me as I don't have any non-860 CPU's to compile code for, but this
also means that I don't know what you should do to build a compiler that
generates 860 code by default and also is capable of generate code for
other CPUs.

> > First you must remove the assumption that cachelines are 32 bytes:
> > Apply this diff, and simply move sysdeps/powerpc/memset.S out of the
> > way for now:
> 
> Perhaps the gcc specs file could have a #define for the cache line size, so
> this is also automatically set via the -mcpu option. Alternatively, a #define
> giving the -mcpu= value would allow the code to work this out, kind of like the
> __i386, __i486, __i586 family for x86 architectures. There doesn't seem to be
> an equivalent for PowerPC's at present.

I like the former solution. Having the compiler keep track of what
line sizes different CPUs have is good, but forcing other user-land
code to know this isn't nice IMHO.

> > My vote is to have a special sysctl entry for the cacheline size,
> > for fast and easy access (one syscall compared to the open()/read()/close()
> > triplet for normal /proc entries, and you also don't have to have the
> > /proc fs mounted), and then cache the result in a static variable.)
> 
> I'd be happy with a compile-time option, but I don't mind either way.

Yep, I have no problem with having it a compile-time option either,
but some people want to run standard LinuxPPC libraries and binaries
on 8xx, so then a run-time check is needed as well.

> > Secondly you will want to remove the floating point assembler.
> 
> Cool! It would be nice to get the fpu code re-arranged in the official glibc
> too...

Speaking of FPU code, I just noticed that there is an FPU emulator
for PPC included in Linux version 2.3.16. We really don't need that 
here, but others might find that very interresting...

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
