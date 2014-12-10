Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 122331A0571
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 20:36:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 19:36:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B96412CE806D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 20:35:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBA9Zw0624772662
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 20:35:59 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBA9ZwI8011013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 20:35:58 +1100
Date: Wed, 10 Dec 2014 15:05:10 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH 2/8] perf probe powerpc: Fix symbol fixup issues due
 to ELF type
Message-ID: <20141210093510.GG5318@naverao1-tp.in.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <0412a00009a22762f92c208964df6f842796464e.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <20141209210717.GA8788@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141209210717.GA8788@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/12/09 06:07PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 09, 2014 at 11:04:00PM +0530, Naveen N. Rao escreveu:
> > If using the symbol table, symbol addresses are not being fixed up
> > properly, resulting in probes being placed at wrong addresses:
> > 
> >   # perf probe do_fork
> >   Added new event:
> >     probe:do_fork        (on do_fork)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> > 	  perf record -e probe:do_fork -aR sleep 1
> > 
> >   # cat /sys/kernel/debug/tracing/kprobe_events
> >   p:probe/do_fork _text+635952
> >   # printf "%x" 635952
> >   9b430
> >   # grep do_fork /boot/System.map
> >   c0000000000ab430 T .do_fork
> > 
> > Fix by checking for ELF type ET_DYN used by ppc64 kernels.
> 
> Are you sure this doesn't need to be enclosed in ifdef PPC64?

I felt this change is architecture-independent, though I'm actually not 
sure if there are other architectures using ET_DYN for their kernel. I 
can restrict this to ppc64 if you think that would be better.

- Naveen

> 
> - Arnaldo
> 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  tools/perf/util/symbol-elf.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 1e23a5b..67e4392 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -629,7 +629,8 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
> >  						     NULL) != NULL);
> >  	} else {
> >  		ss->adjust_symbols = ehdr.e_type == ET_EXEC ||
> > -				     ehdr.e_type == ET_REL;
> > +				     ehdr.e_type == ET_REL ||
> > +				     ehdr.e_type == ET_DYN;
> >  	}
> >  
> >  	ss->name   = strdup(name);
> > -- 
> > 2.1.3
> 
