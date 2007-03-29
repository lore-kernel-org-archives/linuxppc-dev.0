Return-Path: <dgibson@ozlabs.org>
Date: Thu, 29 Mar 2007 12:07:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] DTC: Add support for a C-like #include "file" mechanism.
Message-ID: <20070329020744.GB16270@localhost.localdomain>
References: <1174681120.32390.82.camel@ld0161-tx32>
	<20070328062159.GJ27401@localhost.localdomain>
	<1175102216.32390.220.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1175102216.32390.220.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2007 at 12:16:56PM -0500, Jon Loeliger wrote:
> On Wed, 2007-03-28 at 01:21, David Gibson wrote:
> 
> > [snip]
> > > @@ -49,7 +51,27 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
> > >  
> > >  %%
> > >  
> > > +#[ \t]*include		BEGIN(INCLUDE);
> > 
> > I don't think using this CPP like syntax is a good idea, for several
> > reasons.  Firstly, if people see '#include' in the file, they're
> > likely to assume that the file is actually processed by CPP and so
> > #define and other CPP directives will work.  Second, the circumstances
> > under which this token will be recognized, and what's valid after it
> > aren't *quite* the same as CPP which is also potentially confusing.
> > Thirdly, '#include' is technically a valid property name, they can be
> > disambiguated lexically in various ways, but they're all pretty ugly.
> 
> I can happily change the "3include" syntax.  I'm not tied
> to it at all, but was rather just tacitly defaulting to a
> C-like syntax.
> 
> > If we need new keywords in the dts, which need to be lexically
> > distinct from property and node names, I suggest we do what I did for
> > memreserve and use /s (so '/include/' in this case).  Because of its
> > use in paths, / is one of the few characters we can be pretty
> > confident won't appear in node or property names.
> 
> Yeah.  I'll change it to somethig like:
> 
>     /include/ "filename"
> 
> Does that work for you?

I think it should have a ; after it too, to match other things.  On
second though, I'm a bit uncertain about this syntax - this construct
is recognized at the lexical, not the grammar level, which I think
means it should look different from other constructs.  Maybe
	/include "filename"/
which has the same flavour and lexical recognition properties as the
former.  Perhaps simpler, even, since we could recognize it as a
single token.  But it gives a bit more of an impression that it's a
single, magic, atom, rather than a "statement" similar to the rest of
the file.

Or else maybe we should change where it's recognized, so it is only
valid between "statements".  I don't think there's a strong need to
allow such constructs as:
	reg = /include/ "foo";;
or whatever.

> > However, in any case.  It's not clear to me that an include facility
> > built into dtc itself it particularly useful without some sort of
> > reasonable macro system as well, which would be substantially more
> > complex to implement.
> 
> Totally agree.  We're doing incremental development here.... :-)

Hrm, yeah, that's kind of what worries me.  For a full macro
facilitiy, we're pretty much heading into the realm of a real (mini-)
language, not just an alternate representation of the device tree
structure itself.

Languages developed incrementally tend to be atrocious.  So, I really
don't like the idea of adding macro facilities to dtc itself without a
coherent and at least complete in outline idea of what the macro
language will look like as a whole.

> > So, instead of doing this in dtc itself, I really suggest we instead
> > use m4 to preprocess dts files, which gives us both include and macro
> > facilities.
> 
> To be honest, I really don't think m4 is the right solution
> for us.  Sure, it will likely work at the start, but I think
> over time it will be lacking and not quite the right functionality.
> For example, I tend to agree with Kumar that we might need
> some form of "overlay" kind of concepts, both "merge" and
> "replace" forms, along with some interpolative substitution
> mechanisms.

Oh we'll certainly need some sort of overlay thing.  But I think that
can be orthogonal to the actual include and macro mechanism.  Here's
what I vaguely had in mind.

Simplest variant:

The same node can be defined any number of times, each copy is
merged.  Properties within the node can be defined any number of
times, last definition wins.

Extensions:

A prefix on the property names can mark the definion as weak or strong
(the default).  Weak properties can be freely redefined, redefining a
strong one is an error.  Final .dts files would usually use strong
definitions, includes and macros of library components would use weak
ones, at least for the properties it makes sense to override.

To avoid having to reconstruct the entire path to a node to redefine a
few properties in something deep within the tree, a shorthand could
allow redfinition of a labelled node.  So something like:
	foo {
		bar {
			label: baz {
				property1 = ...;
			}
		}
	}
	&label {
		property2 = ...;
	}
Would result in /foo/bar/baz having two properties.

> > > +<INCLUDE>[ \t]*		/* whitespace before file name */
> > 
> > You don't need this rule - the lex rule which ignores whitespace is
> > recognized in all starting conditions, including <INCLUDE>.
> 
> It was "by the book" anyway.  But we can remove it.
> 
> > > +<INCLUDE>\"[^"\n]*\"	{
> > > +			yytext[strlen(yytext) - 1] = 0;
> > > +			if (!push_input_file(yytext + 1)) {
> > > +				/* Some unrecoverable error.*/
> > 
> > Should be some kind of error message here.
> 
> Hrm.  Yeah.
> 
> > > +int push_input_file(const char *filename)
> > 
> > Functions of this sort of size shouldn't go in a .h (particularly when
> > not marked static).  Either put then in srcpos.c, or directly into
> > dtc-lexer.l in the (currently empty) third section.
> 
> Well, it has to come early so that the type is seen
> prior to the builtin version.  But it could be reorganized
> a bit, I suppose.  I was just angling on not cluttering
> up the lexer proper.

Err... builtin version of what?

> > > -struct boot_info *dt_from_source(FILE *f)
> > > +struct boot_info *dt_from_source(const char *fname)
> > >  {
> > >  	the_boot_info = NULL;
> > >  
> > > -	yyin = f;
> > > +	push_input_file(fname);
> > > +
> > >  	if (yyparse() != 0)
> > >  		return NULL;
> > 
> > It's not at all clear to me how these changes still handle input from
> > stdin.
> 
> It is handled here:
> 
> FILE *dtc_open_file(const char *fname)
> +{
> +       FILE *f;
> +
> +       if (lookup_file_name(fname, 1) < 0)
> +               die("Too many files opened\n");
> +
> +       if (streq(fname, "-"))
> +               f = stdin;
> +       else
> +               f = fopen(fname, "r");
> +
> +       if (! f)
> +               die("Couldn't open \"%s\": %s\n", fname,
> strerror(errno));
> +
> +       return f;
> +}
> 
> 
> Note some people are seeing some compilation problems
> around the struct field "filenum" that I introduced.
> I don't see that problem, but a coworker here does,
> so I am now able to reproduce the issue and am working
> on a fix. Sorry.

Hrm.  Which struct did you add the field to?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
