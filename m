Date: Tue, 28 Mar 2000 09:59:10 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: Ani Joshi <ajoshi@shell.unixbox.com>, David Edelsohn <dje@watson.ibm.com>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet
In-Reply-To: <v03110709b5056af5e158@[129.100.29.243]>
Message-ID: <Pine.LNX.4.05.10003280956190.15578-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 27 Mar 2000, Kevin B. Hendricks wrote:
> I asked the same things a few weeks back.  David is the epxert, I am not.
> I think the key is what David just wrote:
>
> >All of the inlined functions
> >should have constraints which reference the actual memory address read or
> >written to ensure proper dependencies in optimized code.
>
> I think the memory constraint on the exact address prevents the compiler
> from moving this inline code to someplace inappropriate, but David and
> Gabriel could answer better.

It's not about moving inline code, it's about the compiler thinking which
in-memory variables may be clobbered by the inline code. If the constraint says
that `memory' is clobbered, the compiler cannot know which variables were
clobbered, so it will assume they were all clobbered and it will reload them
from memory into the registers instead of reusing the regoister values.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
