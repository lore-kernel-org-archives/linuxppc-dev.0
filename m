Date: Mon, 17 Apr 2000 14:48:54 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: /proc/ppc_htab and 2.3 oddities
In-Reply-To: <Pine.LNX.4.10.10004172130210.455-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10004171430530.25863-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 17 Apr 2000, Geert Uytterhoeven wrote:

>
> A few days ago I saw `mmu_context_overflow' in my kernel messages.
> The machine locked up on `cat /proc/ppc_htab'. Fortunately it autorebooted
> after 180 seconds and came back to life again.

I also saw this a few weeks ago, and was meaning to fix it but I was
unable to reproduce it.

>
> Since I don't have direct access to my PPC box now (I'm recovering from knee
> surgery) and rely on it for receiving email, I'm not very eager to do some
> more experiments with /proc/ppc_htab.

Ouch, hope you feel better soon.

>
> Note that I have no idea what mmu_context_overflow means nor what ppc_htab
> really does. Are these two related?

/proc/ppc_htab is the proc entry for the hash table.  it shows some
current stats on the hash table and allows some manipulation.

an mmu_context_overflow occurs when the counter, well...  overflows.

I'm sure you don't feel like crashing a remote box again, but if you or
anyone else could cat /proc/ppc_htab and tell if panics and perhaps post
the OOPS.

>
> For what it's worth, I'm running the bk tree at the 2.3.99-pre3 level.
>

Speaking of 2.3.99, i think the shared mem or something is terrible
broken.  I am currently in the process of writing an XFree86 driver for
Savage chipset cards, (for those unfamiliar with xfree 4.0, you just
build the driver as a module, ie just an object and place it in a set path
for the server to load), and each time I would build a new driver to test
and copy/replace over the old one and then run the server, it would not
replace the old driver correctly.

Just to prove i wasn't going insane, I used an old build, found out it
worked.  Then made a new build with a ton of ErrorF's (xfree printf's) all
over the place, and replaced the driver.  To my amazement, it was still
using the old build, even though the new one was sitting right over the
old one.  This was all with 2.3.99pre3 with all the /var/shm done.  When I
switched back to 2.2.4 kernel, it worked fine as normal (copy'ing over DID
work as expected).

Has anyone else seen this?

>
> Gr{oetje,eeting}s,
>
> 						Geert


Ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
