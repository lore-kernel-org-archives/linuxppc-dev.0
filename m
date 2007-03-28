Return-Path: <jdl@freescale.com>
Subject: Re: [PATCH] DTC: Add support for a C-like #include "file" mechanism.
From: Jon Loeliger <jdl@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070328062159.GJ27401@localhost.localdomain>
References: <1174681120.32390.82.camel@ld0161-tx32>
	<20070328062159.GJ27401@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1175102216.32390.220.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 28 Mar 2007 12:16:56 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-28 at 01:21, David Gibson wrote:

> [snip]
> > @@ -49,7 +51,27 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
> >  
> >  %%
> >  
> > +#[ \t]*include		BEGIN(INCLUDE);
> 
> I don't think using this CPP like syntax is a good idea, for several
> reasons.  Firstly, if people see '#include' in the file, they're
> likely to assume that the file is actually processed by CPP and so
> #define and other CPP directives will work.  Second, the circumstances
> under which this token will be recognized, and what's valid after it
> aren't *quite* the same as CPP which is also potentially confusing.
> Thirdly, '#include' is technically a valid property name, they can be
> disambiguated lexically in various ways, but they're all pretty ugly.

I can happily change the "3include" syntax.  I'm not tied
to it at all, but was rather just tacitly defaulting to a
C-like syntax.

> If we need new keywords in the dts, which need to be lexically
> distinct from property and node names, I suggest we do what I did for
> memreserve and use /s (so '/include/' in this case).  Because of its
> use in paths, / is one of the few characters we can be pretty
> confident won't appear in node or property names.

Yeah.  I'll change it to somethig like:

    /include/ "filename"

Does that work for you?

> However, in any case.  It's not clear to me that an include facility
> built into dtc itself it particularly useful without some sort of
> reasonable macro system as well, which would be substantially more
> complex to implement.

Totally agree.  We're doing incremental development here.... :-)

> So, instead of doing this in dtc itself, I really suggest we instead
> use m4 to preprocess dts files, which gives us both include and macro
> facilities.

To be honest, I really don't think m4 is the right solution
for us.  Sure, it will likely work at the start, but I think
over time it will be lacking and not quite the right functionality.
For example, I tend to agree with Kumar that we might need
some form of "overlay" kind of concepts, both "merge" and
"replace" forms, along with some interpolative substitution
mechanisms.

> 
> > +<INCLUDE>[ \t]*		/* whitespace before file name */
> 
> You don't need this rule - the lex rule which ignores whitespace is
> recognized in all starting conditions, including <INCLUDE>.

It was "by the book" anyway.  But we can remove it.

> > +<INCLUDE>\"[^"\n]*\"	{
> > +			yytext[strlen(yytext) - 1] = 0;
> > +			if (!push_input_file(yytext + 1)) {
> > +				/* Some unrecoverable error.*/
> 
> Should be some kind of error message here.

Hrm.  Yeah.




> > +int push_input_file(const char *filename)
> 
> Functions of this sort of size shouldn't go in a .h (particularly when
> not marked static).  Either put then in srcpos.c, or directly into
> dtc-lexer.l in the (currently empty) third section.

Well, it has to come early so that the type is seen
prior to the builtin version.  But it could be reorganized
a bit, I suppose.  I was just angling on not cluttering
up the lexer proper.


> >  
> > -struct boot_info *dt_from_source(FILE *f)
> > +struct boot_info *dt_from_source(const char *fname)
> >  {
> >  	the_boot_info = NULL;
> >  
> > -	yyin = f;
> > +	push_input_file(fname);
> > +
> >  	if (yyparse() != 0)
> >  		return NULL;
> 
> It's not at all clear to me how these changes still handle input from
> stdin.

It is handled here:

FILE *dtc_open_file(const char *fname)
+{
+       FILE *f;
+
+       if (lookup_file_name(fname, 1) < 0)
+               die("Too many files opened\n");
+
+       if (streq(fname, "-"))
+               f = stdin;
+       else
+               f = fopen(fname, "r");
+
+       if (! f)
+               die("Couldn't open \"%s\": %s\n", fname,
strerror(errno));
+
+       return f;
+}


Note some people are seeing some compilation problems
around the struct field "filenum" that I introduced.
I don't see that problem, but a coworker here does,
so I am now able to reproduce the issue and am working
on a fix. Sorry.

Thanks,
jdl
