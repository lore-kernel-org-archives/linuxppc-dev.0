Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 662CBB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 13:04:33 +1000 (EST)
Message-ID: <1336532658.1714.15.camel@pasglop>
Subject: Re: [PATCH] powerpc: fix compile fail in hugetlb cmdline parsing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Date: Wed, 09 May 2012 13:04:18 +1000
In-Reply-To: <878vh3cncz.fsf@rustcorp.com.au>
References: <1336401142-18733-1-git-send-email-paul.gortmaker@windriver.com>
 <878vh3cncz.fsf@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jim Cromie <jim.cromie@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Baron <jbaron@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-05-08 at 13:53 +0930, Rusty Russell wrote:
> On Mon,  7 May 2012 10:32:22 -0400, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> > Commit 9fb48c744ba6a4bf58b666f4e6fdac3008ea1bd4
> > 
> >     "params: add 3rd arg to option handler callback signature"
> > 
> > added an extra arg to the function, but didn't catch all the use
> > cases needing it, causing this compile fail in mpc85xx_defconfig:
> > 
> >  arch/powerpc/mm/hugetlbpage.c:316:4: error: passing argument 7 of
> >  'parse_args' from incompatible pointer type [-Werror]
> > 
> >  include/linux/moduleparam.h:317:12: note: expected
> > 	 'int (*)(char *, char *, const char *)' but argument is of type
> > 	 'int (*)(char *, char *)'
> > 
> > This function has no need to printk out the "doing" value, so
> > just add the arg as an "unused".
> > 
> > Cc: Rusty Russell <rusty@rustcorp.com.au>
> > Cc: Jim Cromie <jim.cromie@gmail.com>
> > Cc: Jason Baron <jbaron@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Becky Bruce <beckyb@kernel.crashing.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>

This is for -next right ? IE. I don't seem to have the faulty commit
in my tree so I can't carry the fix for now.... or am I missing
something ?

Cheers,
Ben.
