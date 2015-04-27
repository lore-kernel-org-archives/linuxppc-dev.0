Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B6111A0724
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 15:07:30 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 10:37:28 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 93C761258059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 10:39:24 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R57N5v1311190
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 10:37:23 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R57MZV019242
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 10:37:22 +0530
Date: Mon, 27 Apr 2015 10:36:53 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCHv2 3/8] perf probe powerpc: Fix symbol fixup issues due to
 ELF type
Message-ID: <20150427050653.GB6113@naverao1-tp.in.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <a31f3cfd0841bea8e615ebd6f8f0ec5a0d1f1eaa.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150312202340.GC3550@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150312202340.GC3550@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/03/12 05:23PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Dec 15, 2014 at 08:20:33PM +0530, Naveen N. Rao escreveu:
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
> Sorry if this was answered already, its been a while since this was
> posted/discussed... Are you completely sure this is not a problem on
> !ppc?
> 
> Woudln't it be more conservative to somehow only adjust symbols for this
> ET_DYN type if the arch is ppc? I.e. something like moving that
> adjust_symbols logic to be arch_adjust_symbols(), provide a default and
> then override it for ppc to include also ET_DYN?

I did check and I don't think any other arch kernel uses ET_DYN, but 
yes, being conservative, I could just make this a arch helper. Will do.

- Naveen

> 
> Looking at the other patches...
> 
> - Arnaldo
> 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  tools/perf/util/symbol-elf.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 06fcd1b..7ac4e4c 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -683,7 +683,8 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
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
