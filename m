Return-Path: <markos@codex.gr>
Received: from lvps87-230-20-158.dedicated.hosteurope.de
	(lvps87-230-20-158.dedicated.hosteurope.de [87.230.20.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3E746DDDDC
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 18:05:10 +1000 (EST)
From: Konstantinos Margaritis <markos@codex.gr>
To: rsa@us.ibm.com
Subject: Re: libfreevec benchmarks
Date: Sun, 24 Aug 2008 11:03:56 +0300
References: <200808211909.16852.markos@codex.gr>
	<1219427047.7917.38.camel@localhost>
In-Reply-To: <1219427047.7917.38.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808241103.58485.markos@codex.gr>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=CE=A3=CF=84=CE=B9=CF=82 Friday 22 August 2008 20:44:07 =CE=BF/=CE=B7 Ryan =
S. Arnold =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
> Do you have FSF (Free Software Foundation) copyright assignment yet?

Copyright assignment is not the issue, if there was interest in the first=20
place, that would never had deterred me.

> How've you implemented the optimizations?

Scalar for small sizes, AltiVec for larger (>16 bytes, depending on the=20
routine).

> Optimizations for individual architectures should follow the powerpc-cpu
> precedent for providing these routines, e.g.
>
> sysdeps/powerpc/powerpc32/power6/memcpy.S
> sysdeps/powerpc/powerpc64/power6/memcpy.S

That's the idea I got, but so far I understood that only 64-bit PowerPC/POW=
ER=20
cpus are supported, what about 32-bit cpus? libfreevec isn't ported to 64-b=
it=20
yet (though I will finish that soon). Would it be enough to have one dir li=
ke=20
eg:

sysdeps/powerpc/powerpc32/altivec/

or would I have to refer to specific CPU models? eg 74xx? And use Implies f=
or=20
the rest?

> Today, if glibc is configure with --with-cpu=3D970 it will actually
> default to the power optimizations for the string routines, as indicated
> by the sysdeps/powerpc/powerpc[32|64]/970/Implies files.  It'd be worth
> verifying that your baseline glibc runs are against existing optimized
> versions of glibc.  If they're not then this is a fault of the distro
> you're testing on.

Well, I used Debian Lenny and OpenSuse 11.0 (using glibc 2.7 and glibc2.8=20
resp. If it doesn't work as supposed, these are two popular distros with a=
=20
broken glibc, which I would think it's not very likely.

> I'm not aware of the status of some of the embedded PowerPC processors
> with-regard to powerpc-cpu optimizations.

Would the G4 and 8610 fall under the "embedded" PowerPC category?

> Our research found that for some tasks on some PowerPC processors the
> expense of reserving the floating point pipeline for vector operations
> exceeds the benefit of using vector insns for the task.

Well, I would advise *strongly* against that, except for specific cases, no=
t=20
for OS-wide functions. For example, in a popular 3D application such as=20
Blender (or the Mesa 3D library), a lot of memory copying is done along wit=
h=20
lots of FPU math. If you use the FPU unit for plain memcpy/etc stuff, you=20
essentially forbid the app to use it for the important stuff, ie math, and =
in=20
the end you lose performance. On the other hand, the AltiVec unit remains=20
unused all the time, and it's certainly more capable and more generic than =
the=20
=46PU for most of the stuff -not to mention that inside the same app, the i=
ssue=20
of context switching becomes unimportant.=20

> Generally our optimizations tend to favor data an average of 12 bytes
> with 1000 byte max.  We also favor aligned data and use the existing
> implementation as a model as a baseline for where we try to keep
> unaligned data performance from dropping below.

Please, check the graphs of most libfreevec functions for the sizes=20
12-1000bytes. Apart from strlen(), which is the only function that performs=
=20
better overall than libfreevec, most other functions offer the same=20
performance for sizes up to 48/96 bytes, but then performance increases=20
dramatically due to the use of the vector unit.

> This research would be a good candidate for selectively replacing some
> of the existing libm functionality.  Do these results hold for all
> permutations of long double support?  Do they hold for x86/x86_64 as
> well as PowerPC?  I would suggest against a massive patch to libc-alpha
> and would instead recommend selective, individual replacement of
> fundamental routines to start with accompanied by exhaustive profile
> data.  You have to show that you're dedicated to maintenance of these
> routines and you can't overwhelm the reviewers with massive patches.

=46or the moment, my focus is on 32-bit floats only, but the algorithm is t=
he=20
same for 64-bit/128-bit floating point numbers even. It will just use more=
=20
terms. And yes, as I said, it doesn't use AltiVec and is totally cross-
platform -just plain C- and very short code even. I tested the code on an=20
Athlon X2 again and I get even better performance than on the PowerPC CPUs.=
=20
=46or some reason, glibc -and freebsd libc for that matter as I did a look=
=20
around- use very complex source trees with no good reason. The implementati=
on=20
of a sinf() for example is no more than 20 C lines.=20

As for commitment, well I've been working on that stuff since 2004 (with a =
~2y=20
break because of other obligations, army, family, baby, etc :), but unless=
=20
IBM/Freescale choose to dump AltiVec altogether, I don't see myself stoppin=
g=20
working on it. To tell you the truth, the promotion of the vector unit by b=
oth=20
companies has been a disappointment in my eyes at least, so I might just as=
=20
well switch platform... But that won't happen yet anyway.

> Any submission to GLIBC is going to require that you and your code
> follow the GLIBC process or it'll probably be ignored.  You can engage
> me directly via CC and I can help you understand how to integrate the
> code but I can't give you a free pass or do the work for you.

I never asked that. However, first it's more imporant to me to show that th=
e=20
code is worth including and then *if* it's proven worthy, then we can worry=
=20
about stuff like copyright assignment, etc.=20

> The new libc-help mailing list was also created as a place for people to
> learn the process and get the patches in a state where they're ready to
> be submitted to libc-alpha.

I will take a look, thanks for that info.

Konstantinos Margaritis
Codex
http://www.codex.gr
