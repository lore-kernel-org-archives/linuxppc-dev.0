Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B73B1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 19:52:54 +1000 (AEST)
Date: Tue, 19 May 2015 11:52:47 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] ppc64 ftrace: mark data_access callees "notrace"
 (pt.1)
In-Reply-To: <1432006027.8339.3.camel@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1505191150420.8186@pobox.suse.cz>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
 <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
 <1432006027.8339.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, Torsten Duwe <duwe@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 19 May 2015, Michael Ellerman wrote:

> > ftrace already handles recursion protection by itself (depending on the 
> > per-ftrace-ops FTRACE_OPS_FL_RECURSION_SAFE flag).
> 
> OK, so I wonder why that's not working for us?

The situation when traced function recurses to itself is different from 
the situation when tracing core infrastrcuture would recurse to itself 
while performing tracing.

> > It's however not really well-defined what to do when recursion would 
> > happen. Therefore __notrace__ annotation, that just completely avoid such 
> > situation by making tracing impossible, looks like saner general solution 
> > to me.
> 
> I disagree. Correctly annotating all functions that might be called ever and
> for all time is a maintenance nightmare and is never going to work in the long
> term.

All the functions called by ftrace must be marked as notrace, there is no 
way out of it.

-- 
Jiri Kosina
SUSE Labs
