Date: Tue, 26 Oct 1999 20:22:06 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rob Barris <rbarris@quicksilver.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: question about altivec registers
In-Reply-To: <v03010d0cb43a9d52cd3e@[192.168.1.16]>
Message-ID: <Pine.LNX.4.05.9910262020350.665-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 25 Oct 1999, Rob Barris wrote:
> >The flag is to actually tell the kernel that your application is using
> >the Altivec registers, so that it can save time by not saving and
> >restoring them when the interrupted or swapped application is not using
> >them. It is supposed to be dynamic so only routines actually using Altivec
> >should set (and clear) it. I am not sure of the details so look into the
> >manual for the hardware support. I think the kernel should enforce the
> >use of this flag since moving the full Altivec register set is time
> >consuming (16 bytes X 32 registers = 1/2 KB).
> 
>    I worked this out once, the extra 512 bytes of register context,
> multiplied by (say) a thousand context switches per second only add up to
> about a MB of memory traffic per second - a fraction of a percent of the
> available memory bandwidth in a G4 machine.  Most of that will sit in cache
> anyway depending on the working set size of the processes involved.

Moving around blocks of 512 bytes quickly thrashes the L1 cache, unless the
loads/stores are done using cache-bypassing instructions (cfr. MOVE16 on '040).
Don't know whether PPC has these (still no PPC guru :-(

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
