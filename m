Date: Tue, 13 Jul 2004 07:20:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040713142015.GK16877@smtp.west.cox.net>
References: <20040703222918.GA10425@suse.de> <20040704072350.GA7060@suse.de> <20040705183219.GI2146@smtp.west.cox.net> <20040709013429.GN23135@smtp.west.cox.net> <20040712090618.GB32413@suse.de> <20040712151119.GL28002@smtp.west.cox.net> <20040712180321.GB16877@smtp.west.cox.net> <20040713134945.GA5104@suse.de> <20040713140127.GJ16877@smtp.west.cox.net> <20040713140220.GA20213@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040713140220.GA20213@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 13, 2004 at 04:02:20PM +0200, Olaf Hering wrote:

>  On Tue, Jul 13, Tom Rini wrote:
>
> > On Tue, Jul 13, 2004 at 03:49:45PM +0200, Olaf Hering wrote:
> >
> > >  On Mon, Jul 12, Tom Rini wrote:
> > >
> > > > +cflags-$(CONFIG_6xx)		+= -Wa,-maltivec
> > >
> > > That breaks gas 2.14 with gcc 3.4 or gcc 3.5, it passes -mppc, -many to
> > > as and leads to this error:
> >
> > Er, are you sure you got your patches right?  Adding -Wa,-maltivec only,
> > shouldn't cause -many to ever show up (and we don't want -many to ever
> > show up, since it is broken on otherwise supported binutils combos).
>
> gcc passes it without asking.

OK.  Perhaps gcc should be refusing to build with older binutils
perhaps?  It sounds like gcc-3.4 + binutils-2.14 or older won't work
unless we ensure that any -mppc/altivec/etc type flags that gcc itself
would pass, excluding -many, are re-passed by the kernel itself.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
