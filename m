Date: Sun, 30 Jan 2000 23:55:50 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: Graham Stoney <greyham@research.canon.com.au>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Best compiler/flags combination
In-Reply-To: <20000130232130.B959B1B3E0@elph.research.canon.com.au>
Message-ID: <Pine.LNX.4.21.0001302322580.774-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Graham!

> > The question is, what compiler is known to produce good code for embedded
> > PPC boards and what flags should be used? It is desireable that the
> > binaries still run on PowerPC.
>
> My general approach when starting out is to always use the latest official
> released versions, and move to a newer snapshot if you encounter problems.
> In particular, the latest official gcc release (gcc-2.95.2) is a better
> starting point than the old egcs releases.

Thank you. I'll try it.

This approach works particularily well when you are using the same OS as
the developers (which is probably {i386,alpha}-linux) or when you (or
other people) have time to keep support for your configuration is a good
shape.

You did not mention flags. Maybe my results will be of some interest. I'm
using egcs-1.1.2 native for PowerMAC

-O2                bad code almost everywhere (libcrypt, depmod, bash)
-Os                bad code in tinylogin
-Os -fno-inline    good code (not extensively tested),
                   but it doesn't look like a clean solution
-O2 -mcpu=860 -mmultiple -mstrings -mhard-float
                   good code so far, but libm cannot be compiled
                   (internal error in the compiler)

Probably I'll still have to use
-O2 -mcpu=860 -mmultiple -mstrings -mhard-float

Or should I understand your recommendation so that you don't specify -mcpu
and gcc still produces code running on embedded systems?

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
