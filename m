Date: Fri, 12 Nov 1999 14:32:00 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.27 on CHRP Longtrail
In-Reply-To: <Pine.LNX.4.05.9911121340150.444-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.9911121430470.444-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 12 Nov 1999, Geert Uytterhoeven wrote:
> Plain 2.3.27 panics right after calibrating the delay loop. At first sight, it
> seems to crash in clear_bit() on address 0xa058, hence probably a NULL pointer
> problem somewhere at a higher level. This is being investigated.

The problem is in free_all_bootmem(): we have MAX_DMA_ADDRESS == 0xffffffff
and virt_to_phys() subtracts KERNELBASE from it. I don't understand (yet)
what's all that bootmem stuff doing...

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
