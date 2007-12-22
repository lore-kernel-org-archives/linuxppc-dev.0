Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E28B9DDE22
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 00:59:15 +1100 (EST)
Date: Sat, 22 Dec 2007 07:57:17 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com, linuxppc-dev@ozlabs.org, u-boot-users@lists.sourceforge.net
Subject: Re: [RESEND DTC PATCH 2/2] Add support for binary includes.
Message-ID: <20071222135716.GA16187@ld0162-tx32.am.freescale.net>
References: <20071220195259.GA1238@ld0162-tx32.am.freescale.net>
	<20071221002922.GF2665@localhost.localdomain>
	<20071221170921.GA6977@ld0162-tx32.am.freescale.net>
	<20071222025130.GC7891@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071222025130.GC7891@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 22, 2007 at 01:51:30PM +1100, David Gibson wrote:
> On Fri, Dec 21, 2007 at 11:09:21AM -0600, Scott Wood wrote:
> > OK.  I was being lazy. :-P
> 
> In general I'd approve, but having to invoke dtc in the right place
> for the dts file is a bit too big a usability problem, I think.

Yeah, I agree.  It looks like the existing /include/ has the same
problem, BTW.

> > Yeah, I wanted something that would cause dtc to return an error code,
> > and it doesn't seem that calling yyerror(f) will do that at present.  I
> > guess I should fix that rather than overload YYERROR.
> 
> No.  As per the yacc interface, yyerror() prints only, it doesn't
> terminate.

I don't mean terminate early, just set a flag indicating there were
errors, so it returns an error code once parsing is done.

> > > I'm also not sure that stat()ing the file is a good way to get the
> > > size.  This requires that the included file be a regular file with a
> > > sane st_size value, and I can imagine cases where it might be useful
> > > to incbin from a /dev node or other special file.  Obviosuly
> > > implementing that will require work to data_copy_file().
> > 
> > Hmm...  do you have a use case in mind?
> 
> Nothing really specific.  I'm thinking of a dts that maybe pulls in
> some blobs from a pre-existing firmware, by sucking in files from
> /proc/device-tree.

'ls -l /proc/device-tree' seems to indicate that stat would work fine
there (and fstree.c uses it).

> Or maybe something to produce a dts for a guest under a hypervisor that
> takes an image of a real NVRAM or other device to embed in the tree as
> a virtual NVRAM for the guest.

OK.

> > > Actually, I think the way to go here would be to have two variants of
> > > the incbin directive:  one which takes just a filename and includes
> > > the whole file contents, another which takes a filename and a number
> > > and includes just the first N bytes of the file.
> > 
> > Maybe.  /incbinrange/ "path/name" start len?
> 
> I'd prefer to avoid two different keywords if possible.  I'll see if I
> can think of a reasonable syntax.

/incbin/("path")
/incbin/("path", start, len)
?

-Scott
