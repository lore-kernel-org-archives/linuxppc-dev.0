Message-ID: <3896164A.16417EC2@zeta.org.au>
Date: Tue, 01 Feb 2000 10:10:02 +1100
From: Peter Allworth <linsol@zeta.org.au>
MIME-Version: 1.0
To: Pavel Roskin <pavel_roskin@geocities.com>
CC: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Best compiler/flags combination
References: <Pine.LNX.4.21.0001302322580.774-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel Roskin wrote:
>

<snip>

> You did not mention flags. Maybe my results will be of some interest. I'm
> using egcs-1.1.2 native for PowerMAC
>
> -O2                bad code almost everywhere (libcrypt, depmod, bash)
> -Os                bad code in tinylogin
> -Os -fno-inline    good code (not extensively tested),
>                    but it doesn't look like a clean solution
> -O2 -mcpu=860 -mmultiple -mstrings -mhard-float
>                    good code so far, but libm cannot be compiled
>                    (internal error in the compiler)

Pavel,

I believe I have found the cause of the "internal error" in the compiler.
The source code of the compiler includes a file:

egcs-1.1.2/gcc/config/rs6000/rs6000.c

that defines a routine called "rs6000_override_options" which for -mcpu=860
will FORCE soft-float, irrespective of your command line flags.
(I think it's particularly thoughtful the way it doesn't tell you it's
doing this. ;)

By looking through the available list of cpu types, I've found an old
one that results in the compiler using the correct set of internal flags
to generate code for an MPC core with hardware (or emulated) floating point.

It's: -mcpu=505

With this flag I've been able to successfully compile and use glibc-2.1.1
on my Rev C iMac. I think the same code should run native on the iMac but
I haven't tried it.

> Probably I'll still have to use
> -O2 -mcpu=860 -mmultiple -mstrings -mhard-float
>
> Or should I understand your recommendation so that you don't specify -mcpu
> and gcc still produces code running on embedded systems?

As far as I can tell, the only problem with using the compiler "as-is"
would be that the compiler's idea of how long each instruction takes
would be wrong in some cases and so the resulting code would be suboptimal.

'Hope that all helps,

PeterA.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
