Return-Path: <dgibson@ozlabs.org>
Date: Fri, 27 Jul 2007 11:33:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTC 1.0.0 Release Coming?
Message-ID: <20070727013331.GB1561@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
	<20070726030550.GA1149@localhost.localdomain>
	<E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
	<E1IE59h-0001tt-JE@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IE59h-0001tt-JE@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 10:21:33AM -0500, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> 
> > > > Only thing I'm not really happy with in the current release is the
> > > > versioning stuff.  For starters, it always reports my builds as
> > > > -dirty, even when they're not.
> > > 
> > > I think it won't do that once there is a tag available.
> > 
> > Your 1.0.0-rc1 tag is there, still showing as dirty.
> 
> Hmmm.. Seems to work here.  Is your working directory really clean?

Yes, it really is.  I have quilt control directories, but it still
shows as dirty with no patches applied.  Exttra files which don't
affect the build shouldn't count as being dirty.

>     jdl.com 872 % make clean
> 	     CLEAN (libfdt)
> 	     CLEAN (tests)
> 	     CLEAN
>     jdl.com 873 % make
> 	     LEX lex.yy.c
> 	     BISON dtc-parser.tab.c
> 	     ---- Expect 2 s/r and 2 r/r. ----
>     dtc-parser.y: conflicts: 2 shift/reduce, 2 reduce/reduce
> 	    CHK version_gen.h
> 	    UPD version_gen.h
> 	     CC dtc.o
> 	     CC flattree.o
> 	[ snip ]
> 	     CC tests/del_node.o
> 	     CC tests/truncated_property.o
> 	     AS tests/trees.o
> 	     DUMPTREES
>     jdl.com 874 % ./dtc -v
>     Version: DTC 1.0.0-rc1

sneetch:~/ibm/dtc$ git-ls-files -m
sneetch:~/ibm/dtc$ make clean
         CLEAN (libfdt)
         CLEAN (tests)
         CLEAN
sneetch:~/ibm/dtc$ make
         BISON dtc-parser.tab.c
         LEX lex.yy.c
         ---- Expect 2 s/r and 2 r/r. ----
dtc-parser.y: conflicts: 2 shift/reduce, 2 reduce/reduce
	[snip]
         DUMPTREES
sneetch:~/ibm/dtc$ ./dtc -v
Version: DTC 1.0.0-rc1-dirty

> I hve also verified that at least one other independent build
> using this approach produces a correct version string for them
> as well.

Yes, well, this is the other trouble - the current system is so
complex it's very hard to debug and figure out why it's claiming my
build is dirty but not yours.

> > > That is essentially what is there now.  We just need a tag!
> > 
> > Um... no.  The base version comes from the numbers specified in the
> > Makefile, not from the git tag.
> 
> Ah, ok.  I understand what you mean now.  That part.
> So run it the other way instead.  So perhaps have the
> Makefile generate the tag using those versioning parts
> instead using some "make tagged_release" target?

Hrm... I really think the other way is both easier and less fragile.

> > > I would like to keep the current version mechanism as it
> > > is really quite similar to what is in the Kernel now.
> > 
> > First, I don't think it really is - except in superficial aspect of
> > how the version number is partitioned
> 
> I lifted the code from the Kernel's Makefile directly, and tweaked
> it slightly for lack of Kconfig aspects.

Ah, yes, ok, I see.  Frankly I really don't think a lot of that stuff
makes much sense outside the context of Kbuild.  The whole complex
filechk macro, for example - for which there's only one used parameter
in dtc's case.

> I don't want to tie the code and build mechanism to git too much.
> Specifically, we need to be able to support stand-alone tarball
> based builds.  For example, I've spoken to the Debian package
> maintainer on this issue, and he likes this approach as well as
> he says it will make packaging it much easier.

Have a look at the patch I posted.  I haven't sufficiently tested it
yet, but it should be able to generated version info for a tarball too
(provided the .git-manifest file is included, and I'm intending that
will be build by a make dist target).  It will give both the
git-derived based version, and a file content derived hash so we can
robustly tell different builds apart, all with less code than the
current system.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
