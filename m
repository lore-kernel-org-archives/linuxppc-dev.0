Message-ID: <3A8C6937.5AC788EA@mvista.com>
Date: Thu, 15 Feb 2001 15:41:43 -0800
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: program exception emulates mfspr PVR
References: <20010215160658.P26702@altus.drgw.net> <3A8C5A95.9A94F914@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:
>
> Why did emulate_instruction() get added into traps.c to emulate the
> mfspr PVR instruction?  What user space application is using this
> instruction?
>
> And why add this extra cruft?  The information is already available to
> user applications (one example, /proc/cpuinfo reports the cpu and revision).
>
> Thanks,
>
> Frank
> --
> Frank Rowand <frank_rowand@mvista.com>
> MontaVista Software, Inc
>

The pvr was added so that applications that tune themselves can look at
the pvr information and figure out the processor type.

You can not count on /proc/cpuinfo to exist, or be in the same format
from one kernel version to the next.  The PVR instruction can be counted
on.  (And if someone has a need to emulate a different PVR.)

The idea behind this (originally) was to have glibc tune itself to the
cache-line size, FP ability, and Altivec ability of a CPU, but reading
/proc/cpuinfo wouldn't be acceptible since it may not be mounted, and
the whole open/read/close would have to happen early in glibc's load.
(Not practical)

There was discussion about this and almost everyone agreed it didn't
hurt to have the PVR available in user space as a trapped instruction.

--Mark

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
