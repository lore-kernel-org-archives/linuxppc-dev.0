Date: Thu, 7 Sep 2000 00:32:36 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: More Sandpoint woes
Message-ID: <20000907003235.C5231@hectic.net>
References: <20000905213639.B22842@hectic.net> <39B5764D.C30702A8@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39B5764D.C30702A8@mvista.com>; from mgreer@mvista.com on Tue, Sep 05, 2000 at 03:40:13PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Mark!

On Tue, Sep 05, 2000 at 03:40:13PM -0700, you wrote the following:

> Alex, if you're interested, I have a better kernel for you to use.  Its in
> ftp://www.mvista.com/pub/Area51/sandpoint-8240/sandpoint.linux.tar.gz

Thanks! This did get me further. No more oddities with the
ramdisk/initrd options, and it doesn't crash when trying to run init
-- but instead, it just hangs.. Right after the message "Freeing
unused kernel memory", there's nothing more on the screen. The console
works (when I type something I get it echoed back), and the machine is
pingable, but it just doesn't seem to do anything. Running sash
instead of init yields the same thing.

I wanted to try to debug this myself, because I feel it must be
something not very complicated. But without kgdb I can't do anything.
So I tried to make kgdb work with the Sandpoint. From what I see, the
kgdb-enabled kernel for ppc has the functions getDebugChar,
putDebugChar and kgdb_interruptible in macserial.c, however Sandpoint
uses the regular serial.c, so I don't have these functions and thus
linking fails. Therefore I figured that I should find a kgdb patch for
i386 that would put such funtions into serial.c. I intend to do that
tonight. If you have other tips for me, I'll be delighted to hear.
How do *you* debug it anyway?

Also, I'm confused a bit about -msoft-float and -mhard-float. The 7400
has an FPU, so is it right that the kernel compiles itself with
-msoft-float?

> This has IDE support

Why wouldn't the standard Linux IDE support work? Or are we talking
about different levels here? (Are you talking about some
initialization that is needed for the regular IDE code to work or
something like that? Just a guess...)

> and fixes a bug in the eepro100.c driver for the sandpoint.

Ooh! I selected the eepro100 because I thought that'd be the most
reliable -- I also have an RTL8129 here, and some no-name card that's
supported by tulip.c. Was eepro100 the wisest choice, or should I take
another card? Actually, it probably doesn't really matter once it's
working..

And Mark -- thanks a lot! I don't know where I'd be today if it wasn't
for your help.


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

Ambition is a poor excuse for not having enough sense to be lazy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
