Date: Tue, 12 Nov 2002 08:22:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ppc_8xx-gcc 2.95.3 Monta Vista does not do ANY loop unrolling
Message-ID: <20021112152255.GF658@opus.bloom.county>
References: <IGEFJKJNHJDCBKALBJLLGEOFFHAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLGEOFFHAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 12, 2002 at 10:40:41AM +0100, Joakim Tjernlund wrote:

> I optimized the crc32() in JFFS2(fs/jffs2/crc.h) by manually unrolling
> the crc32 loop. This gave me a speed increase of 22% in mounting JFFS2 FS
>
> Later Alan Cox pointed out that my changes makes x86 run slower and it turns
> out that on x86 and a fairly new gcc will automatically unroll loops 'where appropriate'
>
> Removed my hand coded unrolling and added -funroll-loops to the JFFS2 Makefile,
> I got similar results as my hand coded unrolling (a little better).
>
> I therefore conclude that ppc_8xx-gcc 2.95.3 from Monta Vista does not do ANY unrolling
> unless you specify -funroll-loops. Doing this for the whole kernel is NOT a good idea,
> it will run slower due to big increase of size.

I'm sort-of supprised that gcc-2.95.x (or gcc-*, for that matter) will
unroll some loops with only -O2 since the info page on gcc-3.2 and
gcc-2.95 both say that -funroll-loops isn't turned on my any of the -O
levels.

So I suspect someone decided that small loops can safely be unrolled on
i386 at some optimization level, but that same decision (with possibly
good reason) was not made for PPC32.  So it's a gcc feature, not a
MVista-specific issue.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
[ disclaimer: I work for MVista. ]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
