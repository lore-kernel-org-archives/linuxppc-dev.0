Subject: Re: ibook2r2 & strange freeze.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Figureau <brice@tincell.com>
Cc: "Linuxppc-Dev@Lists.            " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <E31EF083-7828-11D7-9243-0003939D5F18@tincell.com>
References: <E31EF083-7828-11D7-9243-0003939D5F18@tincell.com>
Content-Type: text/plain
Message-Id: <1051390877.1824.44.camel@gaston>
Mime-Version: 1.0
Date: 26 Apr 2003 23:01:18 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The pc was in fbcon_radeon_bmove, so even if it's a fbcon problem, the
> crash is happening into the radeonfb module...
> video=ofonly works fine because it does not use fbcon_radeon_bmove I
> guess...

Well... The only way I see fbcon_radeon_bmove crash this way
would be because of a corrupt struct display.

> > So there is probably some memory corruption going on... I'm comparing
> > other bits of ben8 and ben9 now and see nothing relevants. The changes
> > where in the cache flush affecting cpufreq and sleep, and radeonfb...
> Since the crash occurs in the scoll, if there is a problem with the
> font (corrupted font or something) the scroll computation might be
> wrong, and thus fbcon_radeon_bmove might copy some memory from/to a bad
> area.

I don't think so. But try commenting out setting of the font in the
init scripts and let me know if that helps.

> Unfortunately those bugs are the most difficult to find and fix.
> What I could do is disable some part of the -ben9 patch in favor of the
> -ben8 version, until I find in which part it happens.

Can you try the xmon tricks I told you so I get a disassembly
(only copy the first 2 or 3 lines) and the register dump ?

I'm not sure anything in -ben9 compared to -ben8 explains the
problem if using -ben8's radeonfb in -ben9 still dies. I think
something get corrupt in struct display, it would be useful to
figure out what.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
