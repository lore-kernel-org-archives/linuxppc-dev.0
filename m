Message-ID: <39BD1B9B.1729B5B@mvista.com>
Date: Mon, 11 Sep 2000 10:51:23 -0700
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: clark@esteem.com, Navin Boppuri <nboppuri@trinetcommunication.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Differences between MPC823 powerpc & any other powerpc
References: <1.5.4.32.20000911170434.006a51e8@pop.esteem.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


clark@esteem.com wrote:
>
> At 11:48 AM 5/12/00 +0100, you wrote:
> >
> >Hello,
> >
> >I would like to know what are the basic difference between the MPC823
> >PowerPC and any other PowerPC , say, the G4? Why dont the binaries running
> >on G4 not work correctly on the MPC823?
>
>         For starters the MPC823 has no FPU. I think you could compile FPU
> emulation into the kernel to remedy this but I'm not sure. G4 compiled
> programs may use alti-vec instructions but I'm not sure on this either.
>

In addition to no FPU, the 8xx series also has half of the cachelines
that all
of the other PPC's have.  (4xx, 6xx, 7xx, 74xx, 82xx)  This causes a
problem
with glibc [and possibly other things] which expect a certain line size
to do
fast memset's, memcpy's etc.  (The result of having the wrong cacheline
size
is to miss area's of memory in the previous listed functions.)

Also w/ the no FPU comes ABI issues including (especially?) var args
issues.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
