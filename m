Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (unknown [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 515431A0EA1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 20:52:34 +1000 (AEST)
Date: Wed, 8 Apr 2015 12:52:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: Topology updates and NUMA-level sched domains
Message-ID: <20150408105212.GP21418@twins.programming.kicks-ass.net>
References: <20150406214558.GA38501@linux.vnet.ibm.com>
 <20150407102147.GJ23123@twins.programming.kicks-ass.net>
 <20150407171410.GA62529@linux.vnet.ibm.com>
 <20150407194129.GT23123@twins.programming.kicks-ass.net>
 <552503A1.3050502@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <552503A1.3050502@inria.fr>
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2015 at 12:32:01PM +0200, Brice Goglin wrote:
> Le 07/04/2015 21:41, Peter Zijlstra a écrit :
> > No, that's very much not the same. Even if it were dealing with hotplug
> > it would still assume the cpu to return to the same node.
> >
> > But mostly people do not even bother to handle hotplug.
> >
> 
> You said userspace assumes the cpu<->node relation is a boot-time fixed
> one, and hotplug breaks this.

I said no such thing. Regular hotplug actually respects that relation.

> How do you expect userspace to handle hotplug?

Mostly not. Why would they? CPU hotplug is rare and mostly a case of:
don't do that then.

Its just that some of the virt wankers are using it for resource
management which is entirely misguided. Then again, most of virt is.

> Is there a convenient way to be notified when a CPU (or memory)
> is unplugged?

I think you can poll some sysfs file or other.
