Return-Path: <dgibson@ozlabs.org>
Date: Sat, 22 Dec 2007 13:51:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RESEND DTC PATCH 2/2] Add support for binary includes.
Message-ID: <20071222025130.GC7891@localhost.localdomain>
References: <20071220195259.GA1238@ld0162-tx32.am.freescale.net>
	<20071221002922.GF2665@localhost.localdomain>
	<20071221170921.GA6977@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221170921.GA6977@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 11:09:21AM -0600, Scott Wood wrote:
> On Fri, Dec 21, 2007 at 11:29:22AM +1100, David Gibson wrote:
> > On Thu, Dec 20, 2007 at 01:52:59PM -0600, Scott Wood wrote:
> > > A property's data can be populated with a file's contents
> > > as follows:
> > > 
> > > node {
> > > 	prop = /bin-include/ "path/to/data";
> > > };
> > 
> > I'd be inclined to use /incbin/ rather than /bin-include/.  It's only
> > slightly less obvious, but it's then the same as the gas pseudo-op as
> > well as being a little briefer.
> 
> OK.
> 
> > > Search paths are not yet implemented; non-absolute lookups are relative to
> > > the directory from which dtc was invoked.
> > 
> > Hrm.  I think that's a bit too bogus.  Although it's rather more work
> > to implement, I think we have to make relative paths relative to the
> > location of the dts file until search paths are implemented.
> 
> OK.  I was being lazy. :-P

In general I'd approve, but having to invoke dtc in the right place
for the dts file is a bit too big a usability problem, I think.

> > > +	| propdataprefix DT_BININCLUDE DT_STRING
> > > +		{
> > > +			struct stat st;
> > > +			FILE *f;
> > > +			int fd;
> > > +			
> > > +			f = fopen($3.val, "rb");
> > > +			if (!f) {
> > > +				yyerrorf("Cannot open file \"%s\": %s",
> > > +				         $3.val, strerror(errno));
> > > +				YYERROR;
> > 
> > Hrm.  I'm not sure that being unable to open the file should cause a
> > *parse* error which is what YYERROR will do.  Probably better to print
> > an error message, but let the parsing continue, with the property
> > value being as though the file were empty.
> 
> Yeah, I wanted something that would cause dtc to return an error code,
> and it doesn't seem that calling yyerror(f) will do that at present.  I
> guess I should fix that rather than overload YYERROR.

No.  As per the yacc interface, yyerror() prints only, it doesn't
terminate.

You could use die(), although that might be an excessively scary
message for the situation.

> > > +			}
> > > +
> > > +			fd = fileno(f);
> > > +			if (fstat(fd, &st) < 0) {
> > > +				yyerrorf("Cannot stat file \"%s\": %s",
> > > +				         $3.val, strerror(errno));
> > > +				YYERROR;
> > > +			}
> > 
> > I'm also not sure that stat()ing the file is a good way to get the
> > size.  This requires that the included file be a regular file with a
> > sane st_size value, and I can imagine cases where it might be useful
> > to incbin from a /dev node or other special file.  Obviosuly
> > implementing that will require work to data_copy_file().
> 
> Hmm...  do you have a use case in mind?

Nothing really specific.  I'm thinking of a dts that maybe pulls in
some blobs from a pre-existing firmware, by sucking in files from
/proc/device-tree.  Or maybe something to produce a dts for a guest
under a hypervisor that takes an image of a real NVRAM or other device
to embed in the tree as a virtual NVRAM for the guest.

It's not a big deal, but since it shouldn't be that hard in principle
to read in a whole file without getting an st_size first.

> > Actually, I think the way to go here would be to have two variants of
> > the incbin directive:  one which takes just a filename and includes
> > the whole file contents, another which takes a filename and a number
> > and includes just the first N bytes of the file.
> 
> Maybe.  /incbinrange/ "path/name" start len?

I'd prefer to avoid two different keywords if possible.  I'll see if I
can think of a reasonable syntax.

> > > diff --git a/dtc.h b/dtc.h
> > > index 9b89689..87b5bb1 100644
> > > --- a/dtc.h
> > > +++ b/dtc.h
> > > @@ -138,6 +138,7 @@ struct data data_grow_for(struct data d, int xlen);
> > >  struct data data_copy_mem(const char *mem, int len);
> > >  struct data data_copy_escape_string(const char *s, int len);
> > >  struct data data_copy_file(FILE *f, size_t len);
> > > +struct data data_bin_include(const char *filename);
> > 
> > This looks like a hangover from an earlier version.
> 
> Oops, yes.
> 
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
