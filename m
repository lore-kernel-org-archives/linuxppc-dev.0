Message-ID: <3D831D5A.BF11BC0D@koffie.nl>
Date: Sat, 14 Sep 2002 13:28:26 +0200
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
References: <3D810AF2.2034238C@koffie.nl> <20020912102550.11578@192.168.4.1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >Benjamin Herrenschmidt wrote:
> >> Hrm... you should check the various CPU erratas, I think
> >> the perf. counter exception suffers from the same bugs
> >> the thermal exceptions has regarding clashing with DEC
> >> and thus losing exception context information on some
> >> G4s. If this is the case, that would basically prevent
> >> using it.
> >
> >Ooh, that sounds bad!  Thanks for the hint.
>
> Yah, and we have to thank MOL for helping us find out
> what was going on with the TAU exception easily ;)
>
> The way MOL plays with the DEC made the clash happen
> more often, and since it then happened within MOL emulation
> context, the MOL kernel module could figure out something
> wrong happened, kill the emulator, and stay alive while
> printing nice debug informations ;)
> If that happened during normal kernel operations, I suspect
> we would have just died hard.
>

Okay, here's the data I found on that errata:

It does not exist on 7450 etc.
It exists on 7410 before version 1.3 .
I have no data on 7400.
It does not exist on 750 etc.

[As my only G4 is a 7410 version 1.3, I won't be affected by this.  Hurray.]

The problem itself: if two of thermal assist, decrementer, performance
monitor interrupts happen within 1 cycle of each other, evil things
happen with SRR0 and SRR1, so that the return address becomes
unrecoverable.

Suggested solution:

We can forget about thermal assist, as the TAU on all 74xx is broken
and unsupported.  (Says those same errata sheets).
If necessary, it's possible to disable the decrementer interrupt and have
the performance monitor perform its function.

But I won't run into this, so I'm happy for now :)


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
