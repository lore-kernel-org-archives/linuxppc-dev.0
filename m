Return-Path: <duwe@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E4561A0889
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 18:45:47 +1000 (AEST)
Date: Fri, 15 May 2015 10:45:42 +0200
From: Torsten Duwe <duwe@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] ppc64 ftrace: mark data_access callees "notrace" (pt.1)
Message-ID: <20150515084542.GA20453@suse.de>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431653687.13498.1.camel@ellerman.id.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 15, 2015 at 11:34:47AM +1000, Michael Ellerman wrote:
> On Wed, 2015-05-13 at 18:11 +0200, Torsten Duwe wrote:
> > In order to avoid an endless recursion, functions that may get
> > called from the data access handler must not call into tracing
> > functions, which may cause data access faults ;-)
> > 
> > Advancing from my previous approach that lavishly compiled whole
> > subdirs without the profiling switches, this is more fine-grained
> > (but probably yet incomplete). This patch is necessary albeit not
> > sufficient for FTRACE_WITH_REGS on ppc64.
> 
> There's got to be a better solution than this. The chance that you've correctly
> annotated every function is basically 0, and the chance that we correctly add

Well, I used an automated static code analysis to find these, so from that point
the chances to find all the relevant funcs is significantly > 0.

> it to every new or modififed function in the future is also 0.

Yes, this worries me, too. This may lead to very obscure and confusing breakage :-(

> I don't mean that as a criticism of you, but rather the technique. For starters

No problem, I don't take this personally. I'd also prefer a more elegant solution,
but the problem seems to stem from this particular hardware.

> I don't see any annotations in 32-bit code, or in the BookE code etc.

Exactly, for a start. 32-bit & friends would be another run, for all hardware
where the MMU does not fully autoload. What does sparc do, btw?

> Can you give us more details on what goes wrong without these annotations?

e.g. ftrace tries to note that a function has been called. The memory location of
the tracing framework that is to record this does not yet have an HTAB entry
-> data access fault. Should any of the functions involved in the HTAB handling
be profiled, ftrace will try to note that function call into some RAM location,
which might still not have an entry, etc...

I've seen this lead into an endless recursion, unless, like I wrote and patched before,
disabled tracing in all the relevant source dirs. This looked like overkill to me,
hence the machine-aided approach to find the exact set of functions affected.

Can you think of a better approach?

	Torsten
