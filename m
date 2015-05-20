Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F5F21A060E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 19:03:29 +1000 (AEST)
Date: Wed, 20 May 2015 11:03:25 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] ppc64 ftrace: mark data_access callees "notrace" (pt.1)
Message-ID: <20150520090325.GA11577@lst.de>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
 <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
 <1432006027.8339.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432006027.8339.3.camel@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 19, 2015 at 01:27:07PM +1000, Michael Ellerman wrote:
> On Mon, 2015-05-18 at 14:29 +0200, Jiri Kosina wrote:
> > 
> > ftrace already handles recursion protection by itself (depending on the 
> > per-ftrace-ops FTRACE_OPS_FL_RECURSION_SAFE flag).
> 
> OK, so I wonder why that's not working for us?

IIRC a data access fault happens just before that flag is looked at ;-)

I'm now thinking about a hybrid solution: mark the most critical functions
"notrace", especially those directly involved with MMU loading, and add
a per-thread flag to catch the not-so-obvious cases.

	Torsten
