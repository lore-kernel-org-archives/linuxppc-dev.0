Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DFE41A004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 23:03:01 +1000 (AEST)
Date: Wed, 3 Jun 2015 15:02:57 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] ppc64 ftrace implementation
Message-ID: <20150603130257.GA19424@lst.de>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
 <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
 <1432006027.8339.3.camel@ellerman.id.au>
 <alpine.LNX.2.00.1505191150420.8186@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1505191150420.8186@pobox.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 19, 2015 at 11:52:47AM +0200, Jiri Kosina wrote:
> On Tue, 19 May 2015, Michael Ellerman wrote:
> 
> > > ftrace already handles recursion protection by itself (depending on the 
> > > per-ftrace-ops FTRACE_OPS_FL_RECURSION_SAFE flag).
> > 
> > OK, so I wonder why that's not working for us?
> 
> The situation when traced function recurses to itself is different from 
> the situation when tracing core infrastrcuture would recurse to itself 
> while performing tracing.

I have used this inspiration to add a catch-all parachute for ftrace_caller,
see my last reply. It reappears here as patch 4/4. Expect noticable performance
impact compared to the selected "notrace" attributation discussed here. This should
still be done in a second step especially for the hardware assistance functions
I mentioned.

	Torsten
