Date: Sat, 16 Dec 2000 16:00:04 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: SMP stall on process creation
Message-ID: <20001216160004.A18814@drow.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been using a dual G4/500 with the linuxppc_2_5 tree for a couple weeks
now, and having all sorts of strange problems.  While trying to debug one
(console corruption on select, and sometimes on boot), I discovered
something very interesting.

I ran, in zsh, this command:
% time (for i in {1..100}; do /bin/echo -n; done)

on several machines.  On an old 604e/200:
  0.52s user 1.25s system 100% cpu 1.759 total

On a dual-450 celeron system:
  0.15s user 0.18s system 62% cpu 0.530 system

But on the G4:
  0.07s user 6.24s system 100% cpu 6.302 total

This obviously slows shell scripts to a crawl - forking or execing is being
severely penalized.  I'm also a little startled by the 100% cpu - this is a
multiprocessor system, that loop should NOT have been throttling both
processors.

Does anyone have any ideas?  I'm going to go play with 2.2 SMP and 2.4 UP
for comparison.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
