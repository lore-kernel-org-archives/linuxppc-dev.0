Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWB2w1204zDqCj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 02:59:52 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qWB2v6scbz9t6v
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2016 02:59:51 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 25 Mar 2016 01:59:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CE3FB2CE8054
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2016 02:59:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2OFxeue4653494
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2016 02:59:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2OFxFOx016283
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2016 02:59:16 +1100
Date: Thu, 24 Mar 2016 21:28:51 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>,
 jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 linuxppc-dev@ozlabs.org, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH/RFC] ppc64 livepatch: frameless klp_return_helper using
 odd TOC
Message-ID: <20160324155850.GA7200@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <20160323155858.GB27110@lst.de>
 <20160324101453.GA1445@linux.vnet.ibm.com>
 <20160324102757.GA29197@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160324102757.GA29197@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Torsten Duwe <duwe@lst.de> [2016-03-24 11:27:57]:

> On Thu, Mar 24, 2016 at 03:44:55PM +0530, Kamalesh Babulal wrote:
> > * Torsten Duwe <duwe@lst.de> [2016-03-23 16:58:58]:
> > 
> > > 
> > > Since nobody liked the extra stack frame nor its workarounds, here is
> > > the next attempt. Assumptions:
> > > 
> > > 1. Heuristics are bad. The better they are, the more subtly the
> > >    way they might fail.
> > > 
> > > 2. The TOC pointer is usually dividable by 4, if not by 8. An odd
> > >    value never occurs.
> > > 
> > > Conclusively, this patch unambiguously creates an odd TOC value when
> > > an ftraced function's global entry point is used. Ftrace_caller will
> > > then immediately fix it, and alongside gather the information whether
> > > the made call was local or global.
> > > 
> > > In case of live patching this information is furthermore used to decide
> > > whether a klp_return_helper needs to be inserted or not.
> > > CAVEAT: any frameless klp_return_helper does not play well with
> > > sibling calls! There's an emergency exit that might work, at worst
> > > it will cause an oops, but it surely avoids a lockup.
> > > At least the live patching modules on ppc64le will need to be compiled
> > > using the -fno-optimize-sibling-calls compiler flag!
> > > 
> > > Thanks go to Michael Matz and Richard Biener for reassurance about
> > > heuristics and pointers to the compiler flag.
> > > 
> > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > 
> > Hi Torsten,
> > 
> > Should this patch be applied over Petr Mladek's v4 ?
> 
> Yes. Just omit the changes it makes to entry_64.S and use this instead.

Thanks, I was able to successfully execute basic livepatch sample module test.


Thanks,
Kamalesh.
