Message-ID: <39AAA991.32FDF058@mvista.com>
Date: Mon, 28 Aug 2000 11:04:01 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Seong-kyu Ko <sugenius@doit.ajou.ac.kr>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems of the corss-compiler.
References: <Pine.LNX.4.21.0008290209060.960-100000@doit.ajou.ac.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Seong-kyu,

In the MSR of the PPC processor there is a bit
that indicates whether there is hardware
floating point unit available. This bit should
be set in the state to turn hardware floating
point off when not present. In my experience
even on PowerPC cpus which have hardware
floating point some people do not need or
want to use it. So they make sure that the
MSR is set properly.

That being said, it is important to either make
sure that bit is always set properly or provide
the proper library routines to make sure that
you are getting the desired results. For instance,
the 8xx family of PPC does not have floating point
hardware. So you provide libraries that do
software floating point. The one area where
this comes into play is when using va_args in the
runtime of the C-library. It is typical to save the
registers and the floating point state upon
entry. If the routine does not check the MSR bit
and branch around the floating point state
save code then the system will crash as a
result of the floating point instructions. So the fix
is to eliminate that code from the library and not
depend on the state of the MSR bit. This makes
it necessary to have a special library for the 8xx
family of PPC processors.

Cal

Seong-kyu Ko wrote:

> Hi everyone.
> First, I'm sorry for my weak English.
>
> Well, Now I build a powerpc cross-compiler.
> so I compiled some binary using that cross-compiler, but
> I have some problems.
>
> I think cross-compiler is not problem.
> because I compile kernel with that cross-compiler, and
> kernel runs good.
>
> but, init, shell etc thease binaries have some problems.
> shell cant recieve argument, and some binaries print 'segmentation fault'
>
> I don't know why my compiler can't compile well.
>
> These are the packages that I used.
> 1. binutils-2.10
> 2. gcc-2.95.2
> 3. glibc-2.1.3 (add-ons : glibc-crypt-2.1, glibc-linuxthreads-2.1.3)
>
> First, I compile the binutils for powerpc cpu.
> Second, I build cross compiler with gcc.
> Third, I compile glibc for powerpc with cross compiler that I made.
> Last, I re-build cross compiler include glibc for library.
>
> Please tell me what do you think about that And why the problem happen.
> I'll wait your answers.
> thank you.
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Customer Support Engineer    490 Potrero Avenue
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         e-mail cal_erickson@mvista.com
Pager 877-566-2012           support 1-800-759-8888 pin 202-7489
web http://www.mvista.com    support e-mail: support@mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
