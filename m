Return-Path: <rsa@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26CE8DDEEB
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 08:24:54 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m82MOqvt014477
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 18:24:52 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m82MOpEJ089950
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 16:24:51 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m82MOpLv016475
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Sep 2008 16:24:51 -0600
Subject: Re: libfreevec benchmarks
From: "Ryan S. Arnold" <rsa@us.ibm.com>
To: Konstantinos Margaritis <markos@codex.gr>
In-Reply-To: <200808241103.58485.markos@codex.gr>
References: <200808211909.16852.markos@codex.gr>
	<1219427047.7917.38.camel@localhost>
	<200808241103.58485.markos@codex.gr>
Content-Type: text/plain
Date: Tue, 02 Sep 2008 17:24:51 -0500
Message-Id: <1220394291.9513.34.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>
Reply-To: rsa@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Konstantinos,

I've been on vacation.  Here are my responses.

On Sun, 2008-08-24 at 11:03 +0300, Konstantinos Margaritis wrote:
> Copyright assignment is not the issue, if there was interest in the first 
> place, that would never had deterred me.

Okay.  This does deter some people when they understand the
restrictions.

> > How've you implemented the optimizations?
> 
> Scalar for small sizes, AltiVec for larger (>16 bytes, depending on the 
> routine).

Okay, this is a reasonable approach.

> > Optimizations for individual architectures should follow the powerpc-cpu
> > precedent for providing these routines, e.g.
> >
> > sysdeps/powerpc/powerpc32/power6/memcpy.S
> > sysdeps/powerpc/powerpc64/power6/memcpy.S
> 
> That's the idea I got, but so far I understood that only 64-bit PowerPC/POWER 
> cpus are supported, what about 32-bit cpus? libfreevec isn't ported to 64-bit 
> yet (though I will finish that soon). Would it be enough to have one dir like 
> eg:
> 
> sysdeps/powerpc/powerpc32/altivec/

My team doesn't deal 32-bit only processors at this time and we haven't
been asked to do so, so our focus tends to gravitate toward 64-bit but
we still enable biarch.

> or would I have to refer to specific CPU models? eg 74xx? And use Implies for 
> the rest?

You'd have something like:

sysdeps/powerpc/powerpc32/74xx

Altivec would be a category decision you'd make in the code or you may
be able to do what we do for fpu only code (though I'm not saying this
is _the_ solution), e.g.

sysdeps/powerpc/powerpc32/74xx/altivec

> > Today, if glibc is configure with --with-cpu=970 it will actually
> > default to the power optimizations for the string routines, as indicated
> > by the sysdeps/powerpc/powerpc[32|64]/970/Implies files.  It'd be worth
> > verifying that your baseline glibc runs are against existing optimized
> > versions of glibc.  If they're not then this is a fault of the distro
> > you're testing on.
> 
> Well, I used Debian Lenny and OpenSuse 11.0 (using glibc 2.7 and glibc2.8 
> resp. If it doesn't work as supposed, these are two popular distros with a 
> broken glibc, which I would think it's not very likely.

The term 'broken' isn't relevant here.  They may have made a choice to
select a base build that conforms to an ABI that precedes ppc970.  Or
they may have chosen to not ship an optimized /lib/970/libc.so.6 and
instead defer to the 'default' /lib/libc.so.6.

> > I'm not aware of the status of some of the embedded PowerPC processors
> > with-regard to powerpc-cpu optimizations.
> 
> Would the G4 and 8610 fall under the "embedded" PowerPC category?

I think these processors precede the ISA categories.

As long as these processors exist in a desktop or server machine they
could probably make it into GLIBC main, otherwise I'm sure 'ports' would
accept the overrides.
 
> > Our research found that for some tasks on some PowerPC processors the
> > expense of reserving the floating point pipeline for vector operations
> > exceeds the benefit of using vector insns for the task.
> 
> Well, I would advise *strongly* against that, except for specific cases, not 
> for OS-wide functions. For example, in a popular 3D application such as 
> Blender (or the Mesa 3D library), a lot of memory copying is done along with 
> lots of FPU math. If you use the FPU unit for plain memcpy/etc stuff, you 
> essentially forbid the app to use it for the important stuff, ie math, and in 
> the end you lose performance. On the other hand, the AltiVec unit remains 
> unused all the time, and it's certainly more capable and more generic than the 
> FPU for most of the stuff -not to mention that inside the same app, the issue 
> of context switching becomes unimportant. 

I didn't describe the situation adequately.  The micro architecture
requires that the floating point pipeline be reserved if one wants to
perform vector operations on such systems.  Therefore in these cases we
choose to not use vector operations for memcpy/etc.  This tends to be a
system by system thing and isn't an OS decision.

> > Generally our optimizations tend to favor data an average of 12 bytes
> > with 1000 byte max.  We also favor aligned data and use the existing
> > implementation as a model as a baseline for where we try to keep
> > unaligned data performance from dropping below.
> 
> Please, check the graphs of most libfreevec functions for the sizes 
> 12-1000bytes. Apart from strlen(), which is the only function that performs 
> better overall than libfreevec, most other functions offer the same 
> performance for sizes up to 48/96 bytes, but then performance increases 
> dramatically due to the use of the vector unit.

Even for our own optimizations which choose to not use vector we may
want to consider doing so for sizes in excess of 1000 bytes if you
research holds true on our hardware.  This is interesting.

> For the moment, my focus is on 32-bit floats only, but the algorithm is the 
> same for 64-bit/128-bit floating point numbers even. It will just use more 
> terms. And yes, as I said, it doesn't use AltiVec and is totally cross-
> platform -just plain C- and very short code even. I tested the code on an 
> Athlon X2 again and I get even better performance than on the PowerPC CPUs. 
> For some reason, glibc -and freebsd libc for that matter as I did a look 
> around- use very complex source trees with no good reason. The implementation 
> of a sinf() for example is no more than 20 C lines. 

Currently outside of operations performed in vector, 32-bit floats are
not in the Power ISA.  Were you running on a 32-bit machine with 64-bit
bit float (like the ISA describes) and only using 'float' and not
'double'?

The convoluted function layout is due to various spec conformance
layers, i.e. exceptions, and errno.  On some functions these wrappers
contribute up to 40% of the execution time of the functions.  Some
functions also include wrappers for re-computation to increase
precision.

> As for commitment, well I've been working on that stuff since 2004 (with a ~2y 
> break because of other obligations, army, family, baby, etc :), but unless 
> IBM/Freescale choose to dump AltiVec altogether, I don't see myself stopping 
> working on it. To tell you the truth, the promotion of the vector unit by both 
> companies has been a disappointment in my eyes at least, so I might just as 
> well switch platform... But that won't happen yet anyway.

IBM doesn't plan on dumping Altivec/VMX, in-fact we're coming out with
VSX.

> > Any submission to GLIBC is going to require that you and your code
> > follow the GLIBC process or it'll probably be ignored.  You can engage
> > me directly via CC and I can help you understand how to integrate the
> > code but I can't give you a free pass or do the work for you.
> 
> I never asked that. However, first it's more imporant to me to show that the 
> code is worth including and then *if* it's proven worthy, then we can worry 
> about stuff like copyright assignment, etc. 

I'm just giving you the party line and trying to be helpful.  If you go
to libc-alpha without your papers you'll be ignored.


Ryan S. Arnold
IBM Linux Technology Center
Linux Toolchain Development
