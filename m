Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 176A61A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 13:27:08 +1000 (AEST)
Message-ID: <1432006027.8339.3.camel@ellerman.id.au>
Subject: Re: [PATCH] ppc64 ftrace: mark data_access callees "notrace" (pt.1)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Kosina <jkosina@suse.cz>
Date: Tue, 19 May 2015 13:27:07 +1000
In-Reply-To: <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
 <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Mon, 2015-05-18 at 14:29 +0200, Jiri Kosina wrote:
> yOn Sat, 16 May 2015, Torsten Duwe wrote:
> 
> > > > There's got to be a better solution than this.
> > >
> > > Can you think of a better approach?
> > 
> > Maybe a per thread variable to lock out a recursion into tracing?
> > Thanks for your doubt.
> 
> ftrace already handles recursion protection by itself (depending on the 
> per-ftrace-ops FTRACE_OPS_FL_RECURSION_SAFE flag).

OK, so I wonder why that's not working for us?

> It's however not really well-defined what to do when recursion would 
> happen. Therefore __notrace__ annotation, that just completely avoid such 
> situation by making tracing impossible, looks like saner general solution 
> to me.

I disagree. Correctly annotating all functions that might be called ever and
for all time is a maintenance nightmare and is never going to work in the long
term.

cheers
