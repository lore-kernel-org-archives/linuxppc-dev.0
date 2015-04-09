Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5F071A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 08:40:46 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 9 Apr 2015 16:40:44 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1D12319D8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 16:31:48 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t39MeSrw40501450
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Apr 2015 15:40:28 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t39MegiR032055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Apr 2015 16:40:42 -0600
Date: Thu, 9 Apr 2015 15:40:40 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150409224040.GG53918@linux.vnet.ibm.com>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
 <20150407171410.GA62529@linux.vnet.ibm.com>
 <20150407194129.GT23123@twins.programming.kicks-ass.net>
 <552503A1.3050502@inria.fr>
 <20150408105212.GP21418@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150408105212.GP21418@twins.programming.kicks-ass.net>
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
 Brice Goglin <Brice.Goglin@inria.fr>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.04.2015 [12:52:12 +0200], Peter Zijlstra wrote:
> On Wed, Apr 08, 2015 at 12:32:01PM +0200, Brice Goglin wrote:
> > Le 07/04/2015 21:41, Peter Zijlstra a écrit :
> > > No, that's very much not the same. Even if it were dealing with hotplug
> > > it would still assume the cpu to return to the same node.
> > >
> > > But mostly people do not even bother to handle hotplug.
> > >
> > 
> > You said userspace assumes the cpu<->node relation is a boot-time fixed
> > one, and hotplug breaks this.
> 
> I said no such thing. Regular hotplug actually respects that relation.

Wel, sort of. If you *just* hotplug a CPU out, your invariant of what
CPUs are currently available on what nodes is no longer held. Similarly
if you just add a CPU. And means that you could end up using cpumasks
that are incorrect if you don't make them at runtime, it seems?

> > How do you expect userspace to handle hotplug?
> 
> Mostly not. Why would they? CPU hotplug is rare and mostly a case of:
> don't do that then.
> 
> Its just that some of the virt wankers are using it for resource
> management which is entirely misguided. Then again, most of virt is.

I guess that is a matter of opinion.

-Nish
