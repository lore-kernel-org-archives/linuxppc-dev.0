From: Rosen Jeremy <Rosen.Jeremy@tms-pty.com>
To: clark@esteem.com, dkegel@ixiacom.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: What problems are there with floating point emulation in the
	kernel?
Date: Thu, 23 May 2002 08:57:00 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <M2002052309034228593@safemail.tcs-aus.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


this is best documented in the embedded HOWTO that you will find at
linuxppc.org
but I'll try to explain it quickly.

you can emulate fpu in two way.

1) compile the kernel with FPU emulation, and all applications "normally"
the main advantage is that it's simple. When a FP instruction is issued an
exception will be raised, and catched by the kernel emulation.
the main drawback is that it is slower ( I don't know about memory
consumption)

2) compile all libs and apps with SOFT_FPU. gcc will not generate floating
point instructions, but will use some glibc calls to replace them. It is
faster, but if any application is not compiled properly it will break.

Again, this is not as accurate as the answer in the embedded HOWTO.

just my two cents

>>> Conn Clark 05/23/02 08:41am >>>

Dan Kegel wrote:
>
> Since it's very easy to avoid the use of floating point in
> the kernel, it has not been a big issue.
>
> Do you need to use floating point in the kernel for some reason?
> - Dan

Its not the use of floating point in the kernel thats the problem.

 I would like to "emulate" the fpu in the kernel so I can
compile glibc and everything else with fpu instructions to save
ram. I have been told however that there are "issues" with this
approach, and the only way to go is to emulate the fpu in the
kernel and compile everything with soft float. What I want to
know is what these issues are? (accuracy,segment_fault,etc..)

Conn

--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge    clark@esteem.com
Electronic Systems Technology Inc.  www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
