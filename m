Date: Mon, 19 Jun 2000 13:23:03 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Schinder <schinder@pobox.com>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems handling large files??
In-Reply-To: <p04320401b5733a720acd@[10.0.1.5]>
Message-ID: <Pine.HPX.4.10.10006191302150.6769-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 18 Jun 2000, Paul Schinder wrote:

>
> At 12:57 AM +0200 6/19/00, Michel Lanners wrote:
> >}
> >
> >So the 'Cannot allocate memory' comes from the system (libc? system
> >call?).
> >
> >Anybody know what's going on? Can you verify this on a 2.4.0-test
> >kernel? FWIW, bonnie _was_ working OK on 2.2.13 (later unverified) and
> >2.3.48 (latest benchamrk I have).
>
>
> All I can tell you is my own experience with 2.3.99 (pre 9, I think,
> but it's long gone) and 2.4.0-test1-ac18.  With 2.3.99, I tried doing
> a backup with cddump (a perl script that runs mkisofs and cdrecord
> for backup up onto CD's), and it failed with both read and write
> errors ("fwrite: cannot write" and "cannot open", as I recall).  This
> morning, under 2.4.0-test1-ac18, I made a 400+ Mb cd image and burned
> it with no trouble.  So if I were you, I'd rsync from Paul's tree
> (ac18 as of Saturday morning EDT) and try a 2.4.0.
>
> Of course, the fact that the clock drifted everywhere (xntpd kept on
> making ~ 10 s corrections) and that I couldn't get my new UMAX Astra
> 2200 scanner working under 2.4.0 motivated me to switch to 2.2.16.
> (The scanner still won't work, but the clock doesn't drift.)

Well, it seems nobody noticed my recent (delayed because of linuxppc.org
problems) message about clock problems and the patch to solve it. Actually
the patch was for 2.2.12, I plan to produce a patch for more recent
kernels next week (I'm leaving for a short holiday tomorrow), but the
upgrade for my machines (MVME boards) is painful.

The clock of all PPC kernels drifts a lot, although the 2.4 code is even
more bogus. 2.2 can easily give random drifts of a few seconds per day, I
brought it down by a factor of 30 on my machines (which have a very bad
oscillators), by using a _rigorous_ algorithm which eliminates all kinds
of hazards.

Highest differences I've see since then on NTP are 350 microseconds (the
machine is used as an NTP reference clock, directly on a combination of
GPS and atomic (rubidium and hydrogen maser) clocks, for me 300
microseconds is still large but it seems that I can't do anything about it
since this damned main CPU oscillator frequency varies by about 0.6 ppm
depending on the load on the machine (bus activity, not thermal).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
