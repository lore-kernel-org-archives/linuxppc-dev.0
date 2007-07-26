Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DTC 1.0.0 Release Coming? 
In-Reply-To: Your message of "Fri, 27 Jul 2007 00:27:39 +1000."
	<20070726142739.GB18684@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
	<20070726030550.GA1149@localhost.localdomain>
	<E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
Date: Thu, 26 Jul 2007 10:21:33 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IE59h-0001tt-JE@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:

> > > Only thing I'm not really happy with in the current release is the
> > > versioning stuff.  For starters, it always reports my builds as
> > > -dirty, even when they're not.
> > 
> > I think it won't do that once there is a tag available.
> 
> Your 1.0.0-rc1 tag is there, still showing as dirty.

Hmmm.. Seems to work here.  Is your working directory really clean?

    jdl.com 872 % make clean
	     CLEAN (libfdt)
	     CLEAN (tests)
	     CLEAN
    jdl.com 873 % make
	     LEX lex.yy.c
	     BISON dtc-parser.tab.c
	     ---- Expect 2 s/r and 2 r/r. ----
    dtc-parser.y: conflicts: 2 shift/reduce, 2 reduce/reduce
	    CHK version_gen.h
	    UPD version_gen.h
	     CC dtc.o
	     CC flattree.o
	[ snip ]
	     CC tests/del_node.o
	     CC tests/truncated_property.o
	     AS tests/trees.o
	     DUMPTREES
    jdl.com 874 % ./dtc -v
    Version: DTC 1.0.0-rc1


I hve also verified that at least one other independent build
using this approach produces a correct version string for them
as well.


> > That is essentially what is there now.  We just need a tag!
> 
> Um... no.  The base version comes from the numbers specified in the
> Makefile, not from the git tag.

Ah, ok.  I understand what you mean now.  That part.
So run it the other way instead.  So perhaps have the
Makefile generate the tag using those versioning parts
instead using some "make tagged_release" target?

> > I would like to keep the current version mechanism as it
> > is really quite similar to what is in the Kernel now.
> 
> First, I don't think it really is - except in superficial aspect of
> how the version number is partitioned

I lifted the code from the Kernel's Makefile directly, and tweaked
it slightly for lack of Kconfig aspects.

I don't want to tie the code and build mechanism to git too much.
Specifically, we need to be able to support stand-alone tarball
based builds.  For example, I've spoken to the Debian package
maintainer on this issue, and he likes this approach as well as
he says it will make packaging it much easier.

*sigh*

jdl
