Message-Id: <v04003a09b6618d780015@[24.70.162.12]>
In-Reply-To: <20001216160004.A18814@drow.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 16 Dec 2000 15:34:14 -0600
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>, linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: SMP stall on process creation
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:00 PM -0600 12/16/2000, Daniel Jacobowitz wrote:
>I've been using a dual G4/500 with the linuxppc_2_5 tree for a couple weeks
>now, and having all sorts of strange problems.  While trying to debug one
>(console corruption on select, and sometimes on boot), I discovered
>something very interesting.
>
>I ran, in zsh, this command:
>% time (for i in {1..100}; do /bin/echo -n; done)
>
>on several machines.  On an old 604e/200:
>  0.52s user 1.25s system 100% cpu 1.759 total
>
>On a dual-450 celeron system:
>  0.15s user 0.18s system 62% cpu 0.530 system
>
>But on the G4:
>  0.07s user 6.24s system 100% cpu 6.302 total
>
>This obviously slows shell scripts to a crawl - forking or execing is being
>severely penalized.  I'm also a little startled by the 100% cpu - this is a
>multiprocessor system, that loop should NOT have been throttling both
>processors.
>
>Does anyone have any ideas?  I'm going to go play with 2.2 SMP and 2.4 UP
>for comparison.
[...]

Just ran this on my 9600/200mp, 2.4.0-test11 (linux-pmac-devel, not
terribly current). time says:
 0.84s user 2.63s system 100% cpu 3.466 total

I bumped the count to 1000, and ran top to verify. Top said (roughly) 16%
user (zsh, top, X), 40% system, 44% nice (seti@home, niced 19), which is
about what it should say with only one CPU throttled.

Not as zippy as it could be, but definatley not hammering both CPUs.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
