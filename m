Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Dec 2007 11:16:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RESEND DTC PATCH 2/2] Add support for binary includes.
Message-ID: <20071224001623.GA21400@localhost.localdomain>
References: <20071220195259.GA1238@ld0162-tx32.am.freescale.net>
	<20071221002922.GF2665@localhost.localdomain>
	<20071221170921.GA6977@ld0162-tx32.am.freescale.net>
	<20071222025130.GC7891@localhost.localdomain>
	<20071222135716.GA16187@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071222135716.GA16187@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 22, 2007 at 07:57:17AM -0600, Scott Wood wrote:
> On Sat, Dec 22, 2007 at 01:51:30PM +1100, David Gibson wrote:
> > On Fri, Dec 21, 2007 at 11:09:21AM -0600, Scott Wood wrote:
> > > OK.  I was being lazy. :-P
> > 
> > In general I'd approve, but having to invoke dtc in the right place
> > for the dts file is a bit too big a usability problem, I think.
> 
> Yeah, I agree.  It looks like the existing /include/ has the same
> problem, BTW.

Uh, yes, I guess it would.  I suppose we'd better fix that too.  We'll
see how bored I get at my parents' place over Christmas.

> > > Yeah, I wanted something that would cause dtc to return an error code,
> > > and it doesn't seem that calling yyerror(f) will do that at present.  I
> > > guess I should fix that rather than overload YYERROR.
> > 
> > No.  As per the yacc interface, yyerror() prints only, it doesn't
> > terminate.
> 
> I don't mean terminate early, just set a flag indicating there were
> errors, so it returns an error code once parsing is done.

Ok.  We don't have a really good mechanism for that at present - for
any of the input forms.  I was thinking about trying to hook that into
the checking framework - have a special sort of check that doesn't do
anything when invoked as a check, but can be "pre-failed" by the input
parsing code.

> > > > I'm also not sure that stat()ing the file is a good way to get the
> > > > size.  This requires that the included file be a regular file with a
> > > > sane st_size value, and I can imagine cases where it might be useful
> > > > to incbin from a /dev node or other special file.  Obviosuly
> > > > implementing that will require work to data_copy_file().
> > > 
> > > Hmm...  do you have a use case in mind?
> > 
> > Nothing really specific.  I'm thinking of a dts that maybe pulls in
> > some blobs from a pre-existing firmware, by sucking in files from
> > /proc/device-tree.
> 
> 'ls -l /proc/device-tree' seems to indicate that stat would work fine
> there (and fstree.c uses it).

Uh, yeah.  That's just me being an old-timer and remembering the days
when stat() didn't operate on /proc properly.

> > Or maybe something to produce a dts for a guest under a hypervisor that
> > takes an image of a real NVRAM or other device to embed in the tree as
> > a virtual NVRAM for the guest.
> 
> OK.
> 
> > > > Actually, I think the way to go here would be to have two variants of
> > > > the incbin directive:  one which takes just a filename and includes
> > > > the whole file contents, another which takes a filename and a number
> > > > and includes just the first N bytes of the file.
> > > 
> > > Maybe.  /incbinrange/ "path/name" start len?
> > 
> > I'd prefer to avoid two different keywords if possible.  I'll see if I
> > can think of a reasonable syntax.
> 
> /incbin/("path")
> /incbin/("path", start, len)

Hrm.  Not all that fond of those, but we'll see.  I guess
C-function-like syntax does make a certain amount of sense in the
context of the expression syntax we intend to introduce.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
