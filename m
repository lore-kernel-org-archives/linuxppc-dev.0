Message-ID: <3CEC212A.9070104@ixiacom.com>
Date: Wed, 22 May 2002 15:52:26 -0700
From: Dan Kegel <dkegel@ixiacom.com>
MIME-Version: 1.0
To: Conn Clark <clark@esteem.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What problems are there with floating point emulation in the
 kernel?
References: <9A9C83C019F35D47A570460E87D5D8AB0125EAB9@racerx.ixiacom.com> <3CEC1E95.4CCCA5CA@esteem.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Conn Clark wrote:
> Its not the use of floating point in the kernel thats the problem.
>
> 	I would like to "emulate" the fpu in the kernel so I can
> compile glibc and everything else with fpu instructions to save
> ram. I have been told however that there are "issues" with this
> approach, and the only way to go is to emulate the fpu in the
> kernel and compile everything with soft float. What I want to
> know is what these issues are? (accuracy,segment_fault,etc..)

Oh.  Right.  Well, google reports at least one issue with the code;
see http://groups.google.com/groups?selm=fa.h1feiov.9jqg8k%40ifi.uio.no

> Mikael Pettersson (mikpe@csd.uu.se)
> Subject: Re: Kernel bugs found using inspect tool
> Newsgroups: fa.linux.kernel
> Date: 2000/02/25
>
> Ricky Beam writes:
>  > On Tue, 22 Feb 2000, Rupp, Ed J wrote:
>  > >the AT&T toolchest called 'inspect'.  I found 10 near-certain
>  > >bugs which may or may not be causing any observable problems
>  > >and 13 probable bugs which I couldn't immediately tell if they ...
>  > >===== Questionable ====
>  > >arch/ppc/math-emu/op-4.h: comparison takes precedence over assignment near
>  > >line 215
>  > >  (x3 += ((x2 += ((x1 += ((x0 += i) < x0)) < x1) < x2)))
>
> This whole expression is broken.
> The evaluation order for the "<" operator is unspecified, which means that
> subexpressions like "((x0 += i) < x0)" do not have well-defined values.
> They also violate the ANSI-C rules about permissible accesses and updates
> of variables between sequence points.

- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
