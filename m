Date: Wed, 10 Apr 2002 12:08:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020410190833.GN26754@opus.bloom.county>
References: <20020409145929.GC710@opus.bloom.county> <0204091952.AA24042@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204091952.AA24042@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 09, 2002 at 12:52:40PM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > > I don't see it as ugly, I think it's quite beautiful.
> >
> > Adding an #ifdef per board?
>
> Yes. It's a lot more beautiful than getting link errors about platform_init
> multiply defined or <x>_init undefined.

And neither are as nice as doing some ELF tricks like what Paul
mentioned.  If you do something ala __init which marks a function as
going into .text.platform.init or so, change <x>_init to have a check to
make sure it's on the right board and then have early_init call a
function that goes and runs all of the functions marked as
.text.platform.init, a 1-board kernel is almost no different, and adding
new boards to GENERIC_PPC32 means touching one less file.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
