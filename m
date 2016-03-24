Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW2h13FjNzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 21:28:01 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qW2h05D6Wz9sDH
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2016 21:28:00 +1100 (AEDT)
Date: Thu, 24 Mar 2016 11:27:57 +0100
From: Torsten Duwe <duwe@lst.de>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>,
 jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 linuxppc-dev@ozlabs.org, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH/RFC] ppc64 livepatch: frameless klp_return_helper using
 odd TOC
Message-ID: <20160324102757.GA29197@lst.de>
References: <20160323155858.GB27110@lst.de>
 <20160324101453.GA1445@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160324101453.GA1445@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 24, 2016 at 03:44:55PM +0530, Kamalesh Babulal wrote:
> * Torsten Duwe <duwe@lst.de> [2016-03-23 16:58:58]:
> 
> > 
> > Since nobody liked the extra stack frame nor its workarounds, here is
> > the next attempt. Assumptions:
> > 
> > 1. Heuristics are bad. The better they are, the more subtly the
> >    way they might fail.
> > 
> > 2. The TOC pointer is usually dividable by 4, if not by 8. An odd
> >    value never occurs.
> > 
> > Conclusively, this patch unambiguously creates an odd TOC value when
> > an ftraced function's global entry point is used. Ftrace_caller will
> > then immediately fix it, and alongside gather the information whether
> > the made call was local or global.
> > 
> > In case of live patching this information is furthermore used to decide
> > whether a klp_return_helper needs to be inserted or not.
> > CAVEAT: any frameless klp_return_helper does not play well with
> > sibling calls! There's an emergency exit that might work, at worst
> > it will cause an oops, but it surely avoids a lockup.
> > At least the live patching modules on ppc64le will need to be compiled
> > using the -fno-optimize-sibling-calls compiler flag!
> > 
> > Thanks go to Michael Matz and Richard Biener for reassurance about
> > heuristics and pointers to the compiler flag.
> > 
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> Hi Torsten,
> 
> Should this patch be applied over Petr Mladek's v4 ?

Yes. Just omit the changes it makes to entry_64.S and use this instead.

	Torsten
