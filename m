Date: Fri, 16 Nov 2001 10:29:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011116102949.A9392@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com> <3BF539A9.BA3ED260@midrivers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BF539A9.BA3ED260@midrivers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 16, 2001 at 09:07:05AM -0700, Mark Pilon wrote:
>

> some issues:
> - mem mapped and DCRs have moved around, been added or taken away when
>   going from the 405gp to pm.
>
> - functional differneces exist between the parts as well: one example
>   being the GP has 5 ethernet interrupts mapped into the UIC, while
>   the PM they're all rolled into 1 int.
>
> - there may be silicon errata which affect one processor which have
>   been worked out of another.
>
> - and the cards are different as well ...
>
> for ease of replicating this port when the next kernel comes along,
> I came down on the side of really isolating everything I'm adding:
> 1bm405pm.h instead of ibm405gp.h,

That's exactly how it should go too.  And did you add in a CONFIG_405PM?
405GP things _should_ be CONFIG_405GP'ed.  If not please post a patch
for them.

> my own board and architecture setup funcs in their own module ...
> my own head_ppc405pm.S ....

Were these actually needed?

> my 0.0002: an approach which isolates chip-specific funcs in a
> chip-specific module, same for board-specific.  this adds maintenance
> as the flavors for a given processor grow.  maybe there's a more clever
> way to do this w/o globbing up a few files w/ many ifdefs.

Which is sort-of where things are going, but haven't yet.  The sooner
you post your port the sooner I can think about things too and see what
needs to be seperated out more.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
