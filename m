Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8Gt0p0YzDwLR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:15:33 +1100 (AEDT)
Date: Mon, 19 Dec 2016 15:15:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Anton Blanchard <anton@samba.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, chris.ryder@arm.com,
 peterz@infradead.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, alexander.shishkin@linux.intel.com,
 mingo@redhat.com, paulus@samba.org, mhiramat@kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <masriniv@in.ibm.com>
Subject: Re: [PATCH] perf TUI: Don't throw error for zero length symbols
Message-ID: <20161219181517.GA551@kernel.org>
References: <20161121172818.161639c2@kryten>
 <1479804050-5028-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <5853C42B.9050402@linux.vnet.ibm.com>
 <20161217072754.32e6f492@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161217072754.32e6f492@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Sat, Dec 17, 2016 at 07:27:54AM +1100, Anton Blanchard escreveu:
> Hi Ravi,
> 
> > > perf report (with TUI) exits with error when it finds a sample of
> > > zero length symbol(i.e. addr == sym->start == sym->end). Actually
> > > these are valid samples. Don't exit TUI and show report with such
> > > symbols.
> > >
> > > Link: https://lkml.org/lkml/2016/10/8/189
> 
> You can add:
> 
> Tested-by: Anton Blanchard <anton@samba.org>
> 
> Also, since this issue makes perf report pretty much useless on
> ppc64, can we mark it for stable@, at least to get it into 4.9 where
> the ppc64 kernel changes that triggered this appeared?

Ok, added it, will be in the next pull req to Ingo.

- Arnaldo
 
> Anton
> 
> > > Reported-by: Anton Blanchard <anton@samba.org>
> > > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> > > ---
> > >  tools/perf/util/annotate.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > > index aeb5a44..430d039 100644
> > > --- a/tools/perf/util/annotate.c
> > > +++ b/tools/perf/util/annotate.c
> > > @@ -593,7 +593,8 @@ static int __symbol__inc_addr_samples(struct
> > > symbol *sym, struct map *map,
> > >
> > >  	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__,
> > > map->unmap_ip(map, addr));
> > >
> > > -	if (addr < sym->start || addr >= sym->end) {
> > > +	if ((addr < sym->start || addr >= sym->end) &&
> > > +	    (addr != sym->end || sym->start != sym->end)) {
> > >  		pr_debug("%s(%d): ERANGE! sym->name=%s, start=%#"
> > > PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
> > > __LINE__, sym->name, sym->start, addr, sym->end); return -ERANGE;  
> > 
