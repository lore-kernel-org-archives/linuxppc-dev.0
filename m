Date: Thu, 23 Aug 2001 18:51:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-benh0 problems and kudos
Message-ID: <20010823185112.H14302@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010823130149.X14302@cpe-24-221-152-185.az.sprintbbd.net> <20010824010020.2304.qmail@kunk.jriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010824010020.2304.qmail@kunk.jriver.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 23, 2001 at 08:00:20PM -0500, Robert E Brose II wrote:
> User Tom Rini says:
> > > Did you mean sk_chk_filter?  The problem is that sk_{chk,run}_filter are
> > > only exported on CONFIG_FILTER.  Congrats, you found a bug. :)  Go email
> > > Dave S. Miller <davem@redhat.com> about this.  In the mean time, edit
> > > net/netsyms.c, search for the symbols and remove the #ifdef CONFIG_FILTER/#endif
> > > around them.  Re-run make dep and recompile.
> >
> > Er, wait a second...  drivers/net/pppoe.c doesn't call sk_run_filter...
> >
>
> UMMM, I don't see myself where it's getting it from however with a
> clean compile I see the following...
>
> # nm pppoe.o | grep sk_
>          U sk_alloc_R5f9fe915
>          U sk_free_R6807b2c7
>          U sk_run_filter

Do a grep sk_run_filter /proc/ksyms, I bet it there, w/ some bits on the end.
Try mv .config /tmp && make distclean && mv /tmp/.config . && make oldconfig
Then make vmlinux modules and try again.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
