Message-ID: <3B3CED10.D05BBE56@mvista.com>
Date: Fri, 29 Jun 2001 16:03:12 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: giving up the FPU, MSR[FE0], MSR[FE1], and the FPSCR
References: <3B3C9BC6.9AD7C208@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Lazy FPU initialization IMHO is a good thing for single purpose
>> (embedded?) systems that are on a high end CPU, but do not need floating
>> point.  One example could be a signal processing system that uses
>> altivec and integer math heavily, but no floating point.

>Your non-FP code might seem a wee bit better, but your FP code
>ends up taking faults. Then with all the extra code, we end up
>with extra problems -- for example the original poster's trouble.

Maybe I missed something here, but my understanding is that if you in
SMP lazy initialization never happens.  And if you are single CPU you
take _ONE_ fault per process.

One FP fault per process seems very minor to me, (unless of course you
are spawning a hell of a lot of process, but most likely the process
spawn time would outweigh the single fault.)

>I suppose, if one does want lazy FP save/restore, that it ought
>to be done with a per-process flag to prevent frequent faults.
>When switching to an FP process, restore the registers. From time
>to time take away the FP registers to deal with processes that
>only use them once in a great while or only at startup. Maybe
>take away FP after 1, 2, 4, 8, 16... ticks of use.

That might be of some value, but I'd be concerned that instead of 1
fault per process we could run in to a lot of faults, or into a
situation where each process would need some type of a counter to detect
faults.  (Probably messy...)

--Mark Hatle
MontaVista Software, Inc.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
