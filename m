To: Pavel Roskin <pavel_roskin@geocities.com>
Cc: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Best compiler/flags combination
References: <Pine.LNX.4.21.0001302322580.774-100000@localhost.localdomain>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 31 Jan 2000 13:58:32 +0100
In-Reply-To: Pavel Roskin's message of "Sun, 30 Jan 2000 23:55:50 -0500 (EST)"
Message-ID: <kfy7lgql7nr.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel Roskin <pavel_roskin@geocities.com> writes:

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

What you are seeing is most likely completely random behaviour depending
on how the code and data in the binary is layed out. You can not use a
standard glibc on 8xx or 4xx CPUs due to incorrect assumptions of
cache-line size. See
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00000.html
for a solution.

> Probably I'll still have to use
> -O2 -mcpu=860 -mmultiple -mstrings -mhard-float

If you don't have math emulation in the kernel you should use
-mcpu=860 -msoft-float
If you do have math emulation you don't have to use them. The important
thing is that all binaries and libraries on the system are compiled
with the same flags.

Level of optimization should not matter. If it does something is broken.
Also note that -mhard-float is ignored if -mcpu=860 is present on the
command line. With the layout of the specs file in current gcc you must
either use both "-mcpu=860 -msoft-float" or none of them, otherwise you
get broken binaries.

> Or should I understand your recommendation so that you don't specify -mcpu
> and gcc still produces code running on embedded systems?

If you have kernel math emu you don't need to specify -mcpu.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
