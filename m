Message-ID: <38DAFBE8.10082684@ncal.verio.com>
Date: Thu, 23 Mar 2000 21:23:52 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PB2000 (pismo) install feedback
References: <20000323174416.031445@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> On Thu, Mar 23, 2000, Henry Worth <haworth@ncal.verio.com> wrote:
>
> >It's very timing sensitive, a slight rearrangment of the code eliminated
> >the "burnout", but didn't fix the ongoing offb colormap problems. Adding
> >a small delay between writing the index and the palette value fixed the
> >colomap problem. I rearranged the code to just set the index once and
> >then use the palette index register's auto-incrementing to avoid the
> >index write and delay in the loop, and that worked as well. I think
> >Ben is planning to use a read back of the index register to ensure the
> >write is posted and and give enough of a delay.
> >
> >Does anyone know if any of the ATI chips don't have autoincrementing of
> >the palette index? That's been a fairly standard feature of RAMDAC's
> >for a long time. So I was a bit surprised to see the frame buffers
> >explicitly setting the index on every iteration, especially since
> >the race between writing the palette index and the data has been
> >a common problem for a long time.
>
> What bugs me is that we have no such delay in aty128fb.c and you didn't
> see the problem occur. Looks like a 1 instruction timing (one eieio) is
> enough, so I beleive reading back the index is enough. We didn't have
> this problem with older r128, so this may be a side effect of the
> swadowing of the 2 sets of palette registers in the M3

Possibly, with the extra control logic and the need to minimize the
gate count and power consumption for a mobile use, the control
logic may be somewhat slower than most modern chips. And with
all the integration and duplication, timing errors may send data
off to some very nasty places. Then again the Pismo and Sawmill
are cranking both CPU and I/O bus speeds up another notch, so
perhaps some of these classic timing issues will start cropping
up again.

The code in aty128fb.c isn't quite as tight as the offb.c
cases. In both aty128fb.c cases there is a statement between the
index out and the data out that does a couple of shifts to form
the palette data value, and there would be no advantage for the
compiler to schedule it before the first out. A quick grep didn't
find the definition for aty_st_8, is it completely identical to
out_8, particularly with the macros used to form the address?

The change from the case fall through to completely seperate
case blocks, which stopped the "burnout" effect in offb, would
have removed a barrier for optimization and register use between
setting the DAC select control and the palette index write.
So the code that didn't create the 'burnout' should have had
even less delay between out's. Which is really puzzling, yet
it was completely recreatable.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
