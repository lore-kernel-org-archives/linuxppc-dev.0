Date: Sat, 16 Dec 2000 18:55:02 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: SMP stall on process creation
Message-ID: <20001216185502.A20357@drow.them.org>
References: <20001216160004.A18814@drow.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20001216160004.A18814@drow.them.org>; from dmj+@andrew.cmu.edu on Sat, Dec 16, 2000 at 04:00:04PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Dec 16, 2000 at 04:00:04PM -0500, Daniel Jacobowitz wrote:
>
> I've been using a dual G4/500 with the linuxppc_2_5 tree for a couple weeks
> now, and having all sorts of strange problems.  While trying to debug one
> (console corruption on select, and sometimes on boot), I discovered
> something very interesting.

Which was VGA console stuff, by the way.  I'm trying to get a second
opinion from linux-fbdev before touching the code though.

> I ran, in zsh, this command:
> % time (for i in {1..100}; do /bin/echo -n; done)
>
> on several machines.  On an old 604e/200:
>   0.52s user 1.25s system 100% cpu 1.759 total
>
> On a dual-450 celeron system:
>   0.15s user 0.18s system 62% cpu 0.530 system
>
> But on the G4:
>   0.07s user 6.24s system 100% cpu 6.302 total

And with test13:
    0.16s user 0.53s system 101% cpu 0.681 total

Much better.  Whatever it was seems to have wandered away again.  Note
that we're still a solid thirty percent slower than x86 at this - I'll
try to work out why some other time.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
