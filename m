Message-Id: <200002090102.RAA29474@work.bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Dan Bethe <dan_bethe@yahoo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: the state of the linuxppc-dev community
In-Reply-To: Your message of "Tue, 08 Feb 2000 17:51:14 MST."
             <Pine.LNX.4.10.10002081750240.30794-100000@opus.bloom.county>
Date: Tue, 08 Feb 2000 17:02:17 -0800
From: Larry McVoy <lm@bitmover.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


: > BK users bless it, we'll do a public release.
:
: ooh ooh ooh, you mean it might finally be out?  It has _not_ helped any
: that the only up to date trees have been hidden from the public.
: Duplication of work, general annoyance, etc.

Yeah.  Sorry it's taken so long.  BK is fairly complicated and the problem
is that it is a really poor match to the open style of development, in
my opinion.  If you guys all use it, it isn't really acceptable to have it
break.  Supporting Cort and his buddies on it turned into a big job and it
became clear that we needed to do the renames rewrite before a public
release.

It's minorly amazing that a group of people who don't have tools that handle
renames quickly grow to like having tools that handle renames and use that
feature enough to promptly break it.

The breakage was fairly subtle - stuff like

	start with A, B, C
	# rotate left 1
	mv A tmp
	mv B A
	mv C B
	mv tmp C

actually showed up.  Among others.  So we now have an architecturally
clean rename processing alg, as well as an idempotent resolver (you can
bail out in the middle and start again and its happy), a more robust
resolver (it saves everything and if there is an error, it restores
everything), as well as a rewritten reader/writer global locking scheme,
etc.  It was a lot of work but I think it will pay off in two ways:
less support overhead, and when you guys find a case we missed, we have
a much cleaner way of handling it.

Again, my apologies for the delays.  If it helps - I'm sure it doesn't
help much - we're working on this 7 days a week, usually pulling 12-14
hour days.  My wife pretty much hates me.  I suspect the other guy's
wives are none too thrilled either...

Light at the end of the tunnel, though.

--lm

P.S.  Andrew (awc@bitmover.com) is rolling all the code into one executable.
Initial tests shows this reduces the x86 installation size from about 14MB
to 340KB...  Busy, busy...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
