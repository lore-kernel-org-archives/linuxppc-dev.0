Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 98E01140104
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 15:15:06 +1000 (EST)
Message-ID: <1398834894.31586.14.camel@pasglop>
Subject: Re: [PATCH 1/1] powerpc: crtsaveres.o needed only when -Os flag is
 enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>
Date: Wed, 30 Apr 2014 15:14:54 +1000
In-Reply-To: <20140429153806.GA25743@oc3347516403.ibm.com>
References: <1398729908-15787-1-git-send-email-linuxram@us.ibm.com>
 <20140429153806.GA25743@oc3347516403.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Brian W Hart <hartb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-29 at 10:38 -0500, Brian W Hart wrote:

> >  CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
> >  
> > +ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> > +endif
> > +
> >  
> >  # No AltiVec or VSX instructions when building kernel
> >  KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
> 
> I didn't try building a kernel or in-tree modules, but I confirmed
> that it allows building of out-of-tree modules when crtsavres.o is
> not present (e.g. as for a distro install where the kernel headers
> are provided by package, rather than being manually prepared from
> the sources).
> 
> Tested-by: Brian W Hart <hartb@linux.vnet.ibm.com>

I still don't like it. What guarantee do we have that gcc will never
call into this with other optimisation settings ? It might decide
one day that calling out for saving a large pile of registers
is still more efficient than unrolling the whole lot, including
for speed.

Besides that doesn't fix the root problem. We want to be able to
build the kernel with CONFIG_CC_OPTIMIZE_FOR_SIZE and still have
modules.

So a better solution needs to be found. I don't know what that
solution is (we might want to look at what other archs are doing
maybe ?), could be to include crtsaveres.S in the build of every
module (we really don't want to EXPORT_SYMBOL these guys), but
that would mean having it installed somewhere with the kernel
headers for out-of-tree modules...

If necessary, involve lkml, Rusty etc... but this patch is crap.

Ben.
