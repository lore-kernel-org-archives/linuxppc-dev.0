Message-Id: <4.3.2.20000309152803.00ca9100@mail.munich.netsurf.de>
Date: Thu, 09 Mar 2000 15:46:38 +0100
To: Sean Harding <sharding@dogcow.org>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: compiler optimization? something else?
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000308113436.A3472@dogcow.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 20:34 08.03.00, Sean Harding wrote:

>I posted this on comp.os.linux.powerpc without any response. Perhaps someone
>here can address it.
>
>Is anyone working on optimizing the compiler for PPC? It seems like it could
>use a little work. Maybe that's not actually the problem here, but it's the
>first thing that springs to mind.
>
>I recently was playing with encoding mp3s using LAME on several
>systems. LAME 3.63beta compiles easily out of the box, but it is
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
But what compiler options did it use on with your compile? I downloaded it
myself and it seems to default to a simple -O, which is a rather
non-optimal choice. Try editing the Makefile and play with combinations of
these options:

-O2, -O3, -funroll-loops, -funroll-all-loops, -ffast-math (dunno if this
one has an effect on PPC at all), -finline-functions, -mcpu=604, -mcpu=750

Do that and come back with a table listing your encoding times for the
different switch combinations.

>quite a bit slower than is seeems it should be. For one sample file, the
>encoding took 32 minutes on my PPC 604/150. The same file, encoded with the
>same options, took 6 minutes on my PII 366 laptop. I get similar speeds on
>Tru64 alpha systems, HP-UX pa-risc systems and Solaris sparc systems.
>Obviously there are differences in speed for these systems based on the CPU,
>etc. But they all perform in line with what I would expect to see. It's
>just ppc that's way slower.

Well, if you set the compiler options to suboptimal values, this is what
you would expect. I think I saw hand-tuned compiler options for all
platforms you listed, just not for Linux/PPC+gcc, which usually means
nobody did care til now. Remember Linux is a collaborative effort and if
you care about something being done/implemented/optimized/etc you usually
have to do it yourself or maybe kick the right people :-).


>The system is not i/o bound during the encode, and there were no other
>CPU-intensive processes running at the time. If this were an isolated case,
>I wouldn't worry too much about it. But it seems like most CPU-intensive
>tasks are slower than they should be.
>
>My system is pretty generic LinuxPPC 1999 right now. Here's what I have:
>
>juliet ~
>26% uname -a
>Linux juliet 2.2.13 #1 Fri Nov 12 23:01:37 PST 1999 ppc unknown
>
>juliet ~
>27% gcc --version
>egcs-2.91.66

Upgrade to gcc-2.95.2, <ftp://devel.linuxppc.org/users/fsirl/R5/RPMS/ppc/>.
Though I don't believe this will give you a really big improvement in code
optimization, it is a big step forward in compiler correctness on PPC.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
