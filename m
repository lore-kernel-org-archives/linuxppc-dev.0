Return-Path: <linuxram@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 482D61400A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 04:43:19 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 30 Apr 2014 14:43:15 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C13286E8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 14:43:04 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3UIhBLR55312612
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 18:43:11 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3UIh8oU003557
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 14:43:08 -0400
Date: Wed, 30 Apr 2014 11:43:04 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] powerpc: crtsaveres.o needed only when -Os flag is
 enabled
Message-ID: <20140430184304.GA9784@ram.oc3035372033.ibm.com>
References: <1398729908-15787-1-git-send-email-linuxram@us.ibm.com>
 <20140429153806.GA25743@oc3347516403.ibm.com>
 <1398834894.31586.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398834894.31586.14.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Brian W Hart <hartb@linux.vnet.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2014 at 03:14:54PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2014-04-29 at 10:38 -0500, Brian W Hart wrote:
> 
> > >  CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
> > >  
> > > +ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> > >  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> > > +endif
> > > +
> > >  
> > >  # No AltiVec or VSX instructions when building kernel
> > >  KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
> > 
> > I didn't try building a kernel or in-tree modules, but I confirmed
> > that it allows building of out-of-tree modules when crtsavres.o is
> > not present (e.g. as for a distro install where the kernel headers
> > are provided by package, rather than being manually prepared from
> > the sources).
> > 
> > Tested-by: Brian W Hart <hartb@linux.vnet.ibm.com>
> 
> I still don't like it. What guarantee do we have that gcc will never
> call into this with other optimisation settings ? It might decide
> one day that calling out for saving a large pile of registers
> is still more efficient than unrolling the whole lot, including
> for speed.

This patch operates on the assumption that arch/powerpc/lib/crtsavres.o 
is needed only if the code is compiled with -Os.  Are you saying
this assumption is wrong?

> 
> Besides that doesn't fix the root problem. We want to be able to
> build the kernel with CONFIG_CC_OPTIMIZE_FOR_SIZE and still have
> modules.

And this patch will not stop you from doing that. You can compile your
kernel with CONFIG_CC_OPTIMIZE_FOR_SIZE and modules will be built
because arch/powerpc/lib/crtsavres.o will be linked with the module.
Now, if the arch/powerpc/lib/crtsavres.o file does not exist, that
is a different problem and has to be fixed by the distros for 
out-of-tree modules.

> 
> So a better solution needs to be found. I don't know what that
> solution is (we might want to look at what other archs are doing
> maybe ?), could be to include crtsaveres.S in the build of every
> module (we really don't want to EXPORT_SYMBOL these guys), but
> that would mean having it installed somewhere with the kernel
> headers for out-of-tree modules...

Currently crtsaveres.o is expected to be in the build during
the linking stage of the module. You suggest instead have 
crtsaveres.S and get it compiled and linked?

> 
> If necessary, involve lkml, Rusty etc... but this patch is crap.

I dont see other archs having this problem. Possibly because there
linker have inbuilt capabilities to satisfy the missing symbols?

Alan Modra did mention that the ppc linker will soon have the
capability to handle -Os compiled code, without the help
of arch/powerpc/lib/crtsavres.o.

However this patch is not about having crtsavres.o or crtsaveres.S

Its about not needing crtsavres.o if the code is not compiled for
space optimization using -Os. If you say that the assumption
is wrong, than yes the code is crap :)


RP
