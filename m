Date: Mon, 7 Apr 2003 13:10:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch for PCORE on linuxppc_2_4_devel
Message-ID: <20030407201003.GA17151@ip68-0-152-218.tc.ph.cox.net>
References: <3E8E2D71.8050707@mvista.com> <20030407174355.GD16622@ip68-0-152-218.tc.ph.cox.net> <3E91C1E2.4060502@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E91C1E2.4060502@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 07, 2003 at 11:22:26AM -0700, Mark A. Greer wrote:

> Tom Rini wrote:
>
> >On Fri, Apr 04, 2003 at 06:12:17PM -0700, Mark A. Greer wrote:
> >
> >>This patch does the following:
> >>a) Modifies the CONFIG_MORE_COMPILE_OPTIONS setup at the bottom of
> >>arch/ppc/config.in.  The way that it was didn't work well and seemed
> >>difficult to read.  I believe that the new way is "more correct" and
> >>easier to understand
> >
> >Didn't work well when?  Then intent is that if you don't select this
> >option, you still get -g added when CONFIG_KGDB=y so that you can
> >effectivly use gdb.
>
> Try playing with it a little...

I did.  It works like it should.
No (XMON || KGDB || BDI) -> nothing
XMON || BDI && !MORE -> nothing
KGDB && !MORE -> '-g' && MORE being set.

I even gave xconfig a whirl with both MORE being both set and unset at
the same time in the .config.  It won't let you say no, which is again,
the intent.

> I understand the intent, it just didn't work well.

When doesn't it work well?

> The option is still
> there with a reasonable default.  If they want it, they can use it; if
> they don't, they don't.  If they don't know that they probably want -g
> if they have KGDB, they'll find out soon enough.  Simple.

That's just it.  You never don't want some form of debugging symbols in
your image if you use KGDB.  This is why the i386 kgdb docucmentation
says that -g will be on if KGDB is enabled.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
