Date: Mon, 18 Mar 2002 07:54:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
Message-ID: <20020318145407.GB3762@opus.bloom.county>
References: <3C94E3A8.9080301@embeddededge.com> <0203172010.AA01807@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203172010.AA01807@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Mar 17, 2002 at 12:10:43PM -0800, Michael Sokolov wrote:
>
> Dan Malek <dan@embeddededge.com> wrote:
>
> > So, I don't see the problem.  A default is specified and you can change it,
> > just like lots of other configurations.
>
> The problem is that there is a
>
> define_int CONFIG_SERIAL_CONSOLE_BAUD 115200

The other problem is you're looking at the wrong tree for this, which
I'll get into further down.  But in the galileo tree, it's:
if [ "$CONFIG_MOT_MVP" = "y" ]; then
   define_bool CONFIG_GT64260 y
   define_int CONFIG_SERIAL_CONSOLE_BAUD 115200
fi
...
if [ "$CONFIG_USE_PPCBOOT" != "y" ]; then
   int 'Serial Console Baudrate' CONFIG_SERIAL_CONSOLE_BAUD 115200
fi

So the MVP uses 115200, and possibly even DINK does, and anyone else
gets to pick or assumes 9600.

> Having "$CONFIG_GT64260" = "y" imply support for CONFIG_SERIAL_TEXT_DEBUG is
> also discriminatory and undemocratic. Should we also imply the same then for
> "$CONFIG_CPC700" = "y" -o "$CONFIG_CPC710" = "y" -o "$CONFIG_UNINORTH" = "y",
> etc?

No, because right now the CPC700 and CPC710 systems don't know how to
setup a serial port for early debugging via ppc_md.progress().

> I mean I don't mind if defaults are changed globally, it's just the
> discriminatory treatment of GT-64260 that I violently object to.

Can you be more specific?

> Oh, and having
> a separate BK tree and mailing list for it too isn't something I'm fond of.

Why?  The GT-64260 stuff is under heavy development, and between
gt-64260 problems and board problems (and possible processor issues)
having a seperate tree in which to try and hammer things out between the
folks working on it seems useful.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
